unit uFuncoes;

interface

uses
  System.SysUtils, System.Variants, System.Classes,
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, IdBaseComponent, IdComponent, IdRawBase, IdRawClient,
  IdIcmpClient, System.Json, REST.Response.Adapter, Data.DB, Data.DB.Helper;

procedure JsonToDataset(aDataset: TDataSet; aJSON: string);
function DatasetToJson(const aDataset: TDataSet): string;
function JsonIsEmpty(const aJSON: string): boolean;

implementation

function DatasetToJson(const aDataset: TDataSet): string;
begin
  Result := aDataset.ToJson;
end;

procedure JsonToDataset(aDataset: TDataSet; aJSON: string);
var
  JObj: TJSONArray;
  vConv: TCustomJSONDataSetAdapter;
begin
  if (aJSON = EmptyStr) then
  begin
    Exit;
  end;

  JObj := TJSONObject.ParseJSONValue(aJSON) as TJSONArray;
  vConv := TCustomJSONDataSetAdapter.Create(Nil);

  try
    vConv.DataSet := aDataset;
    vConv.UpdateDataSet(JObj);
  finally
    vConv.Free;
    JObj.Free;
  end;
end;

function JsonIsEmpty(const aJSON: string): boolean;
begin
  Result := False;
  if (trim(aJSON) = '') or (trim(aJSON) = '[]') then
  begin
    Result := True;
  end;
end;

end.
