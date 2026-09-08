unit uConf;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  System.Math,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Layouts,
  FMX.Objects,
  FMX.Edit,
  FMX.Controls.Presentation,
  FMX.StdCtrls,
  FMX.Effects,
  FMX.VirtualKeyboard,
  FMX.Platform,
  Rest.Types,
  FMX.ListBox,
  untAtualizarBD;

type
  TfrmConf = class(TForm)
    Layout3: TLayout;
    Rectangle1: TRectangle;
    ShadowEffect1: TShadowEffect;
    Layout4: TLayout;
    Rectangle3: TRectangle;
    Edit1: TEdit;
    ShadowEffect2: TShadowEffect;
    Layout5: TLayout;
    Rectangle5: TRectangle;
    Image1: TImage;
    Label1: TLabel;
    Layout6: TLayout;
    Rectangle4: TRectangle;
    Edit2: TEdit;
    ShadowEffect3: TShadowEffect;
    Layout1: TLayout;
    Label2: TLabel;
    Image3: TImage;
    Rectangle2: TRectangle;
    ShadowEffect7: TShadowEffect;
    Layout2: TLayout;
    Rectangle6: TRectangle;
    ShadowEffect4: TShadowEffect;
    ComboBox1: TComboBox;
    Layout7: TLayout;
    Layout8: TLayout;
    Rectangle7: TRectangle;
    ShadowEffect5: TShadowEffect;
    Edit4: TEdit;
    Layout9: TLayout;
    Layout10: TLayout;
    Rectangle8: TRectangle;
    Edit3: TEdit;
    ShadowEffect6: TShadowEffect;
    Layout11: TLayout;
    Rectangle9: TRectangle;
    Label3: TLabel;
    ShadowEffect8: TShadowEffect;
    Image2: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure Image3MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure Image3MouseLeave(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
  private
    { Private declarations }
    procedure CarregarImpressora;
  public
    { Public declarations }
  end;

var
  frmConf: TfrmConf;

implementation
{$R *.fmx}

uses
  uBanco,
  uPrinterBluetooth,
  uString,
  uSerial;

procedure TfrmConf.CarregarImpressora;
var
  vLista: TStringList;
  I: Integer;
begin
  try
    vLista := TClsPrinterBluetooth.ListarDispositivosPareados;
    try
      with ComboBox1.Items do
      begin
        Clear;
        Add(uPrinterBluetooth.cSelecionarImpressora);
        if Assigned(vLista) then
        begin
          for I := 0 to vLista.Count - 1 do
            Add(vLista[I]);
        end;
      end;
    finally
      vLista.Free;
    end;
  except
  end;
end;

procedure TfrmConf.FormCreate(Sender: TObject);
begin
//  CarregarImpressora;
end;

procedure TfrmConf.FormShow(Sender: TObject);
begin
  Edit1.Text := dmBanco.qryConfSERVIDOR.Value;
  Edit2.Text := dmBanco.qryConfPORTA.Value;
  Edit3.Text := dmBanco.serial;
  Edit4.Text := dmBanco.qryConfRECIBO.AsString;

  with ComboBox1, ComboBox1.Items do
  begin
    if (dmBanco.qryConfIMPRESSORA.AsString <> '') and (IndexOf(dmBanco.qryConfIMPRESSORA.AsString) >= 0) then
      ItemIndex := IndexOf(dmBanco.qryConfIMPRESSORA.AsString)
    else if Count > 0 then
      ItemIndex := 0
    else
      ItemIndex := -1;
  end;
end;

procedure TfrmConf.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
var
  FService: IFMXVirtualKeyboardService;
begin
  if Key = vkHardwareBack then
  begin
    TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService, IInterface(FService));
    if (FService <> nil) and (TVirtualKeyboardState.Visible in FService.VirtualKeyBoardState) then
    begin
      // Back button pressed, keyboard visible, so do nothing...
    end
    else
    begin
      Key := 0;
    end;
  end
end;

procedure TfrmConf.Image3Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmConf.Image3MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  Image3.Opacity := 0.5;
end;

procedure TfrmConf.Image3MouseLeave(Sender: TObject);
begin
  Image3.Opacity := 1;
end;

procedure TfrmConf.Label1Click(Sender: TObject);
begin
  dmBanco.qryConf.Edit;
  dmBanco.qryConfSERVIDOR.Value   := Edit1.Text;
  dmBanco.qryConfPORTA.Value      := Edit2.Text;
 // dmBanco.qryConfIMPRESSORA.Value := ComboBox1.Selected.Text;
  dmBanco.qryConfRECIBO.Value     := StrToIntDef(Edit4.Text, 0);
  dmBanco.qryConf.Post;

  dmBanco.servidor    := dmBanco.qryConfSERVIDOR.Value;
  dmBanco.porta       := dmBanco.qryConfPORTA.Value;
  dmBanco.impressora  := dmBanco.qryConfPORTA.Value;

  Close;
end;

procedure TfrmConf.Label3Click(Sender: TObject);
begin
  TThread.CreateAnonymousThread(
    procedure
    begin
      dmBanco.SincronizarDados(dmBanco.FDMemTable1, '/GetEmpresa');
      if dmBanco.FDMemTable1.RecordCount > 0 then
        TAtualizaBD.GravarDados('ADM_EMPRESA', dmBanco.FDMemTable1);
      dmBanco.FDMemTable1.Close;

      TThread.Synchronize(nil,
        procedure
        begin
          ShowMessage('Finalizado');
        end);

    end).Start;

end;

end.

