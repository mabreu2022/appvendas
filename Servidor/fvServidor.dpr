program fvServidor;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {frmMain},
  uFuncoes in 'uFuncoes.pas',
  uServerMethods in 'uServerMethods.pas',
  uDM in 'uDM.pas' {DM: TDataModule},
  Data.DB.Helper in 'Data.DB.Helper.pas',
  ServerUtils in 'ServerUtils.pas',
  System.uJson in 'System.uJson.pas',
  SysTypes in 'SysTypes.pas',
  uDataSet in 'uDataSet.pas',
  uRepassaMap in 'uRepassaMap.pas',
  uEntidadeMap in 'uEntidadeMap.pas',
  uReceberCmd in 'uReceberCmd.pas',
  uLogger in 'uLogger.pas',
  uArquivo in 'uArquivo.pas',
  uLoggerMem in 'uLoggerMem.pas',
  uIniFiles in 'uIniFiles.pas',
  uPath in 'uPath.pas',
  uApplication in 'uApplication.pas',
  uDatabaseConfig in 'uDatabaseConfig.pas',
  uConexao in 'uConexao.pas',
  uVersao in 'uVersao.pas',
  uLicenca in 'uLicenca.pas',
  uStringHexa in 'uStringHexa.pas';

{$R *.res}

begin
  Application.Initialize;
  uLogger.Instance.Info('fvServidor', 'entrada / versao: ' + TClsVersao.Get());
  Application.OnException := TClsApplication.OnException;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.