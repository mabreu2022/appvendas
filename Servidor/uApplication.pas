unit uApplication;

interface

uses
  System.Classes, System.StrUtils, System.SysUtils;

type
  TClsApplication = class
  public
    class procedure OnException(Sender: TObject; E: Exception);
  end;

implementation

{ TClsApplication }

uses uLogger;

class procedure TClsApplication.OnException(Sender: TObject; E: Exception);
const
  cMETHOD = 'TClsApplication.OnException';
begin
  uLogger.Instance.Erro(cMETHOD, 'Falha de execucao', '', E);
end;

end.
