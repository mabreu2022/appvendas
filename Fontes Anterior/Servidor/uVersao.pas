unit uVersao;

interface

type
  TClsVersao = class
  public
    class function Get : String;
  end;

implementation

const
  cVERSAO = '20.09.22';

{ TClsVersao }

class function TClsVersao.Get: String;
begin
  Result := cVERSAO;
end;

end.
