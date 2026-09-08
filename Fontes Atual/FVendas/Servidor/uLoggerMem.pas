unit uLoggerMem;

interface

uses
  System.Classes, System.StrUtils, System.SysUtils;

type
  TClsLoggerMem = class
  private
    FLista : TStringList;
    function GetConteudo: String;
  protected
  public
    constructor Create;
    destructor Destroy;
    procedure Add(AMensagem : String);
  published
    property Conteudo : String read GetConteudo;
  end;

  function Instance : TClsLoggerMem;
  procedure Destroy;

implementation

var
  _instance : TClsLoggerMem;

  function Instance : TClsLoggerMem;
  begin
    if not Assigned(_instance) then
      _instance := TClsLoggerMem.Create;
    Result := _instance;
  end;

  procedure Destroy;
  begin
    if Assigned(_instance) then
      FreeAndNil(_instance);
  end;

(* mLoggerMem *)

constructor TClsLoggerMem.Create;
begin
  FLista := TStringList.Create;
end;

destructor TClsLoggerMem.Destroy;
begin
  FreeAndNil(FLista);
end;

procedure TClsLoggerMem.Add(AMensagem: String);
const
  cMaxLin = 1000;
var
  I : Integer;
begin
  with fLista do begin
    Insert(0, AMensagem);
    if Count > cMaxLin then
      for I := Count - 1 downto cMaxLin do
        Delete(I);
  end;
end;

function TClsLoggerMem.GetConteudo: String;
begin
  Result := FLista.Text;
end;

initialization
  //Instance();

finalization
  Destroy();

end.
