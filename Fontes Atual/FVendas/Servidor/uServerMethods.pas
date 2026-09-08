unit uServerMethods;

interface

uses
  System.SysUtils, System.Classes, System.JSON, Dialogs, ServerUtils,
  SysTypes, System.StrUtils,
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Phys.FBDef, FireDAC.Phys.IBBase, FireDAC.Phys.FB, FireDAC.Comp.UI,
  Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, System.uJson,
  Data.DB.Helper, REST.Response.Adapter;

type
{$METHODINFO ON}

  TMetServerMethods = (
    tmGet, tmPost, tmHead);

  TReqServerMethods = (
    trGetVendedor, trGetClientes, trGetProdutos, trGetCondicao,
    trGetUsuario, trGetPedidos, trGetReceber,
    trGetBanco, trGetConta, trGetMoeda, trGetRecibo,
    trSetPedido,
    trSetReceber, trSetReceberRec, trSetReceberPag);

  TServerMethods1 = class(TComponent)
  private
    function DatasetToJson(const ADataset: TDataset): string;
    procedure JsonToDataset(ADataset: TDataset; aJSON: string);
  public
    function GetVendedor: String;
    function GetUsuario: String;
    function GetClientes: String;
    function GetProdutos: String;
    function GetBanco: String;
    function GetConta: String;
    function GetMoeda: String;
    function GetRecibo: String;
    function GetCondicaoPagto: String;
    function GetPedidos(rep, data: String): String;
    procedure SetPedido(aJSON: String);
    function GetReceber: String;
    procedure SetReceber(aJSON: String);
    procedure SetReceberRec(aJSON: String);
    procedure SetReceberPag(aJSON: String);
  end;

  function MetServerToStr(tipo : TMetServerMethods) : string;
  function StrToMetServer(str : string) : TMetServerMethods;
  function ReqServerToStr(tipo : TReqServerMethods) : string;
  function StrToReqServer(str : string) : TReqServerMethods;
  
  function GetMethodCommand(ACmd: String) : String;  

implementation

{ TServerMethods1 }

uses
  udm, uRepassaMap, uReceberCmd, uLogger;

const
  CMetServerMethods : array [TMetServerMethods] of string = (
    'GET', 'POST', 'HEAD');

  CReqServerMethods : array [TReqServerMethods] of string = (
    '/GetVendedor', '/GetClientes', '/GetProdutos', '/GetCondicao',
    '/GetUsuario', '/GetPedidos', '/GetReceber',
    '/GetBanco', '/GetConta', '/GetMoeda', '/GetRecibo',
    '/SetPedido',
    '/SetReceber', '/SetReceberRec', '/SetReceberPag');

  function MetServerToStr(tipo : TMetServerMethods) : string;
  begin
    Result := CMetServerMethods[tipo];
  end;

  function StrToMetServer(str : string) : TMetServerMethods;
  var
    I : Integer;
  begin
    Result := TMetServerMethods(-1);
    for I := 0 to Ord(High(TMetServerMethods)) do
    begin
      if (CMetServerMethods[TMetServerMethods(I)] = str) then
      begin
        Result := TMetServerMethods(I);
        Exit;
      end;
    end;
  end;

  function ReqServerToStr(tipo : TReqServerMethods) : string;
  begin
    Result := CReqServerMethods[tipo];
  end;

  function StrToReqServer(str : string) : TReqServerMethods;
  var
    I : Integer;
  begin
    Result := TReqServerMethods(-1);
    for I := 0 to Ord(High(TReqServerMethods)) do
    begin
      if (CReqServerMethods[TReqServerMethods(I)] = str) then
      begin
        Result := TReqServerMethods(I);
        Exit;
      end;
    end;
  end;
  
  function GetMethodCommand(ACmd: String) : String;
  begin
    if (UpperCase(Copy(ACmd, 1, 3)) = 'GET') then
      Result := 'GET'
    else if (UpperCase(Copy(ACmd, 1, 4)) = 'POST') then
      Result := 'POST'
    else if (UpperCase(Copy(ACmd, 1, 4)) = 'HEAD') then
      Result := 'HEAD'
    else
      Result := '';
  end;  

procedure TServerMethods1.JsonToDataset(ADataset: TDataset; aJSON: string);
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
    vConv.DataSet := ADataset;
    vConv.UpdateDataSet(JObj);
  finally
    vConv.Free;
    JObj.Free;
  end;
end;

procedure TServerMethods1.SetPedido;
const
  cMETHOD = 'TServerMethods1.SetPedido';
var
  dd, mm, ano, hora, minuto, codigo, cmd: string;
  vQryAux : TFDQuery;
  Data: TDateTime;
begin
  JsonToDataset(dm.memPedidos, aJSON);

  codigo := dm.memPedidos.FieldByName('codigo').Value;

  cmd := 'select * from TB_PEDIDO where CODIGO = :codigo';

  vQryAux := dm._ConexaoFB.GetQuery(cmd, False);
  vQryAux.ParamByName('codigo').Value := codigo;
  vQryAux.Open;
  if not (vQryAux.IsEmpty) then
  begin
    uLogger.Instance.Erro(cMETHOD, 'Pedido já cadastrado / Codigo: ' + codigo);
    vQryAux.Free;
    Exit;
  end;
  vQryAux.Free;

  dd := copy(dm.memPedidos.FieldByName('DATA_PEDIDO').AsString, 9, 2);
  mm := copy(dm.memPedidos.FieldByName('DATA_PEDIDO').AsString, 6, 2);
  ano := copy(dm.memPedidos.FieldByName('DATA_PEDIDO').AsString, 1, 4);
  hora := copy(dm.memPedidos.FieldByName('DATA_PEDIDO').AsString, 12, 2);
  minuto := copy(dm.memPedidos.FieldByName('DATA_PEDIDO').AsString, 15, 2);

  Data := StrToDateTime(dd + '/' + mm + '/' + ano + ' ' + hora + ':' + minuto);

  dm.memPedidos.First;

  dm.qryPedidosFB.Open;
  dm.qryItensPedidoFB.Open;

  dm.qryPedidosFB.Insert;
  dm.qryPedidosFBCODIGO.Value := dm.memPedidos.FieldByName('CODIGO').Value;
  dm.qryPedidosFBDATA_PEDIDO.AsDateTime := Data;
  dm.qryPedidosFBVENDEDOR.Value := dm.memPedidos.FieldByName('VENDEDOR').Value;
  dm.qryPedidosFBTIPO.Value := dm.memPedidos.FieldByName('TIPO').Value;
  dm.qryPedidosFBTOTAL_PEDIDO.Value := dm.memPedidos.FieldByName('TOTAL_PEDIDO').AsCurrency;
  dm.qryPedidosFBOBS.AsString := ''; //dm.memPedidos.FieldByName('OBS').Value;
  dm.qryPedidosFBDATA_SINC.AsDateTime := now;
  dm.qryPedidosFBCLIENTE.Value := dm.memPedidos.FieldByName('CLIENTE').Value;
  dm.qryPedidosFBCOD_PAGTO.Value := dm.memPedidos.FieldByName('COD_PAGTO').Value;
  dm.qryPedidosFB.Post;

  while not dm.memPedidos.Eof do
  begin
    dm.qryItensPedidoFB.Insert;
    dm.qryItensPedidoFBSEQ.Value := dm.memPedidos.FieldByName('SEQ').Value;
    dm.qryItensPedidoFbCOD_PEDIDO.Value := dm.memPedidos.FieldByName('COD_PEDIDO').Value;
    dm.qryItensPedidoFBTIPO.Value := dm.memPedidos.FieldByName('TIPO').Value;
    dm.qryItensPedidoFBCOD_PRODUTO.Value := dm.memPedidos.FieldByName('COD_PRODUTO').Value;
    dm.qryItensPedidoFBQTD.Value := dm.memPedidos.FieldByName('QTD').Value;
    dm.qryItensPedidoFBVALOR_UNITARIO.Value := dm.memPedidos.FieldByName('VALOR_UNITARIO').AsCurrency;
    dm.qryItensPedidoFBVALOR_TOTAL.Value := dm.memPedidos.FieldByName('VALOR_TOTAL').AsCurrency;
    dm.qryItensPedidoFB.Post;

    dm.memPedidos.Next;
  end;

  dm.qrypedidosFB.Close;
  dm.qryItensPedidoFB.Close;
  dm.memPedidos.Close;
end;

procedure TServerMethods1.SetReceber(aJSON: String);
var
  vQry : TFDQuery;
  vCmd : String;
begin
  JsonToDataset(dm.memReceber, aJSON);

  with dm.memReceber do
  begin
    First;
    while not Eof do
    begin
      vCmd := TClsReceberCmd.getCmdSelectFB(
        FieldByName('COD_PAGTO').AsString,
        FieldByName('COD_EMP').AsInteger,
        FieldByName('COD_CLIENTE').AsInteger,
        FieldByName('NUM_FAT').AsInteger,
        FieldByName('NUM_PARC').AsInteger);

      vQry := dm._ConexaoFB.GetQuery(vCmd);

      if (vQry.IsEmpty) then
      begin
        vCmd := TClsReceberCmd.getCmdInsertFB(
          FieldByName('COD_PAGTO').AsString,
          FieldByName('COD_EMP').AsInteger,
          FieldByName('COD_CLIENTE').AsInteger,
          FieldByName('NUM_FAT').AsInteger,
          FieldByName('NUM_PARC').AsInteger);

        dm._ConexaoFB.ExecComand(vCmd);
      end;

      vQry.Free;

      Next;
    end;
  end;
end;

procedure TServerMethods1.SetReceberRec(aJSON: String);
begin
  //
end;

procedure TServerMethods1.SetReceberPag(aJSON: String);
begin
  //
end;

function TServerMethods1.DatasetToJson(const ADataset: TDataset): string;
begin
  Result := ADataset.ToJson;
end;

function TServerMethods1.GetClientes: String;
var
  vQryAux: TFDQuery;
Begin
  vQryAux := dm._ConexaoFB.GetQuery('select * from TB_CLIENTE');
  Result := DatasetToJson(vQryAux);
  vQryAux.Free;
end;

function TServerMethods1.GetCondicaoPagto: String;
var
  vQryAux: TFDQuery;
Begin
  vQryAux := dm._ConexaoFB.GetQuery('select * from TB_COND_PAGTO');
  Result := DatasetToJson(vQryAux);
  vQryAux.Free;
end;

function TServerMethods1.GetProdutos: String;
var
  vQryAux: TFDQuery;
Begin
  vQryAux := dm._ConexaoFB.GetQuery('select * from TB_PRODUTO');
  Result := DatasetToJson(vQryAux);
  vQryAux.Free;
end;

function TServerMethods1.GetBanco: String;
var
  vQryAux: TFDQuery;
Begin
  vQryAux := dm._ConexaoFB.GetQuery('select * from TB_BANCO');
  Result := DatasetToJson(vQryAux);
  vQryAux.Free;
end;

function TServerMethods1.GetConta: String;
var
  vQryAux: TFDQuery;
Begin
  vQryAux := dm._ConexaoFB.GetQuery('select * from TB_CONTA');
  Result := DatasetToJson(vQryAux);
  vQryAux.Free;
end;

function TServerMethods1.GetMoeda: String;
var
  vQryAux: TFDQuery;
Begin
  vQryAux := dm._ConexaoFB.GetQuery('select * from TB_MOEDA');
  Result := DatasetToJson(vQryAux);
  vQryAux.Free;
end;

function TServerMethods1.GetRecibo: String;
var
  vQryAux: TFDQuery;
Begin
  vQryAux := dm._ConexaoFB.GetQuery('select * from TB_RECIBO');
  Result := DatasetToJson(vQryAux);
  vQryAux.Free;
end;

function TServerMethods1.GetPedidos(rep, data: String): String;
var
  vQryAux: TFDQuery;
Begin
  vQryAux := dm._ConexaoFB.GetQuery('select * from TB_PEDIDO');
  Result := DatasetToJson(vQryAux);
  vQryAux.Free;
end;

function TServerMethods1.GetReceber: String;
var
  vQryAux: TFDQuery;
Begin
  vQryAux := dm._ConexaoFB.GetQuery('select * from TB_RECEBER');
  Result := DatasetToJson(vQryAux);
  vQryAux.Free;
end;

function TServerMethods1.GetUsuario: String;
var
  vQryAux: TFDQuery;
Begin
  vQryAux := dm._ConexaoFB.GetQuery('select * from TB_USUARIO');
  Result := DatasetToJson(vQryAux);
  vQryAux.Free;
end;

function TServerMethods1.GetVendedor: String;
var
  vQryAux: TFDQuery;
Begin
  vQryAux := dm._ConexaoFB.GetQuery('select * from TB_VENDEDOR');
  Result := DatasetToJson(vQryAux);
  vQryAux.Free;
end;

end.
