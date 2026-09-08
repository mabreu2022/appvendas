unit uBanco;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.FMXUI.Wait,
  FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteDef, FireDAC.Phys.SQLite,
  FireDAC.Comp.UI, Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
  IPPeerClient, REST.Client, REST.Authenticator.Basic, Data.Bind.Components,
  Data.Bind.ObjectScope, REST.Types;

type
  TdmBanco = class(TDataModule)
    Conexao: TFDConnection;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    qryVendedor: TFDQuery;
    qryVendedorCODIGO: TStringField;
    qryVendedorNOME: TStringField;
    qryVendedorUSUARIO: TStringField;
    qryVendedorSENHA: TStringField;
    qryVendedorEMAIL: TStringField;
    qryVendedorPORC_DESC: TFloatField;
    qryVendedorPORC_ADIC: TFloatField;
    qryVendedorPORC_DESC_ITEM: TFloatField;
    qryVendedorCAD_CLI: TStringField;
    qryVendedorCAD_PED: TStringField;
    qryVendedorBONIFICA: TStringField;
    qryVendedorACESSO: TStringField;
    ClientVendedor: TRESTClient;
    ResponseVendedor: TRESTResponse;
    RequestVendedor: TRESTRequest;
    memVendedor: TFDMemTable;
    dsVendedor: TDataSource;
    HTTPBasicAuthenticator1: THTTPBasicAuthenticator;
    qryConf: TFDQuery;
    qryConfSERVIDOR: TStringField;
    qryConfPORTA: TStringField;
    qryConfUSUARIO: TStringField;
    ClientClientes: TRESTClient;
    ResponseClientes: TRESTResponse;
    RequestClientes: TRESTRequest;
    memClientes: TFDMemTable;
    dsClientes: TDataSource;
    qryClientes: TFDQuery;
    qryClientesCODIGO: TStringField;
    qryClientesCODIGO_MOBILE: TStringField;
    qryClientesTIPO: TStringField;
    qryClientesNOME: TStringField;
    qryClientesFANTASIA: TStringField;
    qryClientesCNPJ_CPF: TStringField;
    qryClientesIE_RG: TStringField;
    qryClientesLOGRADOURO: TStringField;
    qryClientesNUMERO: TStringField;
    qryClientesBAIRRO: TStringField;
    qryClientesCOMPLEMENTO: TStringField;
    qryClientesCIDADE_IBGE: TStringField;
    qryClientesCIDADE_DESCRICAO: TStringField;
    qryClientesUF: TStringField;
    qryClientesTELEFONE: TStringField;
    qryClientesCOMERCIAL: TStringField;
    qryClientesCELULAR: TStringField;
    qryClientesWATSAPP: TStringField;
    qryClientesCONTATO: TStringField;
    qryClientesEMAIL1: TStringField;
    qryClientesEMAIL2: TStringField;
    qryClientesATIVIDADE: TStringField;
    qryClientesOBS: TBlobField;
    qryClientesLIMITE_COMPRA_PED: TBCDField;
    qryClientesDIAS_BLOQ_ATRASO: TIntegerField;
    qryClientesDATA_SINC: TSQLTimeStampField;
    qryAux: TFDQuery;
    qryProdutos: TFDQuery;
    qryProdutosCODIGO: TStringField;
    qryProdutosDESCRICAO: TStringField;
    qryProdutosDESCRICAO_RED: TStringField;
    qryProdutosBARRAS: TStringField;
    qryProdutosUNIDADE: TStringField;
    qryProdutosPRECO_VENDA: TBCDField;
    qryProdutosINFO_ADIC: TBlobField;
    qryProdutosIMAGEM: TBlobField;
    ClientProdutos: TRESTClient;
    ResponseProdutos: TRESTResponse;
    RequestProdutos: TRESTRequest;
    memProdutos: TFDMemTable;
    dsProdutos: TDataSource;
    qryPedidos: TFDQuery;
    qryPedidosCODIGO: TStringField;
    qryPedidosDATA_PEDIDO: TSQLTimeStampField;
    qryPedidosVENDEDOR: TStringField;
    qryPedidosTIPO: TStringField;
    qryPedidosTOTAL_PEDIDO: TBCDField;
    qryPedidosOBS: TBlobField;
    qryPedidosDATA_SINC: TSQLTimeStampField;
    qryItensPedido: TFDQuery;
    qryItensPedidoSEQ: TIntegerField;
    qryItensPedidoCOD_PEDIDO: TStringField;
    qryItensPedidoTIPO: TStringField;
    qryItensPedidoCOD_PRODUTO: TStringField;
    qryItensPedidoQTD: TFloatField;
    qryItensPedidoVALOR_UNITARIO: TBCDField;
    qryItensPedidoVALOR_TOTAL: TBCDField;
    qryPedidosCLIENTE: TStringField;
    ClientCondicao: TRESTClient;
    ResponseCondicao: TRESTResponse;
    RequestCondicao: TRESTRequest;
    memCondicao: TFDMemTable;
    dsCondicao: TDataSource;
    qryCondicaoPagto: TFDQuery;
    qryCondicaoPagtoCODIGO: TIntegerField;
    qryCondicaoPagtoDESCRICAO: TStringField;
    memItens: TFDMemTable;
    memItensSEQ: TIntegerField;
    memItensCOD_PRODUTO: TStringField;
    memItensDESCRICAO: TStringField;
    memItensQTD: TFloatField;
    memItensVLR_UNITARIO: TCurrencyField;
    memItensVLR_TOTAL: TCurrencyField;
    qryPedidosCOD_PAGTO: TIntegerField;
    ClientPedidos: TRESTClient;
    ResponsePedidos: TRESTResponse;
    RequestPedidos: TRESTRequest;
    memUsuario: TFDMemTable;
    dsUsuario: TDataSource;
    RequestUsuario: TRESTRequest;
    ResponseUsuario: TRESTResponse;
    ClientUsuario: TRESTClient;
    qryUsuario: TFDQuery;
    qryUsuarioCODIGO: TIntegerField;
    qryUsuarioNOME: TStringField;
    qryUsuarioLOGIN: TStringField;
    qryUsuarioSENHA: TStringField;
    qryProdutosPRECO_MIN: TBCDField;
    qryProdutosPRECO_ATACADO: TBCDField;
    qryProdutosPRECO_COMPRA: TBCDField;
    memReceber: TFDMemTable;
    dsReceber: TDataSource;
    RequestReceber: TRESTRequest;
    ResponseReceber: TRESTResponse;
    ClientReceber: TRESTClient;
    qryReceber: TFDQuery;
    qryReceberRec: TFDQuery;
    qryReceberCOD_EMP: TIntegerField;
    qryReceberCOD_CLIENTE: TIntegerField;
    qryReceberNUM_FAT: TIntegerField;
    qryReceberNUM_PARC: TIntegerField;
    qryReceberNOM_CLIENTE: TStringField;
    qryReceberSITUACAO: TStringField;
    qryReceberDATA_EMISSAO: TSQLTimeStampField;
    qryReceberDATA_VENCTO: TSQLTimeStampField;
    qryReceberCOD_PORT: TIntegerField;
    qryReceberCOD_MOEDA: TIntegerField;
    qryReceberVLR_FATURA: TBCDField;
    qryReceberTIP_DOC: TShortintField;
    qryReceberNUM_DOC: TIntegerField;
    qryReceberUSUARIO: TIntegerField;
    qryReceberCOD_VEND: TIntegerField;
    qryReceberNUM_NOTA: TIntegerField;
    qryReceberNUM_MOV: TIntegerField;
    qryReceberDATA_MOV: TSQLTimeStampField;
    qryReceberRecCOD_PAGTO: TStringField;
    qryReceberRecCOD_EMP: TIntegerField;
    qryReceberRecCOD_CLIENTE: TIntegerField;
    qryReceberRecNUM_FAT: TIntegerField;
    qryReceberRecNUM_PARC: TIntegerField;
    qryReceberRecDATA_REC: TSQLTimeStampField;
    qryReceberRecVLR_RECEBIDO: TBCDField;
    qryReceberRecUSU_REC: TIntegerField;
    qryReceberRecSIT_CONTROLE: TStringField;
    procedure ConexaoBeforeConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    servidor, porta, codusuario, nomeusuario, prod_status, ped: String;
    function GetQuery(pCmd: string; pOpen: Boolean = true) : TFDQuery;
    function GetValue(pCmd, pCampo: string) : Variant;
    procedure ExecComando(pCmd: string);
  end;

var
  dmBanco: TdmBanco;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}

USES
  System.Ioutils;

procedure TdmBanco.ConexaoBeforeConnect(Sender: TObject);
begin
{$IFDEF Android}
  Conexao.Params.Database := TPath.Combine(TPath.GetDocumentsPath, 'app.db3');
{$ENDIF}
end;

function TdmBanco.GetQuery(pCmd: string; pOpen: Boolean = true) : TFDQuery;
begin
  Result := TFDQuery.Create(Self);
  Result.Connection := Conexao;
  Result.SQL.Clear();
  Result.SQL.Add(pCmd);
  if (pOpen) then
    Result.Open();
end;

function TdmBanco.GetValue(pCmd, pCampo: string) : Variant;
var
  vQuery : TFDQuery;
begin
  vQuery := GetQuery(pCmd);
  Result := vQuery.FieldByName(pCampo).Value;
  vQuery.Free;
end;

procedure TdmBanco.ExecComando(pCmd: string);
var
  vQuery : TFDQuery;
begin
  vQuery := GetQuery(pCmd, False);
  vQuery.ExecSQL(pCmd);
  vQuery.Free;
end;

end.
