unit uString;

interface

uses
  System.SysUtils, System.Classes, System.StrUtils;

type
  TClsString = class
  public
    class function IfNull(pValue : String; pValueDef : String = '') : String;
  end;

implementation

{ TClsString }

class function TClsString.IfNull(pValue, pValueDef: String): String;
begin
  Result := IfThen(pValue <> '', pValue, pValueDef);
end;

end.
