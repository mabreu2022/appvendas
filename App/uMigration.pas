unit uMigration;

interface

uses
  System.Classes, System.StrUtils, System.SysUtils,
  FireDAC.Comp.Client;

type
  TClsMigration = class
  private
    class var FConexao : TFDConnection;
    class function GetVersao() : String;
    class procedure SetVersao(pVersao : String);
  public
    class procedure Execute(pConexao : TFDConnection);
  end;

implementation

{ TClsMigration }

uses
  uVersao, uConverter;

const
  cScriptMigration =
    'alter table TB_CONF add VERSAO varchar(50)' + sLineBreak +
    'alter table TB_CONF add IMPRESSORA varchar(50)';

class function TClsMigration.GetVersao(): String;
var
  vResult : Variant;
begin
  try
    vResult := FConexao.ExecSQLScalar('select VERSAO from TB_CONF');
    Result := TClsConverter.VarToString(vResult);
  except
    Result := '';
  end;
end;

class procedure TClsMigration.SetVersao(pVersao : String);
const
  cINSERT =
    'insert into TB_CONF (SERVIDOR, PORTA, USUARIO, VERSAO, IMPRESSORA) '+
    'values (''192.168.0.1'', ''3200'', ''SUPER'', ''{versao}'', '''')';

  cUPDATE =
    'update TB_CONF set VERSAO = ''{versao}''';

  function Execute(pCmd : String) : Boolean;
  begin
    pCmd := ReplaceText(pCmd, '{versao}', pVersao);
    try
      FConexao.ExecSQL(pCmd);
      Result := True;
    except
      Result := False;
    end;
  end;

begin
  if not Execute(cUPDATE) then
    Execute(cINSERT);
end;

class procedure TClsMigration.Execute;
var
  vLista : TStringList;
  I : Integer;
begin
  FConexao := pConexao;

  if GetVersao() = TClsVersao.Get() then
    Exit;

  vLista := TStringList.Create;
  vLista.Text := cScriptMigration;

  for I := 0 to vLista.Count - 1 do
  begin
    try
      pConexao.ExecSQL(vLista[I]);
    except
    end;
  end;

  vLista.Free;

  SetVersao(TClsVersao.Get());
end;

end.
