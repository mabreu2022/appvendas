unit uValueObject;

interface

uses
  RTTI;

type
  TValueObject = class(TObject)
  strict private
    FValue: TValue;
    FValue2: TValue;
  public
    constructor Create(const aValue: TValue); overload;
    constructor Create(const aValue: TValue; const aValue2: TValue); overload;
    property Value: TValue read FValue;
    property Value2: TValue read FValue2;
  end;

implementation

constructor TValueObject.Create(const aValue: TValue);
begin
  FValue := aValue;
end;

constructor TValueObject.Create(const aValue: TValue; const aValue2: TValue);
begin
  FValue := aValue;
  FValue2 := aValue2;
end;

end.
