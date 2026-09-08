unit uReceberCmd;

interface

uses
  System.Classes, System.StrUtils, System.SysUtils;

type
  TTipReceberCmd = (trGerado, trEnviado, trProcessado);

  TClsReceberCmd = class
  public
    class function getCmdUpdateCli(cod_emp, cod_cliente, num_fat, num_parc : integer) : string;
    class function getCmdUpdateFB(cod_emp, cod_cliente, num_fat, num_parc : integer) : string;
    class function getCmdSelectFB(cod_pagto: string;
      cod_emp, cod_cliente, num_fat, num_parc : integer) : string;
    class function getCmdInsertFB(cod_pagto: string;
      cod_emp, cod_cliente, num_fat, num_parc : integer) : string;
    class function getCmdDeleteFB(cod_pagto: string;
      cod_emp, cod_cliente, num_fat, num_parc : integer) : string;
  end;

  function TipReceberCmdToStr(tip : TTipReceberCmd) : string;
  function StrToTipReceberCmd(str : string) : TTipReceberCmd;

implementation

{ TClsReceberCmd }

const
  CTipReceberCmd : array [TTipReceberCmd] of string =
    ('G', 'E', 'P');

  function TipReceberCmdToStr(tip : TTipReceberCmd) : string;
  begin
    Result := CTipReceberCmd[tip];
  end;

  function StrToTipReceberCmd(str : string) : TTipReceberCmd;
  var
    I : Integer;
  begin
    for I := 0 to Ord(High(TTipReceberCmd)) do
    begin
      if (CTipReceberCmd[TTipReceberCmd(I)] = str) then
      begin
        Result := TTipReceberCmd(I);
        Exit;
      end;
    end;
  end;

class function TClsReceberCmd.getCmdUpdateCli(cod_emp, cod_cliente, num_fat, num_parc: integer): string;
const
  cSQL_UPDATE =
    'update FCR_FAT ' +
    'set INEXP = 2 ' +
    'where CODEMP = {COD_EMP} ' +
    'and CODCLIENTE = {COD_CLIENTE} ' +
    'and NUMFAT = {NUM_FAT} ' +
    'and NUMPARC = {NUM_PARC} ';
begin
  Result := cSQL_UPDATE;
  Result := ReplaceText(Result, '{COD_EMP}', IntToStr(cod_emp));
  Result := ReplaceText(Result, '{COD_CLIENTE}', IntToStr(cod_cliente));
  Result := ReplaceText(Result, '{NUM_FAT}', IntToStr(num_fat));
  Result := ReplaceText(Result, '{NUM_PARC}', IntToStr(num_parc));
end;

class function TClsReceberCmd.getCmdUpdateFB(cod_emp, cod_cliente, num_fat, num_parc: integer): string;
const
  cSQL_UPDATE =
    'update TB_RECEBER_REC ' +
    'set SIT_CONTROLE = ''{SIT_CONTROLE}'' ' +
    'where COD_EMP = {COD_EMP} ' +
    'and COD_CLIENTE = {COD_CLIENTE} ' +
    'and NUM_FAT = {NUM_FAT} ' +
    'and NUM_PARC = {NUM_PARC} ';
begin
  Result := cSQL_UPDATE;
  Result := ReplaceText(Result, '{COD_EMP}', IntToStr(cod_emp));
  Result := ReplaceText(Result, '{COD_CLIENTE}', IntToStr(cod_cliente));
  Result := ReplaceText(Result, '{NUM_FAT}', IntToStr(num_fat));
  Result := ReplaceText(Result, '{NUM_PARC}', IntToStr(num_parc));
  Result := ReplaceText(Result, '{SIT_CONTROLE}', TipReceberCmdToStr(trProcessado));
end;

class function TClsReceberCmd.getCmdSelectFB(cod_pagto: string;
  cod_emp, cod_cliente, num_fat, num_parc: integer): string;
const
  cSQL_SELECT =
    'select * from TB_RECEBER_REC ' +
    'where COD_PAGTO = ''{COD_PAGTO}'' ' +
    'and COD_EMP = {COD_EMP} ' +
    'and COD_CLIENTE = {COD_CLIENTE} ' +
    'and NUM_FAT = {NUM_FAT} ' +
    'and NUM_PARC = {NUM_PARC} ';
begin
  Result := cSQL_SELECT;
  Result := ReplaceText(Result, '{COD_PAGTO}', cod_pagto);
  Result := ReplaceText(Result, '{COD_EMP}', IntToStr(cod_emp));
  Result := ReplaceText(Result, '{COD_CLIENTE}', IntToStr(cod_cliente));
  Result := ReplaceText(Result, '{NUM_FAT}', IntToStr(num_fat));
  Result := ReplaceText(Result, '{NUM_PARC}', IntToStr(num_parc));
end;

class function TClsReceberCmd.getCmdInsertFB(cod_pagto: string;
  cod_emp, cod_cliente, num_fat, num_parc: integer): string;
const
  cSQL_INSERT =
    'insert into TB_RECEBER_REC (COD_PAGTO, COD_EMP, COD_CLIENTE, NUM_FAT, NUM_PARC) ' +
    'values (''{COD_PAGTO}'', {COD_EMP}, {COD_CLIENTE}, {NUM_FAT}, {NUM_PARC})';
begin
  Result := cSQL_INSERT;
  Result := ReplaceText(Result, '{COD_PAGTO}', cod_pagto);
  Result := ReplaceText(Result, '{COD_EMP}', IntToStr(cod_emp));
  Result := ReplaceText(Result, '{COD_CLIENTE}', IntToStr(cod_cliente));
  Result := ReplaceText(Result, '{NUM_FAT}', IntToStr(num_fat));
  Result := ReplaceText(Result, '{NUM_PARC}', IntToStr(num_parc));
end;

class function TClsReceberCmd.getCmdDeleteFB(cod_pagto: string;
  cod_emp, cod_cliente, num_fat, num_parc: integer): string;
const
  cSQL_DELETE =
    'delete from TB_RECEBER_REC ' +
    'where COD_PAGTO = ''{COD_PAGTO}'' ' +
    'and COD_EMP = {COD_EMP} ' +
    'and COD_CLIENTE = {COD_CLIENTE} ' +
    'and NUM_FAT = {NUM_FAT} ' +
    'and NUM_PARC = {NUM_PARC} ';
begin
  Result := cSQL_DELETE;
  Result := ReplaceText(Result, '{COD_PAGTO}', cod_pagto);
  Result := ReplaceText(Result, '{COD_EMP}', IntToStr(cod_emp));
  Result := ReplaceText(Result, '{COD_CLIENTE}', IntToStr(cod_cliente));
  Result := ReplaceText(Result, '{NUM_FAT}', IntToStr(num_fat));
  Result := ReplaceText(Result, '{NUM_PARC}', IntToStr(num_parc));
end;

end.
