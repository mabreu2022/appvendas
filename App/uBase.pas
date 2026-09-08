unit uBase;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects;

type
  TfrmBase = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormPaint(Sender: TObject; Canvas: TCanvas; const ARect: TRectF);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ImageCloseClick(Sender: TObject);
    procedure ImageMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure ImageMouseLeave(Sender: TObject);
  end;

var
  frmBase: TfrmBase;

implementation

{$R *.fmx}

uses
  uBootLog;

procedure TfrmBase.FormCreate(Sender: TObject);
begin
  BootLog('TfrmBase.FormCreate executed');
end;

procedure TfrmBase.FormShow(Sender: TObject);
begin
  BootLog('TfrmBase.FormShow executed');
end;

procedure TfrmBase.FormActivate(Sender: TObject);
begin
  BootLog('TfrmBase.FormActivate executed');
end;

procedure TfrmBase.FormPaint(Sender: TObject; Canvas: TCanvas; const ARect: TRectF);
begin
  BootLog('TfrmBase.FormPaint executed');
end;

procedure TfrmBase.ImageCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmBase.ImageMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  TImage(Sender).Opacity := 0.5;
end;

procedure TfrmBase.ImageMouseLeave(Sender: TObject);
begin
  TImage(Sender).Opacity := 1;
end;

end.
