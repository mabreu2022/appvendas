unit uIniFiles;

interface

uses
  System.Classes, System.StrUtils, System.SysUtils, System.IniFiles;

type
  TClsIniFiles = class
  private
    class function ArqIni(pArq : String) : String;
    class function TagIni(pTag : String) : String;
  public
    class procedure Setar(pArq, pTag, pCod : String; pVal : Variant);
    class function Pegar(pArq, pTag, pCod : String; pDef : String = '') : String;

    class function PegarB(pArq, pTag, pCod : String; pDef : Boolean = False) : Boolean;
    class function PegarD(pArq, pTag, pCod : String; pDef : TDateTime = 0) : TDateTime;
    class function PegarF(pArq, pTag, pCod : String; pDef : Real = 0) : Real;
    class function PegarI(pArq, pTag, pCod : String; pDef : Integer = 0) : Integer;
  end;

implementation

class function TClsIniFiles.ArqIni(pArq : String) : String;
begin
  Result := IfThen(pArq <> '', pArq, GetCurrentDir() + '\' + ChangeFileExt(ExtractFileName(ParamStr(0)), '.ini'));
end;

class function TClsIniFiles.TagIni(pTag : String) : String;
begin
  Result := IfThen(pTag <> '', pTag, 'GERAL');
end;

class procedure TClsIniFiles.Setar(pArq, pTag, pCod : String; pVal : Variant);
var
  vArqIni: TIniFile;
  vVal : String;
begin
  pArq := ArqIni(pArq);
  pTag := TagIni(pTag);
  vVal := pVal;

  vArqIni := TIniFile.Create(pArq);
  try
    vArqIni.WriteString(pTag, pCod, vVal);
  finally
    vArqIni.Free;
  end;
end;

class function TClsIniFiles.Pegar(pArq, pTag, pCod, pDef : String) : String;
var
  vArqIni: TIniFile;
begin
  pArq := ArqIni(pArq);
  pTag := TagIni(pTag);

  vArqIni := TIniFile.Create(pArq);
  try
    Result := vArqIni.ReadString(pTag, pCod, pDef);
  finally
    vArqIni.Free;
  end;
end;

class function TClsIniFiles.PegarB(pArq, pTag, pCod : String; pDef : Boolean = False) : Boolean;
begin
  Result := StrToBoolDef(Pegar(pArq, pTag, pCod, ''), pDef);
end;

class function TClsIniFiles.PegarD(pArq, pTag, pCod : String; pDef : TDateTime = 0) : TDateTime;
begin
  Result := StrToDateTimeDef(Pegar(pArq, pTag, pCod, ''), pDef);
end;

class function TClsIniFiles.PegarF(pArq, pTag, pCod : String; pDef : Real = 0) : Real;
begin
  Result := StrToFloatDef(Pegar(pArq, pTag, pCod, ''), pDef);
end;

class function TClsIniFiles.PegarI(pArq, pTag, pCod : String; pDef : Integer = 0) : Integer;
begin
  Result := StrToIntDef(Pegar(pArq, pTag, pCod, ''), pDef);
end;

end.
