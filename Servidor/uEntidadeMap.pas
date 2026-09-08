unit uEntidadeMap;

interface

uses
  System.Classes, System.StrUtils,
  uRepassaMap;

type
  TClsEntidadeMap = class
  public
    class function GetEntidadeMap(pEntidadeOrig, pEntidadeDest: String): TClsRepassaMapList;
    class function GetEntidadeReceberMap(pEntidadeOrig, pEntidadeDest: String; pInverso: Boolean): TClsRepassaMapList;
  end;

implementation

{ TClsEntidadeMap }

class function TClsEntidadeMap.GetEntidadeMap(pEntidadeOrig,
  pEntidadeDest: String): TClsRepassaMapList;
begin
  if (Pos(pEntidadeOrig, 'TB_RECEBER,FCR_FAT') > 0) then
    Result := GetEntidadeReceberMap(pEntidadeOrig, pEntidadeDest, (pEntidadeOrig = 'FCR_FAT'));
end;

class function TClsEntidadeMap.GetEntidadeReceberMap(pEntidadeOrig,
  pEntidadeDest: String; pInverso: Boolean): TClsRepassaMapList;
begin
  Result := TClsRepassaMapList.Create;
  Result.Add('COD_EMP','CODEMP', pInverso);
  Result.Add('COD_CLIENTE','CODCLIENTE', pInverso);
  Result.Add('NUM_FAT','NUMFAT', pInverso);
  Result.Add('NUM_PARC','NUMPARC', pInverso);
  Result.Add('NOM_CLIENTE','NOMCLIENTE', pInverso);
  Result.Add('SITUACAO','SITUACAO', pInverso);
  Result.Add('DATA_EMISSAO','DATAEMISSAO', pInverso);
  Result.Add('DATA_VENCTO','DATAVENCTO', pInverso);
  Result.Add('COD_PORT','CODPORT', pInverso);
  Result.Add('COD_MOEDA','CODMOEDA', pInverso);
  Result.Add('VLR_FATURA','VLFATURA', pInverso);
  Result.Add('TIP_DOC','TPDOC', pInverso);
  Result.Add('NUM_DOC','NUMDOC', pInverso);
  Result.Add('USUARIO','USUARIO', pInverso);
  Result.Add('COD_VEND','CODVEND', pInverso);
  Result.Add('NUM_NOTA','NUMNOTA', pInverso);
  Result.Add('NUM_MOV','NUMMOV', pInverso);
  Result.Add('DATA_MOV','DATAMOV', pInverso);
end;

end.
