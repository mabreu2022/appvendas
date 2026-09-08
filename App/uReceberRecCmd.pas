unit uReceberRecCmd;

interface

uses
  System.Classes, System.StrUtils, System.SysUtils;

type
  TTipReceberRecCmd = (trGerado, trEnviado, trProcessado);

  TClsReceberRecCmd = class
  public
    class function GetSelect(cod_pagto: string) : string;
    class function GetSelectPag(cod_pagto: string) : string;
    class function GetSelectPend() : string;
    class function GetInsert(cod_pagto: string;
      cod_emp, cod_cli, num_fat, num_par: integer) : string;
    class function GetInsertPag(cod_pagto: string;
      nro_pagto, tip_doc, cod_mod: Integer; vlr_doc: Real; dat_doc: TDateTime;
      nro_doc, nro_ban, nro_cta: integer) : string;
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

class function TClsReceberRecCmd.GetSelectPag(cod_pagto: string): string;
const
  cCMD_SELECT =
    'select * from TB_RECEBER_PAG ' +
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

class function TClsReceberRecCmd.GetInsert(cod_pagto: string;
  cod_emp, cod_cli, num_fat, num_par: integer) : string;
const
  cCMD_INSERT =
    'insert into TB_RECEBER_REC (COD_PAGTO, COD_EMP, COD_CLIENTE, NUM_FAT, NUM_PARC, USU_REC, DATA_REC, SIT_CONTROLE) ' +
    'values (''{cod_pagto}'', {cod_emp}, {cod_cli}, {num_fat}, {num_par}, {usu_rec}, ''{dat_rec}'', ''{sit_rec}'')';
begin
  Result := cCMD_INSERT;
  Result := ReplaceText(Result, '{cod_pagto}', cod_pagto);
  Result := ReplaceText(Result, '{cod_emp}', IntToStr(cod_emp));
  Result := ReplaceText(Result, '{cod_cli}', IntToStr(cod_cli));
  Result := ReplaceText(Result, '{num_fat}', IntToStr(num_fat));
  Result := ReplaceText(Result, '{num_par}', IntToStr(num_par));
  Result := ReplaceText(Result, '{usu_rec}', dmBanco.codusuario);
  Result := ReplaceText(Result, '{dat_rec}', DateToStr(date));
  Result := ReplaceText(Result, '{sit_rec}', TipReceberCmdToStr(trGerado));
end;

class function TClsReceberRecCmd.GetInsertPag(cod_pagto: string;
  nro_pagto, tip_doc, cod_mod: Integer; vlr_doc: Real; dat_doc: TDateTime;
  nro_doc, nro_ban, nro_cta: integer) : string;
const
  cCMD_INSERT =
    'insert into TB_RECEBER_PAG (COD_PAGTO, NRO_PAGTO, '+
      'TIP_DOCTO, COD_MOEDA, VLR_DOCTO, ' +
      'DAT_DOCTO, NRO_DOCTO, NRO_BANCO, NRO_CONTA) ' +
    'values (''{cod_pagto}'', {nro_pagto}, ' +
      '{tip_doc}, {cod_mod}, {vlr_doc}, ' +
      '''{dat_doc}'', {nro_doc}, {nro_ban}, {nro_cta})';
begin
  Result := cCMD_INSERT;
  Result := ReplaceText(Result, '{cod_pagto}', cod_pagto);
  Result := ReplaceText(Result, '{nro_pagto}', IntToStr(nro_pagto));
  Result := ReplaceText(Result, '{tip_doc}', IntToStr(tip_doc));
  Result := ReplaceText(Result, '{cod_mod}', IntToStr(cod_mod));
  Result := ReplaceText(Result, '{vlr_doc}', FloatToStr(vlr_doc));
  Result := ReplaceText(Result, '{dat_doc}', DateToStr(dat_doc));
  Result := ReplaceText(Result, '{nro_doc}', IntToStr(nro_doc));
  Result := ReplaceText(Result, '{nro_ban}', IntToStr(nro_ban));
  Result := ReplaceText(Result, '{nro_cta}', IntToStr(nro_cta));
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
