unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Objects,FMX.Edit, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Effects,
  FMX.VirtualKeyboard, FMX.Platform, Rest.Types;

type
  TfrmMain = class(TForm)
    layPrincipal: TLayout;
    layTopo: TLayout;
    layRodape: TLayout;
    layMenu: TLayout;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    Rectangle3: TRectangle;
    GridPanelLayout1: TGridPanelLayout;
    Layout1: TLayout;
    Layout2: TLayout;
    Image2: TImage;
    Layout7: TLayout;
    Image7: TImage;
    Label1: TLabel;
    ShadowEffect2: TShadowEffect;
    ShadowEffect7: TShadowEffect;
    ShadowEffect8: TShadowEffect;
    ShadowEffect9: TShadowEffect;
    ShadowEffect10: TShadowEffect;
    Label2: TLabel;
    Label3: TLabel;
    Image1: TImage;
    ShadowEffect1: TShadowEffect;
    ShadowEffect11: TShadowEffect;
    Label8: TLabel;
    ShadowEffect12: TShadowEffect;
    Image8: TImage;
    ShadowEffect13: TShadowEffect;
    Layout6: TLayout;
    Image6: TImage;
    ShadowEffect6: TShadowEffect;
    Label7: TLabel;
    Layout5: TLayout;
    Image5: TImage;
    ShadowEffect5: TShadowEffect;
    Label6: TLabel;
    Layout3: TLayout;
    Image3: TImage;
    ShadowEffect3: TShadowEffect;
    Label4: TLabel;
    Layout4: TLayout;
    Image4: TImage;
    ShadowEffect4: TShadowEffect;
    Label5: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure Image2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure Image2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure Image5MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure Image5MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure Image6MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure Image6MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure Image8Click(Sender: TObject);
    procedure Image8MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure Image8MouseLeave(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Image3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure Image3MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure Image6Click(Sender: TObject);
    procedure Image5Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure Image4MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure Image4MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}
{$R *.XLgXhdpiTb.fmx ANDROID}

uses
  uBanco, uAcesso, uConf, uTabs, uMessage,
  Androidapi.JNI.PowerManager;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  {$IFDEF ANDROID}
  //AcquireWakeLock;
  {$ENDIF}
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  {$IFDEF ANDROID}
  //ReleaseWakeLock;
  {$ENDIF}

//  frmMain.Free;
//  frmMain := nil;
end;

procedure TfrmMain.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
var
  FService : IFMXVirtualKeyboardService;
begin
  if Key = vkHardwareBack then
  begin
    TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService, IInterface(FService));
    if (FService <> nil) and (TVirtualKeyboardState.Visible in FService.VirtualKeyBoardState) then
    begin
      //Back button pressed, keyboard visible, so do nothing...
    end else
    begin
      key := 0;
    end;
  end;

end;

procedure TfrmMain.Image1Click(Sender: TObject);
begin
  dmBanco.qryClientes.Close;
  dmBanco.qryClientes.Open;

  Application.CreateForm(TfrmTabs,frmTabs);
  frmTabs.TabControlPrin.TabIndex := 1;
  frmTabs.TabControlCli.TabIndex := 0;
  dmBanco.qryClientes.First;
  frmTabs.ListViewCliente.Items.Clear;
  while not dmBanco.qryClientes.Eof do
  begin
    with frmTabs.ListViewCliente.Items.Add do
    begin
      Data['Text5'] := dmbanco.qryClientesCODIGO.AsString;
      Data['Text1'] := dmbanco.qryClientesCODIGO.AsString+' - '+dmbanco.qryClientesNOME.AsString;
      Data['Text2'] := 'Documento .: '+dmbanco.qryClientesCNPJ_CPF.AsString;
      Data['Text3'] := 'Cidade    .: '+dmbanco.qryClientesCIDADE_DESCRICAO.AsString;
      Data['Text4'] := 'Telefone  .: '+dmbanco.qryClientesTELEFONE.AsString;
    end;
    dmBanco.qryClientes.Next;
  end;
  frmTabs.Show;
end;

procedure TfrmMain.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  Image1.Opacity := 0.5;
end;

procedure TfrmMain.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  Image1.Opacity := 1;
end;

procedure TfrmMain.Image2Click(Sender: TObject);
begin
   dmBanco.prod_status := 'V';

   dmBanco.qryProdutos.Close;
   dmBanco.qryProdutos.SQL.Clear;
   dmBanco.qryProdutos.SQL.Add('select * from TB_PRODUTO order by Descricao limit 500');
   dmBanco.qryProdutos.Open;

   Application.CreateForm(TfrmTabs,frmTabs);
   frmTabs.ListViewProduto.Items.Clear;
   frmTabs.ListViewProduto.BeginUpdate;
   dmBanco.qryProdutos.First;
   frmTabs.ListViewProduto.Items.Clear;
   while not dmBanco.qryProdutos.Eof do
   begin
     with frmTabs.ListViewProduto.Items.Add do
      begin
         Data['Text5'] := dmbanco.qryProdutosCODIGO.AsString;
         Data['Text1'] := dmbanco.qryProdutosCODIGO.AsString+' - '+dmbanco.qryProdutosDESCRICAO.AsString;
         Data['Text2'] := 'UN       .: '+dmbanco.qryProdutosUNIDADE.AsString;
         Data['Text3'] := 'Barra    .: '+dmbanco.qryProdutosBARRAS.AsString;
         Data['Text4'] := formatfloat('##,###,###0.00',dmbanco.qryProdutosPRECO_VENDA.AsCurrency);
         Data['Text6'] := 'Vlr Minimo .: '+formatfloat('##,###,###0.00',dmbanco.qryProdutosPRECO_MIN.AsCurrency);
         Data['Text7'] := 'Vlr Atacado.: '+formatfloat('##,###,###0.00',dmbanco.qryProdutosPRECO_ATACADO.AsCurrency);
         Data['Text8'] := 'Vlr Compra .: '+formatfloat('##,###,###0.00',dmbanco.qryProdutosPRECO_COMPRA.AsCurrency);
      end;
     dmBanco.qryProdutos.Next;
   end;
   frmTabs.ListViewProduto.EndUpdate;
   frmTabs.TabControlPrin.TabIndex := 4;
   frmTabs.Show;
end;

procedure TfrmMain.Image2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  image2.Opacity := 0.5;
end;

procedure TfrmMain.Image2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  image2.Opacity := 1;
end;

procedure TfrmMain.Image3Click(Sender: TObject);
begin
  Application.CreateForm(TfrmConf,frmConf);
  frmConf.Show;
end;

procedure TfrmMain.Image3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  Image3.Opacity := 0.5;
end;

procedure TfrmMain.Image3MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
 Image3.Opacity := 1;
end;

procedure TfrmMain.Image4Click(Sender: TObject);
begin
  Application.CreateForm(TfrmTabs,frmTabs);
  frmTabs.TabControlPrin.TabIndex := 6;
  frmTabs.p_CarregarRecibo;
  frmTabs.Show;
end;

procedure TfrmMain.Image4MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  image4.Opacity := 0.5;
end;

procedure TfrmMain.Image4MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  image4.Opacity := 1;
end;

procedure TfrmMain.Image5Click(Sender: TObject);
begin
  dmBanco.ped := 'P';
  dmBanco.qrypedidos.Close;
  dmBanco.qrypedidos.SQL.Clear;
  dmBanco.qrypedidos.SQL.Add('select * from TB_PEDIDO order by DATA_PEDIDO desc');
  dmBanco.qrypedidos.Open;

  Application.CreateForm(TfrmTabs,frmTabs);
  frmTabs.TabControlPrin.TabIndex := 2;
  frmTabs.ListViewPedido.BeginUpdate;
  dmBanco.qrypedidos.First;
  frmTabs.ListViewPedido.Items.Clear;
  while not dmBanco.qrypedidos.Eof do
  begin
    with frmTabs.ListViewPedido.Items.Add do
    begin
      Data['Text1'] := dmbanco.qrypedidosCODIGO.AsString;
      Data['Text2'] := dmbanco.qrypedidosDATA_PEDIDO.AsString;
      Data['Text3'] := Formatfloat('##,###,###0.00',dmbanco.qrypedidosTOTAL_PEDIDO.Value);
      Data['Text4'] := 'Enviado .: '+dmbanco.qrypedidosDATA_SINC.AsString;
    end;
    dmBanco.qrypedidos.Next;
  end;
  frmTabs.ListViewPedido.EndUpdate;
  frmTabs.image5.Visible := false;
  frmTabs.image11.Visible:= false;
  frmTabs.Show;
end;

procedure TfrmMain.Image5MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  image5.Opacity := 0.5;
end;

procedure TfrmMain.Image5MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  image5.Opacity := 1;
end;

procedure TfrmMain.Image6Click(Sender: TObject);
begin
  Application.CreateForm(TfrmTabs,frmTabs);
  frmTabs.TabControlPrin.TabIndex := 0;
  frmTabs.Show;
end;

procedure TfrmMain.Image6MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  Image6.Opacity := 0.5;
end;

procedure TfrmMain.Image6MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  Image6.Opacity := 1;
end;

procedure TfrmMain.Image8Click(Sender: TObject);
begin
  MessageDlg('Você deseja realmente sair do aplicativo ?', System.UITypes.TMsgDlgType.mtInformation,
  [System.UITypes.TMsgDlgBtn.mbYes, System.UITypes.TMsgDlgBtn.mbNo], 0,
  procedure(const AResult: System.UITypes.TModalResult)
  begin
    case AResult of
      mrYES:
      begin
        dmBanco.qryConf.Edit;
        dmBanco.qryConfUSUARIO.Value := '';
        dmBanco.qryConf.Post;

       frmAcesso.ComboBox1.Items.Clear;
        dmBanco.qryUsuario.First;
        while not dmBanco.qryUsuario.Eof do
         begin
           frmAcesso.ComboBox1.Items.Add(dmBanco.qryUsuarioLOGIN.Value);
           dmBanco.qryUsuario.Next;
         end;

        Close;
      end;
      mrNo:
    end;
  end);
end;

procedure TfrmMain.Image8MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  Image8.Opacity := 0.5;
end;

procedure TfrmMain.Image8MouseLeave(Sender: TObject);
begin
  Image8.Opacity := 1;
end;

end.
