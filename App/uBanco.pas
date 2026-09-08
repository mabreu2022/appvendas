unit uBanco;

interface

uses

{$IFDEF ANDROID}
  Androidapi.Jni.Net,
  idUri,
  Androidapi.Jni.Telephony,
  Androidapi.Jni.Provider,
  Fmx.Platform.Android,
  Fmx.Helpers.Android,
  Androidapi.Jni,
  Androidapi.Jni.App,
  Androidapi.NativeWindow,
  Androidapi.JNIBridge,
  Androidapi.NativeActivity,
  Androidapi.Jni.JavaTypes,
  Androidapi.Jni.GraphicsContentViewText,
  Androidapi.Jni.Os,
  Androidapi.Helpers,
  Androidapi.Jni.Widget,
  // Teclado
  Fmx.VirtualKeyboard,
  Fmx.Platform,
{$ENDIF }
  System.SysUtils,
  System.Classes,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.FMXUI.Wait,
  FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteDef,
  FireDAC.Phys.SQLite,
  FireDAC.Comp.UI,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.Comp.DataSet,
  IPPeerClient,
  REST.Client,
  REST.Authenticator.Basic,
  Data.Bind.Components,
  Data.Bind.ObjectScope,
  REST.Types,
  FireDAC.Phys.SQLiteWrapper.Stat,
  System.UITypes,
  REST.Response.Adapter, System.Net.URLClient, System.Net.HttpClient;

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
    qryConfVERSAO: TStringField;
    qryConfIMPRESSORA: TStringField;
    memItensVLR_DESCONTO: TCurrencyField;
    memItensVLR_LIQUIDO: TCurrencyField;
    qryItensPedidoVALOR_DESCONTO: TCurrencyField;
    qryItensPedidoVALOR_LIQUIDO: TCurrencyField;
    qryReceberPag: TFDQuery;
    qryReceberPagCOD_PAGTO: TStringField;
    qryReceberPagNRO_PAGTO: TIntegerField;
    qryReceberPagTIP_DOCTO: TIntegerField;
    qryReceberPagNRO_DOCTO: TIntegerField;
    qryReceberPagVLR_DOCTO: TCurrencyField;
    qryReceberPagDAT_DOCTO: TDateField;
    qryReceberPagCOD_MOEDA: TIntegerField;
    qryReceberPagNRO_BANCO: TIntegerField;
    qryReceberPagNRO_CONTA: TStringField;
    memReceberPag: TFDMemTable;
    dsReceberPag: TDataSource;
    RequestReceberPag: TRESTRequest;
    ResponseReceberPag: TRESTResponse;
    ClientReceberPag: TRESTClient;
    qryBanco: TFDQuery;
    qryConta: TFDQuery;
    qryBancoNRO_BANCO: TIntegerField;
    qryBancoNRO_CODIGO: TIntegerField;
    qryBancoNRO_AGENCIA: TStringField;
    qryBancoDESC_BANCO: TStringField;
    qryBancoSIT_BANCO: TIntegerField;
    qryContaNRO_CODIGO: TIntegerField;
    qryContaNRO_BANCO: TIntegerField;
    qryContaCOD_CONTA: TStringField;
    qryContaCOD_EMPRESA: TIntegerField;
    qryContaDESC_CONTA: TStringField;
    qryContaTIP_CONTA: TIntegerField;
    qryContaSIT_CONTA: TStringField;
    qryContaCOD_MOEDA: TIntegerField;
    qryConfRECIBO: TIntegerField;
    memReceberPagCOD_PAGTO: TStringField;
    memReceberPagNRO_PAGTO: TIntegerField;
    memReceberPagTIP_DOCTO: TIntegerField;
    memReceberPagNRO_DOCTO: TIntegerField;
    memReceberPagVLR_DOCTO: TCurrencyField;
    memReceberPagDAT_DOCTO: TDateField;
    memReceberPagCOD_MOEDA: TIntegerField;
    memReceberPagNRO_BANCO: TIntegerField;
    memReceberPagNRO_CONTA: TStringField;
    ClientBanco: TRESTClient;
    ResponseBanco: TRESTResponse;
    RequestBanco: TRESTRequest;
    memBanco: TFDMemTable;
    dsBanco: TDataSource;
    ClientConta: TRESTClient;
    ResponseConta: TRESTResponse;
    RequestConta: TRESTRequest;
    memConta: TFDMemTable;
    dsConta: TDataSource;
    qryMoeda: TFDQuery;
    qryRecibo: TFDQuery;
    qryMoedaCOD_MOEDA: TIntegerField;
    qryMoedaDESC_MOEDA: TStringField;
    qryMoedaSIMB_MOEDA: TStringField;
    qryReciboCOD_RECIBO: TStringField;
    qryReciboNRO_RECIBO: TIntegerField;
    ClientMoeda: TRESTClient;
    ResponseMoeda: TRESTResponse;
    RequestMoeda: TRESTRequest;
    memMoeda: TFDMemTable;
    dsMoeda: TDataSource;
    ClientRecibo: TRESTClient;
    ResponseRecibo: TRESTResponse;
    RequestRecibo: TRESTRequest;
    memRecibo: TFDMemTable;
    dsRecibo: TDataSource;
    qryReceberPagCOD_EMPRESA: TIntegerField;
    memReceberPagCOD_EMPRESA: TIntegerField;
    FDMemTable1: TFDMemTable;
    qryEmpresa: TFDQuery;
    qryEmpresaROWID: TLargeintField;
    qryEmpresaCODEMP: TIntegerField;
    qryEmpresaNOME: TStringField;
    qryEmpresaNOMEFANTASIA: TStringField;
    qryEmpresaENDERTPLOGRAD: TStringField;
    qryEmpresaENDERLOGRAD: TStringField;
    qryEmpresaENDERNUMLOGRAD: TStringField;
    qryEmpresaENDERCOMPLEMENTO: TStringField;
    qryEmpresaENDERBAIRRO: TStringField;
    qryEmpresaCODCIDADE: TIntegerField;
    qryEmpresaNUMTELEFONE: TStringField;
    qryEmpresaUSUARIO: TIntegerField;
    qryEmpresaDATAATU: TDateField;
    qryEmpresaHORAATU: TStringField;
    qryEmpresaINEXPORTADOR: TStringField;
    qryEmpresaDOCFISCAL: TStringField;
    qryEmpresaDOCFISCALREPRLEGAL: TStringField;
    qryEmpresaNOMEREPRLEGAL: TStringField;
    qryEmpresaTPREPRLEGAL: TStringField;
    qryEmpresaNACIONALIDADE: TStringField;
    qryEmpresaESTADOCIVIL: TStringField;
    qryEmpresaDOCIDENTIDADE: TStringField;
    qryPadrao: TFDQuery;
    procedure ConexaoBeforeConnect(Sender: TObject);
    procedure ConexaoAfterConnect(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    impressora, serial, servidor, porta, codusuario, nomeusuario, prod_status, ped: string;
    function GetQuery(pCmd: string; pOpen: Boolean = true): TFDQuery;
    function GetValue(pCmd, pCampo: string): Variant;
    procedure ExecComando(pCmd: string);
    procedure AjustarCor(aCor: TAlphaColor = $FF1F4687);
    procedure SincronizarDados(CDS: TFDMemTable; Resource: string);
  end;

var
  dmBanco: TdmBanco;

implementation
{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}

uses
  System.Ioutils,
  uMigration,
  untAtualizarBD, uBootLog;

procedure TdmBanco.AjustarCor(aCor: TAlphaColor);
begin
// disabled for test
end;

procedure TdmBanco.ConexaoAfterConnect(Sender: TObject);
begin
  BootLog('ConexaoAfterConnect inicio');
  TClsMigration.Execute(Conexao);
  BootLog('ConexaoAfterConnect fim');
end;

procedure TdmBanco.ConexaoBeforeConnect(Sender: TObject);
var
  LPath: string;
begin
{$IFDEF Android}
  LPath := TPath.GetDocumentsPath;
  BootLog('ConexaoBeforeConnect DocumentsPath=' + LPath);
  ForceDirectories(LPath);
  Conexao.Params.Values['DriverID'] := 'SQLite';
  Conexao.Params.Database := TPath.Combine(LPath, 'app.db3');
  BootLog('ConexaoBeforeConnect Database=' + Conexao.Params.Database + ' exists=' + BoolToStr(FileExists(Conexao.Params.Database), True));
{$ENDIF}
end;

procedure TdmBanco.DataModuleCreate(Sender: TObject);
begin
  BootLog('TdmBanco.DataModuleCreate inicio');
  try
    TAtualizaBD.AtualizarBanco(Conexao);
    BootLog('TdmBanco.DataModuleCreate apos TAtualizaBD.AtualizarBanco');
    qryEmpresa.Close;
    qryEmpresa.Open();
    BootLog('TdmBanco.DataModuleCreate apos qryEmpresa.Open count=' + IntToStr(qryEmpresa.RecordCount));
    qryConf.Close;
    qryConf.Open();
    BootLog('TdmBanco.DataModuleCreate apos qryConf.Open count=' + IntToStr(qryConf.RecordCount));
  except
    on E: Exception do
      BootLog('Erro em TdmBanco.DataModuleCreate: ' + E.ClassName + ': ' + E.Message);
  end;
end;

function TdmBanco.GetQuery(pCmd: string; pOpen: Boolean = true): TFDQuery;
begin
  Result := TFDQuery.Create(Self);
  Result.Connection := Conexao;
  Result.SQL.Clear();
  Result.SQL.Add(pCmd);
  if (pOpen) then
    Result.Open();
end;

function TdmBanco.GetValue(pCmd, pCampo: string): Variant;
var
  vQuery: TFDQuery;
begin
  vQuery := GetQuery(pCmd);
  Result := vQuery.FieldByName(pCampo).Value;
  vQuery.Free;
end;

procedure TdmBanco.SincronizarDados(CDS: TFDMemTable; Resource: string);
var
  RestClient: TRESTClient;
  RestRequest: TRESTRequest;
  RestResponse: TRESTResponse;
  RESTResponseDataSetAdapter: TRESTResponseDataSetAdapter;
  HTTPBasicAuthenticator: THTTPBasicAuthenticator;
begin
  try
    HTTPBasicAuthenticator := THTTPBasicAuthenticator.Create(Nil);
    HTTPBasicAuthenticator.Password := 'fv2019';
    HTTPBasicAuthenticator.Username := 'fv';

    RestClient := TRESTClient.Create(Nil);
    RestClient.Authenticator := HTTPBasicAuthenticator;
    RestClient.BaseURL := 'http://' + dmBanco.servidor + ':' + dmBanco.porta;

    RestResponse := TRESTResponse.Create(Nil);

    RestRequest := TRESTRequest.Create(Nil);
    RestRequest.Client := RestClient;
    RestRequest.Resource := Resource;
    RestRequest.Response := RestResponse;

    RESTResponseDataSetAdapter := TRESTResponseDataSetAdapter.Create(Nil);
    RESTResponseDataSetAdapter.Response := RestResponse;
    RESTResponseDataSetAdapter.Dataset := CDS;

    RestRequest.Execute;

  finally
    begin
      RestClient.DisposeOf;
      RestRequest.DisposeOf;
      RestResponse.DisposeOf;
      RESTResponseDataSetAdapter.DisposeOf;
      HTTPBasicAuthenticator.DisposeOf;
    end;
  end;
end;

procedure TdmBanco.ExecComando(pCmd: string);
var
  vQuery: TFDQuery;
begin
  vQuery := GetQuery(pCmd, False);
  vQuery.ExecSQL(pCmd);
  vQuery.Free;
end;

end.

