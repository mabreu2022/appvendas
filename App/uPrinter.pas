unit uPrinter;

interface

uses
  System.Classes, System.StrUtils, System.Types,
  FMX.Graphics, FMX.Printer, FMX.Types;

type
  TClsPrinter = class
  public
    class function GetListPrinter(): TStringList;
    class function GetLabelPrinterIndex(PrinterName: String): Integer;
    class function GetPrinterByName(PrinterName: String): TPrinterDevice;
    class procedure ImprimirConteudo(AConteudo: String; APrinterName: String = '');
  end;

implementation

{ TClsPrinter }

{
https://community.idera.com/developer-tools/programming-languages/f/delphi-rtl/68564/how-to-use-bluetooth-thermal-printer-with-its-android-jar
https://community.idera.com/developer-tools/b/blog/posts/integrando-impressora-bluetooh-com-aplicativos-delphi-multi-device-android
}

class function TClsPrinter.GetListPrinter(): TStringList;
var
  I: Integer;
begin
  Result := TStringList.Create;
  for I := 0 to Printer.Count - 1 do
  begin
    Result.Add(Printer.Printers[I].Title);
  end;
end;

class function TClsPrinter.GetLabelPrinterIndex(PrinterName: String): Integer;
var
  I: Integer;
begin
  for I := 0 to Printer.Count - 1 do
  begin
    if AnsiContainsText(Printer.Printers[I].Title, PrinterName) then
    begin
      Exit(I);
    end;
  end;
  Result := -1;
end;

class function TClsPrinter.GetPrinterByName(PrinterName: String): TPrinterDevice;
var
  I: Integer;
begin
  for I := 0 to Printer.Count - 1 do
  begin
    if AnsiContainsText(Printer.Printers[I].Title, PrinterName) then
    begin
      Exit(Printer.Printers[I]);
    end;
  end;
  Result := nil;
end;

class procedure TClsPrinter.ImprimirConteudo(AConteudo: String; APrinterName: String);
var
  ATextAlign, AVTextAlign: TTextAlign;
  vPrinterDevice, vPrinterDeviceAnt : TPrinterDevice;
  vStringList : TStringList;
  AFlags: TFillTextFlags;
  DestRect : TRectF;
  I : Integer;
begin
  vPrinterDeviceAnt := nil;

  vStringList := TStringList.Create;
  vStringList.Text := AConteudo;

  ATextAlign := TTextAlign.Center; // ?????
  AVTextAlign := TTextAlign.Leading; // ?????

  if (APrinterName <> '') then
  begin
    vPrinterDevice := GetPrinterByName(APrinterName);
    if (vPrinterDevice <> nil) then
    begin
      vPrinterDeviceAnt := Printer.ActivePrinter;
      Printer.ActivePrinter := vPrinterDevice;
    end;
  end;

  Printer.ActivePrinter.SelectDPI(1200, 1200);

  Printer.Title:= 'ImprimirConteudo';
  Printer.Canvas.Fill.Kind := TBrushKind.Solid;

  Printer.BeginDoc;
  DestRect := TRectF.Create(0, 0, Printer.PageWidth, Printer.PageHeight);
  Printer.Canvas.Font.Size:= 80;

  //Printer.Canvas.FillText(DestRect,AConteudo,True,1,AFlags,ATextAlign,AVTextAlign);

  for I := 0 to vStringList.Count -1 do
  begin
    Printer.Canvas.FillText(DestRect,vStringList[0],True,1,AFlags,ATextAlign,AVTextAlign);
  end;

  Printer.EndDoc;

  if (vPrinterDeviceAnt <> nil) then
    Printer.ActivePrinter := vPrinterDeviceAnt;
end;

(*
var
  SrcRect, DestRect: TRectF;
  vBitmap: TBitmap;
begin
  if PrinterSetupDialog1.Execute then
  begin
    Printer.ActivePrinter.SelectDPI(1200, 1200);

    { Set canvas filling style. }
    Printer.Canvas.Fill.Color := TAlphaColorRec.White;
    Printer.Canvas.Fill.Kind := TBrushKind.Solid;

    { Start printing. }
    Printer.BeginDoc;

    { Set the Destination TRects. }
    DestRect := TRectF.Create(0, 0, Printer.PageWidth, Printer.PageHeight);

    vBitmap := TBitmap.Create;
    try
      { Page 1 }
      vBitmap.LoadFromFile('D:\Page1.bmp');
      SrcRect.Width := vBitmap.Width;
      SrcRect.Height := vBitmap.Height;
      { Print the picture on all the surface of the page and all opaque. }
      Printer.Canvas.DrawBitmap(vBitmap, SrcRect, DestRect, 1);


      { Page 2 }
      vBitmap.LoadFromFile('D:\Page2.bmp');
      SrcRect.Width := vBitmap.Width;
      SrcRect.Height := vBitmap.Height;
      { Add new Page}
      Printer.NewPage;
      { Print the picture on all the surface of the page and all opaque. }
      Printer.Canvas.DrawBitmap(vBitmap, SrcRect, DestRect, 1);
    finally
      vBitmap.Free;
    end;

    { Finish printing job. }
    Printer.EndDoc;
  end;
end;
*)

(*
var
  SrcRect, DestRect: TRect;
  vBitmap: TBitmap;
begin
  if PrinterSetupDialog1.Execute then
  begin
    Printer.BeginDoc;

    DestRect := Rect(0, 0, Printer.PageWidth, Printer.PageHeight);

    vBitmap := TBitmap.Create;
    try
      vBitmap.LoadFromFile('D:\Page1.bmp');
      SrcRect := Rect(0, 0, vBitmap.Width, vBitmap.Height);
      Printer.Canvas.CopyRect(DestRect, vBitmap.Canvas, SrcRect);

      Printer.NewPage;

      vBitmap.LoadFromFile('D:\Page2.bmp');
      SrcRect := Rect(0, 0, vBitmap.Width, vBitmap.Height);
      Printer.Canvas.CopyRect(DestRect, vBitmap.Canvas, SrcRect);
    finally
      vBitmap.Free;
    end;

    Printer.EndDoc;
  end;
end;
*)

end.
