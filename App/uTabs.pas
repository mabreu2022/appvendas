unit uTabs;

interface

uses
  ssESCPOSPrintBitmap,
  FMX.Ani,
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  System.StrUtils,
  System.Math,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Layouts,
  FMX.TabControl,
  FMX.Objects,
  FMX.Controls.Presentation,
  FMX.StdCtrls,
  FMX.Effects,
  FMX.Edit,
  FMX.VirtualKeyboard,
  FMX.Platform,
  Rest.Types,
  FMX.ListView.Types,
  FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base,
  FMX.ListView,
  System.Actions,
  FMX.ActnList,
  System.Rtti,
  System.Bindings.Outputs,
  FMX.Bind.Editors,
  Data.Bind.EngExt,
  FMX.Bind.DBEngExt,
  Data.Bind.Components,
  Data.Bind.DBScope,
  FMX.EditBox,
  FMX.NumberBox,
  FMX.ListBox,
  FMX.Gestures,
  FireDAC.Comp.Client,
  System.Bluetooth,
  System.Bluetooth.Components,
  System.Generics.Collections,
  FMX.Memo.Types,
  FMX.ScrollBox,
  FMX.Memo,
  untAtualizarBD;
// UUID para impressoras Bluetooth

const
  UUID = '{00001101-0000-1000-8000-00805F9B34FB}';

type
  TfrmTabs = class(TForm)
    LayoutPrin: TLayout;
    TabControlPrin: TTabControl;
    TabSinc: TTabItem;
    TabClientes: TTabItem;
    TabPedidos: TTabItem;
    Layout2: TLayout;
    Rectangle2: TRectangle;
    Label2: TLabel;
    Image3: TImage;
    Layout3: TLayout;
    Rectangle1: TRectangle;
    Layout4: TLayout;
    Rectangle3: TRectangle;
    EditVendedores: TEdit;
    ShadowEffect2: TShadowEffect;
    Layout5: TLayout;
    Rectangle5: TRectangle;
    Image1: TImage;
    ShadowEffect1: TShadowEffect;
    ShadowEffect7: TShadowEffect;
    Layout7: TLayout;
    Rectangle6: TRectangle;
    EditProdutos: TEdit;
    ShadowEffect4: TShadowEffect;
    Layout8: TLayout;
    Rectangle7: TRectangle;
    EditClientes: TEdit;
    ShadowEffect5: TShadowEffect;
    Layout9: TLayout;
    Layout10: TLayout;
    Layout11: TLayout;
    qtdVendedor: TLabel;
    qtdClientes: TLabel;
    qtdProdutos: TLabel;
    Label1: TLabel;
    Layout13: TLayout;
    TabControlCli: TTabControl;
    TabSinc2: TTabItem;
    Layout14: TLayout;
    Rectangle8: TRectangle;
    Label3: TLabel;
    Image2: TImage;
    TabClientes2: TTabItem;
    TabProdutos2: TTabItem;
    Layout15: TLayout;
    ListViewCliente: TListView;
    ShadowEffect6: TShadowEffect;
    Layout16: TLayout;
    Rectangle9: TRectangle;
    Label4: TLabel;
    Image4: TImage;
    ActionList1: TActionList;
    actClientes: TChangeTabAction;
    actPedido: TChangeTabAction;
    Image5: TImage;
    ShadowEffect8: TShadowEffect;
    Layout17: TLayout;
    ListViewPedido: TListView;
    ShadowEffect9: TShadowEffect;
    TabAddPedido: TTabItem;
    TabProdutos: TTabItem;
    Layout18: TLayout;
    Rectangle10: TRectangle;
    Label5: TLabel;
    Image6: TImage;
    Layout19: TLayout;
    ListViewProduto: TListView;
    ShadowEffect10: TShadowEffect;
    Layout20: TLayout;
    Rectangle11: TRectangle;
    Layout21: TLayout;
    Rectangle12: TRectangle;
    EditDescrProdutos: TEdit;
    ShadowEffect11: TShadowEffect;
    Image7: TImage;
    actAddPedido: TChangeTabAction;
    Layout22: TLayout;
    lblCliente: TLabel;
    Layout23: TLayout;
    Rectangle13: TRectangle;
    EditCondPagto: TEdit;
    Layout24: TLayout;
    qtdCondicao: TLabel;
    ShadowEffect12: TShadowEffect;
    Layout25: TLayout;
    Rectangle14: TRectangle;
    Image9: TImage;
    ShadowEffect13: TShadowEffect;
    Layout26: TLayout;
    Rectangle15: TRectangle;
    Image10: TImage;
    Layout27: TLayout;
    Rectangle16: TRectangle;
    Layout28: TLayout;
    Rectangle17: TRectangle;
    Layout29: TLayout;
    Layout30: TLayout;
    ListViewItemPedido: TListView;
    ShadowEffect14: TShadowEffect;
    Layout31: TLayout;
    Layout32: TLayout;
    Rectangle18: TRectangle;
    EditDescrProduto: TEdit;
    ShadowEffect15: TShadowEffect;
    Image8: TImage;
    actProdutos: TChangeTabAction;
    TabAddItem: TTabItem;
    actAdditem: TChangeTabAction;
    Layout33: TLayout;
    Rectangle19: TRectangle;
    Layout34: TLayout;
    Label8: TLabel;
    Layout35: TLayout;
    Layout36: TLayout;
    NumberBoxQtde: TNumberBox;
    ButtonAdicionar: TButton;
    ComboBoxPagto: TComboBox;
    Label7: TLabel;
    Label9: TLabel;
    Label6: TLabel;
    GestureManager1: TGestureManager;
    Layout6: TLayout;
    ComboBoxVendedor: TComboBox;
    Label10: TLabel;
    Layout12: TLayout;
    Image11: TImage;
    ShadowEffect3: TShadowEffect;
    Image12: TImage;
    ShadowEffect16: TShadowEffect;
    TabReceber: TTabItem;
    actReceber: TChangeTabAction;
    Layout37: TLayout;
    Rectangle4: TRectangle;
    EditReceber: TEdit;
    Layout38: TLayout;
    qtdReceber: TLabel;
    ShadowEffect17: TShadowEffect;
    Layout39: TLayout;
    Rectangle20: TRectangle;
    Label11: TLabel;
    Image13: TImage;
    Layout40: TLayout;
    ListViewReceber: TListView;
    ShadowEffect18: TShadowEffect;
    Layout1: TLayout;
    LabelValorReceber: TLabel;
    Image14: TImage;
    ShadowEffect19: TShadowEffect;
    Bluetooth1: TBluetooth;
    Layout41: TLayout;
    EditClienteReceber: TEdit;
    ImageBuscarReceber: TImage;
    Layout42: TLayout;
    EditValorReceber: TEdit;
    Layout43: TLayout;
    Rectangle21: TRectangle;
    Edit1: TEdit;
    Layout44: TLayout;
    qtdUsuario: TLabel;
    ShadowEffect20: TShadowEffect;
    Layout45: TLayout;
    NumberBoxUnit: TNumberBox;
    Label12: TLabel;
    Layout46: TLayout;
    NumberBoxDesc: TNumberBox;
    Layout47: TLayout;
    Label15: TLabel;
    ComboBoxTipoValor: TComboBox;
    Layout48: TLayout;
    NumberBoxLiqui: TNumberBox;
    Label16: TLabel;
    Label13: TLabel;
    ComboBoxTipoDesc: TComboBox;
    LabelValorPedido: TLabel;
    TabReceberPag: TTabItem;
    Layout51: TLayout;
    LabelReceberPag: TLabel;
    Image15: TImage;
    ShadowEffect21: TShadowEffect;
    Layout52: TLayout;
    Rectangle22: TRectangle;
    Label20: TLabel;
    Image16: TImage;
    Layout53: TLayout;
    ListViewReceberPag: TListView;
    ShadowEffect22: TShadowEffect;
    LayoutTipoDocto: TLayout;
    LayoutValorDocto: TLayout;
    EditValorDocto: TEdit;
    ComboBoxTipoDocto: TComboBox;
    LayoutDataDocto: TLayout;
    LayoutBancoDocto: TLayout;
    EditNroDocto: TEdit;
    Image17: TImage;
    ShadowEffect23: TShadowEffect;
    actReceberPag: TChangeTabAction;
    ComboBoxBancoDocto: TComboBox;
    EditDataDocto: TEdit;
    ComboBoxTipoMoeda: TComboBox;
    LayoutContaDocto: TLayout;
    ComboBoxContaDocto: TComboBox;
    Image18: TImage;
    ShadowEffect24: TShadowEffect;
    Layout49: TLayout;
    EditNroRecibo: TEdit;
    Image19: TImage;
    ShadowEffect25: TShadowEffect;
    Layout50: TLayout;
    Rectangle23: TRectangle;
    qtdConta: TEdit;
    Layout54: TLayout;
    Label14: TLabel;
    ShadowEffect26: TShadowEffect;
    Layout55: TLayout;
    Rectangle24: TRectangle;
    qtdBanco: TEdit;
    Layout56: TLayout;
    Label17: TLabel;
    ShadowEffect27: TShadowEffect;
    recMenu: TRectangle;
    recSubMenu: TRectangle;
    lblPedido: TLabel;
    Layout57: TLayout;
    Layout58: TLayout;
    Path1: TPath;
    Text1: TText;
    Path2: TPath;
    actImpressao: TChangeTabAction;
    tbImpressao: TTabItem;
    Layout59: TLayout;
    Rectangle25: TRectangle;
    Label18: TLabel;
    Image20: TImage;
    Memo1: TMemo;
    Path3: TPath;
    Rectangle26: TRectangle;
    cbxDevices: TComboBox;
    procedure ImageCloseClick(Sender: TObject);
    procedure ImageMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure ImageMouseLeave(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Image3MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure Image3MouseLeave(Sender: TObject);
    procedure Label1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure Label1MouseLeave(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Image2MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure Image2MouseLeave(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image4MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure Image4MouseLeave(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure ListViewClienteItemClick(const Sender: TObject; const AItem: TListViewItem);
    procedure Image5MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure Image5MouseLeave(Sender: TObject);
    procedure Image6MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure Image6MouseLeave(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure Image7MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure Image7MouseLeave(Sender: TObject);
    procedure Image7Click(Sender: TObject);
    procedure Image5Click(Sender: TObject);
    procedure Image9MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure Image9MouseLeave(Sender: TObject);
    procedure Image10MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure Image10MouseLeave(Sender: TObject);
    procedure Image10Click(Sender: TObject);
    procedure ListViewProdutoItemClick(const Sender: TObject; const AItem: TListViewItem);
    procedure Image8MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure Image8MouseLeave(Sender: TObject);
    procedure Image8Click(Sender: TObject);
    procedure ButtonAdicionarClick(Sender: TObject);
    procedure NumberBoxQtdeMouseLeave(Sender: TObject);
    procedure Image9Click(Sender: TObject);
    procedure ListViewPedidoItemClick(const Sender: TObject; const AItem: TListViewItem);
    procedure Image12Click(Sender: TObject);
    procedure Image11Click(Sender: TObject);
    procedure Image12MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure Image12MouseLeave(Sender: TObject);
    procedure Image11MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure Image11MouseLeave(Sender: TObject);
    procedure Image14Click(Sender: TObject);
    procedure ListViewReceberItemClick(const Sender: TObject; const AItem: TListViewItem);
    procedure ListViewReceberItem(AItem: TListViewItem);
    procedure ImageBuscarReceberClick(Sender: TObject);
    procedure EditValorReceberKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure ComboBoxTipoValorChange(Sender: TObject);
    procedure NumberBoxDescChange(Sender: TObject);
    procedure ComboBoxTipoDescChange(Sender: TObject);
    procedure Image15Click(Sender: TObject);
    procedure ComboBoxTipoDoctoChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image17Click(Sender: TObject);
    procedure Image18Click(Sender: TObject);
    procedure Image19Click(Sender: TObject);
    procedure recMenuClick(Sender: TObject);
    procedure Layout58Click(Sender: TObject);
    procedure Image20Click(Sender: TObject);
    procedure Rectangle26Click(Sender: TObject);
    procedure cbxDevicesChange(Sender: TObject);
  private
    { Private declarations }
    procedure ResetDocto();
    procedure SetComboTipoDesc;
    procedure SetComboTipoValor;
    procedure SetComboTipoDocto;
    procedure SetComboTipoMoeda;
    procedure SetComboDoctoBanco;
    procedure SetComboDoctoConta;
    procedure SetComboDoctoColor(pComboBoxList: TList<TComboBox>);
    function GetVlDesconto(): Real;
    procedure TotalizarPedido;
    procedure p_AdicionarItemPedido;
    procedure p_RemoverItemPedido;
    procedure TotalizarRecebimento;
    procedure p_AdicionarRecebimento;
    procedure p_EfetuarRecebimento;
    procedure p_LimparCodigoPagamento;
    procedure p_GerarCodigoPagamento;
    procedure p_LimparPagtoRecebimento;
    procedure p_AdicionarPagtoRecebimento;
    procedure p_RemoverPagtoRecebimento;
    procedure EfetuarRecebimento;
    procedure p_ImprimirRecebimento;
    procedure ImprimirRecebimento;
  public
    { Public declarations }
    FSocket: TBluetoothSocket;
    FCdPagto: string;
    procedure p_CarregarRecibo;
    procedure p_SalvarRecibo;
    procedure ShowMenu(ARecMenu, ARecSubMenu: TRectangle);
    procedure CloseMenu(ARecMenu, ARecSubMenu: TRectangle);
    function ConectarImpressora(ANomeDevice: string): Boolean;
    function ObterDevicePeloNome(ANomeDevice: string): TBluetoothDevice;
    procedure ListarDispositivosPareadosNoCombo;
    function MakeScaleScreenshot(const Sender: TControl): TBitmap;
    procedure EnviarImpressao(const Sender: TControl);
    procedure ImprimirPedido;
  end;

  TTipoFatura = (tfAberto, tfReceber);

  TTipoDesc = (tpPerc, tpValor);

  TTipoValor = (tvAtacado, tvVarejo);

  TTipoDocto = (tdDinheiro, tdDeposito, tdCheque);

  TTipoMoeda = (tmGuarani, tmDolar, tmReal);

var
  frmTabs: TfrmTabs;

implementation
{$R *.fmx}

uses
  uBanco,
  uFuncoes,
  uPrinter,
  uMessage,
  Androidapi.JNI.PowerManager,
  Androidapi.JNI.Toast,
  uConverter,
  uReceberRecCmd,
  uSincronizar,
  uPrinterBluetooth,
  uValueObject,
  uBootLog;

const
  cTipoFatura: array[TTipoFatura] of string = ('Aberto', 'Receber');
  cTipoDesc: array[TTipoDesc] of string = ('% desc', '$ desc');
  cTipoValor: array[TTipoValor] of string = ('Atacado', 'Varejo');
  cTipoDocto: array[TTipoDocto] of string = ('Dinheiro', 'Deposito', 'Cheque');
  cTipoMoeda: array[TTipoMoeda] of string = ('Guarani', 'Dolar', 'Real');
  //-- TTipoFatura

function StrToTipoFatura(pStr: string): TTipoFatura;
var
  I: Integer;
begin
  Result := TTipoFatura(Ord(-1));
  for I := 0 to Ord(High(cTipoFatura)) do
    if (cTipoFatura[TTipoFatura(Ord(I))] = pStr) then
    begin
      Result := TTipoFatura(Ord(I));
      Exit;
    end;
end;

function IsAberto(pTip: TTipoFatura): Boolean;
begin
  Result := pTip in [tfAberto];
end;

function IsReceber(pTip: TTipoFatura): Boolean;
begin
  Result := pTip in [tfReceber];
end;
  //-- Reset Docto

procedure TfrmTabs.Rectangle26Click(Sender: TObject);
var
  I: Integer;
begin
  // ESC/POS
  if (FSocket <> nil) and (FSocket.Connected) then
  begin
    for I := 0 to Pred(Memo1.Lines.Count) do
    begin
      FSocket.SendData(TEncoding.UTF8.GetBytes(Memo1.Lines[I]));
      FSocket.SendData(TEncoding.UTF8.GetBytes(chr(27) + chr(100) + chr(0)));
      if Trim(Memo1.Lines[I]) = '' then
        FSocket.SendData(TEncoding.UTF8.GetBytes(chr(27) + chr(100) + chr(1)));
    end;
    FSocket.SendData(TEncoding.UTF8.GetBytes(chr(27) + chr(100) + chr(3)));
  end;
end;

procedure TfrmTabs.ResetDocto();
begin
  ComboBoxTipoDocto.ItemIndex := 0;
  ComboBoxTipoDoctoChange(nil);
  ComboBoxBancoDocto.ItemIndex := 0;
  ComboBoxContaDocto.ItemIndex := 0;
end;
  //-- SetComboTipo

procedure TfrmTabs.SetComboTipoDesc();
var
  I: Integer;
begin
  with ComboBoxTipoDesc do
  begin
    Items.Clear;
    for I := 0 to Ord(High(cTipoDesc)) do
      Items.Add(cTipoDesc[TTipoDesc(I)]);
    ItemIndex := 0;
  end;
end;

procedure TfrmTabs.SetComboTipoValor();
var
  I: Integer;
begin
  with ComboBoxTipoValor do
  begin
    Items.Clear;
    for I := 0 to Ord(High(cTipoValor)) do
      Items.Add(cTipoValor[TTipoValor(I)]);
    ItemIndex := 0;
  end;
end;

procedure TfrmTabs.SetComboTipoDocto();
var
  I: Integer;
begin
  with ComboBoxTipoDocto do
  begin
    Items.Clear;
    for I := 0 to Ord(High(cTipoDocto)) do
      Items.Add(cTipoDocto[TTipoDocto(I)]);
    ItemIndex := 0;
  end;
end;

procedure TfrmTabs.SetComboTipoMoeda();
var
  I: Integer;
begin
  with ComboBoxTipoMoeda do
  begin
    Items.Clear;
    for I := 0 to Ord(High(cTipoMoeda)) do
      Items.Add(cTipoMoeda[TTipoMoeda(I)]);
    ItemIndex := 0;
  end;
end;
  //-- SetComboDocto

procedure TfrmTabs.SetComboDoctoBanco();
begin
  with ComboBoxBancoDocto do
  begin
    Items.Clear;
    Items.Add('SELECIONAR O BANCO');
    with dmBanco, dmBanco.qryBanco do
    begin
      while not EOF do
      begin
        Items.AddObject(qryBancoDESC_BANCO.AsString, TValueObject.Create(qryBancoNRO_CODIGO.Value));
        Next;
      end;
    end;
    ItemIndex := 0;
  end;
end;

procedure TfrmTabs.SetComboDoctoConta();
begin
  with ComboBoxContaDocto do
  begin
    Items.Clear;
    Items.Add('SELECIONAR A CONTA');
    with dmBanco, dmBanco.qryConta do
    begin
      while not EOF do
      begin
        Items.AddObject(qryContaDESC_CONTA.AsString, TValueObject.Create(qryContaCOD_EMPRESA.Value, qryContaNRO_CODIGO.Value));
        Next;
      end;
    end;
    ItemIndex := 0;
  end;
end;

procedure TfrmTabs.SetComboDoctoColor;
var
  vComboBox: TComboBox;
  I: Integer;
begin
  for vComboBox in pComboBoxList do
  begin
    with vComboBox.ListBox do
    begin
      for I := 0 to Count - 1 do
      begin
        with ListItems[I] do
        begin
          TextSettings.FontColor := TAlphaColorRec.White;
          StyledSettings := StyledSettings - [TStyledSetting.FontColor];
        end;
      end;
    end;
  end;
end;
  //-- GetVlDesconto

function TfrmTabs.GetVlDesconto(): Real;
begin
  Result := 0;
  if (NumberBoxUnit.Value <= 0) or (NumberBoxDesc.Value <= 0) then
  begin
    exit;
  end;
  if (NumberBoxDesc.Value > NumberBoxUnit.Value) then
  begin
    NumberBoxDesc.Value := 0;
  end;
  case (TTipoDesc(ComboBoxTipoDesc.Index)) of
    tpPerc:
      begin
        Result := NumberBoxUnit.Value * NumberBoxDesc.Value / 100;
        Result := RoundTo(Result, 2);
      end;
    tpValor:
      begin
        Result := NumberBoxDesc.Value;
      end;
  end;
end;

function VarToInt(const AVariant: Variant): integer;
begin
  Result := StrToIntDef(Trim(VarToStr(AVariant)), 0);
end;

procedure TfrmTabs.ButtonAdicionarClick(Sender: TObject);
var
  vVlDesconto, vVlMinimo: Real;
begin
  if dmBanco.qryProdutosCODIGO.AsString = '' then
  begin
    TClsMessage.MensagemHint('Produto deve ser informado');
    Exit;
  end;
  if dmBanco.qryProdutosDESCRICAO.AsString = '' then
  begin
    TClsMessage.MensagemHint('Produto invalido');
    Exit;
  end;
  if NumberBoxQtde.Value <= 0 then
  begin
    TClsMessage.MensagemHint('Informe a quantidade');
    Exit;
  end;
  if NumberBoxUnit.Value <= 0 then
  begin
    TClsMessage.MensagemHint('Informe o valor');
    Exit;
  end;
  vVlDesconto := GetVlDesconto();
  dmBanco.memitens.Append;
  dmBanco.memitensCOD_PRODUTO.Value := dmBanco.qryProdutosCODIGO.Value;
  dmBanco.memitensDESCRICAO.Value := dmBanco.qryProdutosDESCRICAO.Value;
  dmBanco.memitensQTD.Value := NumberBoxQtde.Value;
  dmBanco.memitensVLR_UNITARIO.Value := NumberBoxUnit.Value;
  dmBanco.memitensVLR_DESCONTO.Value := vVlDesconto;
  dmBanco.memitensVLR_LIQUIDO.Value := dmBanco.memitensVLR_UNITARIO.Value - dmBanco.memitensVLR_DESCONTO.Value;
  dmBanco.memitensVLR_TOTAL.Value := dmBanco.memitensQTD.Value * dmBanco.memitensVLR_LIQUIDO.Value;
  dmBanco.memitens.Post;
  p_AdicionarItemPedido;
  TotalizarPedido;
  actAddPedido.ExecuteTarget(self);
end;

procedure TfrmTabs.FormCreate(Sender: TObject);
var
  vComboBoxList: TList<TComboBox>;
begin
  try
    if Bluetooth1.Enabled then
      ListarDispositivosPareadosNoCombo;
  except
    on E: Exception do
      BootLog('Bluetooth1 init error: ' + E.Message);
  end;
  SetComboTipoDesc;
  SetComboTipoValor;
  SetComboTipoDocto;
  SetComboTipoMoeda;
  SetComboDoctoBanco;
  SetComboDoctoConta;
  vComboBoxList := TList<TComboBox>.Create;
  try
    vComboBoxList.AddRange([ComboBoxTipoDocto, ComboBoxTipoMoeda, ComboBoxBancoDocto, ComboBoxContaDocto]);
    SetComboDoctoColor(vComboBoxList);
  finally
    vComboBoxList.Free;
  end;
end;

procedure TfrmTabs.ImageCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmTabs.ImageMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  TImage(Sender).Opacity := 0.5;
end;

procedure TfrmTabs.ImageMouseLeave(Sender: TObject);
begin
  TImage(Sender).Opacity := 1;
end;

procedure TfrmTabs.Label1Click(Sender: TObject);
var
  FThread: TThread;
begin
  Label1.Text := 'SINCRONIZANDO...';
  Application.ProcessMessages;
  try
    TclsSincronizar.SetPedidoPend;
    TclsSincronizar.SetReceberPend;
    qtdVendedor.Text := IntToStr(TclsSincronizar.GetVendedores.Qtde);
    Application.ProcessMessages;
    qtdClientes.Text := IntToStr(TclsSincronizar.GetClientes.Qtde);
    Application.ProcessMessages;
    qtdProdutos.Text := IntToStr(TclsSincronizar.GetProdutos.Qtde);
    Application.ProcessMessages;
    qtdCondicao.Text := IntToStr(TclsSincronizar.GetCondPagto.Qtde);
    Application.ProcessMessages;
    qtdReceber.Text := IntToStr(TclsSincronizar.GetReceber.Qtde);
    Application.ProcessMessages;
    qtdUsuario.Text := IntToStr(TclsSincronizar.GetUsuarios.Qtde);
    Application.ProcessMessages;
    qtdBanco.Text := IntToStr(TclsSincronizar.GetBancos.Qtde);
    Application.ProcessMessages;
    qtdConta.Text := IntToStr(TclsSincronizar.GetContas.Qtde);
    Application.ProcessMessages;
    TclsSincronizar.GetMoedas;
    TclsSincronizar.GetRecibo;
    TclsSincronizar.RemReceberPend;
    TclsSincronizar.GetEmpresa;
    TClsMessage.MensagemHint('Sincronismo finalizado !!!');
  except
    on E: Exception do
    begin
      TClsMessage.MensagemHint('Erro. Tente novamente !!!' + e.Message);
    end;
  end;
  Label1.Text := 'SINCRONIZAR';
  Application.ProcessMessages;
end;

procedure TfrmTabs.Image10Click(Sender: TObject);
begin
  MessageDlg('Deseja realmente cancelar pedido ?', System.UITypes.TMsgDlgType.mtInformation, [System.UITypes.TMsgDlgBtn.mbYes, System.UITypes.TMsgDlgBtn.mbNo], 0,
    procedure(const AResult: System.UITypes.TModalResult)
    begin
      case AResult of
        mrYES:
          begin
            dmBanco.memitens.Close;
            actPedido.ExecuteTarget(self);
          end;
        mrNo:


      end;
    end);
end;

procedure TfrmTabs.Image10MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  Image10.Opacity := 0.5;
end;

procedure TfrmTabs.Image10MouseLeave(Sender: TObject);
begin
  Image10.Opacity := 1;
end;

procedure TfrmTabs.Image11Click(Sender: TObject);
var
  vSincronizar: TRecSincronizar;
  txt: TListItemText;
begin
  if (ListViewPedido.Items.Count = 0) then
    exit;
  if (ListViewPedido.ItemIndex = -1) or (ListViewPedido.Selected = nil) then
  begin
    TClsMessage.MensagemHint('Selecione um pedido na lista');
    exit;
  end;
  txt := TListItemText(ListViewPedido.Items[ListViewPedido.ItemIndex].Objects.FindDrawable('Text1'));
  dmBanco.qrypedidos.Locate('CODIGO', txt.Text, []);
  if dmBanco.qrypedidosDATA_SINC.IsNull then
  begin
    MessageDlg('Deseja realmente enviar pedido ?', System.UITypes.TMsgDlgType.mtInformation, [System.UITypes.TMsgDlgBtn.mbYes, System.UITypes.TMsgDlgBtn.mbNo], 0,
      procedure(const AResult: System.UITypes.TModalResult)
      begin
        case AResult of
          mrYES:
            begin
              vSincronizar := TclsSincronizar.SetPedido(dmBanco.qryPedidosCODIGO.Value, False);
              if vSincronizar.Erro then
              begin
                TClsMessage.MensagemHint('Erro ao enviar pedido !!! ' + vSincronizar.Mensagem);
                Exit;
              end;
              if vSincronizar.Qtde > 0 then
              begin
                dmBanco.qryAux.Close;
                dmBanco.qryAux.Sql.Clear;
                dmBanco.qryAux.Sql.Add('update TB_PEDIDO');
                dmBanco.qryAux.Sql.Add('set DATA_SINC = :data');
                dmBanco.qryAux.Sql.Add('where CODIGO = :codigo');
                dmBanco.qryAux.ParamByName('codigo').Value := dmBanco.qryPedidosCODIGO.Value;
                dmBanco.qryAux.ParamByName('data').AsDateTime := now;
                dmBanco.qryAux.ExecSQL;
                dmBanco.qryPedidos.Refresh;
                ListViewPedido.BeginUpdate;
                dmBanco.qryPedidos.First;
                ListViewPedido.Items.Clear;
                while not dmBanco.qryPedidos.Eof do
                begin
                  with ListViewPedido.Items.Add do
                  begin
                    Data['Text1'] := dmBanco.qryPedidosCODIGO.AsString;
                    Data['Text2'] := dmBanco.qryPedidosDATA_PEDIDO.AsString;
                    Data['Text3'] := '$ ' + formatfloat('##,###,###0.00', dmBanco.qryPedidosTOTAL_PEDIDO.Value);
                    Data['Text4'] := 'Enviado .: ' + dmBanco.qryPedidosDATA_SINC.AsString;
                  end;
                  dmBanco.qryPedidos.Next;
                end;
                ListViewPedido.EndUpdate;
                TClsMessage.MensagemHint('Pedido enviado com sucesso !!!');
              end;
          //else
            //TClsMessage.MensagemHint('Erro ao enviar pedido !!!'  );
            end;
          mrNo:


        end;
      end);
  end;
end;

procedure TfrmTabs.Image11MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  Image11.Opacity := 0.5;
end;

procedure TfrmTabs.Image11MouseLeave(Sender: TObject);
begin
  Image11.Opacity := 1;
end;

procedure TfrmTabs.Image12Click(Sender: TObject);
var
  txt: TListItemText;
begin
  txt := TListItemText(ListViewPedido.Items[ListViewPedido.ItemIndex].Objects.FindDrawable('Text1'));
  dmBanco.qrypedidos.Locate('CODIGO', txt.Text, []);
  if dmBanco.qrypedidosDATA_SINC.IsNull then
  begin
    MessageDlg('Deseja realmente excluir pedido ?', System.UITypes.TMsgDlgType.mtInformation, [System.UITypes.TMsgDlgBtn.mbYes, System.UITypes.TMsgDlgBtn.mbNo], 0,
      procedure(const AResult: System.UITypes.TModalResult)
      begin
        case AResult of
          mrYES:
            begin
              dmBanco.qryAux.Close;
              dmBanco.qryAux.Sql.Clear;
              dmBanco.qryAux.Sql.Add('delete from TB_PEDIDO where CODIGO = :codigo');
              dmBanco.qryAux.ParamByName('codigo').Value := dmBanco.qrypedidosCODIGO.Value;
              dmBanco.qryAux.ExecSQL;
              dmBanco.qrypedidos.Refresh;
              ListViewPedido.BeginUpdate;
              dmBanco.qrypedidos.First;
              ListViewPedido.Items.Clear;
              while not dmBanco.qrypedidos.Eof do
              begin
                with ListViewPedido.Items.Add do
                begin
                  Data['Text1'] := dmBanco.qrypedidosCODIGO.AsString;
                  Data['Text2'] := dmBanco.qrypedidosDATA_PEDIDO.AsString;
                  Data['Text3'] := '$ ' + formatfloat('##,###,###0.00', dmBanco.qrypedidosTOTAL_PEDIDO.Value);
                  Data['Text4'] := 'Enviado .: ' + dmBanco.qrypedidosDATA_SINC.AsString;
                end;
                dmBanco.qrypedidos.Next;
              end;
              ListViewPedido.EndUpdate;
            end;
          mrNo:


        end;
      end);
  end;
end;

procedure TfrmTabs.Image12MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  Image12.Opacity := 0.5;
end;

procedure TfrmTabs.Image12MouseLeave(Sender: TObject);
begin
  Image12.Opacity := 1;
end;

procedure TfrmTabs.Image14Click(Sender: TObject);
begin
  actReceberPag.ExecuteTarget(self);
end;

procedure TfrmTabs.Image15Click(Sender: TObject);
begin
  try
    p_EfetuarRecebimento;
  except
    on E: Exception do
    begin
      ShowMessage('Erro: ' + e.Message);
    end;
  end;
end;

procedure TfrmTabs.Image17Click(Sender: TObject);
begin
  p_AdicionarPagtoRecebimento;
end;

procedure TfrmTabs.p_AdicionarItemPedido;
begin
  with ListViewItemPedido.Items.Add do
  begin
    Data['Text1'] := dmBanco.qryProdutosCODIGO.AsString + ' - ' + dmBanco.qryProdutosDESCRICAO.AsString;
    Data['Text2'] := dmBanco.memitensQTD.AsString + ' X $ ' + formatfloat('##,###,###0.00', dmBanco.memitensVLR_UNITARIO.Value);
    Data['Text3'] := '$ ' + formatfloat('##,###,###0.00', dmBanco.memitensVLR_TOTAL.Value);
  end;
end;

procedure TfrmTabs.p_RemoverItemPedido;
var
  vItem: TListViewItem;
  vData: string;
begin
  with ListViewItemPedido do
  begin
    if (ItemIndex = -1) then
      Exit;
    vItem := TListViewItem(Items[ItemIndex]);
    vData := vItem.Data['Text1'].AsString;
    if (Pos(' - ', vData) > 0) then
    begin
      vData := Copy(vData, 1, Pos(' - ', vData));
    end;
    //-- excluir item entidade
    ItemIndex := -1;
    with dmBanco, dmBanco.memItens do
    begin
      First;
      while not EOF do
      begin
        if (memItensCOD_PRODUTO.AsString = vData) then
        begin
          Delete;
          Break;
        end;
        Next;
      end;
    end;
    //-- atualizar listView
    Items.Clear;
    with dmBanco, dmBanco.memItens do
    begin
      First;
      while not EOF do
      begin
        p_AdicionarItemPedido;
        Next;
      end;
    end;
    TotalizarPedido;
  end;
end;

procedure TfrmTabs.Image18Click(Sender: TObject);
begin
  MessageDlg('Deseja realmente excluir item pedido ?', System.UITypes.TMsgDlgType.mtInformation, [System.UITypes.TMsgDlgBtn.mbYes, System.UITypes.TMsgDlgBtn.mbNo], 0,
    procedure(const AResult: System.UITypes.TModalResult)
    begin
      case AResult of
        mrYES:
          begin
            p_RemoverItemPedido();
          end;
      end;
    end);
end;

procedure TfrmTabs.p_LimparPagtoRecebimento;
begin
  with dmBanco do
  begin
    memReceberPag.EmptyDataSet;
  end;
  ListViewReceberPag.Items.Clear;
  FCdPagto := '';
end;

procedure TfrmTabs.p_LimparCodigoPagamento;
begin
  FCdPagto := '';
end;

procedure TfrmTabs.p_GerarCodigoPagamento;
begin
  if (FCdPagto = '') then
  begin
    FCdPagto := TGUID.NewGuid.ToString;
  end;
end;

procedure TfrmTabs.p_AdicionarPagtoRecebimento;
var
  vNroPagto, vNroDocto: Integer;
  vVlrDocto: Real;
  vDatDocto: TDateTime;
begin
  vNroDocto := StrToIntDef(EditNroDocto.Text, 0);
  vVlrDocto := StrToFloatDef(EditValorDocto.Text, 0);
  vDatDocto := StrToDateDef(EditDataDocto.Text, 0);
  if (vNroDocto = 0) then
  begin
    TClsMessage.MensagemHint('Informe o numero do docto');
    Exit;
  end;
  if (vVlrDocto = 0) then
  begin
    TClsMessage.MensagemHint('Informe o valor do docto');
    Exit;
  end;
  if (vDatDocto = 0) then
  begin
    TClsMessage.MensagemHint('Informe a data do docto');
    Exit;
  end;
  if (LayoutBancoDocto.Visible) and (ComboBoxBancoDocto.ItemIndex = 0) then
  begin
    TClsMessage.MensagemHint('Informe o banco do pagto');
    Exit;
  end;
  if (LayoutContaDocto.Visible) and (ComboBoxContaDocto.ItemIndex = 0) then
  begin
    TClsMessage.MensagemHint('Informe a conta do pagto');
    Exit;
  end;
  p_GerarCodigoPagamento;
  with dmBanco do
  begin
    memReceberPag.Last;
    vNroPagto := memReceberPagNRO_PAGTO.Value + 1;
    memReceberPag.Append;
    memReceberPagCOD_PAGTO.Value := FCdPagto;
    memReceberPagNRO_PAGTO.Value := vNroPagto;
    with ComboBoxTipoDocto do
    begin
      memReceberPagTIP_DOCTO.Value := TValueObject(Items.Objects[ItemIndex]).Value.AsInteger;
    end;
    memReceberPagNRO_DOCTO.Value := vNroDocto;
    memReceberPagVLR_DOCTO.Value := vVlrDocto;
    memReceberPagDAT_DOCTO.Value := vDatDocto;
    with ComboBoxTipoMoeda do
    begin
      memReceberPagCOD_MOEDA.Value := TValueObject(Items.Objects[ItemIndex]).Value.AsInteger;
    end;
    with ComboBoxBancoDocto do
    begin
      if (ItemIndex > 0) then
      begin
        memReceberPagNRO_BANCO.Value := TValueObject(Items.Objects[ItemIndex]).Value.AsInteger;
      end;
    end;
    with ComboBoxContaDocto do
    begin
      if (ItemIndex > 0) then
      begin
        memReceberPagCOD_EMPRESA.Value := TValueObject(Items.Objects[ItemIndex]).Value.AsInteger;
        memReceberPagNRO_CONTA.Value := TValueObject(Items.Objects[ItemIndex]).Value2.AsString;
      end;
    end;
    memReceberPag.Post;
  end;
  p_AdicionarRecebimento;
end;

procedure TfrmTabs.p_RemoverPagtoRecebimento;
var
  vItem: TListViewItem;
  vData: Integer;
begin
  with ListViewReceberPag do
  begin
    if (ItemIndex = -1) then
      Exit;
    vItem := TListViewItem(Items[ItemIndex]);
    vData := StrToIntDef(vItem.Data['Text1'].AsString, 0);
    //-- excluir item entidade
    ItemIndex := -1;
    with dmBanco, dmBanco.memReceberPag do
    begin
      First;
      while not EOF do
      begin
        if (memReceberPagNRO_PAGTO.Value = vData) then
        begin
          Delete;
          Break;
        end;
        Next;
      end;
    end;
    //-- atualizar listView
    Items.Clear;
    with dmBanco, dmBanco.memReceberPag do
    begin
      First;
      while not EOF do
      begin
        p_AdicionarRecebimento;
        Next;
      end;
    end;
    TotalizarRecebimento;
  end;
end;

procedure TfrmTabs.Image19Click(Sender: TObject);
begin
  MessageDlg('Deseja realmente excluir pagto ?', System.UITypes.TMsgDlgType.mtInformation, [System.UITypes.TMsgDlgBtn.mbYes, System.UITypes.TMsgDlgBtn.mbNo], 0,
    procedure(const AResult: System.UITypes.TModalResult)
    begin
      case AResult of
        mrYES:
          begin
            p_RemoverPagtoRecebimento;
          end;
      end;
    end);
end;

procedure TfrmTabs.Image20Click(Sender: TObject);
begin
  actPedido.ExecuteTarget(self);
end;

procedure TfrmTabs.Image2Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmTabs.Image2MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  Image2.Opacity := 0.5;
end;

procedure TfrmTabs.Image2MouseLeave(Sender: TObject);
begin
  Image2.Opacity := 1;
end;

procedure TfrmTabs.Image3Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmTabs.Image3MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  Image3.Opacity := 0.5;
end;

procedure TfrmTabs.Image3MouseLeave(Sender: TObject);
begin
  Image3.Opacity := 1;
end;

procedure TfrmTabs.Image4Click(Sender: TObject);
begin
  if dmBanco.ped = 'C' then
    actClientes.ExecuteTarget(self)
  else
    Close;
end;

procedure TfrmTabs.Image4MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  Image4.Opacity := 0.5;
end;

procedure TfrmTabs.Image4MouseLeave(Sender: TObject);
begin
  Image4.Opacity := 1;
end;

procedure TfrmTabs.Image5Click(Sender: TObject);
begin
  dmBanco.qryProdutos.Close;
  dmBanco.qryProdutos.sql.Clear;
  dmBanco.qryProdutos.sql.Add('select * from TB_PRODUTO order by Descricao limit 100');
  dmBanco.qryProdutos.Open;
  dmBanco.qryCondicaoPagto.Close;
  dmBanco.qryCondicaoPagto.Open;
  dmBanco.qryCondicaoPagto.First;
  ComboBoxPagto.Items.Clear;
  while not dmBanco.qryCondicaoPagto.Eof do
  begin
    ComboBoxPagto.Items.Add(dmBanco.qryCondicaoPagtoCODIGO.AsString + '-' + dmBanco.qryCondicaoPagtoDESCRICAO.AsString);
    dmBanco.qryCondicaoPagto.Next;
  end;
  dmBanco.qryVendedor.Close;
  dmBanco.qryVendedor.Open;
  dmBanco.qryVendedor.First;
  ComboBoxVendedor.Items.Clear;
  while not dmBanco.qryVendedor.Eof do
  begin
    ComboBoxVendedor.Items.Add(dmBanco.qryVendedorCODIGO.AsString + '-' + dmBanco.qryVendedorNOME.AsString);
    dmBanco.qryVendedor.Next;
  end;
  Label6.Text := dmBanco.qryClientesNOME.AsString;
  ListViewItemPedido.Items.Clear;
  dmBanco.memitens.Close;
  dmBanco.memitens.Open;
  actAddPedido.ExecuteTarget(self);
end;

procedure TfrmTabs.Image5MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  Image5.Opacity := 0.5;
end;

procedure TfrmTabs.Image5MouseLeave(Sender: TObject);
begin
  Image5.Opacity := 1;
end;

procedure TfrmTabs.Image6Click(Sender: TObject);
begin
  if dmBanco.prod_status = 'I' then
  begin
  end;
  if dmBanco.prod_status = 'V' then
  begin
    Close;
  end;
end;

procedure TfrmTabs.Image6MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  Image6.Opacity := 0.5;
end;

procedure TfrmTabs.Image6MouseLeave(Sender: TObject);
begin
  Image6.Opacity := 1;
end;

procedure TfrmTabs.Image7Click(Sender: TObject);
begin
  dmBanco.qryProdutos.Close;
  dmBanco.qryProdutos.sql.Clear;
  dmBanco.qryProdutos.sql.Add('select * from TB_PRODUTO where descricao like ' + QuotedStr('%' + EditDescrProdutos.Text + '%') + ' order by Descricao');
  dmBanco.qryProdutos.Open;
  ListViewProduto.BeginUpdate;
  dmBanco.qryProdutos.First;
  ListViewProduto.Items.Clear;
  while not dmBanco.qryProdutos.Eof do
  begin
    with ListViewProduto.Items.Add do
    begin
      Data['Text5'] := dmBanco.qryProdutosCODIGO.AsString;
      Data['Text1'] := dmBanco.qryProdutosCODIGO.AsString + ' - ' + dmBanco.qryProdutosDESCRICAO.AsString;
      Data['Text2'] := 'Unid.    .: ' + dmBanco.qryProdutosUNIDADE.AsString;
      Data['Text3'] := 'Barra    .: ' + dmBanco.qryProdutosBARRAS.AsString;
      Data['Text4'] := formatfloat('##,###,###0.00', dmBanco.qryProdutosPRECO_VENDA.AsCurrency);
      Data['Text6'] := 'Vlr Minimo .: ' + formatfloat('##,###,###0.00', dmBanco.qryProdutosPRECO_MIN.AsCurrency);
      Data['Text7'] := 'Vlr Atacado.: ' + formatfloat('##,###,###0.00', dmBanco.qryProdutosPRECO_ATACADO.AsCurrency);
      Data['Text8'] := 'Vlr Compra .: ' + formatfloat('##,###,###0.00', dmBanco.qryProdutosPRECO_COMPRA.AsCurrency);
    end;
    dmBanco.qryProdutos.Next;
  end;
  ListViewProduto.EndUpdate;
  EditDescrProdutos.Text := '';
end;

procedure TfrmTabs.Image7MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  Image7.Opacity := 0.5;
end;

procedure TfrmTabs.Image7MouseLeave(Sender: TObject);
begin
  Image7.Opacity := 1;
end;

procedure TfrmTabs.Image8Click(Sender: TObject);
begin
  with dmBanco.qryProdutos do
  begin
    Close;
    Sql.Clear;
    Sql.Add('select * from TB_PRODUTO');
    if EditDescrProduto.Text <> '' then
      Sql.Add('where descricao like ''%' + ReplaceText(EditDescrProduto.Text, ' ', '%') + '%''');
    Sql.Add('order by Descricao');
    Sql.Add('limit 500');
    Open;
  end;
  ListViewProduto.BeginUpdate;
  dmBanco.qryProdutos.First;
  ListViewProduto.Items.Clear;
  while not dmBanco.qryProdutos.Eof do
  begin
    with ListViewProduto.Items.Add do
    begin
      Data['Text5'] := dmBanco.qryProdutosCODIGO.AsString;
      Data['Text1'] := dmBanco.qryProdutosCODIGO.AsString + ' - ' + dmBanco.qryProdutosDESCRICAO.AsString;
      Data['Text2'] := 'UN       .: ' + dmBanco.qryProdutosUNIDADE.AsString;
      Data['Text3'] := 'Barra    .: ' + dmBanco.qryProdutosBARRAS.AsString;
      Data['Text4'] := formatfloat('##,###,###0.00', dmBanco.qryProdutosPRECO_VENDA.AsCurrency);
      Data['Text6'] := 'Vlr Minimo .: ' + formatfloat('##,###,###0.00', dmBanco.qryProdutosPRECO_MIN.AsCurrency);
      Data['Text7'] := 'Vlr Atacado.: ' + formatfloat('##,###,###0.00', dmBanco.qryProdutosPRECO_ATACADO.AsCurrency);
      Data['Text8'] := 'Vlr Compra .: ' + formatfloat('##,###,###0.00', dmBanco.qryProdutosPRECO_COMPRA.AsCurrency);
    end;
    dmBanco.qryProdutos.Next;
  end;
  ListViewProduto.EndUpdate;
  EditDescrProduto.Text := '';
  dmBanco.prod_status := 'I';
  actProdutos.ExecuteTarget(self);
end;

procedure TfrmTabs.Image8MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  Image8.Opacity := 0.5;
end;

procedure TfrmTabs.Image8MouseLeave(Sender: TObject);
begin
  Image8.Opacity := 1;
end;

procedure TfrmTabs.Image9Click(Sender: TObject);
var
  total: currency;
  i: integer;
  cod: string;
begin
  if (ComboBoxVendedor.Selected = nil) then
  begin
    TClsMessage.MensagemHint('Informe o vendedor');
    Exit;
  end;
  if (ComboBoxPagto.Selected = nil) then
  begin
    TClsMessage.MensagemHint('Informe a cond. pagto');
    Exit;
  end;
  if (dmBanco.memitens.IsEmpty) then
  begin
    TClsMessage.MensagemHint('Informe um item de produto');
    Exit;
  end;
  total := 0;
  i := 1;
  dmBanco.memitens.First;
  while not dmBanco.memitens.Eof do
  begin
    total := total + dmBanco.memitensVLR_TOTAL.Value;
    dmBanco.memitens.Next;
  end;
  cod := format('%4.4d', [StrToInt(dmBanco.codusuario)]) + FormatDateTime('yyyymmddhhmmss', now);
  dmBanco.qryAux.Close;
  dmBanco.qryAux.sql.Clear;
  dmBanco.qryAux.sql.Add('insert into TB_PEDIDO (CODIGO,DATA_PEDIDO,VENDEDOR,TIPO,TOTAL_PEDIDO,OBS,CLIENTE,COD_PAGTO,CODEMP) ');
  dmBanco.qryAux.sql.Add('VALUES (:CODIGO,:DATA_PEDIDO,:VENDEDOR,:TIPO,:TOTAL_PEDIDO,:OBS,:CLIENTE,:COD_PAGTO,:CODEMP)');
  dmBanco.qryAux.ParamByName('CODIGO').Value := cod;
  dmBanco.qryAux.ParamByName('DATA_PEDIDO').AsDateTime := now;
  dmBanco.qryAux.ParamByName('VENDEDOR').Value := StrToInt(copy(ComboBoxVendedor.Selected.Text, 1, Pos('-', ComboBoxVendedor.Selected.Text) - 1));
  dmBanco.qryAux.ParamByName('TIPO').Value := 'P';
  dmBanco.qryAux.ParamByName('TOTAL_PEDIDO').Value := total;
  dmBanco.qryAux.ParamByName('OBS').Value := '';
  dmBanco.qryAux.ParamByName('CLIENTE').Value := dmBanco.qryClientesCODIGO.AsString;
  dmBanco.qryAux.ParamByName('COD_PAGTO').Value := StrToInt(copy(ComboBoxPagto.Selected.Text, 1, Pos('-', ComboBoxPagto.Selected.Text) - 1));
  dmBanco.qryAux.ParamByName('CODEMP').Value := TAtualizaBD.LerINI('Usuario', 'CodEmp');
  dmBanco.qryAux.ExecSQL;
  dmBanco.memitens.First;
  while not dmBanco.memitens.Eof do
  begin
    dmBanco.qryAux.Close;
    dmBanco.qryAux.sql.Clear;
    dmBanco.qryAux.sql.Add('insert into TB_ITENS_PEDIDO (SEQ,COD_PEDIDO,TIPO,COD_PRODUTO,QTD,VALOR_UNITARIO,VALOR_TOTAL) ');
    dmBanco.qryAux.sql.Add('VALUES (:SEQ,:COD_PEDIDO,:TIPO,:COD_PRODUTO,:QTD,:VALOR_UNITARIO,:VALOR_TOTAL)');
    dmBanco.qryAux.ParamByName('SEQ').Value := i;
    dmBanco.qryAux.ParamByName('COD_PEDIDO').Value := cod;
    dmBanco.qryAux.ParamByName('TIPO').Value := 'P';
    dmBanco.qryAux.ParamByName('COD_PRODUTO').Value := dmBanco.memitensCOD_PRODUTO.Value;
    dmBanco.qryAux.ParamByName('QTD').Value := dmBanco.memitensQTD.Value;
    dmBanco.qryAux.ParamByName('VALOR_UNITARIO').Value := dmBanco.memitensVLR_UNITARIO.Value;
    dmBanco.qryAux.ParamByName('VALOR_TOTAL').Value := dmBanco.memitensVLR_TOTAL.Value;
    dmBanco.qryAux.ExecSQL;
    inc(i);
    dmBanco.memitens.Next;
  end;
  dmBanco.memitens.Close;
  dmBanco.qrypedidos.Refresh;
  ListViewPedido.BeginUpdate;
  dmBanco.qrypedidos.First;
  ListViewPedido.Items.Clear;
  while not dmBanco.qrypedidos.Eof do
  begin
    with ListViewPedido.Items.Add do
    begin
      Data['Text1'] := dmBanco.qrypedidosCODIGO.AsString;
      Data['Text2'] := dmBanco.qrypedidosDATA_PEDIDO.AsString;
      Data['Text3'] := '$ ' + formatfloat('##,###,###0.00', dmBanco.qrypedidosTOTAL_PEDIDO.Value);
      Data['Text4'] := 'Enviado .: ' + dmBanco.qrypedidosDATA_SINC.AsString;
    end;
    dmBanco.qrypedidos.Next;
  end;
  ListViewPedido.EndUpdate;
  actPedido.ExecuteTarget(self);
end;

procedure TfrmTabs.Image9MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  Image9.Opacity := 0.5;
end;

procedure TfrmTabs.Image9MouseLeave(Sender: TObject);
begin
  Image9.Opacity := 1;
end;

procedure TfrmTabs.Label1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  Rectangle5.Opacity := 0.5;
end;

procedure TfrmTabs.Label1MouseLeave(Sender: TObject);
begin
  Rectangle5.Opacity := 1;
end;

procedure TfrmTabs.ListarDispositivosPareadosNoCombo;
var
  lDevice: TBluetoothDevice;
begin
  try
    cbxDevices.Clear;
    if Assigned(Bluetooth1) and Bluetooth1.Enabled and (Bluetooth1.PairedDevices <> nil) and (Bluetooth1.PairedDevices.Count > 0) then
    begin
      for lDevice in Bluetooth1.PairedDevices do
        cbxDevices.Items.Add(lDevice.DeviceName);
    end;
  except
    on E: Exception do
      BootLog('ListarDispositivosPareadosNoCombo error: ' + E.Message);
  end;
end;

procedure TfrmTabs.ListViewClienteItemClick(const Sender: TObject; const AItem: TListViewItem);
begin
  dmBanco.ped := 'C';
  dmBanco.qryClientes.Locate('Codigo', AItem.Data['Text5'].AsString, []);
  dmBanco.qrypedidos.Close;
  dmBanco.qrypedidos.sql.Clear;
  dmBanco.qrypedidos.sql.Add('select * from TB_PEDIDO where CLIENTE = :cli');
  dmBanco.qrypedidos.ParamByName('cli').Value := dmBanco.qryClientesCODIGO.Value;
  dmBanco.qrypedidos.Open;
  ListViewPedido.BeginUpdate;
  dmBanco.qrypedidos.First;
  ListViewPedido.Items.Clear;
  while not dmBanco.qrypedidos.Eof do
  begin
    with ListViewPedido.Items.Add do
    begin
      Data['Text1'] := dmBanco.qrypedidosCODIGO.AsString;
      Data['Text2'] := dmBanco.qrypedidosDATA_PEDIDO.AsString;
      Data['Text3'] := formatfloat('##,###,###0.00', dmBanco.qrypedidosTOTAL_PEDIDO.Value);
      Data['Text4'] := 'Enviado .: ' + dmBanco.qrypedidosDATA_SINC.AsString;
    end;
    dmBanco.qrypedidos.Next;
  end;
  ListViewPedido.EndUpdate;
  lblCliente.Text := dmBanco.qryClientesNOME.AsString;
  Image5.Visible := true;
  Image12.Visible := true;
  Image11.Visible := true;
  actPedido.ExecuteTarget(self);
end;

procedure TfrmTabs.ListViewPedidoItemClick(const Sender: TObject; const AItem: TListViewItem);
begin
  ShowMenu(recMenu, recSubMenu);
end;

procedure TfrmTabs.ListViewProdutoItemClick(const Sender: TObject; const AItem: TListViewItem);
begin
  if dmBanco.prod_status = 'I' then
  begin
    dmBanco.qryProdutos.Locate('CODIGO', AItem.Data['Text5'].AsString, []);
    Label8.Text := dmBanco.qryProdutosDESCRICAO.AsString;
    NumberBoxQtde.Value := 1;
    NumberBoxUnit.Value := dmBanco.qryProdutosPRECO_VENDA.Value;
    ComboBoxTipoValor.Index := ord(tvVarejo);
    actAdditem.ExecuteTarget(self);
  end;
end;

procedure TfrmTabs.ImageBuscarReceberClick(Sender: TObject);
var
  vCodCliente: Integer;
  vNomCliente: string;
begin
  ListViewReceber.Items.Clear;
  vNomCliente := UpperCase(Trim(EditClienteReceber.Text));
  if (vNomCliente = '') then
  begin
    TClsMessage.MensagemHint('Informe o cliente!!!');
    Exit;
  end;
  TClsMessage.MensagemHint('Consultando...');
  vCodCliente := TClsConverter.StrToInteger(vNomCliente);
  dmBanco.qryReceber.Close;
  dmBanco.qryReceber.SQL.Clear;
  dmBanco.qryReceber.SQL.Add('select * from TB_RECEBER');
  if (vCodCliente > 0) then
    dmBanco.qryReceber.SQL.Add('where COD_CLIENTE = ' + IntToStr(vCodCliente))
  else
    dmBanco.qryReceber.SQL.Add('where NOM_CLIENTE like ''%' + ReplaceText(vNomCliente, ' ', '%') + '%'' ');
  dmBanco.qryReceber.SQL.Add('and DATA_VENCTO < :data_vencto');
  dmBanco.qryReceber.SQL.Add('order by DATA_VENCTO');
  dmBanco.qryReceber.ParamByName('data_vencto').AsDateTime := Date;
  dmBanco.qryReceber.Open;
  if (dmBanco.qryReceber.IsEmpty) then
  begin
    TClsMessage.MensagemHint('Nenhum registro encontrado...');
    Exit;
  end;
  ListViewReceber.BeginUpdate;
  ListViewReceber.Items.Clear;
  dmBanco.qryReceber.First;
  while not dmBanco.qryReceber.Eof do
  begin
    with ListViewReceber.Items.Add do
    begin
      Data['Text1'] := dmbanco.qryReceberCOD_EMP.AsString + '#' + dmbanco.qryReceberCOD_CLIENTE.AsString + '#' + dmbanco.qryReceberNUM_FAT.AsString + '#' + dmbanco.qryReceberNUM_PARC.AsString;
      Data['Text2'] := dmbanco.qryReceberDATA_EMISSAO.AsString + ' - ' + dmbanco.qryReceberNOM_CLIENTE.AsString;
      Data['Text3'] := Formatfloat('##,###,###0.00', dmbanco.qryReceberVLR_FATURA.Value);
      Data['Text4'] := 'Vencto .: ' + dmbanco.qryReceberDATA_VENCTO.AsString;
      Data['Text5'] := 'Aberto';
    end;
    dmBanco.qryReceber.Next;
  end;
  ListViewReceber.EndUpdate;
  Show;
end;

procedure TfrmTabs.ListViewReceberItemClick(const Sender: TObject; const AItem: TListViewItem);
begin
  ListViewReceberItem(AItem);
end;

function TfrmTabs.MakeScaleScreenshot(const Sender: TControl): TBitmap;
var
  fScreenScale: Single;
begin
  fScreenScale := 1; // Canvas.Scale; //GetScreenScale;
  Result := TBitmap.Create(Round(Sender.Width * fScreenScale), Round(Sender.Height * fScreenScale));
  Result.Clear(0);
  if Result.Canvas.BeginScene then
  try
    Sender.PaintTo(Result.Canvas, RectF(0, 0, Result.Width, Result.Height));
  finally
    Result.Canvas.EndScene;
  end;
end;

procedure TfrmTabs.ListViewReceberItem(AItem: TListViewItem);
var
  vVlrTotalReceber, vVlrValorReceber: Real;
  vTipoFatura: TTipoFatura;
  vData: string;
begin
  if (AItem = nil) then
    Exit;
  vVlrValorReceber := TClsConverter.StrToFloat(EditValorReceber.Text);
  vVlrTotalReceber := TClsConverter.StrToFloat(LabelValorReceber.Text);
  vData := AItem.Data['Text5'].AsString;
  vTipoFatura := StrToTipoFatura(vData);
  if (IsAberto(vTipoFatura)) then
    if (vVlrValorReceber > 0) and (vVlrTotalReceber > vVlrValorReceber) then
    begin
      TClsMessage.MensagemHint('Titulo(s) excede ao valor informado!!!');
      Exit;
    end;
  if IsAberto(vTipoFatura) then
    vTipoFatura := tfReceber
  else
    vTipoFatura := tfAberto;
  vData := cTipoFatura[vTipoFatura];
  AItem.Data['Text5'] := vData;
  TotalizarRecebimento;
end;

procedure TfrmTabs.TotalizarPedido;
var
  vVlrPedido, vVlItem: Real;
  vItem: TListViewItem;
  vData: string;
  I: Integer;
begin
  vVlrPedido := 0;
  for I := 0 to ListViewItemPedido.Items.Count - 1 do
  begin
//    vItem := TListViewItem(ListViewReceber.Items[I]);
    vItem := TListViewItem(ListViewItemPedido.Items[I]);
    vData := vItem.Data['Text3'].AsString;
    vData := ReplaceStr(vData, '$ ', '');
    vVlItem := TClsConverter.StrToFloatFmt(vData);
    vVlrPedido := vVlrPedido + vVlItem;
  end;
  LabelValorPedido.Text := FormatFloat('##,###,###0.00', vVlrPedido);
end;

procedure TfrmTabs.TotalizarRecebimento;
var
  vVlrReceber, vVlrParcela: Real;
  vTipoFatura: TTipoFatura;
  vItem: TListViewItem;
  vData: string;
  I: Integer;
begin
  vVlrReceber := 0;
  for I := 0 to ListViewReceber.Items.Count - 1 do
  begin
    vItem := TListViewItem(ListViewReceber.Items[I]);
    vData := vItem.Data['Text5'].AsString;
    vTipoFatura := StrToTipoFatura(vData);
    if (IsReceber(vTipoFatura)) then
    begin
      vData := vItem.Data['Text3'].AsString;
      vVlrParcela := TClsConverter.StrToFloatFmt(vData);
      vVlrReceber := vVlrReceber + vVlrParcela;
    end;
  end;
  LabelValorReceber.Text := FormatFloat('##,###,###0.00', vVlrReceber);
end;

procedure TfrmTabs.p_AdicionarRecebimento;
begin
  with ListViewReceberPag.Items.Add do
  begin
    Data['Text1'] := dmBanco.memReceberPagNRO_PAGTO.AsString;
    Data['Text2'] := dmBanco.memReceberPagTIP_DOCTO.AsString + ' / ' + dmBanco.memReceberPagNRO_DOCTO.AsString;
    Data['Text3'] := dmBanco.memReceberPagCOD_MOEDA.AsString + ' X $ ' + formatfloat('##,###,###0.00', dmBanco.memReceberPagVLR_DOCTO.Value);
    Data['Text4'] := dmBanco.memReceberPagNRO_BANCO.AsString;
    Data['Text5'] := dmBanco.memReceberPagNRO_CONTA.AsString;
  end;
end;

procedure TfrmTabs.p_EfetuarRecebimento;
begin
  MessageDlg('Efetuar recibiemento ?', System.UITypes.TMsgDlgType.mtInformation, [System.UITypes.TMsgDlgBtn.mbYes, System.UITypes.TMsgDlgBtn.mbNo], 0,
    procedure(const AResult: System.UITypes.TModalResult)
    begin
      case AResult of
        mrYES:
          begin
            EfetuarRecebimento;
          end;
      end;
    end);
end;

procedure TfrmTabs.ComboBoxTipoValorChange(Sender: TObject);
begin
  case TTipoValor(ComboBoxTipoValor.ItemIndex) of
    tvAtacado:
      begin
        NumberBoxUnit.Value := dmBanco.qryProdutosPRECO_ATACADO.AsCurrency;
      end;
    tvVarejo:
      begin
        NumberBoxUnit.Value := dmBanco.qryProdutosPRECO_VENDA.AsCurrency;
      end;
  end;
  NumberBoxDesc.Value := 0;
  NumberBoxLiqui.Value := NumberBoxUnit.Value;
end;

procedure TfrmTabs.cbxDevicesChange(Sender: TObject);
begin
  if (cbxDevices.Selected <> nil) and (cbxDevices.Selected.Text <> EmptyStr) then
    if ConectarImpressora(cbxDevices.Selected.Text) then

end;

function TfrmTabs.ConectarImpressora(ANomeDevice: string): Boolean;
var
  lDevice: TBluetoothDevice;
begin
  try
    Result := False;
    lDevice := ObterDevicePeloNome(ANomeDevice);
    if lDevice <> nil then
    begin
      FSocket := lDevice.CreateClientSocket(StringToGUID(UUID), False);
      if FSocket <> nil then
      begin
        FSocket.Connect;
        Result := FSocket.Connected
      end;
    end;
  except
    on E: Exception do


  end;
end;

function TfrmTabs.ObterDevicePeloNome(ANomeDevice: string): TBluetoothDevice;
var
  lDevice: TBluetoothDevice;
begin
  Result := nil;
  try
    if Assigned(Bluetooth1) and Bluetooth1.Enabled and (Bluetooth1.PairedDevices <> nil) then
    begin
      for lDevice in Bluetooth1.PairedDevices do
        if lDevice.DeviceName = ANomeDevice then
        begin
          Result := lDevice;
          Break;
        end;
    end;
  except
    on E: Exception do
      BootLog('ObterDevicePeloNome error: ' + E.Message);
  end;
end;

procedure TfrmTabs.CloseMenu(ARecMenu, ARecSubMenu: TRectangle);
begin
  var T: TThread;
  begin
    TAnimator.AnimateFloat(ARecSubMenu, 'Position.Y', Application.MainForm.ClientHeight + 200, 0.2, TAnimationType.out, TInterpolationType.Linear);
    T := TThread.CreateAnonymousThread(
      procedure
      begin
        Sleep(250);
        TThread.Synchronize(TThread(nil),
          procedure
          begin
            ARecMenu.Visible := False;
          end);
      end);
    T.OnTerminate := Nil;
    T.Start;
  end;
end;

procedure TfrmTabs.ShowMenu(ARecMenu, ARecSubMenu: TRectangle);
begin
  ARecSubMenu.Align := TAlignLayout.None;
  ARecSubMenu.Position.Y := Application.MainForm.ClientHeight + 200;
  ARecSubMenu.Width := Application.MainForm.ClientWidth;
  ARecSubMenu.Height := Trunc(Application.MainForm.ClientHeight / 2);
  ARecSubMenu.Position.X := 0;
  ARecSubMenu.BringToFront;

  ARecMenu.Visible := True;
  TAnimator.AnimateFloat(ARecSubMenu, 'Position.Y', Trunc(Application.MainForm.ClientHeight / 2), 0.2, TAnimationType.out, TInterpolationType.Linear);
end;

procedure TfrmTabs.ComboBoxTipoDescChange(Sender: TObject);
begin
  ComboBoxTipoValorChange(nil);
end;

procedure TfrmTabs.ComboBoxTipoDoctoChange(Sender: TObject);
var
  vTipoDocto: TTipoDocto;
begin
  vTipoDocto := TTipoDocto(ComboBoxTipoDocto.ItemIndex);
  LayoutDataDocto.Visible := vTipoDocto in [tdDeposito, tdCheque];
  LayoutContaDocto.Visible := vTipoDocto in [tdDeposito];
  LayoutBancoDocto.Visible := vTipoDocto in [tdCheque];
end;

procedure TfrmTabs.EditValorReceberKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if not CharInSet(KeyChar, ['.', '0'..'9']) then
  begin
    KeyChar := #0;
  end;
  if (KeyChar = '.') and (TEdit(Sender).Text.IndexOf('.') < -1) then
  begin
    KeyChar := #0;
  end;
end;

procedure TfrmTabs.EfetuarRecebimento;
var
  vCodEmp, vCodCli, vNumFat, vNumPar, I: Integer;
  vNroPagto, vTipDoc, vCodMod, vNroDoc, vNroBan, vNroCta: Integer;
  vTipoFatura: TTipoFatura;
  vDataList: TStringList;
  vItem: TListViewItem;
  vDatDoc: TDateTime;
  vVlrDoc: Real;
  vData: string;
begin
  vDataList := TStringList.Create;
  vDataList.Delimiter := '#';
  p_LimparCodigoPagamento;
  for I := 0 to ListViewReceber.Items.Count - 1 do
  begin
    vItem := TListViewItem(ListViewReceber.Items[I]);
    vData := vItem.Data['Text5'].AsString;
    vTipoFatura := StrToTipoFatura(vData);
    if (IsReceber(vTipoFatura)) then
    begin
      vData := vItem.Data['Text1'].AsString + sLineBreak;
      vDataList.DelimitedText := vData;
      vCodEmp := StrToIntDef(vDataList[0], 0);
      vCodCli := StrToIntDef(vDataList[1], 0);
      vNumFat := StrToIntDef(vDataList[2], 0);
      vNumPar := StrToIntDef(vDataList[3], 0);
      if (vCodEmp > 0) and (vCodCli > 0) and (vNumFat > 0) and (vNumPar > 0) then
      begin
        p_GerarCodigoPagamento;
        TClsSincronizar.IncReceber(FCdPagto, vCodEmp, vCodCli, vNumFat, vNumPar);
      end;
    end;
  end;
  vNroPagto := 1;
  for I := 0 to ListViewReceberPag.Items.Count - 1 do
  begin
    vTipDoc := StrToIntDef(vDataList[0], 0);
    vCodMod := StrToIntDef(vDataList[1], 0);
    vVlrDoc := StrToFloatDef(vDataList[2], 0);
    vDatDoc := StrToDateDef(vDataList[3], 0);
    vNroDoc := StrToIntDef(vDataList[4], 0);
    vNroBan := StrToIntDef(vDataList[5], 0);
    vNroCta := StrToIntDef(vDataList[6], 0);
    TClsSincronizar.IncReceberPag(FCdPagto, vNroPagto, vTipDoc, vCodMod, vVlrDoc, vDatDoc, vNroDoc, vNroBan, vNroCta);
    Inc(vNroPagto);
  end;
  vDataList.Free;
  if (FCdPagto <> '') then
  begin
    ShowMessage('Recebimento efetuado com sucesso!!! ' + FCdPagto);
    p_ImprimirRecebimento;
  end
  else
    ShowMessage('Nenhum recebimento efetuado!!!');
end;

procedure TfrmTabs.EnviarImpressao(const Sender: TControl);
var
  LBuffer: string;
  Bitmap: TBitmap;
  I: Integer;
  viDif: Integer;
  vbNormal: TBytes;
begin
  Bitmap := MakeScaleScreenshot(Sender);

  LBuffer := #27'3'#30#27'@'; // Inicializa a impressora
  LBuffer := LBuffer + _ESCPosPrintBitmap().RenderBitmapObj(Bitmap) + LBuffer;

  // Converte a String em Bytes para enviar à impressora...
  SetLength(vbNormal, Length(LBuffer));

  viDif := Abs(Low(LBuffer) - Low(vbNormal));
  for I := Low(LBuffer) to High(LBuffer) do
    vbNormal[I - viDif] := Ord(LBuffer[I]);

  // Imprimir
  if (FSocket <> nil) and (FSocket.Connected) then
  begin
    FSocket.SendData(vbNormal);
  end;
end;

procedure TfrmTabs.p_ImprimirRecebimento;
begin
  MessageDlg('Imprimir recibo ?', System.UITypes.TMsgDlgType.mtInformation, [System.UITypes.TMsgDlgBtn.mbYes, System.UITypes.TMsgDlgBtn.mbNo], 0,
    procedure(const AResult: System.UITypes.TModalResult)
    begin
      case AResult of
        mrYES:
          begin
            ImprimirRecebimento;
          end;
        mrNo:
          begin
            Close;
          end;
      end;
    end);
end;

procedure TfrmTabs.ImprimirRecebimento;
const
  cTRACOD = '==============================';
  cTRACOS = '------------------------------';
var
  vConteudo, vData: string;
  vTipoFatura: TTipoFatura;
  vItem: TListViewItem;
  I: Integer;
begin
  vConteudo := '';
  for I := 0 to ListViewReceber.Items.Count - 1 do
  begin
    vItem := TListViewItem(ListViewReceber.Items[I]);
    vData := vItem.Data['Text5'].AsString;
    vTipoFatura := StrToTipoFatura(vData);
    if (IsReceber(vTipoFatura)) then
    begin
      if (vConteudo = '') then
      begin
        vConteudo := vConteudo + cTRACOD + sLineBreak;
        vConteudo := vConteudo + 'Recibo: ' + EditNroRecibo.Text + sLineBreak;
        vConteudo := vConteudo + cTRACOS + sLineBreak;
        vConteudo := vConteudo + 'Pagto: ' + FCdPagto + sLineBreak;
        vConteudo := vConteudo + 'Data: ' + DateTimeToStr(now) + sLineBreak;
        vConteudo := vConteudo + 'Usuario: ' + dmBanco.nomeusuario + '-' + dmBanco.codusuario + sLineBreak;
        vConteudo := vConteudo + 'Cliente: ' + EditClienteReceber.Text + sLineBreak;
        if (EditValorReceber.Text <> '') then
          vConteudo := vConteudo + 'Valor Informado: ' + EditValorReceber.Text + sLineBreak;
      end;
      vConteudo := vConteudo + cTRACOS + sLineBreak;
      vData := 'Titulo:' + vItem.Data['Text1'].AsString + sLineBreak + 'Emissao:' + vItem.Data['Text2'].AsString + sLineBreak + 'Valor:' + vItem.Data['Text3'].AsString + sLineBreak + 'Vencto:' + vItem.Data['Text4'].AsString + sLineBreak;
      vConteudo := vConteudo + vData + sLineBreak;
    end;
  end;
  for I := 0 to ListViewReceberPag.Items.Count - 1 do
  begin
    vItem := TListViewItem(ListViewReceberPag.Items[I]);
    vConteudo := vConteudo + cTRACOS + sLineBreak;
    vData := 'Tipo:' + vItem.Data['Text1'].AsString + sLineBreak + 'Moeda:' + vItem.Data['Text2'].AsString + sLineBreak + 'Valor:' + vItem.Data['Text3'].AsString + sLineBreak + 'Data:' + vItem.Data['Text4'].AsString + sLineBreak + 'Numero:' + vItem.Data['Text5'].AsString + sLineBreak + 'Conta:' + vItem.Data['Text6'].AsString + sLineBreak;
    vConteudo := vConteudo + vData + sLineBreak;
  end;
  if (vConteudo = '') then
    exit;
  vConteudo := vConteudo + cTRACOS + sLineBreak;
  vConteudo := vConteudo + 'Valor Recebido: ' + LabelValorReceber.Text + sLineBreak;
  vConteudo := vConteudo + cTRACOD + sLineBreak;
  try
    if TClsPrinterBluetooth.ImprimirConteudo(vConteudo, dmBanco.impressora) then
      TClsMessage.MensagemHint('Impressão efetuada com sucesso');
  except
    on E: Exception do
    begin
      TClsMessage.MensagemHint('Erro ao efetuar impressão / ' + e.Message);
    end;
  end;
  p_SalvarRecibo;
  Close;
end;

procedure TfrmTabs.NumberBoxDescChange(Sender: TObject);
var
  vVlDesconto: Real;
begin
  vVlDesconto := GetVlDesconto();
  NumberBoxLiqui.Value := NumberBoxUnit.Value - vVlDesconto;
end;

procedure TfrmTabs.NumberBoxQtdeMouseLeave(Sender: TObject);
begin
  TNumberBox(Sender).SelectAll;
end;
//--

procedure TfrmTabs.p_CarregarRecibo;
begin
  EditNroRecibo.Text := dmBanco.qryConfRECIBO.AsString;
end;

procedure TfrmTabs.p_SalvarRecibo;
begin
  dmBanco.qryConf.Edit;
  dmBanco.qryConfRECIBO.AsInteger := StrToIntDef(EditNroRecibo.Text, 0) + 1;
  dmBanco.qryConf.Post;
end;

procedure TfrmTabs.recMenuClick(Sender: TObject);
begin
  CloseMenu(recMenu, recSubMenu);
end;

procedure TfrmTabs.Layout58Click(Sender: TObject);
begin
  ImprimirPedido;
  CloseMenu(recMenu, recSubMenu);
  actImpressao.ExecuteTarget(self);
end;

procedure TfrmTabs.ImprimirPedido;
var
  I: Integer;
begin
  dmBanco.qryPadrao.Close;
  dmBanco.qryPadrao.SQL.Clear;
  dmBanco.qryPadrao.SQL.Add('');
  dmBanco.qryPadrao.SQL.Add(' SELECT  ');
  dmBanco.qryPadrao.SQL.Add('     IP.*, ');
  dmBanco.qryPadrao.SQL.Add('     P.DESCRICAO, ');
  dmBanco.qryPadrao.SQL.Add('     PE.*, ');
  dmBanco.qryPadrao.SQL.Add('     EM.NOME DS_EMPRESA, ');
  dmBanco.qryPadrao.SQL.Add('     CL.NOME NM_CLIENTE, ');
  dmBanco.qryPadrao.SQL.Add('     VE.NOME NM_VENDEDOR, ');
  dmBanco.qryPadrao.SQL.Add('     COALESCE((SELECT SUM(VALOR_DESCONTO) DESCONTO FROM TB_ITENS_PEDIDO WHERE COD_PEDIDO = :CODIGO), 0) DESCONTO');
  dmBanco.qryPadrao.SQL.Add(' FROM TB_ITENS_PEDIDO IP ');
  dmBanco.qryPadrao.SQL.Add(' LEFT JOIN TB_PRODUTO P ON P.CODIGO = IP.COD_PRODUTO ');
  dmBanco.qryPadrao.SQL.Add(' LEFT JOIN TB_PEDIDO PE ON PE.CODIGO = IP.COD_PEDIDO ');
  dmBanco.qryPadrao.SQL.Add(' LEFT JOIN ADM_EMPRESA EM ON EM.CODEMP = PE.CODEMP ');
  dmBanco.qryPadrao.SQL.Add(' LEFT JOIN TB_CLIENTE CL ON CL.CODIGO = PE.CLIENTE ');
  dmBanco.qryPadrao.SQL.Add(' LEFT JOIN TB_VENDEDOR VE ON VE.CODIGO = PE.VENDEDOR ');
  dmBanco.qryPadrao.SQL.Add(' WHERE COD_PEDIDO = :CODIGO ');
  dmBanco.qryPadrao.ParamByName('CODIGO').AsString := dmBanco.qryPedidosCODIGO.AsString;
  dmBanco.qryPadrao.Open();

  Memo1.Lines.Clear;
  Memo1.Lines.Add('PRESUPUESTO DE VENTA');
  Memo1.Lines.Add('Empresa: ' + dmBanco.qryPadrao.FieldByName('DS_EMPRESA').AsString);
  Memo1.Lines.Add('Fecha: ' + dmBanco.qryPadrao.FieldByName('DATA_PEDIDO').AsString);
  Memo1.Lines.Add('Cliente: ' + dmBanco.qryPadrao.FieldByName('NM_CLIENTE').AsString);
  Memo1.Lines.Add('DIVERSOS');
  Memo1.Lines.Add('Vendedor: ' + dmBanco.qryPadrao.FieldByName('NM_VENDEDOR').AsString);
//  Memo1.Lines.Add('LOJA ' + dmBanco.qryPadrao.FieldByName('TIPO').AsString);
//  Memo1.Lines.Add('Cond. pago: ' + dmBanco.qryPadrao.FieldByName('TIPO').AsString);
  Memo1.Lines.Add('CONTADO');
//  Memo1.Lines.Add('Operacion: ' + dmBanco.qryPadrao.FieldByName('TIPO').AsString);
  Memo1.Lines.Add('-------------------------------');
  Memo1.Lines.Add('Codigo');
  Memo1.Lines.Add('Descripcion del producto ');
  Memo1.Lines.Add('Ct Descto. Unitario Total #');
  Memo1.Lines.Add('-------------------------------');

  for I := 0 to dmBanco.qryPadrao.RecordCount - 1 do
  begin
    Memo1.Lines.Add(dmBanco.qryPadrao.FieldByName('COD_PEDIDO').AsString);
    Memo1.Lines.Add(dmBanco.qryPadrao.FieldByName('DESCRICAO').AsString);

    Memo1.Lines.Add(
    FormatFloat('###,###,##0.00', StrToFloatDef(dmBanco.qryPadrao.FieldByName('QTD').AsString, 0)) + ' ' +
    FormatFloat('###,###,##0.00', StrToFloatDef(dmBanco.qryPadrao.FieldByName('VALOR_DESCONTO').AsString, 0)) + ' ' +
    FormatFloat('###,###,##0.00', StrToFloatDef(dmBanco.qryPadrao.FieldByName('VALOR_UNITARIO').AsString, 0)) + ' ' +
    FormatFloat('###,###,##0.00', StrToFloatDef(dmBanco.qryPadrao.FieldByName('VALOR_TOTAL').AsString, 0)));
  end;

  Memo1.Lines.Add('-------------------------------');
  Memo1.Lines.Add('Descuentos: ' + FormatFloat('###,###,##0.00', StrToFloatDef(dmBanco.qryPadrao.FieldByName('DESCONTO').AsString, 0)));
  Memo1.Lines.Add('Valor Total: ' + FormatFloat('###,###,##0.00', StrToFloatDef(dmBanco.qryPadrao.FieldByName('TOTAL_PEDIDO').AsString, 0)));
end;

end.

