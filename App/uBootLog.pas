unit uBootLog;

interface

uses
  System.SysUtils;

procedure BootLog(const AMensagem: string);
procedure RegisterGlobalExceptionHandler;

type
  TBootLogHandler = class
  public
    class procedure OnException(Sender: TObject; E: Exception);
  end;

implementation

{$IFDEF ANDROID}
uses
  Androidapi.Log, FMX.Forms;
{$ELSE}
uses
  FMX.Forms;
{$ENDIF}

procedure BootLog(const AMensagem: string);
{$IFDEF ANDROID}
var
  LTag: UTF8String;
  LMensagem: UTF8String;
{$ENDIF}
begin
{$IFDEF ANDROID}
  LTag := UTF8String('FVAPP');
  LMensagem := UTF8String(AMensagem);
  __android_log_write(ANDROID_LOG_INFO, MarshaledAString(LTag), MarshaledAString(LMensagem));
{$ENDIF}
end;

class procedure TBootLogHandler.OnException(Sender: TObject; E: Exception);
begin
  BootLog('GLOBAL EXCEPTION: ' + E.ClassName + ': ' + E.Message);
end;

procedure RegisterGlobalExceptionHandler;
begin
  Application.OnException := TBootLogHandler.OnException;
end;

initialization
  BootLog('uBootLog initialization');

end.
