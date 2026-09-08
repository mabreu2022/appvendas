unit uStringHexa;

interface

uses
  System.Classes, System.StrUtils, System.SysUtils;

type
  TClsStringHexa = class
  public
    class function String2Hex(const Buffer: AnsiString): string;
    class function Hex2String(const Buffer: string): AnsiString;
  end;

implementation

class function TClsStringHexa.String2Hex(const Buffer: AnsiString): string;
begin
  SetLength(Result, Length(Buffer) * 2);
  BinToHex(PAnsiChar(Buffer), PChar(Result), Length(Buffer));
end;

class function TClsStringHexa.Hex2String(const Buffer: string): AnsiString;
begin
  SetLength(Result, Length(Buffer) div 2);
  HexToBin(PChar(Buffer), PAnsiChar(Result), Length(Result));
end;

end.
