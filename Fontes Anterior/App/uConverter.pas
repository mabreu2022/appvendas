unit uConverter;

interface

uses
  System.Classes, System.StrUtils, System.SysUtils,
  Data.SqlTimSt;

type
  TClsConverter = class
    class function StrToDateTime(const aValue: String): TDateTime;
    class function StrToInteger(const aValue: String): Integer;
    class function StrToIntegerFmt(aValue: String): Integer;
    class function StrToFloat(const aValue: String): Real;
    class function StrToFloatFmt(aValue: String): Real;
    class function StrToTimeStamp(const aValue: String): TSQLTimeStamp;
  end;

implementation

{ TClsFuncaoTimeStamp }

class function TClsConverter.StrToDateTime(const aValue: String): TDateTime;
var
  fs: TFormatSettings;
  dt: TDateTime;
begin
  fs := TFormatSettings.Create;
  fs.DateSeparator := '-';
  fs.ShortDateFormat := 'yyyy-MM-dd';
  fs.TimeSeparator := ':';
  fs.ShortTimeFormat := 'hh:mm';
  fs.LongTimeFormat := 'hh:mm:ss';

  // 2018-07-11T13:45:14.363

  Result := System.SysUtils.StrToDateTimeDef(aValue, 0, fs);
end;

class function TClsConverter.StrToTimeStamp(const aValue: String): TSQLTimeStamp;
begin
  Result := DateTimeToSQLTimeStamp(StrToDateTime(aValue));
end;

class function TClsConverter.StrToInteger(const aValue: String): Integer;
begin
  Result := StrToIntDef(aValue, 0);
end;

class function TClsConverter.StrToIntegerFmt(aValue: String): Integer;
var
  fs : TFormatSettings;
begin
  fs.DecimalSeparator := '.';
  fs.ThousandSeparator := ',';

  // 100.000

  aValue := Trim(aValue);
  aValue := ReplaceText(aValue, '.', '');

  Result := StrToIntDef(aValue, 0);
end;

class function TClsConverter.StrToFloat(const aValue: String): Real;
begin
  Result := StrToFloatDef(aValue, 0);
end;

class function TClsConverter.StrToFloatFmt(aValue: String): Real;
var
  fs : TFormatSettings;
begin
  fs.DecimalSeparator := '.';
  fs.ThousandSeparator := ',';

  // 100.000,00

  aValue := Trim(aValue);
  aValue := ReplaceText(aValue, '.', '');
  aValue := ReplaceText(aValue, ',', '.');

  Result := StrToFloatDef(aValue, 0, fs);
end;

end.
