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
    class procedure ImprimirConteudo(pConteudo: String; pNomeDevice: String = '');
  end;

implementation

const
  UUID = '{00001101-0000-1000-8000-00805F9B34FB}';

(*
ServiceDiscoveryServerServiceClassID= ‘{00001000-0000-1000-8000-00805F9B34FB}’;
BrowseGroupDescriptorServiceClassID = ‘{00001001-0000-1000-8000-00805F9B34FB}’;
PublicBrowseGroupServiceClass = ‘{00001002-0000-1000-8000-00805F9B34FB}’;
SerialPortServiceClass = ‘{00001101-0000-1000-8000-00805F9B34FB}’;
LANAccessUsingPPPServiceClass = ‘{00001102-0000-1000-8000-00805F9B34FB}’;
DialupNetworkingServiceClas = ‘{00001103-0000-1000-8000-00805F9B34FB}’;
IrMCSyncServiceClass = ‘{00001104-0000-1000-8000-00805F9B34FB}’;
OBEXObjectPushServiceClass= ‘{00001105-0000-1000-8000-00805F9B34FB}’;
OBEXFileTransferServiceClass = ‘{00001106-0000-1000-8000-00805F9B34FB}’;
IrMCSyncCommandServiceClass= ‘{00001107-0000-1000-8000-00805F9B34FB}’;
HeadsetServiceClass = ‘{00001108-0000-1000-8000-00805F9B34FB}’;
CordlessTelephonyServiceClass = ‘{00001109-0000-1000-8000-00805F9B34FB}’;
AudioSourceServiceClass = ‘{0000110A-0000-1000-8000-00805F9B34FB}’;
AudioSinkServiceClass= ‘{0000110B-0000-1000-8000-00805F9B34FB}’;
AVRemoteControlTargetServiceClass = ‘{0000110C-0000-1000-8000-00805F9B34FB}’;
AdvancedAudioDistributionServiceClass = ‘{0000110D-0000-1000-8000-00805F9B34FB}’;
AVRemoteControlServiceClass= ‘{0000110E-0000-1000-8000-00805F9B34FB}’;
VideoConferencingServiceClass = ‘{0000110F-0000-1000-8000-00805F9B34FB}’;
IntercomServiceClass = ‘{00001110-0000-1000-8000-00805F9B34FB}’;
FaxServiceClass = ‘{00001111-0000-1000-8000-00805F9B34FB}’;
HeadsetAudioGatewayServiceClass= ‘{00001112-0000-1000-8000-00805F9B34FB}’;
WAPServiceClass = ‘{00001113-0000-1000-8000-00805F9B34FB}’;
WAPClientServiceClass = ‘{00001114-0000-1000-8000-00805F9B34FB}’;
PANUServiceClass = ‘{00001115-0000-1000-8000-00805F9B34FB}’;
NAPServiceClass = ‘{00001116-0000-1000-8000-00805F9B34FB}’;
GNServiceClass = ‘{00001117-0000-1000-8000-00805F9B34FB}’;
DirectPrintingServiceClass = ‘{00001118-0000-1000-8000-00805F9B34FB}’;
ReferencePrintingServiceClass = ‘{00001119-0000-1000-8000-00805F9B34FB}’;
ImagingServiceClass= ‘{0000111A-0000-1000-8000-00805F9B34FB}’;
ImagingResponderServiceClass = ‘{0000111B-0000-1000-8000-00805F9B34FB}’;
ImagingAutomaticArchiveServiceClass = ‘{0000111C-0000-1000-8000-00805F9B34FB}’;
ImagingReferenceObjectsServiceClass = ‘{0000111D-0000-1000-8000-00805F9B34FB}’;
HandsfreeServiceClass = ‘{0000111E-0000-1000-8000-00805F9B34FB}’;
HandsfreeAudioGatewayServiceClass = ‘{0000111F-0000-1000-8000-00805F9B34FB}’;
DirectPrintingReferenceObjectsServiceClass = ‘{00001120-0000-1000-8000-00805F9B34FB}’;
ReflectedUIServiceClass = ‘{00001121-0000-1000-8000-00805F9B34FB}’;
BasicPringingServiceClass = ‘{00001122-0000-1000-8000-00805F9B34FB}’;
PrintingStatusServiceClass= ‘{00001123-0000-1000-8000-00805F9B34FB}’;
HumanInterfaceDeviceServiceClass = ‘{00001124-0000-1000-8000-00805F9B34FB}’;
HardcopyCableReplacementServiceClass = ‘{00001125-0000-1000-8000-00805F9B34FB}’;
HCRPrintServiceClas = ‘{00001126-0000-1000-8000-00805F9B34FB}’;
HCRScanServiceClass= ‘{00001127-0000-1000-8000-00805F9B34FB}’;
CommonISDNAccessServiceClass = ‘{00001128-0000-1000-8000-00805F9B34FB}’;
VideoConferencingGWServiceClass = ‘{00001129-0000-1000-8000-00805F9B34FB}’;
UDIMTServiceClass = ‘{0000112A-0000-1000-8000-00805F9B34FB}’;
UDITAServiceClass = ‘{0000112B-0000-1000-8000-00805F9B34FB}’;
AudioVideoServiceClass = ‘{0000112C-0000-1000-8000-00805F9B34FB}’;
SIMAccessServiceClass = ‘{0000112D-0000-1000-8000-00805F9B34FB}’;
PnPInformationServiceClass= ‘{00001200-0000-1000-8000-00805F9B34FB}’;
GenericNetworkingServiceClass = ‘{00001201-0000-1000-8000-00805F9B34FB}’;
GenericFileTransferServiceClass = ‘{00001202-0000-1000-8000-00805F9B34FB}’;
GenericAudioServiceClass= ‘{00001203-0000-1000-8000-00805F9B34FB}’;
GenericTelephonyServiceClass = ‘{00001204-0000-1000-8000-00805F9B34FB}’;
*)

class procedure TClsPrinterBluetooth.SetDispositivo;
begin
  if not Assigned(FBluetooth) then
  begin
    FBluetooth := TBluetooth.Create(nil);
    FBluetooth.Enabled := true;
  end;
end;

class function TClsPrinterBluetooth.ListarDispositivosPareados : TStringList;
var
  lDevice: TBluetoothDevice;
begin
  SetDispositivo;
  Result := TStringList.Create;
  for lDevice in FBluetooth.PairedDevices do
  begin
    Result.Add(lDevice.DeviceName);
  end;
end;

class function TClsPrinterBluetooth.ObterDevicePeloNome(pNomeDevice: String): TBluetoothDevice;
var
  lDevice: TBluetoothDevice;
begin
  SetDispositivo;
  Result := nil;
  for lDevice in FBluetooth.PairedDevices do
  begin
    if lDevice.DeviceName = pNomeDevice then
    begin
      Result := lDevice;
    end;
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

(*
procedure TfrmImpressora.btnConectarClick(Sender: TObject);
begin
  if (ComboBox1.Selected <> nil) and (ComboBox1.Selected.Text <> '') then
  begin
    if ConectarImpressora(ComboBox1.Selected.Text) then
    begin
      Label1.Text := 'Conectado';
    end
    else
    begin
      Label1.Text := 'Desconectado';
    end;
  end
  else
  begin
    ShowMessage('Selecione um dispositivo');
  end;
end;

procedure TfrmImpressora.btnImprimirClick(Sender: TObject);
begin
  if (FSocket <> nil) and (FSocket.Connected) then
  begin
    FSocket.SendData(TEncoding.UTF8.GetBytes(chr(27) + chr(64)));
    FSocket.SendData(TEncoding.UTF8.GetBytes(chr(27) + chr(97) + chr(1)));
    FSocket.SendData(TEncoding.UTF8.GetBytes(chr(27) + chr(33) + chr(8)));
    FSocket.SendData(TEncoding.UTF8.GetBytes(chr(27) + chr(33) + chr(16)));
    FSocket.SendData(TEncoding.UTF8.GetBytes(chr(27) + chr(33) + chr(32)));

    FSocket.SendData(TEncoding.UTF8.GetBytes('Delphi Berlin' + chr(13)));
    FSocket.SendData(TEncoding.UTF8.GetBytes(chr(27) + chr(100) + chr(1)));
    FSocket.SendData(TEncoding.UTF8.GetBytes('Delphi Berlin' + chr(13)));
    FSocket.SendData(TEncoding.UTF8.GetBytes(chr(27) + chr(100) + chr(1)));
    FSocket.SendData(TEncoding.UTF8.GetBytes(chr(27) + chr(33) + chr(0)));

    FSocket.SendData(TEncoding.UTF8.GetBytes('Utilizando TBluetooth '));
    FSocket.SendData(TEncoding.UTF8.GetBytes(chr(27) + chr(100) + chr(1)));
    FSocket.SendData(TEncoding.UTF8.GetBytes('Utilizando TBluetooth '));
    FSocket.SendData(TEncoding.UTF8.GetBytes(chr(27) + chr(100) + chr(1)));

    FSocket.SendData(TEncoding.UTF8.GetBytes(chr(27) + chr(97) + chr(0)));
    FSocket.SendData(TEncoding.UTF8.GetBytes(chr(27) + chr(100) + chr(5)));
    FSocket.SendData(TEncoding.UTF8.GetBytes(chr(29) + chr(107) + chr(2) + '7896006259701' + chr(0)));
    FSocket.SendData(TEncoding.UTF8.GetBytes(chr(27) + chr(100) + chr(5)));
  end;
end;
*)

class procedure TClsPrinterBluetooth.ImprimirConteudo(pConteudo: String; pNomeDevice: String = '');
var
  vListaDispositivos, vListaConteudo : TStringList;
  vConteudo : String;
  I : Integer;
begin
  if (FSocket = nil) or not (FSocket.Connected) then
    Exit;

  if (pNomeDevice = '') then
  begin
    vListaDispositivos := ListarDispositivosPareados;
    if (vListaDispositivos.Count > 1) then
      pNomeDevice := vListaDispositivos[0];
  end;

  if (pNomeDevice = '') then
    Exit;

  if not ConectarImpressora(pNomeDevice) then
    Exit;

  vListaConteudo := TStringList.Create;
  vListaConteudo.Text := pConteudo;

  for I := 0 to vListaConteudo.Count -1 do
  begin
    vConteudo := vListaConteudo[i];
    FSocket.SendData(TEncoding.UTF8.GetBytes(vConteudo + chr(13)));
  end;
end;

end.
