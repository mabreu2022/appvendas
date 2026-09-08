unit uSerial;

interface

uses
  System.Classes, System.StrUtils, System.SysUtils, System.Permissions;

type
  TClsSerial = class
  private
    class procedure GetPermissao();
  public
    class function GetSerial() : String;
  end;

implementation

{ TClsSerial }

//uses
//  AndroidApi.Helpers,
//  AndroidApi.JNI.Os,
//  AndroidApi.JNI.Telephony;

class procedure TClsSerial.GetPermissao;
//var
//  lPermissapPhoneState : String;
begin
//  lPermissapPhoneState := JStringToString(TJManifest_permission.JavaClass.READ_PHONE_STATE);
//  PermissionsService.RequestPermissions([lPermissapPhoneState], nil, nil);
end;

class function TClsSerial.GetSerial: String;
//var
//  lTM : JTelephonyManager;
begin
  (*Result := '';

  try
    GetPermissao();
  except
  end;

  try
    lTM := TJTelephonyManager.Create;
    Result := JStringToString(lTM.getImei);
  except
  end;

  if (Result <> '') then
    Exit;

  try
    Result := JStringToString(TJBuild.JavaClass.SERIAL);
  except
  end;

  if (Result <> '') then
    Exit;*)

  Result := 'NOK';
end;

end.