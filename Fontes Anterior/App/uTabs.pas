unit uTabs;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, System.StrUtils, System.Math,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.TabControl, FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls,
  FMX.Effects, FMX.Edit, FMX.VirtualKeyboard, FMX.Platform, Rest.Types,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, System.Actions, FMX.ActnList, System.Rtti,
  System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.EngExt,
  FMX.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope, FMX.EditBox,
  FMX.NumberBox, FMX.ListBox, FMX.Gestures, FireDAC.Comp.Client,
  System.Bluetooth, System.Bluetooth.Components;

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
    NumberBox1: TNumberBox;
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
    NumberBox2: TNumberBox;
    Label12: TLabel;
    Label13: TLabel;
    procedure ImageCloseClick(Sender: TObject);
    procedure ImageMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure ImageMouseLeave(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Image3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure Image3MouseLeave(Sender: TObject);
    procedure Label1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure Label1MouseLeave(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Image2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure Image2MouseLeave(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image4MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure Image4MouseLeave(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure ListViewClienteItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure Image5MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure Image5MouseLeave(Sender: TObject);
    procedure Image6MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure Image6MouseLeave(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure Image7MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure Image7MouseLeave(Sender: TObject);
    procedure Image7Click(Sender: TObject);
    procedure Image5Click(Sender: TObject);
    procedure Image9MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure Image9MouseLeave(Sender: TObject);
    procedure Image10MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure Image10MouseLeave(Sender: TObject);
    procedure Image10Click(Sender: TObject);
    procedure ListViewProdutoItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure Image8MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure Image8MouseLeave(Sender: TObject);
    procedure Image8Click(Sender: TObject);
    procedure ButtonAdicionarClick(Sender: TObject);
    procedure NumberBox1MouseLeave(Sender: TObject);
    procedure Image9Click(Sender: TObject);
    procedure ListViewPedidoItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure ListViewPedidoGesture(Sender: TObject;
      const EventInfo: TGestureEventInfo; var Handled: Boolean);
    procedure Image12Click(Sender: TObject);
    procedure Image11Click(Sender: TObject);
    procedure Image12MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure Image12MouseLeave(Sender: TObject);
    procedure Image11MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure Image11MouseLeave(Sender: TObject);
    procedure Image14Click(Sender: TObject);
    procedure ListViewReceberItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure ListViewReceberItem(AItem: TListViewItem);
    procedure ImageBuscarReceberClick(Sender: TObject);
    procedure EditValorReceberKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
  private
    { Private declarations }
    FDsMessage: String;
    procedure TotalizarRecebimento;
    procedure p_EfetuarRecebimento;
    procedure EfetuarRecebimento;
    procedure p_ImprimirRecebimento;
    procedure ImprimirRecebimento;
  public
    { Public declarations }
    FCdPagto: String;
  end;

var
  frmTabs: TfrmTabs;

implementation

{$R *.fmx}

uses
  uBanco, uFuncoes, uPrinter, uMessage,
  Androidapi.JNI.PowerManager,
  Androidapi.JNI.Toast, uConverter, uReceberRecCmd, uSincronizar,
  uPrinterBluetooth;

const
  cAberto = 'Aberto';
  cReceber = 'Receber';

procedure TfrmTabs.ButtonAdicionarClick(Sender: TObject);
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
  if NumberBox1.Value <= 0 then
  begin
    TClsMessage.MensagemHint('Informe a quantidade');
    Exit;
  end;
  if NumberBox2.Value <= 0 then
  begin
    TClsMessage.MensagemHint('Informe o valor');
    Exit;
  end;

  dmBanco.memitens.Append;
  dmBanco.memitensCOD_PRODUTO.Value := dmBanco.qryProdutosCODIGO.Value;
  dmBanco.memitensDESCRICAO.Value := dmBanco.qryProdutosDESCRICAO.Value;
  dmBanco.memitensQTD.Value := NumberBox1.Value;
  dmBanco.memitensVLR_UNITARIO.Value := NumberBox2.Value;
  dmBanco.memitensVLR_TOTAL.Value := dmBanco.memitensQTD.Value * dmBanco.memitensVLR_UNITARIO.Value;
  dmBanco.memitens.Post;

  with ListViewItemPedido.Items.Add do
  begin
    Data['Text1'] := dmBanco.qryProdutosCODIGO.AsString + ' - ' + dmBanco.qryProdutosDESCRICAO.AsString;
    Data['Text2'] := dmBanco.memitensQTD.AsString + ' X $ ' + formatfloat('##,###,###0.00', dmBanco.memitensVLR_UNITARIO.Value);
    Data['Text3'] := '$ ' + formatfloat('##,###,###0.00', dmBanco.memitensVLR_TOTAL.Value);
  end;

  actAddPedido.ExecuteTarget(self);
end;

procedure TfrmTabs.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmTabs.Free;
  frmTabs := nil;
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

    TclsSincronizar.RemReceberPend;

    TClsMessage.MensagemHint('Sincronismo finalizado !!!');
  except
    on E : Exception do begin
      TClsMessage.MensagemHint('Erro. Tente novamente !!!' + e.Message);
    end;
  end;

  Label1.Text := 'SINCRONIZAR';
  Application.ProcessMessages;

end;

procedure TfrmTabs.Image10Click(Sender: TObject);
begin
  MessageDlg('Deseja realmente cancelar pedido ?',
    System.UITypes.TMsgDlgType.mtInformation, [System.UITypes.TMsgDlgBtn.mbYes,
    System.UITypes.TMsgDlgBtn.mbNo], 0,
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

procedure TfrmTabs.Image10MouseDown(Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Single);
begin
  Image10.Opacity := 0.5;
end;

procedure TfrmTabs.Image10MouseLeave(Sender: TObject);
begin
  Image10.Opacity := 1;
end;

procedure TfrmTabs.Image11Click(Sender: TObject);
var
  vSincronizar : TRecSincronizar;
  txt: TListItemText;
begin
  if (ListViewPedido.Items.Count = 0) then
    exit;

  if (ListViewPedido.ItemIndex = -1)
  or (ListViewPedido.Selected = nil) then
  begin
    TClsMessage.MensagemHint('Selecione um pedido na lista');
    exit;
  end;

  txt := TListItemText(ListViewPedido.Items[ListViewPedido.ItemIndex].Objects.FindDrawable('Text1'));
  dmBanco.qrypedidos.Locate('CODIGO', txt.Text, []);

  if dmBanco.qrypedidosDATA_SINC.IsNull then
  begin
    MessageDlg('Deseja realmente enviar pedido ?',
    System.UITypes.TMsgDlgType.mtInformation,
    [System.UITypes.TMsgDlgBtn.mbYes, System.UITypes.TMsgDlgBtn.mbNo], 0,
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

procedure TfrmTabs.Image11MouseDown(Sender: TObject;
Button: TMouseButton; Shift: TShiftState; X, Y: Single);
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
  txt := TListItemText(ListViewPedido.Items[ListViewPedido.ItemIndex]
    .Objects.FindDrawable('Text1'));
  dmBanco.qrypedidos.Locate('CODIGO', txt.Text, []);

  if dmBanco.qrypedidosDATA_SINC.IsNull then
  begin
    MessageDlg('Deseja realmente excluir pedido ?',
      System.UITypes.TMsgDlgType.mtInformation,
      [System.UITypes.TMsgDlgBtn.mbYes, System.UITypes.TMsgDlgBtn.mbNo], 0,
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

procedure TfrmTabs.Image12MouseDown(Sender: TObject;
Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  Image12.Opacity := 0.5;
end;

procedure TfrmTabs.Image12MouseLeave(Sender: TObject);
begin
  Image12.Opacity := 1;
end;

procedure TfrmTabs.Image14Click(Sender: TObject);
begin
  try
    p_EfetuarRecebimento;
  except
    on E : Exception do begin
      ShowMessage('Erro: ' + e.Message);
    end;
  end;
end;

procedure TfrmTabs.Image2Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmTabs.Image2MouseDown(Sender: TObject;
Button: TMouseButton; Shift: TShiftState; X, Y: Single);
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

procedure TfrmTabs.Image3MouseDown(Sender: TObject;
Button: TMouseButton; Shift: TShiftState; X, Y: Single);
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

procedure TfrmTabs.Image4MouseDown(Sender: TObject;
Button: TMouseButton; Shift: TShiftState; X, Y: Single);
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

procedure TfrmTabs.Image5MouseDown(Sender: TObject;
Button: TMouseButton; Shift: TShiftState; X, Y: Single);
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

procedure TfrmTabs.Image6MouseDown(Sender: TObject;
Button: TMouseButton; Shift: TShiftState; X, Y: Single);
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
  dmBanco.qryProdutos.sql.Add('select * from TB_PRODUTO where descricao like ' +
    QuotedStr('%' + EditDescrProdutos.Text + '%') + ' order by Descricao');
  dmBanco.qryProdutos.Open;

  ListViewProduto.BeginUpdate;
  dmBanco.qryProdutos.First;
  ListViewProduto.Items.Clear;
  While not dmBanco.qryProdutos.Eof do
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

procedure TfrmTabs.Image7MouseDown(Sender: TObject;
Button: TMouseButton; Shift: TShiftState; X, Y: Single);
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
      Sql.Add('where descricao like ''%' + ReplaceText(EditDescrProduto.Text,' ','%') + '%''');
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

procedure TfrmTabs.Image8MouseDown(Sender: TObject;
Button: TMouseButton; Shift: TShiftState; X, Y: Single);
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
  dmBanco.qryAux.sql.Add('insert into TB_PEDIDO (CODIGO,DATA_PEDIDO,VENDEDOR,TIPO,TOTAL_PEDIDO,OBS,CLIENTE,COD_PAGTO) ');
  dmBanco.qryAux.sql.Add('VALUES (:CODIGO,:DATA_PEDIDO,:VENDEDOR,:TIPO,:TOTAL_PEDIDO,:OBS,:CLIENTE,:COD_PAGTO)');
  dmBanco.qryAux.ParamByName('CODIGO').Value := cod;
  dmBanco.qryAux.ParamByName('DATA_PEDIDO').AsDateTime := now;
  dmBanco.qryAux.ParamByName('VENDEDOR').Value := StrToInt(copy(ComboBoxVendedor.Selected.Text, 1, Pos('-', ComboBoxVendedor.Selected.Text) - 1));
  dmBanco.qryAux.ParamByName('TIPO').Value := 'P';
  dmBanco.qryAux.ParamByName('TOTAL_PEDIDO').Value := total;
  dmBanco.qryAux.ParamByName('OBS').Value := '';
  dmBanco.qryAux.ParamByName('CLIENTE').Value := dmBanco.qryClientesCODIGO.AsString;
  dmBanco.qryAux.ParamByName('COD_PAGTO').Value := StrToInt(copy(ComboBoxPagto.Selected.Text, 1, Pos('-', ComboBoxPagto.Selected.Text) - 1));
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

procedure TfrmTabs.Image9MouseDown(Sender: TObject;
Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  Image9.Opacity := 0.5;
end;

procedure TfrmTabs.Image9MouseLeave(Sender: TObject);
begin
  Image9.Opacity := 1;
end;

procedure TfrmTabs.Label1MouseDown(Sender: TObject;
Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  Rectangle5.Opacity := 0.5;
end;

procedure TfrmTabs.Label1MouseLeave(Sender: TObject);
begin
  Rectangle5.Opacity := 1;
end;

procedure TfrmTabs.ListViewClienteItemClick(const Sender: TObject;
const AItem: TListViewItem);
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

procedure TfrmTabs.ListViewPedidoGesture(Sender: TObject;
const EventInfo: TGestureEventInfo; var Handled: Boolean);
var
  txt: TListItemText;
begin
  {if EventInfo.GestureID = sgiLeft  then
  begin
    txt := TListItemText(ListViewPedido.Items[ListViewPedido.ItemIndex].Objects.FindDrawable('Text1'));
    dmBanco.qrypedidos.Locate('CODIGO',txt.Text,[]);

    MessageDlg('Deseja realmente excluir pedido ?', System.UITypes.TMsgDlgType.mtInformation,
    [System.UITypes.TMsgDlgBtn.mbYes,System.UITypes.TMsgDlgBtn.mbNo], 0,
    procedure(const AResult: System.UITypes.TModalResult)
    begin
      case AResult of
        mrYES:
        begin
          dmBanco.qryAux.Close;
          dmBanco.qryAux.SQL.Clear;
          dmBanco.qryAux.SQL.Add('delete from TB_PEDIDO where CODIGO = :codigo');
          dmBanco.qryAux.ParamByName('codigo').Value := dmBanco.qrypedidosCODIGO.Value;
          dmBanco.qryAux.ExecSQL;

          DMBANCO.qrypedidos.Refresh;

          ListViewPedido.BeginUpdate;
          dmBanco.qrypedidos.First;
          ListViewPedido.Items.Clear;
          while not dmBanco.qrypedidos.Eof do
          begin
            with ListViewPedido.Items.Add do
            begin
              Data['Text1'] := dmbanco.qrypedidosCODIGO.AsString;
              Data['Text2'] := dmbanco.qrypedidosDATA_PEDIDO.AsString;
              Data['Text3'] := 'R$ '+Formatfloat('##,###,###0.00',dmbanco.qrypedidosTOTAL_PEDIDO.Value);
              Data['Text4'] := 'Enviado .: '+dmbanco.qrypedidosDATA_SINC.AsString;
            end;
            dmBanco.qrypedidos.Next;
          end;
          ListViewPedido.EndUpdate;
        end;
        mrNo:

      end;
    end);
  end;}

  {if EventInfo.GestureID = sgiRight then
  begin
    txt := TListItemText(ListViewPedido.Items[ListViewPedido.ItemIndex].Objects.FindDrawable('Text1'));
    dmBanco.qrypedidos.Locate('CODIGO',txt.Text,[]);
    if dmBanco.qrypedidosDATA_SINC.IsNull then
    begin
      MessageDlg('Deseja realmente enviar pedido ?', System.UITypes.TMsgDlgType.mtInformation,
      [System.UITypes.TMsgDlgBtn.mbYes,
      System.UITypes.TMsgDlgBtn.mbNo
      ], 0,
      procedure(const AResult: System.UITypes.TModalResult)
      begin
        case AResult of
          mrYES:
          begin
            if SetPedido(dmBanco.qrypedidosCODIGO.Value) > 0 then
            begin
              dmBanco.qryAux.Close;
              dmBanco.qryAux.SQL.Clear;
              dmBanco.qryAux.SQL.Add('update TB_PEDIDO set DATA_SINC = :data where CODIGO = :codigo');
              dmBanco.qryAux.ParamByName('codigo').Value := dmBanco.qrypedidosCODIGO.Value;
              dmBanco.qryAux.ParamByName('data').AsDateTime := now;
              dmBanco.qryAux.ExecSQL;

              DMBANCO.qrypedidos.Refresh;

              ListViewPedido.BeginUpdate;
              dmBanco.qrypedidos.First;
              ListViewPedido.Items.Clear;
              while not dmBanco.qrypedidos.Eof do
              begin
                with ListViewPedido.Items.Add do
                begin
                  Data['Text1'] := dmbanco.qrypedidosCODIGO.AsString;
                  Data['Text2'] := dmbanco.qrypedidosDATA_PEDIDO.AsString;
                  Data['Text3'] := 'R$ '+Formatfloat('##,###,###0.00',dmbanco.qrypedidosTOTAL_PEDIDO.Value);
                  Data['Text4'] := 'Enviado .: '+dmbanco.qrypedidosDATA_SINC.AsString;
                end;
                dmBanco.qrypedidos.Next;
              end;
              ListViewPedido.EndUpdate;

              TClsMessage.MensagemHint('Pedido enviado com sucesso !!!');
            end
            else
              showmessage('Erro ao enviar pedido !!!');
          end;
          mrNo:

        end;
      end);
    end
    else
    begin
      showmessage('Pedido já enviado !!!');
    end;
  end;}
end;

procedure TfrmTabs.ListViewPedidoItemClick(const Sender: TObject;
const AItem: TListViewItem);
begin
  {dmBanco.qrypedidos.Locate('CODIGO',AItem.Data['Text1'].AsString,[]);
  if dmBanco.qrypedidosDATA_SINC.IsNull then
  begin
    MessageDlg('Deseja realmente enviar pedido ?', System.UITypes.TMsgDlgType.mtInformation,
    [System.UITypes.TMsgDlgBtn.mbYes, System.UITypes.TMsgDlgBtn.mbNo], 0,
    procedure(const AResult: System.UITypes.TModalResult)
    begin
      case AResult of
        mrYES:
        begin
          if SetPedido(dmBanco.qrypedidosCODIGO.Value) > 0 then
          begin
            dmBanco.qryAux.Close;
            dmBanco.qryAux.SQL.Clear;
            dmBanco.qryAux.SQL.Add('update TB_PEDIDO set DATA_SINC = :data where CODIGO = :codigo');
            dmBanco.qryAux.ParamByName('codigo').Value := dmBanco.qrypedidosCODIGO.Value;
            dmBanco.qryAux.ParamByName('data').AsDateTime := now;
            dmBanco.qryAux.ExecSQL;

            DMBANCO.qrypedidos.Refresh;

            ListViewPedido.BeginUpdate;
            dmBanco.qrypedidos.First;
            ListViewPedido.Items.Clear;
            while not dmBanco.qrypedidos.Eof do
            begin
              with ListViewPedido.Items.Add do
              begin
                Data['Text1'] := dmbanco.qrypedidosCODIGO.AsString;
                Data['Text2'] := dmbanco.qrypedidosDATA_PEDIDO.AsString;
                Data['Text3'] := 'R$ '+Formatfloat('##,###,###0.00',dmbanco.qrypedidosTOTAL_PEDIDO.Value);
                Data['Text4'] := 'Enviado .: '+dmbanco.qrypedidosDATA_SINC.AsString;
              end;
              dmBanco.qrypedidos.Next;
            end;
            ListViewPedido.EndUpdate;

            TClsMessage.MensagemHint('Pedido enviado com sucesso !!!');
          end
          else
            showmessage('Erro ao enviar pedido !!!');
        end;
      mrNo:

      end;
    end);
  end;}
end;

procedure TfrmTabs.ListViewProdutoItemClick(const Sender: TObject;
const AItem: TListViewItem);
begin
  if dmBanco.prod_status = 'I' then
  begin
    dmBanco.qryProdutos.Locate('CODIGO', AItem.Data['Text5'].AsString, []);
    Label8.Text := dmBanco.qryProdutosDESCRICAO.Value;
    NumberBox1.Value := 1;
    NumberBox2.Value := dmBanco.qryProdutosPRECO_VENDA.Value;
    actAdditem.ExecuteTarget(self);
  end;
end;

procedure TfrmTabs.ImageBuscarReceberClick(Sender: TObject);
var
  vCodCliente : Integer;
  vNomCliente : String;
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
      Data['Text1'] := dmbanco.qryReceberCOD_EMP.AsString + '#' + dmbanco.qryReceberCOD_CLIENTE.AsString + '#' +
        dmbanco.qryReceberNUM_FAT.AsString + '#' + dmbanco.qryReceberNUM_PARC.AsString;
      Data['Text2'] := dmbanco.qryReceberDATA_EMISSAO.AsString + ' - ' + dmbanco.qryReceberNOM_CLIENTE.AsString;
      Data['Text3'] := Formatfloat('##,###,###0.00',dmbanco.qryReceberVLR_FATURA.Value);
      Data['Text4'] := 'Vencto .: ' + dmbanco.qryReceberDATA_VENCTO.AsString;
      Data['Text5'] := 'Aberto';
    end;
    dmBanco.qryReceber.Next;
  end;

  ListViewReceber.EndUpdate;
  Show;

end;

procedure TfrmTabs.ListViewReceberItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  ListViewReceberItem(AItem);
end;

procedure TfrmTabs.ListViewReceberItem(AItem: TListViewItem);
var
  vVlrTotalReceber, vVlrValorReceber : Real;
  vData: String;
begin
  if (AItem = nil) then
    Exit;

  vVlrValorReceber := TClsConverter.StrToFloat(EditValorReceber.Text);
  vVlrTotalReceber := TClsConverter.StrToFloat(LabelValorReceber.Text);

  vData := AItem.Data['Text5'].AsString;

  if (vData = cAberto) then
    if (vVlrValorReceber > 0) and (vVlrTotalReceber > vVlrValorReceber) then
    begin
      TClsMessage.MensagemHint('Titulo(s) excede ao valor informado!!!');
      Exit;
    end;

  vData := IfThen(vData = cAberto, cReceber, cAberto);
  AItem.Data['Text5'] := vData;
  TotalizarRecebimento;
end;

procedure TfrmTabs.TotalizarRecebimento;
var
  vVlrReceber, vVlrParcela : Real;
  vItem: TListViewItem;
  vData: String;
  I : Integer;
begin
  vVlrReceber := 0;

  for I := 0 to ListViewReceber.Items.Count-1 do
  begin
    vItem := TListViewItem(ListViewReceber.Items[I]);
    vData := vItem.Data['Text5'].AsString;
    if (vData = cReceber) then
    begin
      vData := vItem.Data['Text3'].AsString;
      vVlrParcela := TClsConverter.StrToFloatFmt(vData);
      vVlrReceber := vVlrReceber + vVlrParcela;
    end;
  end;

  LabelValorReceber.Text := FormatFloat('##,###,###0.00', vVlrReceber);
end;

procedure TfrmTabs.p_EfetuarRecebimento;
begin
  MessageDlg('Efetuar recibiemento ?',
    System.UITypes.TMsgDlgType.mtInformation, [System.UITypes.TMsgDlgBtn.mbYes,
    System.UITypes.TMsgDlgBtn.mbNo], 0,
    procedure(const AResult: System.UITypes.TModalResult)
    begin
      case AResult of
        mrYES:
        begin
          EfetuarRecebimento;
        end;
        mrNo:
      end;
    end);
end;

procedure TfrmTabs.EditValorReceberKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if not CharInSet(KeyChar,['.', '0'..'9']) then
  begin
    KeyChar := #0;
  end;
  if (KeyChar='.') and (TEdit(Sender).Text.IndexOf('.') < -1) then
  begin
    KeyChar := #0;
  end;
end;

procedure TfrmTabs.EfetuarRecebimento;
var
  vCodEmp, vCodCliente, vNumFat, vNumParc, I : Integer;
  vDataList : TStringList;
  vItem: TListViewItem;
  vData : String;
begin
  vDataList := TStringList.Create;
  vDataList.Delimiter := '#';

  FCdPagto := '';

  for I := 0 to ListViewReceber.Items.Count-1 do
  begin
    vItem := TListViewItem(ListViewReceber.Items[I]);
    vData := vItem.Data['Text5'].AsString;
    if (vData = cReceber) then
    begin
      vData := vItem.Data['Text1'].AsString + sLineBreak;
      vDataList.DelimitedText := vData;

      vCodEmp := StrToIntDef(vDataList[0],0);
      vCodCliente := StrToIntDef(vDataList[1],0);
      vNumFat := StrToIntDef(vDataList[2],0);
      vNumParc := StrToIntDef(vDataList[3],0);

      if (vCodEmp > 0) and (vCodCliente > 0) and (vNumFat > 0) and (vNumParc > 0) then
      begin
        if (FCdPagto = '') then
        begin
          FCdPagto := TGUID.NewGuid.ToString;
        end;

        TClsSincronizar.IncReceber(FCdPagto, vCodEmp, vCodCliente, vNumFat, vNumParc);
      end;
    end;
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

procedure TfrmTabs.p_ImprimirRecebimento;
begin
  MessageDlg('Imprimir recibo ?',
    System.UITypes.TMsgDlgType.mtInformation, [System.UITypes.TMsgDlgBtn.mbYes,
    System.UITypes.TMsgDlgBtn.mbNo], 0,
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
var
  vConteudo, vData : String;
  vItem: TListViewItem;
  I : Integer;
begin
  vConteudo := '';

  for I := 0 to ListViewReceber.Items.Count-1 do
  begin
    vItem := TListViewItem(ListViewReceber.Items[I]);
    vData := vItem.Data['Text5'].AsString;
    if (vData = cReceber) then
    begin
      if (vConteudo = '') then
      begin
        vConteudo := vConteudo + 'Cliente: ' + EditClienteReceber.Text + sLineBreak;
        if (EditValorReceber.Text <> '') then
          vConteudo := vConteudo + 'Valor Informado: ' + EditValorReceber.Text + sLineBreak;
      end;

      vData :=
        'Titulo:' + vItem.Data['Text1'].AsString + sLineBreak +
        'Emissao:' + vItem.Data['Text2'].AsString + sLineBreak +
        'Valor:' + vItem.Data['Text3'].AsString + sLineBreak +
        'Vencto:' + vItem.Data['Text4'].AsString + sLineBreak;

      vConteudo := vConteudo + vData + sLineBreak;
    end;
  end;

  if (vConteudo = '') then
    exit;

  vConteudo := vConteudo + 'Valor Recebido: ' + LabelValorReceber.Text + sLineBreak;

  try
    //TClsPrinter.ImprimirConteudo(vConteudo);
    TClsPrinterBluetooth.ImprimirConteudo(vConteudo);
    TClsMessage.MensagemHint('Imprissão efetuada com sucesso');
  except
    on E : Exception do begin
      TClsMessage.MensagemHint('Erro ao efetuar impressão / ' + e.Message);
    end;
  end;

  Close;
end;

procedure TfrmTabs.NumberBox1MouseLeave(Sender: TObject);
begin
  TNumberBox(Sender).SelectAll;
end;

end.
