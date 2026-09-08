unit uSerial;

interface

uses
  System.Classes, System.StrUtils, System.SysUtils, System.Permissions;

type
  TClsSerial = class
  private
  public
    class function GetPermissao(): String;
    class function GetSerial() : String;
  end;

implementation

{ TClsSerial }

uses
  AndroidApi.Helpers,
  AndroidApi.JNI.Os,
  AndroidApi.JNI.Telephony;

class function TClsSerial.GetPermissao: String;
var
  lPermissapPhoneState : String;
begin
  Result := '';
  lPermissapPhoneState := JStringToString(TJManifest_permission.JavaClass.READ_PHONE_STATE);
  PermissionsService.RequestPermissions([lPermissapPhoneState], nil, nil);
end;

class function TClsSerial.GetSerial: String;
var
  lTM : JTelephonyManager;
begin
  GetPermissao();

  lTM := TJTelephonyManager.Create;
  Result := JStringToString(lTM.getImei);
end;

end.
