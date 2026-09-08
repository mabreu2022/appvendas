unit uFuncoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.DBCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Wininet, Mask, DB;

type
  PNetResourceArray = ^TNetResourceArray;
  TNetResourceArray = array [0 .. 100] of TNetResource;

procedure InfoBox(Msg: String);
procedure ErrorBox(Msg: String);
function SimNao(Msg: String): Boolean;
function EncryptStr(const S: WideString; Key: Word): String;
function DecryptStr(const S: String; Key: Word): String;
function GeraCodigo(Tabela, Campo: String): Integer;
function GeraCodigoFB(Tabela, Campo: String): Integer;
function PedeSenha(Senha: String): Boolean;
function NomeComputador: String;
function Rede: Boolean;
function InputComData(var Data: string): Boolean;

implementation

Uses
  uDM;

const
  CKEY1 = 53761;
  CKEY2 = 32618;

function InputComData(var Data: string): Boolean;
var
  Form: TForm;
  Edt: TMaskEdit;
begin
  Result := false;

  Form := TForm.Create(Application);
  try
    { config form }
    Form.BorderStyle := bsDialog;
    Form.Caption := 'Data';
    Form.Position := poScreenCenter;
    Form.Width := 200;
    Form.Height := 150;

    { config label }
    with TLabel.Create(Form) do
    begin
      Parent := Form;
      Caption := 'Entre com a data:';
      Left := 10;
      Top := 10;
    end;

    { config edit mask }
    Edt := TMaskEdit.Create(Form);
    with Edt do
    begin
      Parent := Form;
      Left := 10;
      Top := 25;
      Width := Form.ClientWidth - 20;
      EditMask := '!99/99/0000;1;_';
    end;

    { config btn ok }
    with TBitBtn.Create(Form) do
    begin
      Parent := Form;
      { Posiciona de acordo com a largura do form }
      Left := Form.ClientWidth - (Width * 2) - 20;
      Top := 70;
      Kind := bkOK;
    end;

    { config btn cancel }
    with TBitBtn.Create(Form) do
    begin
      Parent := Form;
      Left := Form.ClientWidth - Width - 10;
      Top := 70;
      Kind := bkCancel; { Botão Cancel }
    end;

    { Se for OK... }
    if Form.ShowModal = mrOK then
    begin
      if Edt.Text = '  /  /    ' then
        Data := ''
      else
        Data := Edt.Text;
      Result := true;
    end;
  finally
    Form.Free;
  end;
end;

function Rede: Boolean;
var
  flag: DWORD;
begin
  if InternetGetConnectedState(@flag, 0) then
    Result := true
  else
    Result := false;
end;

function NomeComputador: String;
var
  buffer: array [0 .. 255] of char;
  size: DWORD;
begin
  size := 256;
  if GetComputerName(buffer, size) then
    Result := buffer;
end;

function PedeSenha(Senha: String): Boolean;
begin
  if InputBox('Acesso restrito', #27'Senha Requerida', '') = Senha then
    Result := true
  else
    Result := false;
end;

function SimNao(Msg: String): Boolean;
begin
  if MessageBox(Application.Handle, Pchar(Msg), 'Pergunta',
    MB_YESNO + MB_ICONQUESTION) = IDYES then
    Result := true
  else
    Result := false;
end;

procedure InfoBox(Msg: String);
begin
  MessageBox(Application.Handle, Pchar(Msg), 'Informação',
    MB_ICONINFORMATION + MB_OK);
end;

procedure ErrorBox(Msg: String);
begin
  MessageBox(Application.Handle, Pchar(Msg), 'Erro', MB_ICONERROR + MB_OK);
end;

function EncryptStr(const S: WideString; Key: Word): String;
var
  i: Integer;
  RStr: RawByteString;
  RStrB: TBytes Absolute RStr;
begin
  Result := '';
  RStr := UTF8Encode(S);
  for i := 0 to Length(RStr) - 1 do
  begin
    RStrB[i] := RStrB[i] xor (Key shr 8);
    Key := (RStrB[i] + Key) * CKEY1 + CKEY2;
  end;
  for i := 0 to Length(RStr) - 1 do
  begin
    Result := Result + IntToHex(RStrB[i], 2);
  end;
end;

function DecryptStr(const S: String; Key: Word): String;
var
  i, tmpKey: Integer;
  RStr: RawByteString;
  RStrB: TBytes Absolute RStr;
  tmpStr: string;
begin
  tmpStr := UpperCase(S);
  SetLength(RStr, Length(tmpStr) div 2);
  i := 1;
  try
    while (i < Length(tmpStr)) do
    begin
      RStrB[i div 2] := StrToInt('$' + tmpStr[i] + tmpStr[i + 1]);
      Inc(i, 2);
    end;
  except
    Result := '';
    Exit;
  end;
  for i := 0 to Length(RStr) - 1 do
  begin
    tmpKey := RStrB[i];
    RStrB[i] := RStrB[i] xor (Key shr 8);
    Key := (tmpKey + Key) * CKEY1 + CKEY2;
  end;
  Result := UTF8Decode(RStr);
end;

function GeraCodigo(Tabela, Campo: String): Integer;
var
  Codigo: Integer;
  qryAux: TFDQuery;
begin
  qryAux := TFDQuery.Create(nil);
  try
    // qryAux.Connection :=dmBanco.Conexao;
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('select max(' + (Campo) + ') Ultimo from ' + (Tabela));
    qryAux.Open;

    if qryAux.IsEmpty then
      Codigo := 1
    else
      Codigo := qryAux.FieldByName('Ultimo').AsInteger + 1;

    Result := Codigo;
  finally
    qryAux.Free;
  end;
end;

function GeraCodigoFB(Tabela, Campo: String): Integer;
var
  Codigo: Integer;
  qryAux: TFDQuery;
begin
  qryAux := TFDQuery.Create(nil);
  try
    // qryAux.Connection :=dmBanco.ConexaoFB;
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('select max(' + (Campo) + ') Ultimo from ' + (Tabela));
    qryAux.Open;

    if qryAux.IsEmpty then
      Codigo := 1
    else
      Codigo := qryAux.FieldByName('Ultimo').AsInteger + 1;

    Result := Codigo;
  finally
    qryAux.Free;
  end;
end;

end.
