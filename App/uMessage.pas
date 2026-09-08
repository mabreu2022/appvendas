unit uMessage;

interface

uses
  System.SysUtils, System.Variants, System.Classes,
  Androidapi.JNI.Toast;

type
  TClsMessage = class
  public
    class procedure MensagemHint(const aMessage: string);
  end;

implementation

{ TClsMessage }

class procedure TClsMessage.MensagemHint(const aMessage: string);
begin
{$IFDEF ANDROID}
  Toast(aMessage, LongToast);
{$ENDIF}
end;

end.
