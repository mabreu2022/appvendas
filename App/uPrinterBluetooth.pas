unit uPrinterBluetooth;

interface

uses
  System.Classes, System.SysUtils, System.StrUtils,
  System.Bluetooth, System.Bluetooth.Components;

type
  TClsPrinterBluetooth = class
  private
    class var FBluetooth : TBluetooth;
    class var FSocket: TBluetoothSocket;
    class procedure SetDispositivo;
  public
    class function ListarDispositivosPareados : TStringList;
    class function ObterDevicePeloNome(pNomeDevice: String): TBluetoothDevice;
    class function ConectarImpressora(pNomeDevice: String): boolean;
    class function ImprimirConteudo(pConteudo: String; pNomeDevice: String = '') : Boolean;
  end;

const
  cSelecionarImpressora = 'Selecionar Impressora';

implementation

uses uMessage;

const
  UUID = '{00001101-0000-1000-8000-00805F9B34FB}';

class procedure TClsPrinterBluetooth.SetDispositivo;
begin
  if not Assigned(FBluetooth) then
  begin
    try
      FBluetooth := TBluetooth.Create(nil);
    except
      on E: Exception do
      begin
        FreeAndNil(FBluetooth);
      end;
    end;
  end;
end;

class function TClsPrinterBluetooth.ListarDispositivosPareados : TStringList;
var
  lDevice: TBluetoothDevice;
begin
  Result := TStringList.Create;
  try
    SetDispositivo;
    if Assigned(FBluetooth) and FBluetooth.Enabled and (FBluetooth.PairedDevices <> nil) then
    begin
      for lDevice in FBluetooth.PairedDevices do
      begin
        Result.Add(lDevice.DeviceName);
      end;
    end;
  except
  end;
end;

class function TClsPrinterBluetooth.ObterDevicePeloNome(pNomeDevice: String): TBluetoothDevice;
var
  lDevice: TBluetoothDevice;
begin
  Result := nil;
  try
    SetDispositivo;
    if Assigned(FBluetooth) and FBluetooth.Enabled and (FBluetooth.PairedDevices <> nil) then
    begin
      for lDevice in FBluetooth.PairedDevices do
      begin
        if lDevice.DeviceName = pNomeDevice then
        begin
          Result := lDevice;
          Break;
        end;
      end;
    end;
  except
  end;
end;

class function TClsPrinterBluetooth.ConectarImpressora(pNomeDevice: String): boolean;
var
  lDevice: TBluetoothDevice;
begin
  Result := False;
  lDevice := ObterDevicePeloNome(pNomeDevice);
  if lDevice <> nil then
  begin
    FSocket := lDevice.CreateClientSocket(StringToGUID(UUID), False);
    if FSocket <> nil then
    begin
      FSocket.Connect;
      Result := FSocket.Connected
    end;
  end;
end;

class function TClsPrinterBluetooth.ImprimirConteudo(pConteudo: String;
  pNomeDevice: String = '') : Boolean;
var
  vListaConteudo : TStringList;
  vConteudo : String;
  I : Integer;
begin
  Result := False;

  if (pNomeDevice = '')
  or (pNomeDevice = cSelecionarImpressora) then
  begin
    TClsMessage.MensagemHint('Impressora deve ser configurada');
    Exit;
  end;

  if not ConectarImpressora(pNomeDevice) then
    Exit;

  if FSocket = nil then
    Exit;

  vListaConteudo := TStringList.Create;
  vListaConteudo.Text := pConteudo;

  FSocket.SendData(TEncoding.UTF8.GetBytes(chr(27) + chr(64))); // inicializa impressora

  for I := 0 to vListaConteudo.Count -1 do
  begin
    vConteudo := vListaConteudo[i];
    FSocket.SendData(TEncoding.UTF8.GetBytes(vConteudo + chr(13)));
  end;

  for I := 1 to 2 do
  begin
    FSocket.SendData(TEncoding.UTF8.GetBytes(chr(27) + chr(74))); // pular linha
  end;

  Result := True;
end;

end.
