unit uBase;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects;

type
  TfrmBase = class(TForm)
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
