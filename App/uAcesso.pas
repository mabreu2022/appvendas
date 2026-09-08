unit uAcesso;
interface
uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Objects, FMX.Edit, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Effects,
  FMX.VirtualKeyboard, FMX.Platform, Rest.Types,
  FMX.ListBox, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope, untAtualizarBD;
type
  TfrmAcesso = class(TForm)
    layRodape: TLayout;
    Rectangle2: TRectangle;
    Layout1: TLayout;
    Image2: TImage;
    ShadowEffect4: TShadowEffect;
    Label2: TLabel;
    ShadowEffect10: TShadowEffect;
    Layout3: TLayout;
    Rectangle1: TRectangle;
    ShadowEffect1: TShadowEffect;
    Layout4: TLayout;
    Rectangle3: TRectangle;
    ShadowEffect2: TShadowEffect;
    Layout5: TLayout;
    Rectangle5: TRectangle;
    Image1: TImage;
    Label1: TLabel;
    Layout2: TLayout;
    Image3: TImage;
    ShadowEffect5: TShadowEffect;
    ShadowEffect6: TShadowEffect;
    ShadowEffect7: TShadowEffect;
    ComboBox1: TComboBox;
    Layout6: TLayout;
    Rectangle4: TRectangle;
    ShadowEffect3: TShadowEffect;
    Edit1: TEdit;
    StyleBook1: TStyleBook;
    LabelVersao: TLabel;
    Layout7: TLayout;
    Rectangle6: TRectangle;
    cbEmpresa: TComboBox;
    ShadowEffect8: TShadowEffect;
    Text1: TText;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Label1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure Label1MouseLeave(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Image3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure Image3MouseLeave(Sender: TObject);
    procedure Image3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
var
  frmAcesso: TfrmAcesso;
implementation
{$R *.fmx}
{$R *.LgXhdpiPh.fmx ANDROID}
{$R *.iPhone55in.fmx IOS}
{$R *.XLgXhdpiTb.fmx ANDROID}
uses
  uBanco, uMain, uFuncoes, uConf, uMessage,
  Androidapi.JNI.Toast, uSIncronizar, uVersao, uSerial, uBootLog;

procedure TfrmAcesso.FormCreate(Sender: TObject);
begin
  BootLog('TfrmAcesso.FormCreate inicio');
  dmBanco.AjustarCor();
  LabelVersao.Text := 'Versão ' + TClsVersao.Get();
  BootLog('TfrmAcesso.FormCreate fim');
end;
procedure TfrmAcesso.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  frmAcesso.Free;
//  frmAcesso := nil;
end;
procedure TfrmAcesso.FormKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
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
      Close;
    end;
  end;
end;
procedure TfrmAcesso.FormShow(Sender: TObject);
begin
  BootLog('TfrmAcesso.FormShow inicio');
  try
    dmBanco.qryConf.Close;
    dmBanco.qryConf.Open;
    BootLog('TfrmAcesso.FormShow qryConf opened');
    dmBanco.servidor := dmBanco.qryConfSERVIDOR.Value;
    dmBanco.porta := dmBanco.qryConfPORTA.Value;
    dmBanco.codusuario := dmBanco.qryConfUSUARIO.AsString;
    dmBanco.impressora := dmBanco.qryConfIMPRESSORA.AsString;
    BootLog('TfrmAcesso.FormShow conf fields read');
    dmBanco.serial := TClsSerial.GetSerial();
    BootLog('TfrmAcesso.FormShow serial obtained');
    dmBanco.qryUsuario.Close;
    dmBanco.qryUsuario.Open;
    BootLog('TfrmAcesso.FormShow qryUsuario opened count=' + IntToStr(dmBanco.qryUsuario.RecordCount));
    if not dmBanco.qryUsuario.IsEmpty then
    begin
      ComboBox1.Items.Clear;
      dmBanco.qryUsuario.First;
      while not dmBanco.qryUsuario.Eof do
      begin
        ComboBox1.Items.Add(dmBanco.qryUsuarioLOGIN.Value);
        dmBanco.qryUsuario.Next;
      end;
      if dmBanco.codusuario <> '' then
      begin
        if dmBanco.qryUsuario.locate('CODIGO', dmBanco.codusuario, []) then
        begin
          ComboBox1.ItemIndex := ComboBox1.Items.IndexOf
            (dmBanco.qryUsuarioLOGIN.Value);
          Edit1.Text := dmBanco.qryUsuarioSENHA.Value;
//        frmAcesso.Label1.OnClick(self);
        end;
      end;
    end;
    BootLog('TfrmAcesso.FormShow fim');
  except
    on E: Exception do
      BootLog('Erro em TfrmAcesso.FormShow: ' + E.ClassName + ': ' + E.Message);
  end;
end;
procedure TfrmAcesso.Image3Click(Sender: TObject);
begin
  Application.CreateForm(TfrmConf, frmConf);
  frmConf.Show;
end;
procedure TfrmAcesso.Image3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  Image3.Opacity := 0.5;
end;
procedure TfrmAcesso.Image3MouseLeave(Sender: TObject);
begin
  Image3.Opacity := 1;
end;
procedure TfrmAcesso.Label1Click(Sender: TObject);
var
  vRet : TRecSincronizar;
begin
  { if (date >= StrToDate('10/03/2020')) then
    begin
    showmessage('EXPIRADO');
    exit;
    end; }
  if cbEmpresa.ItemIndex = -1 then
  begin
    ShowMessage('Selecione uma empresa');
    Abort;
  end;

  if dmBanco.qryUsuario.IsEmpty then
  begin
    vRet := TClsSincronizar.GetUsuarios;
    if vRet.Erro then
    begin
      TClsMessage.MensagemHint(vRet.Mensagem);
      exit;
    end;
    ComboBox1.Items.Clear;
    dmBanco.qryUsuario.First;
    while not dmBanco.qryUsuario.Eof do
    begin
      ComboBox1.Items.Add(dmBanco.qryUsuarioLOGIN.Value);
      dmBanco.qryUsuario.Next;
    end;
    exit;
  end;
  if ComboBox1.ItemIndex < 0 then
    exit;
  if dmBanco.qryUsuario.locate('LOGIN', UpperCase(ComboBox1.Selected.Text), []) then
  begin
    if dmBanco.qryUsuarioSENHA.AsString = trim(Edit1.Text) then
    begin
      Application.CreateForm(TfrmMain, frmMain);
      frmMain.Label8.Text := 'Usuário .: ' + dmBanco.qryUsuarioLOGIN.Value;
      dmBanco.codusuario := dmBanco.qryUsuarioCODIGO.AsString;
      dmBanco.nomeusuario := dmBanco.qryUsuarioLOGIN.Value;
      dmBanco.qryConf.Edit;
      dmBanco.qryConfUSUARIO.Value := dmBanco.codusuario;
      dmBanco.qryConf.Post;
      frmMain.Show;
      TAtualizaBD.GravarINI('Usuario', 'CodEmp', dmBanco.qryEmpresaCODEMP.AsString);
    end
    else
      TClsMessage.MensagemHint('Senha inválida !!!');
  end
  else
    TClsMessage.MensagemHint('Usuário inválido !!!');
end;
procedure TfrmAcesso.Label1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  Rectangle5.Opacity := 0.5;
end;
procedure TfrmAcesso.Label1MouseLeave(Sender: TObject);
begin
  Rectangle5.Opacity := 1;
end;
end.
