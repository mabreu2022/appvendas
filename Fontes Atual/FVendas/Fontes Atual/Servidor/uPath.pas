unit uPath;

interface

uses
  System.Classes, System.StrUtils, System.SysUtils,
  Forms;

type
  TClsPath = class
  public
    class function Get(APasta: string = ''; ASub : string = '';
      AArq : string = ''; ACreate : boolean = false): String;
  end;

implementation

{ TClsPath }

class function TClsPath.Get(APasta, ASub, AArq: String; ACreate: Boolean): String;
begin
  Result := IfThen(APasta <> '', APasta, ExtractFilePath(Application.ExeName));

  if ASub <> '' then
  begin
    Result := IncludeTrailingPathDelimiter(Result) + ASub;
  end;

  if ACreate then
  begin
    ForceDirectories(Result);
  end;

  if AArq <> '' then
  begin
    Result := IncludeTrailingPathDelimiter(Result) + AArq;
  end;
end;

end.
