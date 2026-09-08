program fvApp;

uses
  System.StartUpCopy,
  FMX.Forms,
  uMain in 'uMain.pas' {frmMain},
  Data.DB.Helper in '..\Servidor\Data.DB.Helper.pas',
  ServerUtils in '..\Servidor\ServerUtils.pas',
  System.uJson in '..\Servidor\System.uJson.pas',
  SysTypes in '..\Servidor\SysTypes.pas',
  uVersao in '..\Servidor\uVersao.pas',
  uAcesso in 'uAcesso.pas' {frmAcesso},
  uBanco in 'uBanco.pas' {dmBanco: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TdmBanco, dmBanco);
  Application.CreateForm(TfrmAcesso, frmAcesso);
  Application.Run;
end.
