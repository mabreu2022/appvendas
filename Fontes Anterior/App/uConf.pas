unit uConf;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Objects, FMX.Edit, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Effects,
  FMX.VirtualKeyboard, FMX.Platform, Rest.Types;

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
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Image3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure Image3MouseLeave(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConf: TfrmConf;

implementation

{$R *.fmx}

uses
  uBanco;

procedure TfrmConf.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmConf.Free;
  frmConf := nil;
end;

procedure TfrmConf.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
var
  FService: IFMXVirtualKeyboardService;
begin
  if Key = vkHardwareBack then
  begin
    TPlatformServices.Current.SupportsPlatformService
      (IFMXVirtualKeyboardService, IInterface(FService));
    if (FService <> nil) and (TVirtualKeyboardState.Visible
      in FService.VirtualKeyBoardState) then
    begin
      // Back button pressed, keyboard visible, so do nothing...
    end
    else
    begin
      Key := 0;
    end;
  end
end;

procedure TfrmConf.FormShow(Sender: TObject);
begin
  Edit1.Text := dmBanco.qryConfSERVIDOR.Value;
  Edit2.Text := dmBanco.qryConfPORTA.Value;
end;

procedure TfrmConf.Image3Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmConf.Image3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
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
  dmBanco.qryConfSERVIDOR.Value := Edit1.Text;
  dmBanco.qryConfPORTA.Value := Edit2.Text;
  dmBanco.qryConf.Post;

  dmBanco.servidor := dmBanco.qryConfSERVIDOR.Value;
  dmBanco.porta := dmBanco.qryConfPORTA.Value;

  Close;
end;

end.
