unit uConexao;

interface

uses
  System.Classes, System.SysUtils, System.StrUtils,
  FireDAC.Comp.Client;
  
type
  TClsConexao = class(TFDConnection)
  private
	FOwner: TComponent;
  public
    constructor Create(AOwner: TComponent); override;
    function GetQuery(pCmd : String; pOpen : Boolean = True) : TFDQuery;
    function GetValue(pCmd, pCampo : String) : String;
    function GetValueI(pCmd, pCampo : String) : Integer;
    procedure ExecComand(pCmd : String);
  end;

implementation

uses
  uLogger;
  
constructor TClsConexao.Create(AOwner: TComponent);
begin
  FOwner := AOwner;
end;  

function TClsConexao.GetQuery(pCmd : String; pOpen : Boolean) : TFDQuery;
const
  cMETHOD = 'TClsConexao.GetQuery';
begin
  if pOpen then
    uLogger.Instance.Debug(cMETHOD, 'pCmd: ' + pCmd);

  try
    Result := TFDQuery.Create(FOwner);
    Result.Connection := Self;
    Result.Close;
    Result.SQL.Clear;
    Result.SQL.Add(pCmd);
    if (pOpen) then
      Result.Open;
  except
    on E : Exception do begin
      uLogger.Instance.Erro(cMETHOD, 'Erro ao efetuar consulta / pCmd: ' + pCmd, '', E);
      raise;
    end;
  end;
end;

function TClsConexao.GetValue(pCmd, pCampo : String) : String;
const
  cMETHOD = 'TClsConexao.GetValue';
var
  vQuery : TFDQuery;
begin
  uLogger.Instance.Debug(cMETHOD, 'pCmd: ' + pCmd);

  try
    vQuery := GetQuery(pCmd, False);
    vQuery.Open;
    Result := vQuery.FieldByName(pCampo).AsString;
    vQuery.Free;
  except
    on E : Exception do begin
      uLogger.Instance.Erro(cMETHOD, 'Erro ao pegar valor / pCmd: ' + pCmd, '', E);
      raise;
    end;
  end;
end;

function TClsConexao.GetValueI(pCmd, pCampo : String) : Integer;
begin
  Result := StrToIntDef(GetValue(pCmd, pCampo), 0);
end;

procedure TClsConexao.ExecComand(pCmd : String);
const
  cMETHOD = 'TClsConexao.ExecComand';
var
  vQuery : TFDQuery;
begin
  uLogger.Instance.Debug(cMETHOD, 'pCmd: ' + pCmd);

  try
    vQuery := GetQuery(pCmd, False);
    vQuery.ExecSQL;
  except
    on E : Exception do begin
      uLogger.Instance.Erro(cMETHOD, 'Erro ao executar comando / pCmd: ' + pCmd, '', E);
      raise;
    end;
  end;
end;

end.