unit uLicenca;

interface

uses
  System.Classes, System.StrUtils, System.SysUtils;

type
  TClsLicenca = class
  private
    class var FQtdeAcesso : Integer;
    class var FListAcesso : TStringList;
    class procedure Adicionar(aSerial : String);
    class function Buscar(aSerial : String) : Boolean;
    class procedure Carregar();
    class procedure CarregarLista();
    class procedure CarregarQtde();
  public
    class procedure ValidarAcesso(aSerial : String);
  end;

implementation

{ TClsLicenca }

uses
  uIniFiles, uArquivo, uStringHexa;

const
  cNomeArquivo = 'acesso.dat';

class procedure TClsLicenca.Adicionar(aSerial : String);
var
  vConteudo : String;
begin
  if (FListAcesso.Count >= FQtdeAcesso) then
    raise Exception.Create('Qtde de acesso liberada excede ao permitido');

  FListAcesso.Add(aSerial + '#' + DateTimeToStr(now));

  TClsArquivo.GravarHex(cNomeArquivo, FListAcesso.Text);
end;

class function TClsLicenca.Buscar(aSerial : String) : Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to FListAcesso.Count-1 do
  begin
    if StartsText(aSerial + '#', FListAcesso[I]) then
    begin
      Result := True;
      Exit;
    end;
  end;
end;

class procedure TClsLicenca.Carregar;
begin
  if Assigned(FListAcesso) then
    Exit;

  CarregarLista();
  CarregarQtde();
end;

class procedure TClsLicenca.CarregarLista;
begin
  FListAcesso := TStringList.Create;
  FListAcesso.Text := TClsArquivo.LerHex(cNomeArquivo);
end;

class procedure TClsLicenca.CarregarQtde;
var
  sQtdeAcesso : String;
begin
  sQtdeAcesso := TClsIniFiles.Pegar('', 'LICENCA', 'QT_ACESSO', '');
  if sQtdeAcesso <> '' then
  begin
    sQtdeAcesso := TClsStringHexa.Hex2String(sQtdeAcesso);
    if StartsText('QTDE#', sQtdeAcesso) then
    begin
      sQtdeAcesso := ReplaceText(sQtdeAcesso, 'QTDE#', '');
    end;
  end;
  FQtdeAcesso := StrToIntDef(sQtdeAcesso, 2);
end;

class procedure TClsLicenca.ValidarAcesso(aSerial: String);
const
  cMETHOD = 'TClsLicenca.ValidarAcesso';
begin
  if (aSerial = '') then
    raise Exception.Create('Serial deve ser informado');

  Carregar;

  if not Buscar(aSerial) then
  begin
    Adicionar(aSerial);
  end;
end;

end.
