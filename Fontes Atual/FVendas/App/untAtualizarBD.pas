unit untAtualizarBD;

interface

uses
  IniFiles,
  System.IOUtils,
  System.SysUtils,
  FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteDef,
  FireDAC.UI.Intf,
  FireDAC.FMXUI.Wait,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  FireDAC.Comp.UI,
  FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteWrapper.Stat,
  System.Classes, uBanco;

type
  TAtualizaBD = class
  public
    class procedure GravarINI(Secao, Propriedade, Valor: string);
    class function LerINI(Secao, Propriedade: string): string;
    class function GerarSQLInsert(ATabela: string; CDS: TFDMemTable): string;
    class function GravarDados(ATabela: string; CDS: TFDMemTable): Boolean;
    class procedure ConectarBanco(Conexao: TFDConnection);
    class function ExisteCampo(Tabela, Coluna: string): Boolean;
    class procedure ExecutarAlteracao(aSQL: TStringList);
    class procedure AtualizarBanco;
    class procedure Versao0001;
  end;

implementation

{ TAtualizaBD }

class procedure TAtualizaBD.AtualizarBanco;
begin
  TAtualizaBD.Versao0001;
end;

class procedure TAtualizaBD.ConectarBanco(Conexao: TFDConnection);
var
  LPath: string;
  LFile: TextFile;
begin

  Conexao.Params.Values['DriverID'] := 'SQLite';

    {$IFDEF ANDROID OR IOS}
  LPath := System.IOUtils.TPath.GetDocumentsPath;
    {$ENDIF}
    {$IFDEF MSWINDOWS}
  LPath := 'D:\Github\Freenlancer\ClaudineiCamargo\';
    {$ENDIF}

  LPath := System.IOUtils.TPath.Combine(LPath, 'app.db3');
  ForceDirectories(LPath);
  LPath := System.IOUtils.TPath.Combine(LPath, 'app.db3');

  if not (FileExists(LPath)) then
  begin
    try
      AssignFile(LFile, LPath);
      Rewrite(LFile);
    finally
      CloseFile(LFile);
    end;
  end;

  try
    Conexao.Params.Values['Database'] := LPath;
    Conexao.Params.Values['LockingMode'] := 'Normal';
    Conexao.Connected := True;
  except
    on E: Exception do
      raise Exception.Create('Erro de conexão com o banco de dados: ' + E.Message);
  end;
end;

class procedure TAtualizaBD.ExecutarAlteracao(aSQL: TStringList);
var
  I: Integer;
  bFDQuery: TFDQuery;
begin
  bFDQuery := Nil;
  bFDQuery := TFDQuery.Create(Nil);
  bFDQuery.Connection := dmBanco.Conexao;

  try
    bFDQuery.Close;
    bFDQuery.SQL.Clear;
    if aSQL.Count > 0 then
    begin
      for I := 0 to aSQL.Count - 1 do
        bFDQuery.SQL.Add(aSQL.Strings[I]);
      bFDQuery.ExecSQL;
    end;
  finally
    bFDQuery.DisposeOf;
  end;
end;

class function TAtualizaBD.ExisteCampo(Tabela, Coluna: string): Boolean;
var
  I: Integer;
  bFDQuery: TFDQuery;
begin
  bFDQuery := Nil;

  bFDQuery := TFDQuery.Create(Nil);
  bFDQuery.Connection := dmBanco.Conexao;
  Result := False;
  try
    bFDQuery.Close;
    bFDQuery.SQL.Clear;
    bFDQuery.SQL.Add('SELECT sql FROM sqlite_master WHERE type=''table'' AND name=:TABELA');
    bFDQuery.ParamByName('TABELA').AsString := Tabela;
    bFDQuery.Open;
    if bFDQuery.RecordCount > 0 then
    begin
      I := Pos(Coluna, bFDQuery.FieldByName('SQL').AsString);
      if I > 0 then
      begin
        Result := True;
      end;
    end;
  finally
    bFDQuery.DisposeOf;
  end;
end;

class function TAtualizaBD.GerarSQLInsert(ATabela: string; CDS: TFDMemTable): string;
var
  aSQL, bSQL: string;
  I: Integer;
begin
  aSQL := '';
  bSQL := '';
  Result := '';
  // Gerar sql
  for I := 0 to CDS.FieldCount - 1 do
  begin
    aSQL := aSQL + CDS.FieldDefs.Items[I].Name + ', ';
    bSQL := bSQL + ':' + CDS.FieldDefs.Items[I].Name + ', ';
  end;
  Result := ('INSERT INTO ' + ATabela + '(' + copy(aSQL, 1, length(aSQL) - 2) + ') VALUES(' + copy(bSQL, 1, length(bSQL) - 2) + ')');
end;

class function TAtualizaBD.GravarDados(ATabela: string; CDS: TFDMemTable): Boolean;
var
  xSql: string;
  X, Y: Integer;
  bFDQuery: TFDQuery;
begin
  bFDQuery := Nil;

  bFDQuery := TFDQuery.Create(Nil);
  bFDQuery.Connection := dmBanco.Conexao;

  CDS.First;
  xSql := ' DELETE FROM ' + ATabela;
  dmBanco.Conexao.ExecSQL(xSql);

  try
    if not CDS.IsEmpty then
    begin
      bFDQuery.Close;
      bFDQuery.SQL.Clear;
      bFDQuery.SQL.Add(GerarSQLInsert(ATabela, CDS));
      bFDQuery.Params.ArraySize := CDS.RecordCount;

      CDS.First;
      CDS.DisableControls;
      for X := 0 to CDS.RecordCount - 1 do
      begin
        for Y := 0 to CDS.FieldCount - 1 do
        begin
          if (CDS.Fields.Fields[Y].FieldName = 'PRD_DESC') or (CDS.Fields.Fields[Y].FieldName = 'PRD_ACREC') or (CDS.Fields.Fields[Y].FieldName = 'PRD_ESTOQUE') or (CDS.Fields.Fields[Y].FieldName = 'PRD_PRC_VND') then
            bFDQuery.Params[Y].AsFloats[X] := StrToFloatDef(CDS.Fields.Fields[Y].AsString, 0)
          else if Trim(CDS.Fields.Fields[Y].AsString) = '' then
            bFDQuery.Params[Y].AsStrings[X] := CDS.Fields.Fields[Y].AsString
          else
            bFDQuery.Params[Y].Values[X] := CDS.Fields.Fields[Y].Value;
        end;

        CDS.Next;
      end;
      CDS.EnableControls;
      bFDQuery.Execute(CDS.RecordCount);
    end;

  except
    on E: Exception do
    begin
      raise Exception.Create('Error Message: ' + E.Message);
    end;
  end;
end;

class procedure TAtualizaBD.GravarINI(Secao, Propriedade, Valor: string);
var
  ArquivoINI: TIniFile;
begin
{$IFDEF ANDROID OR IOS}
  ArquivoINI := TIniFile.Create(TPath.Combine(TPath.GetDocumentsPath, 'Arquivo.ini'));
{$ENDIF}
{$IFDEF MSWINDOWS}
  ArquivoINI := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'Arquivo.ini');
{$ENDIF}
  ArquivoINI.WriteString(Secao, Propriedade, Valor);
  ArquivoINI.Free;
end;

class function TAtualizaBD.LerINI(Secao, Propriedade: string): string;
var
  ArquivoINI: TIniFile;
begin
{$IFDEF ANDROID OR IOS}
  ArquivoINI := TIniFile.Create(TPath.Combine(TPath.GetDocumentsPath, 'Arquivo.ini'));
{$ENDIF}
{$IFDEF MSWINDOWS}
  ArquivoINI := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'Arquivo.ini');
{$ENDIF}
  Result := ArquivoINI.ReadString(Secao, Propriedade, '');
  ArquivoINI.Free;
end;

class procedure TAtualizaBD.Versao0001;
var
  SQL: TStringList;
begin
  SQL := Nil;
  SQL := TStringList.Create;
  try
    if not (TAtualizaBD.ExisteCampo('ADM_EMPRESA', 'ROWID')) then
    begin
      SQL.Add(' CREATE TABLE ADM_EMPRESA ( ');
      SQL.Add('     ROWID              INTEGER, ');
      SQL.Add('     CODEMP              INTEGER, ');
      SQL.Add('     NOME                VARCHAR(40), ');
      SQL.Add('     NOMEFANTASIA        VARCHAR(60), ');
      SQL.Add('     ENDERTPLOGRAD       VARCHAR(10), ');
      SQL.Add('     ENDERLOGRAD         VARCHAR(100), ');
      SQL.Add('     ENDERNUMLOGRAD      VARCHAR(10), ');
      SQL.Add('     ENDERCOMPLEMENTO    VARCHAR(15), ');
      SQL.Add('     ENDERBAIRRO         VARCHAR(30), ');
      SQL.Add('     CODCIDADE           INTEGER, ');
      SQL.Add('     NUMTELEFONE         VARCHAR(20), ');
      SQL.Add('     USUARIO             INTEGER, ');
      SQL.Add('     DATAATU             DATE, ');
      SQL.Add('     HORAATU             VARCHAR(8) , ');
      SQL.Add('     INEXPORTADOR        VARCHAR(4), ');
      SQL.Add('     DOCFISCAL           VARCHAR(25), ');
      SQL.Add('     DOCFISCALREPRLEGAL  VARCHAR(25), ');
      SQL.Add('     NOMEREPRLEGAL       VARCHAR(40), ');
      SQL.Add('     TPREPRLEGAL         VARCHAR(1), ');
      SQL.Add('     NACIONALIDADE       VARCHAR(20), ');
      SQL.Add('     ESTADOCIVIL         VARCHAR(20), ');
      SQL.Add('     DOCIDENTIDADE       VARCHAR(20) ');
      SQL.Add(' ); ');
      TAtualizaBD.ExecutarAlteracao(SQL);
      SQL.Clear;
    end;
    if not (TAtualizaBD.ExisteCampo('TB_PEDIDO', 'CODEMP')) then
    begin
      SQL.Add('DROP TABLE TB_PEDIDO');
      TAtualizaBD.ExecutarAlteracao(SQL);
      SQL.Clear;

      SQL.Add('DELETE FROM TB_ITENS_PEDIDO');
      TAtualizaBD.ExecutarAlteracao(SQL);
      SQL.Clear;

      SQL.Add(' CREATE TABLE TB_PEDIDO ( ');
      SQL.Add('     CODIGO       VARCHAR (50)    NOT NULL ');
      SQL.Add('                                  PRIMARY KEY, ');
      SQL.Add('     DATA_PEDIDO  TIMESTAMP, ');
      SQL.Add('     VENDEDOR     VARCHAR (3), ');
      SQL.Add('     TIPO         CHAR (1), ');
      SQL.Add('     TOTAL_PEDIDO DECIMAL (15, 2), ');
      SQL.Add('     OBS          BLOB, ');
      SQL.Add('     DATA_SINC    TIMESTAMP, ');
      SQL.Add('     CLIENTE      VARCHAR (10), ');
      SQL.Add('     COD_PAGTO    INTEGER, ');
      SQL.Add('     CODEMP    INTEGER ');
      SQL.Add(' ); ');
      TAtualizaBD.ExecutarAlteracao(SQL);
      SQL.Clear;
    end;
  finally
    SQL.DisposeOf;
  end;
end;

end.

