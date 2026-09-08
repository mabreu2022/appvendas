unit uDatabaseConfig;

interface

uses
  System.Classes, System.StrUtils, System.SysUtils,
  Forms;

type
  TClsDatabaseTipo = (tdbCli, tdbFB);

  TClsDatabaseModel = class
  private
    FTipo: TClsDatabaseTipo;
    FAmbiente: string;
    FDatabase: string;
    FUsername: string;
    FPassword: string;
  public
    constructor Create(ATipo: TClsDatabaseTipo; AAmbiente, ADatabase, AUsername, APassword: string);
    property Tipo : TClsDatabaseTipo read FTipo;
    property Ambiente : string read FAmbiente;
    property Database : string read FDatabase;
    property Username : string read FUsername;
    property Password : string read FPassword;
  end;

  TClsDatabaseConfig = class
  public
    class function GetDatabase(tip: TClsDatabaseTipo) : TClsDatabaseModel;
  end;

implementation

{ TClsDatabaseModel }

uses uIniFiles, uLogger;

const
  CClsDatabaseTipo : array [TClsDatabaseTipo] of string =
    ('CLI', 'FB');

constructor TClsDatabaseModel.Create(ATipo: TClsDatabaseTipo;
  AAmbiente, ADatabase, AUsername, APassword: string);
begin
  FTipo := ATipo;
  FAmbiente := AAmbiente;
  FDatabase := ADatabase;
  FUsername := AUsername;
  FPassword := APassword;
end;

{ TClsDatabaseConfig }

class function TClsDatabaseConfig.GetDatabase(
  tip: TClsDatabaseTipo): TClsDatabaseModel;
const
  cMETHOD = 'TClsDatabaseConfig.GetDatabase';
var
  tag, amb, sub, data, user, pass : string;
begin
  amb := TClsIniFiles.Pegar('', '', 'TP_AMBIENTE', 'TEST');
  sub := CClsDatabaseTipo[tip];
  tag := 'DADOS_' + amb;

  data := TClsIniFiles.Pegar('', tag, 'DS_DATABASE_' + sub, '');
  user := TClsIniFiles.Pegar('', tag, 'DS_USERNAME_' + sub, '');
  pass := TClsIniFiles.Pegar('', tag, 'DS_PASSWORD_' + sub, '');

  data := ReplaceText(data, '{appPath}', ExtractFilePath(Application.ExeName));

  uLogger.Instance.Debug(cMETHOD, 'amb: ' + amb + ' / sub: ' + sub +
    ' / data: ' + data + ' / user: ' + user + ' / pass: ' + pass);

  Result := TClsDatabaseModel.Create(tip, amb, data, user, pass);
end;

end.