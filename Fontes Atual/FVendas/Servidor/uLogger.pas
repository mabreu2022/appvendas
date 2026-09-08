unit uLogger;

interface

uses
  System.Classes, System.StrUtils, System.SysUtils;

type
  TTipLogger = (tlArgLog, tlMemLog, tlDebug, tlErro, tlInfo);

  TSetLogger = set of TTipLogger;

  TClsLogger = class
  private
    FFlags : TSetLogger;
    FCaminho : string;
    FArquivo : string;
    FPasta : string;
    procedure SetarConfig();
    function GetFlags: TSetLogger;
    function GetCaminho : string;
    function GetArquivo : string;
    function GetPasta : string;
    procedure Log(tipo : TTipLogger; metodo, mensagem, gerador : string; ex: Exception);
    procedure LogArg(tipo : TTipLogger; data : TDateTime; metodo, mensagem, gerador : string; ex: Exception);
    procedure LogMem(tipo : TTipLogger; data : TDateTime; metodo, mensagem, gerador : string; ex: Exception);
  public
    constructor Create;
    procedure Debug(metodo, mensagem : string; gerador : string = ''; ex: Exception = nil);
    procedure Erro(metodo, mensagem : string; gerador : string = ''; ex: Exception = nil);
    procedure Info(metodo, mensagem : string; gerador : string = ''; ex: Exception = nil);
  published
    property Flags : TSetLogger read GetFlags write FFlags;
    property Caminho : string read GetCaminho write FCaminho;
    property Arquivo : string read GetArquivo write FArquivo;
    property Pasta : string read GetPasta write FPasta;
  end;

  function TipLoggerToStr(tip : TTipLogger) : string;
  function StrToTipLogger(str : string) : TTipLogger;

  function Instance : TClsLogger;
  procedure Destroy;

implementation

{ TClsLogger }

uses uArquivo, uLoggerMem, uIniFiles, uPath;

var
  _instance : TClsLogger;

  function Instance : TClsLogger;
  begin
    if not Assigned(_instance) then
      _instance := TClsLogger.Create;
    Result := _instance;
  end;

  procedure Destroy;
  begin
    if Assigned(_instance) then
      FreeAndNil(_instance);
  end;

const
  CTipLogger : array [TTipLogger] of string =
    ('ArgLog', 'MemLog', 'Debug', 'Erro', 'Info');

  function TipLoggerToStr(tip : TTipLogger) : string;
  begin
    Result := CTipLogger[tip];
  end;

  function StrToTipLogger(str : string) : TTipLogger;
  var
    I : Integer;
  begin
    for I := 0 to Ord(High(TTipLogger)) do
    begin
      if (CTipLogger[TTipLogger(I)] = str) then
      begin
        Result := TTipLogger(I);
        Exit;
      end;
    end;
  end;

  function TClsLogger.GetFlags: TSetLogger;
  begin
    Result := FFlags;
  end;

  function TClsLogger.GetArquivo: string;
  begin
    Result := IfThen(FArquivo <> '', FArquivo, 'logging.' + FormatDateTime('yyyy.mm.dd', Date) + '.xml');
  end;

  function TClsLogger.GetPasta: string;
  begin
    Result := IfThen(FPasta <> '', FPasta, TClsPath.Get('', 'Log', '', True));
  end;

  function TClsLogger.GetCaminho: string;
  begin
    Result := IncludeTrailingPathDelimiter(Pasta) + Arquivo;
  end;

  procedure TClsLogger.SetarConfig();
  begin
    FFlags := [];
    if (TClsIniFiles.PegarB('', '', 'IN_ARGLOG', True)) then
      FFlags := FFlags + [tlArgLog];
    if (TClsIniFiles.PegarB('', '', 'IN_MEMLOG', True)) then
      FFlags := FFlags + [tlMemLog];
    if (TClsIniFiles.PegarB('', '', 'IN_DEBUG', False)) then
      FFlags := FFlags + [tlDebug];
    if (TClsIniFiles.PegarB('', '', 'IN_ERRO', True)) then
      FFlags := FFlags + [tlErro];
    if (TClsIniFiles.PegarB('', '', 'IN_INFO', False)) then
      FFlags := FFlags + [tlInfo];
  end;

//--

constructor TClsLogger.Create;
begin
  SetarConfig();
end;

procedure TClsLogger.Debug(metodo, mensagem, gerador: string; ex: Exception);
begin
  Log(tlDebug, metodo, mensagem, gerador, ex);
end;

procedure TClsLogger.Erro(metodo, mensagem, gerador: string; ex: Exception);
begin
  Log(tlErro, metodo, mensagem, gerador, ex);
end;

procedure TClsLogger.Info(metodo, mensagem, gerador: string; ex: Exception);
begin
  Log(tlInfo, metodo, mensagem, gerador, ex);
end;

//--

procedure TClsLogger.Log(tipo: TTipLogger;
  metodo, mensagem, gerador: string; ex: Exception);
var
  data : TDateTime;
begin
  data := Now;

  if (tlArgLog in FFlags) then
    LogArg(tipo, data, mensagem, metodo, gerador, ex);

  if (tlMemLog in FFlags) then
    LogMem(tipo, data, mensagem, metodo, gerador, ex);
end;

procedure TClsLogger.LogArg(tipo: TTipLogger; data: TDateTime;
  metodo, mensagem, gerador: string; ex: Exception);
var
  conteudo, exception : string;
begin
  if Assigned(ex) then
    exception := ex.Message + ' / ' + ex.StackTrace
  else
    exception := '';

  conteudo :=
    '<log>' + sLineBreak +
    '<data>' + DateTimeToStr(data) + '</data>' + sLineBreak +
    '<tipo>' + TipLoggerToStr(tipo) + '</tipo>' + sLineBreak +
    '<metodo>' + metodo + '</metodo>' + sLineBreak +
    '<message>' + mensagem + '</message>' + sLineBreak +
    '<gerador>' + gerador + '</gerador>' + sLineBreak +
    '<exception>' + exception + '</exception>' + sLineBreak +
    '</log>' + sLineBreak;

  TClsArquivo.Adicionar(Caminho, conteudo);
end;

procedure TClsLogger.LogMem(tipo: TTipLogger; data: TDateTime;
  metodo, mensagem, gerador: string; ex: Exception);
var
  conteudo : string;
begin
  conteudo :=
    '[ ' + DateTimeToStr(data) + ' ]' + sLineBreak +
    'Tipo: ' + TipLoggerToStr(tipo) + ' / ' +
    'Metodo: ' + metodo + sLineBreak +
    'Message: ' + mensagem + sLineBreak;

  uLoggerMem.Instance.Add(conteudo);
end;

initialization
  //Instance();

finalization
  Destroy();

end.
