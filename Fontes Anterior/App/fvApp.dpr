program fvApp;

uses
  System.StartUpCopy,
  FMX.Forms,
  uMain in 'uMain.pas' {frmMain},
  uAcesso in 'uAcesso.pas' {frmAcesso},
  uBanco in 'uBanco.pas' {dmBanco: TDataModule},
  uFuncoes in 'uFuncoes.pas',
  Androidapi.JNI.PowerManager in 'Androidapi.JNI.PowerManager.pas',
  Androidapi.JNI.Toast in 'Androidapi.JNI.Toast.pas',
  uTabs in 'uTabs.pas' {frmTabs},
  uConf in 'uConf.pas' {frmConf},
  Data.DB.Helper in '..\Servidor\Data.DB.Helper.pas',
  ServerUtils in '..\Servidor\ServerUtils.pas',
  System.uJson in '..\Servidor\System.uJson.pas',
  SysTypes in '..\Servidor\SysTypes.pas',
  uPrinter in 'uPrinter.pas',
  uMessage in 'uMessage.pas',
  uBase in 'uBase.pas' {frmBase},
  uConverter in 'uConverter.pas',
  uReceberRecCmd in 'uReceberRecCmd.pas',
  uSincronizar in 'uSincronizar.pas',
  uPrinterBluetooth in 'uPrinterBluetooth.pas',
  uVersao in '..\Servidor\uVersao.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TdmBanco, dmBanco);
  Application.CreateForm(TfrmAcesso, frmAcesso);
  Application.CreateForm(TfrmBase, frmBase);
  Application.Run;
end.
