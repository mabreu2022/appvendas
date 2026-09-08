unit uDataSet;

interface

uses
  System.Classes, System.StrUtils, Data.DB,
  uRepassaMap;

type
  TClsDataSet = class
  public
    class procedure RepassarDados(pDataSetOri, pDataSetDest : TDataSet;
      pRepassaMapList : TClsRepassaMapList);
  end;

implementation

{ TClsDataSet }

class procedure TClsDataSet.RepassarDados(pDataSetOri, pDataSetDest: TDataSet;
  pRepassaMapList : TClsRepassaMapList);
var
  Value : Variant;
  I : Integer;
begin
  for I := 0 to pRepassaMapList.Count - 1 do
  begin
    with pRepassaMapList.Items[I] do
    begin
      Value := pDataSetOri.FieldByName(CampoOrig).Value;
      pDataSetDest.FieldByName(CampoDest).Value := Value;
    end;
  end;
end;

end.
