unit uReceberRecCmd;

interface

uses
  System.Classes, System.StrUtils, System.SysUtils;

type
  TTipReceberRecCmd = (trGerado, trEnviado, trProcessado);

  TClsReceberRecCmd = class
  public
    class function GetSelect(cod_pagto: string) : string;
    class function GetSelectPend() : string;
    class function GetInsert(cod_pagto: string; cod_emp, cod_cliente, num_fat, num_parc: integer) : string;
    class function GetUpdate(cod_pagto: string) : string;
    class function GetDelete() : string;
  end;

  function TipReceberCmdToStr(tip : TTipReceberRecCmd) : string;
  function StrToTipReceberCmd(str : string) : TTipReceberRecCmd;

implementation

{ TClsReceberCmd }

uses
  uBanco;

const
  CTipReceberCmd : array [TTipReceberRecCmd] of string =
    ('G', 'E', 'P');

  function TipReceberCmdToStr(tip : TTipReceberRecCmd) : string;
  begin
    Result := CTipReceberCmd[tip];
  end;

  function StrToTipReceberCmd(str : string) : TTipReceberRecCmd;
  var
    I : Integer;
  begin
    for I := 0 to Ord(High(TTipReceberRecCmd)) do
    begin
      if (CTipReceberCmd[TTipReceberRecCmd(I)] = str) then
      begin
        Result := TTipReceberRecCmd(I);
        Exit;
      end;
    end;
  end;

class function TClsReceberRecCmd.GetSelect(cod_pagto: string): string;
const
  cCMD_SELECT =
    'select * from TB_RECEBER_REC ' +
    'where COD_PAGTO = ''{cod_pagto}'' ';
begin
  Result := cCMD_SELECT;
  Result := ReplaceText(Result, '{cod_pagto}', cod_pagto);
end;

class function TClsReceberRecCmd.GetSelectPend(): string;
const
  cCMD_SELECT =
    'select distinct COD_PAGTO from TB_RECEBER_REC ' +
    'where SIT_CONTROLE = ''{sit_controle}'' ';
begin
  Result := cCMD_SELECT;
  Result := ReplaceText(Result, '{sit_controle}', TipReceberCmdToStr(trGerado));
end;

class function TClsReceberRecCmd.GetInsert(cod_pagto: string; cod_emp, cod_cliente, num_fat, num_parc: integer) : string;
const
  cCMD_INSERT =
    'insert into TB_RECEBER_REC (COD_PAGTO, COD_EMP, COD_CLIENTE, NUM_FAT, NUM_PARC, USU_REC, DATA_REC, SIT_CONTROLE) ' +
    'values (''{cod_pagto}'', {cod_emp}, {cod_cliente}, {num_fat}, {num_parc}, {usu_rec}, ''{data_rec}'', ''{sit_controle}'')';
begin
  Result := cCMD_INSERT;
  Result := ReplaceText(Result, '{cod_pagto}', cod_pagto);
  Result := ReplaceText(Result, '{cod_emp}', IntToStr(cod_emp));
  Result := ReplaceText(Result, '{cod_cliente}', IntToStr(cod_cliente));
  Result := ReplaceText(Result, '{num_fat}', IntToStr(num_fat));
  Result := ReplaceText(Result, '{num_parc}', IntToStr(num_parc));
  Result := ReplaceText(Result, '{usu_rec}', dmBanco.codusuario);
  Result := ReplaceText(Result, '{data_rec}', DateToStr(date));
  Result := ReplaceText(Result, '{sit_controle}', TipReceberCmdToStr(trGerado));
end;

class function TClsReceberRecCmd.GetUpdate(cod_pagto: string): string;
const
  cCMD_UPDATE =
    'update TB_RECEBER_REC ' +
    'set SIT_CONTROLE = ''{sit_controle}'' ' +
    'where COD_PAGTO = ''{cod_pagto}'' ';
begin
  Result := cCMD_UPDATE;
  Result := ReplaceText(Result, '{cod_pagto}', cod_pagto);
  Result := ReplaceText(Result, '{sit_controle}', TipReceberCmdToStr(trEnviado));
end;

class function TClsReceberRecCmd.GetDelete(): string;
const
  cCMD_UPDATE =
    'delete from  TB_RECEBER_REC ' +
    'where SIT_CONTROLE = ''{sit_controle}'' ';
begin
  Result := cCMD_UPDATE;
  Result := ReplaceText(Result, '{sit_controle}', TipReceberCmdToStr(trEnviado));
end;

end.
