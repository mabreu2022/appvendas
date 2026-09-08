unit uSincronizar;
interface
uses
  FMX.Dialogs,
  System.Classes, System.StrUtils, System.SysUtils,
  REST.Types, REST.Client, FireDAC.Comp.Client, untAtualizarBD;
type
  TRecSincronizar = record
    Erro : Boolean;
    Mensagem : String;
    Qtde : Integer;
  end;
  TClsSincronizar = class
  private
    class procedure SetHeaders(aRequest: TRESTRequest);
  public
    class function GetUsuarios : TRecSincronizar;
    class function GetClientes: TRecSincronizar;
    class function GetProdutos: TRecSincronizar;
    class function GetVendedores: TRecSincronizar;
    class function GetCondPagto: TRecSincronizar;
    class function SetPedido(Codigo: String; Mostrar : Boolean = True): TRecSincronizar;
    class function SetPedidoPend(): TRecSincronizar;
    class function GetReceber: TRecSincronizar;
    class function SetReceber(cod_pagto: string): TRecSincronizar;
    class function SetReceberPag(cod_pagto: string): TRecSincronizar;
    class function SetReceberPend(): TRecSincronizar;
    class function IncReceber(cod_pagto: string;
      cod_emp, cod_cli, num_fat, num_par: integer): TRecSincronizar;
    class function UpdReceber(cod_pagto: string): TRecSincronizar;
    class function RemReceberPend(): TRecSincronizar;
    class function IncReceberPag(cod_pagto: string;
      nro_pagto, tip_doc, cod_mod: Integer; vlr_doc: Real; dat_doc: TDateTime;
      nro_doc, nro_ban, nro_cta: integer): TRecSincronizar;
    class function GetBancos : TRecSincronizar;
    class function GetContas : TRecSincronizar;
    class function GetMoedas : TRecSincronizar;
    class function GetRecibo : TRecSincronizar;
    class function GetEmpresa : TRecSincronizar;
  end;
implementation
uses
  uBanco, uFuncoes, uReceberRecCmd, uConverter, uSerial;
const
  cJSON_VAZIO = '[]';
{ TClsSincronizar }
  class procedure TClsSincronizar.SetHeaders(aRequest: TRESTRequest);
  begin
    aRequest.Params.Clear();
    aRequest.Params.AddItem('serial', dmBanco.serial);
  end;
class function TClsSincronizar.GetUsuarios: TRecSincronizar;
var
  str: String;
begin
  try
    dmBanco.ClientUsuario.BaseURL := 'http://' + dmBanco.servidor + ':' + dmBanco.porta + '/GetUsuario';
    dmBanco.RequestUsuario.Method := TRESTRequestMethod.rmGET;
    SetHeaders(dmBanco.RequestUsuario);
    dmBanco.RequestUsuario.Execute;
    str := (dmBanco.ResponseUsuario.Content);
    if JsonIsEmpty(str) then Exit;
    JsonToDataset(dmBanco.memUsuario, str);
    dmBanco.memUsuario.DisableControls;
    dmBanco.memUsuario.Last;
    dmBanco.memUsuario.First;
    dmBanco.ExecComando('delete from TB_USUARIO');
    dmBanco.qryUsuario.Close;
    dmBanco.qryUsuario.Open;
    while not dmBanco.memUsuario.Eof do
    begin
      dmBanco.qryUsuario.Insert;
      dmBanco.qryUsuarioCODIGO.Value := dmBanco.memUsuario.FieldByName('CODIGO').AsInteger;
      dmBanco.qryUsuarioNOME.Value := dmBanco.memUsuario.FieldByName('NOME').AsString;
      dmBanco.qryUsuarioLOGIN.Value := dmBanco.memUsuario.FieldByName('LOGIN').AsString;
      dmBanco.qryUsuarioSENHA.Value := dmBanco.memUsuario.FieldByName('SENHA').AsString;
      dmBanco.qryUsuario.Post;
      dmBanco.memUsuario.Next;
    end;
    result.Qtde := dmBanco.memUsuario.RecordCount;
    dmBanco.memUsuario.Close;
  except
    on E : Exception do begin
      result.Erro := true;
      result.Mensagem := 'Erro ao sincronizar usuários !!!' + E.Message;
      raise Exception.Create(result.Mensagem);
    end;
  end;
end;
class function TClsSincronizar.GetClientes: TRecSincronizar;
var
  str : string;
begin
  try
    dmBanco.ClientClientes.BaseURL := 'http://' + dmBanco.servidor + ':' + dmBanco.porta + '/GetClientes';
    dmBanco.RequestClientes.Method := TRESTRequestMethod.rmGET;
    SetHeaders(dmBanco.RequestClientes);
    dmBanco.RequestClientes.Execute;
    str := (dmBanco.ResponseClientes.Content);
    if JsonIsEmpty(str) then Exit;
    JsonToDataset(dmBanco.memClientes, str);
    dmBanco.memClientes.DisableControls;
    dmBanco.memClientes.Last;
    dmBanco.memClientes.First;
    dmBanco.ExecComando('delete from TB_CLIENTE');
    dmBanco.qryClientes.Close;
    dmBanco.qryClientes.Open;
    while not dmBanco.memClientes.Eof do
    begin
      dmBanco.qryClientes.Insert;
      dmBanco.qryClientesCODIGO.Value := dmBanco.memClientes.FieldByName('CODIGO').AsString;
      dmBanco.qryClientesNOME.Value := dmBanco.memClientes.FieldByName('NOME').AsString;
      dmBanco.qryClientesCNPJ_CPF.Value := dmBanco.memClientes.FieldByName('CNPJ_CPF').AsString;
      dmBanco.qryClientesLOGRADOURO.Value := dmBanco.memClientes.FieldByName('LOGRADOURO').AsString;
      dmBanco.qryClientesNUMERO.Value := dmBanco.memClientes.FieldByName('NUMERO').AsString;
      dmBanco.qryClientesBAIRRO.Value := dmBanco.memClientes.FieldByName('BAIRRO').AsString;
      dmBanco.qryClientesCIDADE_DESCRICAO.Value := dmBanco.memClientes.FieldByName('CIDADE_DESCRICAO').AsString;
      dmBanco.qryClientesTELEFONE.Value := dmBanco.memClientes.FieldByName('TELEFONE').AsString;
      dmBanco.qryClientesCONTATO.Value := dmBanco.memClientes.FieldByName('CONTATO').AsString;
      dmBanco.qryClientes.Post;
      dmBanco.memClientes.Next;
    end;
    result.Qtde := dmBanco.memClientes.RecordCount;
    dmBanco.memClientes.Close;
  except
    on E : Exception do begin
      result.Erro := true;
      result.Mensagem := 'Erro ao sincronizar clientes !!!' + E.Message;
      raise Exception.Create(result.Mensagem);
    end;
  end;
end;
class function TClsSincronizar.GetProdutos: TRecSincronizar;
var
  str: String;
begin
  try
    dmBanco.Clientprodutos.BaseURL := 'http://' + dmBanco.servidor + ':' + dmBanco.porta + '/GetProdutos';
    dmBanco.Requestprodutos.Method := TRESTRequestMethod.rmGET;
    SetHeaders(dmBanco.Requestprodutos);
    dmBanco.Requestprodutos.Execute;
    str := (dmBanco.Responseprodutos.Content);
    if JsonIsEmpty(str) then Exit;
    JsonToDataset(dmBanco.memprodutos, str);
    dmBanco.memprodutos.DisableControls;
    dmBanco.memprodutos.Last;
    dmBanco.memprodutos.First;
    dmBanco.ExecComando('delete from TB_PRODUTO');
    dmBanco.qryProdutos.Close;
    dmBanco.qryProdutos.Open;
    while not dmBanco.memprodutos.Eof do
    begin
      dmBanco.qryProdutos.Insert;
      dmBanco.qryProdutosCODIGO.Value := dmBanco.memprodutos.FieldByName('CODIGO').AsString;
      dmBanco.qryProdutosDESCRICAO.Value := dmBanco.memprodutos.FieldByName('DESCRICAO').AsString;
      dmBanco.qryProdutosDESCRICAO_RED.Value := dmBanco.memprodutos.FieldByName('DESCRICAO_RED').AsString;
      dmBanco.qryProdutosBARRAS.Value := dmBanco.memprodutos.FieldByName('BARRAS').AsString;
      dmBanco.qryProdutosUNIDADE.Value := dmBanco.memprodutos.FieldByName('UNIDADE').AsString;
      dmBanco.qryProdutosPRECO_VENDA.Value := dmBanco.memprodutos.FieldByName('PRECO_VENDA').AsCurrency;
      dmBanco.qryProdutosPRECO_MIN.Value := dmBanco.memprodutos.FieldByName('PRECO_MIN').AsCurrency;
      dmBanco.qryProdutosPRECO_ATACADO.Value := dmBanco.memprodutos.FieldByName('PRECO_ATACADO').AsCurrency;
      dmBanco.qryProdutosPRECO_COMPRA.Value := dmBanco.memprodutos.FieldByName('PRECO_COMPRA').AsCurrency;
      dmBanco.qryProdutosINFO_ADIC.AsString := dmBanco.memprodutos.FieldByName('INFO_ADIC').AsString;
      dmBanco.qryProdutos.Post;
      dmBanco.memprodutos.Next;
    end;
    result.Qtde := dmBanco.memprodutos.RecordCount;
    dmBanco.memprodutos.Close;
  except
    on E : Exception do begin
      result.Erro := true;
      result.Mensagem := 'Erro ao sincronizar produtos !!!' + E.Message;
      raise Exception.Create(result.Mensagem);
    end;
  end;
end;
class function TClsSincronizar.GetVendedores: TRecSincronizar;
var
  str : string;
begin
  try
    dmBanco.ClientVendedor.BaseURL := 'http://' + dmBanco.servidor + ':' + dmBanco.porta + '/GetVendedor';
    dmBanco.RequestVendedor.Method := TRESTRequestMethod.rmGET;
    SetHeaders(dmBanco.RequestVendedor);
    dmBanco.RequestVendedor.Execute;
    str := (dmBanco.ResponseVendedor.Content);
    if JsonIsEmpty(str) then Exit;
    JsonToDataset(dmBanco.memVendedor, str);
    dmBanco.memVendedor.DisableControls;
    dmBanco.memVendedor.Last;
    dmBanco.memVendedor.First;
    dmBanco.ExecComando('delete from TB_VENDEDOR');
    dmBanco.qryVendedor.Close;
    dmBanco.qryVendedor.Open;
    while not dmBanco.memVendedor.Eof do
    begin
      dmBanco.qryVendedor.Insert;
      dmBanco.qryVendedorCODIGO.Value := dmBanco.memVendedor.FieldByName('CODIGO').AsString;
      dmBanco.qryVendedorNOME.Value := dmBanco.memVendedor.FieldByName('NOME').AsString;
      dmBanco.qryVendedorUSUARIO.Value := dmBanco.memVendedor.FieldByName('USUARIO').AsString;
      dmBanco.qryVendedorSENHA.Value := dmBanco.memVendedor.FieldByName('SENHA').AsString;
      dmBanco.qryVendedorEMAIL.Value := dmBanco.memVendedor.FieldByName('EMAIL').AsString;
      dmBanco.qryVendedorPORC_DESC.Value := dmBanco.memVendedor.FieldByName('PORC_DESC').AsFloat;
      dmBanco.qryVendedorPORC_ADIC.Value := dmBanco.memVendedor.FieldByName('PORC_ADIC').AsFloat;
      dmBanco.qryVendedorPORC_DESC_ITEM.Value := dmBanco.memVendedor.FieldByName('PORC_DESC_ITEM').AsFloat;
      dmBanco.qryVendedorCAD_CLI.Value := dmBanco.memVendedor.FieldByName('CAD_CLI').AsString;
      dmBanco.qryVendedorCAD_PED.Value := dmBanco.memVendedor.FieldByName('CAD_PED').AsString;
      dmBanco.qryVendedorBONIFICA.Value := dmBanco.memVendedor.FieldByName('BONIFICA').AsString;
      dmBanco.qryVendedorACESSO.Value := dmBanco.memVendedor.FieldByName('ACESSO').AsString;
      dmBanco.qryVendedor.Post;
      dmBanco.memVendedor.Next;
    end;
    result.Qtde := dmBanco.memVendedor.RecordCount;
    dmBanco.memVendedor.Close;
  except
    on E : Exception do begin
      result.Erro := true;
      result.Mensagem := 'Erro ao sincronizar vendedores !!!' + E.Message;
      raise Exception.Create(result.Mensagem);
    end;
  end;
end;
class function TClsSincronizar.GetCondPagto: TRecSincronizar;
var
  str: String;
begin
  try
    dmBanco.ClientCondicao.BaseURL := 'http://' + dmBanco.servidor + ':' + dmBanco.porta + '/GetCondicao';
    dmBanco.RequestCondicao.Method := TRESTRequestMethod.rmGET;
    SetHeaders(dmBanco.RequestCondicao);
    dmBanco.RequestCondicao.Execute;
    str := (dmBanco.ResponseCondicao.Content);
    if JsonIsEmpty(str) then Exit;
    JsonToDataset(dmBanco.memCondicao, str);
    dmBanco.memCondicao.DisableControls;
    dmBanco.memCondicao.Last;
    dmBanco.memCondicao.First;
    dmBanco.ExecComando('delete from TB_COND_PAGTO');
    dmBanco.qryCondicaoPagto.Close;
    dmBanco.qryCondicaoPagto.Open;
    while not dmBanco.memCondicao.Eof do
    begin
      dmBanco.qryCondicaoPagto.Insert;
      dmBanco.qryCondicaoPagtoCODIGO.Value := dmBanco.memCondicao.FieldByName('CODIGO').AsInteger;
      dmBanco.qryCondicaoPagtoDESCRICAO.Value := dmBanco.memCondicao.FieldByName('DESCRICAO').AsString;
      dmBanco.qryCondicaoPagto.Post;
      dmBanco.memCondicao.Next;
    end;
    result.Qtde := dmBanco.memCondicao.RecordCount;
    dmBanco.memCondicao.Close;
  except
    on E : Exception do begin
      result.Erro := true;
      result.Mensagem := 'Erro ao sincronizar cond. pagtos !!!' + E.Message;
      raise Exception.Create(result.Mensagem);
    end;
  end;
end;
class function TClsSincronizar.SetPedido(Codigo: String; Mostrar : Boolean): TRecSincronizar;
var
  str: String;
begin
  try
    dmBanco.qryAux.Close;
    dmBanco.qryAux.sql.Clear;
    dmBanco.qryAux.sql.Add(
      'select * from TB_PEDIDO p ' +
      'inner join TB_ITENS_PEDIDO i on p.codigo = i.cod_pedido ' +
      'where p.CODIGO = :codigo');
    dmBanco.qryAux.ParamByName('codigo').Value := Codigo;
    dmBanco.qryAux.Open;
    if not dmBanco.qryAux.IsEmpty then
    begin
      str := DatasetToJson(dmBanco.qryAux);
      dmBanco.Clientpedidos.BaseURL := 'http://' + dmBanco.servidor + ':' + dmBanco.porta + '/SetPedido';
      dmBanco.Requestpedidos.Method := TRESTRequestMethod.rmPOST;
      SetHeaders(dmBanco.Requestpedidos);
      with dmBanco.Requestpedidos.Params.AddItem do
      begin
        name := 'json';
        Value := str;
      end;
      dmBanco.RequestPedidos.Execute;
      dmBanco.qryAux.Close;
      result.Qtde := 1;
    end;
  except
    on E : Exception do begin
      result.Erro := true;
      result.Mensagem := 'Erro ao sincronizar pedido !!!' + E.Message;
      if Mostrar then
        raise Exception.Create(result.Mensagem);
    end;
  end;
end;
class function TClsSincronizar.SetPedidoPend: TRecSincronizar;
begin
//
end;
class function TClsSincronizar.GetReceber: TRecSincronizar;
var
  str: String;
begin
  try
    dmBanco.ClientReceber.BaseURL := 'http://' + dmBanco.servidor + ':' + dmBanco.porta + '/GetReceber';
    dmBanco.RequestReceber.Method := TRESTRequestMethod.rmGET;
    SetHeaders(dmBanco.RequestReceber);
    dmBanco.RequestReceber.Execute;
    str := (dmBanco.ResponseReceber.Content);
    if JsonIsEmpty(str) then Exit;
    JsonToDataset(dmBanco.memReceber, str);
    dmBanco.memReceber.DisableControls;
    dmBanco.memReceber.Last;
    dmBanco.memReceber.First;
    dmBanco.ExecComando('delete from TB_RECEBER');
    dmBanco.qryReceber.Close;
    dmBanco.qryReceber.Open;
    while not dmBanco.memReceber.Eof do
    begin
      dmBanco.qryReceber.Insert;
      with dmBanco.memReceber do
      begin
        dmBanco.qryReceberCOD_EMP     .Value :=   TClsConverter.StrToInteger(FieldByName('COD_EMP'     ).AsString);
        dmBanco.qryReceberCOD_CLIENTE .Value :=   TClsConverter.StrToInteger(FieldByName('COD_CLIENTE' ).AsString);
        dmBanco.qryReceberNUM_FAT     .Value :=   TClsConverter.StrToInteger(FieldByName('NUM_FAT'     ).AsString);
        dmBanco.qryReceberNUM_PARC    .Value :=   TClsConverter.StrToInteger(FieldByName('NUM_PARC'    ).AsString);
        dmBanco.qryReceberNOM_CLIENTE .Value :=                              FieldByName('NOM_CLIENTE' ).AsString;
        dmBanco.qryReceberSITUACAO    .Value :=                              FieldByName('SITUACAO'    ).AsString;
        dmBanco.qryReceberDATA_EMISSAO.Value := TClsConverter.StrToTimeStamp(FieldByName('DATA_EMISSAO').AsString);
        dmBanco.qryReceberDATA_VENCTO .Value := TClsConverter.StrToTimeStamp(FieldByName('DATA_VENCTO' ).AsString);
        dmBanco.qryReceberCOD_PORT    .Value :=   TClsConverter.StrToInteger(FieldByName('COD_PORT'    ).AsString);
        dmBanco.qryReceberCOD_MOEDA   .Value :=   TClsConverter.StrToInteger(FieldByName('COD_MOEDA'   ).AsString);
        dmBanco.qryReceberVLR_FATURA  .Value :=     TClsConverter.StrToFloat(FieldByName('VLR_FATURA'  ).AsString);
        dmBanco.qryReceberTIP_DOC     .Value :=   TClsConverter.StrToInteger(FieldByName('TIP_DOC'     ).AsString);
        dmBanco.qryReceberNUM_DOC     .Value :=   TClsConverter.StrToInteger(FieldByName('NUM_DOC'     ).AsString);
        dmBanco.qryReceberUSUARIO     .Value :=   TClsConverter.StrToInteger(FieldByName('USUARIO'     ).AsString);
        dmBanco.qryReceberCOD_VEND    .Value :=   TClsConverter.StrToInteger(FieldByName('COD_VEND'    ).AsString);
        dmBanco.qryReceberNUM_NOTA    .Value :=   TClsConverter.StrToInteger(FieldByName('NUM_NOTA'    ).AsString);
        dmBanco.qryReceberNUM_MOV     .Value :=   TClsConverter.StrToInteger(FieldByName('NUM_MOV'     ).AsString);
        dmBanco.qryReceberDATA_MOV    .Value := TClsConverter.StrToTimeStamp(FieldByName('DATA_MOV'    ).AsString);
      end;
      dmBanco.qryReceber.Post;
      dmBanco.memReceber.Next;
    end;
    result.Qtde := dmBanco.memReceber.RecordCount;
    dmBanco.memReceber.Close;
  except
    on E : Exception do begin
      result.Erro := true;
      result.Mensagem := 'Erro ao sincronizar receber !!!' + E.Message;
      raise Exception.Create(result.Mensagem);
    end;
  end;
end;
class function TClsSincronizar.SetReceber(cod_pagto: string): TRecSincronizar;
var
  qry: TFDQuery;
  cmd, str: string;
begin
  try
    cmd := TClsReceberRecCmd.GetSelect(cod_pagto);
    qry := dmBanco.GetQuery(cmd);
    if not qry.IsEmpty then
    begin
      str := DatasetToJson(qry);
      dmBanco.ClientReceber.BaseURL := 'http://' + dmBanco.servidor + ':' + dmBanco.porta + '/SetReceber';
      dmBanco.RequestReceber.Method := TRESTRequestMethod.rmPOST;
      SetHeaders(dmBanco.RequestReceber);
      with dmBanco.RequestReceber.Params.AddItem do
      begin
        name := 'json';
        Value := str;
      end;
      dmBanco.RequestReceber.Execute;
      qry.Free;
      UpdReceber(cod_pagto);
      result.Qtde := 1;
    end;
  except
    on E : Exception do begin
      result.Erro := true;
      result.Mensagem := 'Erro ao sincronizar receber (SetReceber) !!!' + E.Message;
      raise Exception.Create(result.Mensagem);
    end;
  end;
end;
class function TClsSincronizar.SetReceberPag(cod_pagto: string): TRecSincronizar;
var
  qry: TFDQuery;
  cmd, str: string;
begin
  try
    cmd := TClsReceberRecCmd.GetSelectPag(cod_pagto);
    qry := dmBanco.GetQuery(cmd);
    if not qry.IsEmpty then
    begin
      str := DatasetToJson(qry);
      dmBanco.ClientReceber.BaseURL := 'http://' + dmBanco.servidor + ':' + dmBanco.porta + '/SetReceberPag';
      dmBanco.RequestReceber.Method := TRESTRequestMethod.rmPOST;
      SetHeaders(dmBanco.RequestReceber);
      with dmBanco.RequestReceber.Params.AddItem do
      begin
        name := 'json';
        Value := str;
      end;
      dmBanco.RequestReceber.Execute;
      qry.Free;
      UpdReceber(cod_pagto);
      result.Qtde := 1;
    end;
  except
    on E : Exception do begin
      result.Erro := true;
      result.Mensagem := 'Erro ao sincronizar receber (SetReceber) !!!' + E.Message;
      raise Exception.Create(result.Mensagem);
    end;
  end;
end;
class function TClsSincronizar.SetReceberPend(): TRecSincronizar;
var
  qry: TFDQuery;
  cmd: String;
begin
  try
    cmd := TClsReceberRecCmd.GetSelectPend();
    qry := dmBanco.GetQuery(cmd);
    if not qry.IsEmpty then
    begin
      while not qry.eof do
      begin
        SetReceberPag(qry.FieldByName('COD_PAGTO').AsString);
        SetReceber(qry.FieldByName('COD_PAGTO').AsString);
        qry.Next;
      end;
      result.Qtde := 1;
    end;
  except
    on E : Exception do begin
      result.Erro := true;
      result.Mensagem := 'Erro ao sincronizar receber pend !!!' + E.Message;
      raise Exception.Create(result.Mensagem);
    end;
  end;
end;
class function TClsSincronizar.IncReceber(cod_pagto: string;
  cod_emp, cod_cli, num_fat, num_par: integer): TRecSincronizar;
var
  cmd: string;
begin
  try
    cmd := TClsReceberRecCmd.GetInsert(cod_pagto,
      cod_emp, cod_cli, num_fat, num_par);
    dmBanco.ExecComando(cmd);
    result.Qtde := 1;
  except
    on E : Exception do begin
      result.Erro := true;
      result.Mensagem := 'Erro ao incluir receber !!!' + E.Message;
      raise Exception.Create(result.Mensagem);
    end;
  end;
end;
class function TClsSincronizar.IncReceberPag(cod_pagto: string;
  nro_pagto, tip_doc, cod_mod: Integer; vlr_doc: Real; dat_doc: TDateTime;
  nro_doc, nro_ban, nro_cta: integer): TRecSincronizar;
var
  cmd: string;
begin
  try
    cmd := TClsReceberRecCmd.GetInsertPag(cod_pagto,
      nro_pagto, tip_doc, cod_mod, vlr_doc,
      dat_doc, nro_doc, nro_ban, nro_cta);
    dmBanco.ExecComando(cmd);
    result.Qtde := 1;
  except
    on E : Exception do begin
      result.Erro := true;
      result.Mensagem := 'Erro ao incluir receber pag !!!' + E.Message;
      raise Exception.Create(result.Mensagem);
    end;
  end;
end;
class function TClsSincronizar.UpdReceber(cod_pagto: string): TRecSincronizar;
var
  cmd: string;
begin
  try
    cmd := TClsReceberRecCmd.GetUpdate(cod_pagto);
    dmBanco.ExecComando(cmd);
    result.Qtde := 1;
  except
    on E : Exception do begin
      result.Erro := true;
      result.Mensagem := 'Erro ao atualizar receber !!!' + E.Message;
      raise Exception.Create(result.Mensagem);
    end;
  end;
end;
class function TClsSincronizar.RemReceberPend(): TRecSincronizar;
var
  cmd: string;
begin
  try
    cmd := TClsReceberRecCmd.GetDelete();
    dmBanco.ExecComando(cmd);
    result.Qtde := 1;
  except
    on E : Exception do begin
      result.Erro := true;
      result.Mensagem := 'Erro ao excluir receber pend !!!' + E.Message;
      raise Exception.Create(result.Mensagem);
    end;
  end;
end;
class function TClsSincronizar.GetBancos : TRecSincronizar;
var
  str: String;
begin
  try
    dmBanco.ClientBanco.BaseURL := 'http://' + dmBanco.servidor + ':' + dmBanco.porta + '/GetBanco';
    dmBanco.RequestBanco.Method := TRESTRequestMethod.rmGET;
    SetHeaders(dmBanco.RequestBanco);
    dmBanco.RequestBanco.Execute;
    str := (dmBanco.ResponseBanco.Content);
    if JsonIsEmpty(str) then Exit;
    JsonToDataset(dmBanco.memBanco, str);
    dmBanco.memBanco.DisableControls;
    dmBanco.memBanco.Last;
    dmBanco.memBanco.First;
    dmBanco.ExecComando('delete from TB_BANCO');
    dmBanco.qryBanco.Close;
    dmBanco.qryBanco.Open;
    while not dmBanco.memBanco.Eof do
    begin
      dmBanco.qryBanco.Insert;
      dmBanco.qryBancoNRO_CODIGO.Value := dmBanco.memBanco.FieldByName('NRO_CODIGO').AsInteger;
      dmBanco.qryBancoNRO_BANCO.Value := dmBanco.memBanco.FieldByName('NRO_BANCO').AsInteger;
      dmBanco.qryBancoNRO_AGENCIA.Value := dmBanco.memBanco.FieldByName('NRO_AGENCIA').AsString;
      dmBanco.qryBancoDESC_BANCO.Value := dmBanco.memBanco.FieldByName('DESC_BANCO').AsString;
      dmBanco.qryBancoSIT_BANCO.Value := dmBanco.memBanco.FieldByName('SIT_BANCO').AsInteger;
      dmBanco.qryBanco.Post;
      dmBanco.memBanco.Next;
    end;
    result.Qtde := dmBanco.memBanco.RecordCount;
    dmBanco.memUsuario.Close;
  except
    on E : Exception do begin
      result.Erro := true;
      result.Mensagem := 'Erro ao sincronizar bancos !!!' + E.Message;
      raise Exception.Create(result.Mensagem);
    end;
  end;
end;
class function TClsSincronizar.GetContas : TRecSincronizar;
var
  str: String;
begin
  try
    dmBanco.ClientConta.BaseURL := 'http://' + dmBanco.servidor + ':' + dmBanco.porta + '/GetConta';
    dmBanco.RequestConta.Method := TRESTRequestMethod.rmGET;
    SetHeaders(dmBanco.RequestConta);
    dmBanco.RequestConta.Execute;
    str := (dmBanco.ResponseConta.Content);
    if JsonIsEmpty(str) then Exit;
    JsonToDataset(dmBanco.memConta, str);
    dmBanco.memConta.DisableControls;
    dmBanco.memConta.Last;
    dmBanco.memConta.First;
    dmBanco.ExecComando('delete from TB_CONTA');
    dmBanco.qryConta.Close;
    dmBanco.qryConta.Open;
    while not dmBanco.memConta.Eof do
    begin
      dmBanco.qryConta.Insert;
      dmBanco.qryContaCOD_EMPRESA.Value := dmBanco.memConta.FieldByName('COD_EMPRESA').AsInteger;
      dmBanco.qryContaNRO_CODIGO.Value := dmBanco.memConta.FieldByName('NRO_CODIGO').AsInteger;
      dmBanco.qryContaNRO_BANCO.Value := dmBanco.memConta.FieldByName('NRO_BANCO').AsInteger;
      dmBanco.qryContaCOD_CONTA.Value := dmBanco.memConta.FieldByName('COD_CONTA').AsString;
      dmBanco.qryContaDESC_CONTA.Value := dmBanco.memConta.FieldByName('DESC_CONTA').AsString;
      dmBanco.qryContaTIP_CONTA.Value := dmBanco.memConta.FieldByName('TIP_CONTA').AsInteger;
      dmBanco.qryContaSIT_CONTA.Value := dmBanco.memConta.FieldByName('SIT_CONTA').AsString;
      dmBanco.qryContaCOD_MOEDA.Value := dmBanco.memConta.FieldByName('COD_MOEDA').AsInteger;
      dmBanco.qryConta.Post;
      dmBanco.memConta.Next;
    end;
    result.Qtde := dmBanco.memConta.RecordCount;
    dmBanco.memConta.Close;
  except
    on E : Exception do begin
      result.Erro := true;
      result.Mensagem := 'Erro ao sincronizar contas !!!' + E.Message;
      raise Exception.Create(result.Mensagem);
    end;
  end;
end;
class function TClsSincronizar.GetEmpresa: TRecSincronizar;
begin
 dmBanco.SincronizarDados(dmBanco.FDMemTable1, '/GetEmpresa');
  if dmBanco.FDMemTable1.RecordCount > 0 then
    TAtualizaBD.GravarDados('ADM_EMPRESA', dmBanco.FDMemTable1);
  dmBanco.FDMemTable1.Close;
end;

class function TClsSincronizar.GetMoedas : TRecSincronizar;
var
  str: String;
begin
  try
    dmBanco.ClientMoeda.BaseURL := 'http://' + dmBanco.servidor + ':' + dmBanco.porta + '/GetMoeda';
    dmBanco.RequestMoeda.Method := TRESTRequestMethod.rmGET;
    SetHeaders(dmBanco.RequestMoeda);
    dmBanco.RequestMoeda.Execute;
    str := (dmBanco.ResponseMoeda.Content);
    if JsonIsEmpty(str) then Exit;
    JsonToDataset(dmBanco.memMoeda, str);
    dmBanco.memMoeda.DisableControls;
    dmBanco.memMoeda.Last;
    dmBanco.memMoeda.First;
    dmBanco.ExecComando('delete from TB_MOEDA');
    dmBanco.qryMoeda.Close;
    dmBanco.qryMoeda.Open;
    while not dmBanco.memMoeda.Eof do
    begin
      dmBanco.qryMoeda.Insert;
      dmBanco.qryMoedaCOD_MOEDA.Value := dmBanco.memMoeda.FieldByName('COD_MOEDA').AsInteger;
      dmBanco.qryMoedaDESC_MOEDA.Value := dmBanco.memMoeda.FieldByName('DESC_MOEDA').AsString;
      dmBanco.qryMoedaSIMB_MOEDA.Value := dmBanco.memMoeda.FieldByName('SIMB_MOEDA').AsString;
      dmBanco.qryMoeda.Post;
      dmBanco.memMoeda.Next;
    end;
    result.Qtde := dmBanco.memMoeda.RecordCount;
    dmBanco.memMoeda.Close;
  except
    on E : Exception do begin
      result.Erro := true;
      result.Mensagem := 'Erro ao sincronizar moedas !!!' + E.Message;
      raise Exception.Create(result.Mensagem);
    end;
  end;
end;
class function TClsSincronizar.GetRecibo : TRecSincronizar;
var
  str: String;
begin
  try
    dmBanco.ClientRecibo.BaseURL := 'http://' + dmBanco.servidor + ':' + dmBanco.porta + '/GetRecibo';
    dmBanco.RequestRecibo.Method := TRESTRequestMethod.rmGET;
    SetHeaders(dmBanco.RequestRecibo);
    dmBanco.RequestRecibo.Execute;
    str := (dmBanco.ResponseRecibo.Content);
    if JsonIsEmpty(str) then Exit;
    JsonToDataset(dmBanco.memRecibo, str);
    dmBanco.memRecibo.DisableControls;
    dmBanco.memRecibo.Last;
    dmBanco.memRecibo.First;
    dmBanco.ExecComando('delete from TB_RECIBO');
    dmBanco.qryRecibo.Close;
    dmBanco.qryRecibo.Open;
    while not dmBanco.memRecibo.Eof do
    begin
      dmBanco.qryRecibo.Insert;
      dmBanco.qryReciboCOD_RECIBO.Value := dmBanco.memRecibo.FieldByName('COD_RECIBO').AsString;
      dmBanco.qryReciboNRO_RECIBO.Value := dmBanco.memRecibo.FieldByName('NRO_RECIBO').AsInteger;
      dmBanco.qryRecibo.Post;
      dmBanco.memRecibo.Next;
    end;
    result.Qtde := dmBanco.memRecibo.RecordCount;
    dmBanco.memRecibo.Close;
  except
    on E : Exception do begin
      result.Erro := true;
      result.Mensagem := 'Erro ao sincronizar recibos !!!' + E.Message;
      raise Exception.Create(result.Mensagem);
    end;
  end;
end;
end.
