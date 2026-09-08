unit uRepassaMap;

interface

uses
  System.Classes, System.StrUtils;

type
  TClsRepassaMap = class;
  TClsRepassaMapClass = class of TClsRepassaMap;

  TClsRepassaMap = class
  private
    FCampoDest: String;
    FCampoOrig: String;
    FInverso: Boolean;
    procedure SetCampoDest(const Value: String);
    procedure SetCampoOrig(const Value: String);
    procedure SetInverso(const Value: Boolean);
  public
    constructor Create(pCampoOrig, pCampoDest: String; pInverso : Boolean);
    property CampoOrig : String read FCampoOrig write SetCampoOrig;
    property CampoDest : String read FCampoDest write SetCampoDest;
    property Inverso : Boolean read FInverso write SetInverso;
  end;

  TClsRepassaMapList = class(TList)
  private
    function GetItem(index: integer): TClsRepassaMap;
    procedure SetItem(index: integer; const Value: TClsRepassaMap);
  public
    function Add(pCampoOrig, pCampoDest: String; pInverso : Boolean) : TClsRepassaMap; overload;
    property Items[index: integer]: TClsRepassaMap read GetItem write SetItem;
  end;

implementation

{ TClsRepassaMap }

constructor TClsRepassaMap.Create(pCampoOrig, pCampoDest: String; pInverso : Boolean);
begin
  FCampoOrig := pCampoOrig;
  FCampoDest := IfThen(pCampoDest <> '', pCampoDest, pCampoOrig);
  SetInverso(pInverso);
end;

procedure TClsRepassaMap.SetCampoDest(const Value: String);
begin
  FCampoDest := Value;
end;

procedure TClsRepassaMap.SetCampoOrig(const Value: String);
begin
  FCampoOrig := Value;
end;

procedure TClsRepassaMap.SetInverso(const Value: Boolean);
var
  vCampoAux : String;
begin
  FInverso := Value;
  if (FInverso) then
  begin
    vCampoAux := FCampoOrig;
    FCampoOrig := FCampoDest;
    FCampoDest := vCampoAux;
  end;
end;

{ TClsRepassaMapList }

function TClsRepassaMapList.Add(pCampoOrig, pCampoDest: String; pInverso : Boolean) : TClsRepassaMap;
begin
  Result := TClsRepassaMap.Create(pCampoOrig, pCampoDest, pInverso);
  Self.Add(Result);
end;

function TClsRepassaMapList.GetItem(index: integer): TClsRepassaMap;
begin
  Result := TClsRepassaMap(self[index]);
end;

procedure TClsRepassaMapList.SetItem(index: integer;
  const Value: TClsRepassaMap);
begin
  self[index] := Value;
end;

end.
