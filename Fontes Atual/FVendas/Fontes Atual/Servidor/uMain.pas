unit uMain;
interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, System.StrUtils,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ComCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, Vcl.Imaging.jpeg, Vcl.StdCtrls, Vcl.AppEvnts, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls, Inifiles, FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Phys.FBDef, FireDAC.Phys.IBBase, FireDAC.Phys.FB, FireDAC.Comp.UI,
  FireDAC.Comp.Client, IdBaseComponent, IdComponent, IdCustomTCPServer,
  FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, Vcl.Buttons,
  IdTCPConnection, IdTCPClient, IdHTTP, IdCustomHTTPServer, IdHTTPServer,
  IdContext, System.DateUtils;
type
  TfrmMain = class(TForm)
    StatusBar1: TStatusBar;
    TrayIcon1: TTrayIcon;
    ApplicationEvents1: TApplicationEvents;
    PopupMenu1: TPopupMenu;
    Sair1: TMenuItem;
    TimerAtualizar: TTimer;
    Server: TIdHTTPServer;
    AtualizarDados1: TMenuItem;
    TimerAtualizarServ: TTimer;
    AtualizarDadosServ1: TMenuItem;
    TimerMinimizar: TTimer;
    Restaurar1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ApplicationEvents1Minimize(Sender: TObject);
    procedure ApplicationEvents1Restore(Sender: TObject);
    procedure TrayIcon1DblClick(Sender: TObject);
    procedure Restaurar1Click(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure ServerCommandGet(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
    procedure AtualizarDados1Click(Sender: TObject);
    procedure AtualizarDadosServ1Click(Sender: TObject);
    procedure TimerMinimizarTimer(Sender: TObject);
  private
    FInSerial : Boolean;
    FInAcesso : Boolean;
    procedure AtualizaVendedores;
    procedure AtualizaProdutos;
    procedure AtualizaClientes;
    procedure AtualizaCondicaoPagto;
    procedure AtualizaUsuarios;
    procedure AtualizaPedidos;
    procedure AtualizaPedidosServ;
    procedure AtualizaReceber;
    procedure AtualizaReceberServ;
    procedure AtualizaReceberRecServ;
    procedure AtualizaReceberPagServ;
    procedure AtualizaBanco;
    procedure AtualizaConta;
    procedure AtualizaMoeda;
    procedure AtualizaRecibo;
    procedure AtualizaAdmEmpresa;
  public
  end;
var
  frmMain: TfrmMain;
implementation
{$R *.dfm}
uses
  uFuncoes, uDM, uServerMethods, uEntidadeMap, uRepassaMap, uDataSet,
  uReceberCmd, uLogger, uIniFiles, uLicenca;
var
  gDtAtual : TDateTime;
procedure TfrmMain.FormCreate(Sender: TObject);
begin
  dm.FDPhysFBDriverLink1.VendorLib := ExtractFilePath(Application.ExeName) + 'fbclient.dll';
  if dm.ConectaBaseCliente = false then
  begin
    ErrorBox('Erro ao conectar base de dados !!!');
    Application.Terminate;
    Exit;
  end;
  TimerAtualizar.Interval := TClsIniFiles.PegarI('', 'TIMER', 'NR_TEMPOENVIO', TimerAtualizar.Interval);
  TimerAtualizar.Enabled := True;
  TimerAtualizarServ.Interval := TClsIniFiles.PegarI('', 'TIMER', 'NR_TEMPORECEB', TimerAtualizarServ.Interval);
  TimerAtualizarServ.Enabled := True;
  FInSerial := TClsIniFiles.PegarB('', '', 'IN_SERIAL', False);
  FInAcesso := TClsIniFiles.PegarB('', '', 'IN_ACESSO', False);
  gDtAtual := Date;
end;
procedure TfrmMain.FormShow(Sender: TObject);
begin
  Server.Active := True;
  TimerAtualizarServ.Enabled := True;
end;
procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if SimNao('Deseja Realmente finalizar o sistema ?') then
    Application.Terminate
  else
    Action := caNone;
end;
procedure TfrmMain.ApplicationEvents1Minimize(Sender: TObject);
begin
  Self.Hide();
  TrayIcon1.Visible := True;
  TrayIcon1.Animate := True;
end;
procedure TfrmMain.ApplicationEvents1Restore(Sender: TObject);
begin
  TrayIcon1.Animate := False;
  TrayIcon1.Visible := False;
  Self.Show();
end;
procedure TfrmMain.Restaurar1Click(Sender: TObject);
begin
  Application.Restore;
end;
procedure TfrmMain.Sair1Click(Sender: TObject);
begin
  Application.Terminate;
end;
procedure TfrmMain.ServerCommandGet(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
const
  cMETHOD = 'TfrmMain.ServerCommandGet';
var
  JSONStr, Param1, Param2, Cmd, Met, Serial: string;
  ServerMethod1: TServerMethods1;
  vMet : TMetServerMethods;
  vReq : TReqServerMethods;
  procedure p_ValidarSerial;
  begin
    if not FInSerial then
      Exit;
    try
      Serial := ARequestInfo.Params.Values['serial'];
      TClsLicenca.ValidarAcesso(Serial);
    except
      on E : Exception do begin
        uLogger.Instance.Erro(cMETHOD, 'Erro na validacao do serial / ' + Serial, '', E);
        AResponseInfo.ContentText := 'AUTENTICAÇÃO INVÁLIDA !!!';
        AResponseInfo.WriteContent;
        Exit;
      end;
    end;
  end;
  procedure p_ValidarAcesso;
  begin
    if not FInAcesso then
      Exit;
    try
      if (ARequestInfo.AuthUsername = '') then
        raise Exception.Create('Username deve ser informado');
      if (ARequestInfo.AuthPassword = '') Then
        raise Exception.Create('Password deve ser informado');
      //TClsAutenticacao.Validar(ARequestInfo.AuthUsername, ARequestInfo.AuthPassword);
    except
      on E : Exception do begin
        uLogger.Instance.Erro(cMETHOD, 'Erro na autenticacao', '', E);
        AResponseInfo.ContentText := 'AUTENTICAÇÃO INVÁLIDA !!!';
        AResponseInfo.WriteContent;
        Exit;
      end;
    end;
  end;
begin
  Cmd := ARequestInfo.RawHTTPCommand;
  Met := GetMethodCommand(Cmd);
  uLogger.Instance.Debug(cMETHOD, 'Cmd: ' + Cmd + ' / Met: ' + Met + ' / URI: ' + ARequestInfo.URI);
  vMet := StrToMetServer(Met);
  vReq := StrToReqServer(ARequestInfo.URI);
  p_ValidarSerial;
  p_ValidarAcesso;
  if (vMet in [tmGET, tmPOST, tmHEAD]) then begin
    ServerMethod1 := TServerMethods1.Create(nil);
    try
      if vMet in [tmGET] then begin
        case vReq of
          trGetVendedor : JSONStr := ServerMethod1.Getvendedor;
          trGetClientes : JSONStr := ServerMethod1.GetClientes;
          trGetProdutos : JSONStr := ServerMethod1.GetProdutos;
          trGetCondicao : JSONStr := ServerMethod1.GetCondicaoPagto;
          trGetUsuario : JSONStr := ServerMethod1.GetUsuario;
          trGetPedidos :
          begin
            {Param1 := ARequestInfo.Params.Values['rep'];
            Param2 := ARequestInfo.Params.Values['data'];
            JSONStr := ServerMethod1.GetPedidos(Param1,Param2);}
          end;
          trGetReceber : JSONStr := ServerMethod1.GetReceber;
          trGetBanco : JSONStr := ServerMethod1.GetBanco;
          trGetConta : JSONStr := ServerMethod1.GetConta;
          trGetMoeda : JSONStr := ServerMethod1.GetMoeda;
          trGetRecibo : JSONStr := ServerMethod1.GetRecibo;
          trGetEmpresa : JSONStr := ServerMethod1.GetEmpresa;
        end;
        uLogger.Instance.Debug(cMETHOD, 'GET / URI: ' + ARequestInfo.URI + ' / JSONStr: ' + JSONStr);
      end;
      if vMet in [tmPOST] then begin
        JSONStr := ARequestInfo.Params.Values['json'];
        uLogger.Instance.Debug(cMETHOD, 'POST / URI: ' + ARequestInfo.URI + ' / JSONStr: ' + JSONStr);
        case vReq of
          trSetPedido : ServerMethod1.SetPedido(JSONStr);
          trSetReceber : ServerMethod1.SetReceber(JSONStr);
          trSetReceberRec : ServerMethod1.SetReceberRec(JSONStr);
          trSetReceberPag : ServerMethod1.SetReceberPag(JSONStr);
        end;
      end;
      AResponseInfo.ContentText := JSONStr;
      AResponseInfo.WriteContent;
    finally
      ServerMethod1.Free;
    end;
  end;
end;
procedure TfrmMain.TimerMinimizarTimer(Sender: TObject);
begin
  TimerMinimizar.Enabled := False;
  Application.Minimize
end;
procedure TfrmMain.TrayIcon1DblClick(Sender: TObject);
begin
  TrayIcon1.Visible := false;
  Show();
  WindowState := wsNormal;
  Application.BringToFront();
end;
procedure TfrmMain.AtualizarDados1Click(Sender: TObject);
begin
  with TimerAtualizar do
  begin
    Enabled := False;
    AtualizaAdmEmpresa;
    AtualizaUsuarios;
    AtualizaVendedores;
    AtualizaProdutos;
    AtualizaClientes;
    AtualizaCondicaoPagto;
    AtualizaPedidos;
    AtualizaReceber;
    AtualizaBanco;
    AtualizaConta;
    AtualizaMoeda;
    AtualizaRecibo;
    Enabled := True;
  end;
end;
procedure TfrmMain.AtualizaClientes;
const
  cMETHOD = 'TfrmMain.AtualizaClientes';
var
  vQryAtua : TFDQuery;
begin
  try
    try
      dm._ConexaoFB.ExecComand('delete from TB_CLIENTE');
      dm.qryClientesFB.Close;
      dm.qryClientesFB.Open;
      dm.qryClientesFB.DisableControls;
      vQryAtua := dm._ConexaoCli.GetQuery('select * from V_CAD_CLIENTE');
      while not vQryAtua.Eof do
      begin
        dm.qryClientesFB.Insert;
        dm.qryClientesFBCODIGO.Value := vQryAtua.FieldByName('CODCLIENTE').AsString;
        dm.qryClientesFBNOME.Value := vQryAtua.FieldByName('NOME').AsString;
        dm.qryClientesFBCNPJ_CPF.Value := vQryAtua.FieldByName('DOCFISCAL').AsString;
        dm.qryClientesFBLOGRADOURO.Value := vQryAtua.FieldByName('ENDERLOGRAD').AsString;
        dm.qryClientesFBNUMERO.Value := vQryAtua.FieldByName('ENDERNUMLOGRAD').AsString;
        dm.qryClientesFBBAIRRO.Value := vQryAtua.FieldByName('ENDERBAIRRO').AsString;
        dm.qryClientesFBCIDADE_DESCRICAO.Value := vQryAtua.FieldByName('NOMECIDADE').AsString;
        dm.qryClientesFBTELEFONE.Value := vQryAtua.FieldByName('NUMTELEFONE1').AsString;
        dm.qryClientesFBCONTATO.Value := vQryAtua.FieldByName('PESSOACONTATO').AsString;
        dm.qryClientesFB.Post;
        vQryAtua.Next;
        Application.ProcessMessages;
      end;
    except
      on E : Exception do begin
        uLogger.Instance.Erro(cMETHOD, 'Erro ao atualizar clientes', '', E);
      end;
    end;
  finally
    vQryAtua.Free;
  end;
end;
procedure TfrmMain.AtualizaCondicaoPagto;
const
  cMETHOD = 'TfrmMain.AtualizaCondicaoPagto';
var
  vQryAtua: TFDQuery;
begin
  try
    try
      vQryAtua := dm._ConexaoCli.GetQuery('select * from CAD_CONDPGTOC');
      dm._ConexaoFB.ExecComand('delete from TB_COND_PAGTO');
      dm.qryCondPagtoFB.Close;
      dm.qryCondPagtoFB.Open;
      vQryAtua.First;
      while not vQryAtua.Eof do
      begin
        dm.qryCondPagtoFB.Insert;
        dm.qryCondPagtoFBCODIGO.Value := vQryAtua.FieldByName('CODCOND').AsInteger;
        dm.qryCondPagtoFBDESCRICAO.Value := vQryAtua.FieldByName('DESCRICAO').AsString;
        dm.qryCondPagtoFB.Post;
        vQryAtua.Next;
      end;
    except
      on E : Exception do begin
        uLogger.Instance.Erro(cMETHOD, 'Erro ao atualizar cond. pagto', '', E);
      end;
    end;
  finally
    vQryAtua.Free;
  end;
end;
procedure TfrmMain.AtualizaProdutos;
const
  cMETHOD = 'TfrmMain.AtualizaProdutos';
begin
  try
    try
      dm._ConexaoFB.ExecComand('delete from TB_PRODUTO');
      dm.qryProdutosFB.Close;
      dm.qryProdutosFB.Open;
      dm.qryProdutosFB.DisableControls;
      dm.qryProdutosCli.Close;
      dm.qryProdutosCli.Open;
      dm.qryProdutosCli.DisableControls;
      dm.qryProdutosCli.Last;
      dm.qryProdutosCli.First;
      while not dm.qryProdutosCli.Eof do
      begin
        dm.qryProdutosFB.Insert;
        dm.qryProdutosFBCODIGO.Value := dm.qryProdutosCliCODPROD.AsString;
        dm.qryProdutosFBDESCRICAO.Value := dm.qryProdutosCliDESCCOMPLETA.AsString;
        dm.qryProdutosFBDESCRICAO_RED.Value := dm.qryProdutosCliDESCRICAO.Value;
        dm.qryProdutosFBBARRAS.Value := dm.qryProdutosCliCODBAR.Value;
        dm.qryProdutosFBUNIDADE.Value := dm.qryProdutosCliUNIDMEDIDA.AsString;
        dm.qryProdutosFBPRECO_VENDA.Value := dm.qryProdutosCliVLVENDA.AsCurrency;
        dm.qryProdutosFBPRECO_MIN.Value := dm.qryProdutosCliVLVENDAMIN.AsCurrency;
        dm.qryProdutosFBPRECO_ATACADO.Value := dm.qryProdutosCliVLVENDAATACADO.AsCurrency;
        dm.qryProdutosFBPRECO_COMPRA.Value := dm.qryProdutosCliVLCTOULTCOMP.AsCurrency;
        dm.qryProdutosFB.Post;
        dm.qryProdutosCli.Next;
        Application.ProcessMessages;
      end;
      dm.qryProdutosFB.EnableControls;
    except
      on E : Exception do begin
        uLogger.Instance.Erro(cMETHOD, 'Erro ao atualizar produtos', '', E);
      end;
    end;
  finally
  end;
end;
procedure TfrmMain.AtualizaUsuarios;
const
  cMETHOD = 'TfrmMain.AtualizaUsuarios';
var
  vQryAtua: TFDQuery;
begin
  try
    try
      vQryAtua := dm._ConexaoCli.GetQuery('select * from ADM_USUARIO');
      dm.qryUsuariosFB.Close;
      dm.qryUsuariosFB.Open;
      vQryAtua.First;
      while not vQryAtua.Eof do
      begin
        if not dm.qryUsuariosFB.Locate('CODIGO', vQryAtua.FieldByName('CODUSU').AsString, []) then
        begin
          dm.qryUsuariosFB.Insert;
        end
        else
        begin
          dm.qryUsuariosFB.Edit;
        end;
        dm.qryUsuariosFBCODIGO.Value := vQryAtua.FieldByName('CODUSU').AsInteger;
        dm.qryUsuariosFBNOME.Value := vQryAtua.FieldByName('NOME').AsString;
        dm.qryUsuariosFBLOGIN.Value := vQryAtua.FieldByName('LOGIN').AsString;
        dm.qryUsuariosFBSENHA.Value := vQryAtua.FieldByName('SENHA_MOB').AsString;
        dm.qryUsuariosFB.Post;
        vQryAtua.Next;
      end;
    except
      on E : Exception do begin
        uLogger.Instance.Erro(cMETHOD, 'Erro ao atualizar usuarios', '', E);
      end;
    end;
  finally
    vQryAtua.Free;
  end;
end;
procedure TfrmMain.AtualizaVendedores;
const
  cMETHOD = 'TfrmMain.AtualizaVendedores';
var
  vQryAtua: TFDQuery;
begin
  try
    try
      vQryAtua := dm._ConexaoCli.GetQuery('select * from CAD_VEND');
      dm.qryVendedoresFB.Close;
      dm.qryVendedoresFB.Open;
      vQryAtua.First;
      while not vQryAtua.Eof do
      begin
        if not dm.qryVendedoresFB.Locate('CODIGO', vQryAtua.FieldByName('CODVEND').AsString, []) then
        begin
          dm.qryVendedoresFB.Insert;
        end
        else
        begin
          dm.qryVendedoresFB.Edit;
        end;
        dm.qryVendedoresFBCODIGO.Value := vQryAtua.FieldByName('CODVEND').AsString;
        dm.qryVendedoresFBNOME.Value := vQryAtua.FieldByName('NOMEVEND').AsString;
        dm.qryVendedoresFBUSUARIO.Value := vQryAtua.FieldByName('NOMEVEND').AsString;
        dm.qryVendedoresFB.Post;
        vQryAtua.Next;
      end;
    except
      on E : Exception do begin
        uLogger.Instance.Erro(cMETHOD, 'Erro ao atualizar vendedores', '', E);
      end;
    end;
  finally
    vQryAtua.Free;
  end;
end;
procedure TfrmMain.AtualizaPedidos;
{var
  vQryPedidosFB, vQryPedidosCli: TFDQuery;
  vRepasseMapList: TClsRepassaMapList;}
begin
  {ShowMessage('AtualizaPedidos');
  vRepasseMapList:= TClsEntidadeMap.GetEntidadeMap('TB_PEDIDO', '');
  dm._ConexaoFB.ExecComand('delete from TB_PEDIDO');
  vQryPedidosCli := dm._ConexaoCli.GetQuery('select * from MOV_RESC where 1 = 2');
  vQryPedidosFB := dm._ConexaoFB.GetQuery('select * from TB_PEDIDO');
  with vQryPedidosCli do
  begin
    First;
    while not EOF do
    begin
      vQryPedidosFB.Insert;
      TClsDataSet.RepassarDados(vQryPedidosCli, vQryPedidosFB, vRepasseMapList);
      vQryPedidosFB.Post;
      Next;
    end;
  end;
  ShowMessage('AtualizaPedidos - ok');}
end;
procedure TfrmMain.AtualizaReceber;
const
  cMETHOD = 'TfrmMain.AtualizaReceber';
var
  vQryReceberFB, vQryReceberCli: TFDQuery;
  vRepasseMapList: TClsRepassaMapList;
begin
  try
    try
      vRepasseMapList:= TClsEntidadeMap.GetEntidadeMap('FCR_FAT', '');
      dm._ConexaoFB.ExecComand('delete from TB_RECEBER');
      vQryReceberCli := dm._ConexaoCli.GetQuery('select * from V_FCR_REC_FV');
      vQryReceberFB := dm._ConexaoFB.GetQuery('select * from TB_RECEBER');
      with vQryReceberCli do
      begin
        First;
        while not EOF do
        begin
          if not vQryReceberFB.Locate('COD_EMP;COD_CLIENTE;NUM_FAT;NUM_PARC',
            VarArrayOf([vQryReceberCli.FieldByName('CODEMP').Value,
                        vQryReceberCli.FieldByName('CODCLIENTE').Value,
                        vQryReceberCli.FieldByName('NUMFAT').Value,
                        vQryReceberCli.FieldByName('NUMPARC').Value])) then
          begin
            vQryReceberFB.Insert;
            TClsDataSet.RepassarDados(vQryReceberCli, vQryReceberFB, vRepasseMapList);
            vQryReceberFB.Post;
          end;
          Next;
        end;
      end;
    except
      on E : Exception do begin
        uLogger.Instance.Erro(cMETHOD, 'Erro ao atualizar receber', '', E);
      end;
    end;
  finally
  end;
end;
procedure TfrmMain.AtualizarDadosServ1Click(Sender: TObject);
begin
  with TTimer(Sender) do
  begin
    Enabled := false;
    AtualizaPedidosServ;
    AtualizaReceberServ;
    AtualizaReceberRecServ;
    AtualizaReceberPagServ;
    Enabled := True;
  end;
end;
procedure TfrmMain.AtualizaPedidosServ;
const
  cMETHOD = 'TfrmMain.AtualizaPedidosServ';
var
  vCodProxPed, vGlbCodMoeda: Integer;
  vNomePessoa: String;
begin
  try
    try
      with dm do
      begin
        AtuaPedidoCli.Open;
        AtuaItensCli.Open;
        AtuaPedidoFB.Close;
        AtuaPedidoFB.SQL.Clear;
        AtuaPedidoFB.SQL.Add('select * from TB_PEDIDO where ENV = ''N''');
        AtuaPedidoFB.Open;
        if not AtuaPedidoFB.IsEmpty then
        begin
          // Busca último número de pré-venda no banco
          vCodProxPed := dm._ConexaoCli.GetValueI('select gen_id(SQ_MOV_REC_SAI_EMP1,1) as ultimo from RDB$DATABASE', 'ultimo');
          //
          // Busca Código da moéda Padrão de Venda no banco de dados
          vGlbCodMoeda := dm._ConexaoCli.GetValueI('select codmoeda from ADM_PARAM', 'codmoeda');
          //
          AtuaPedidoFB.First;
          while not AtuaPedidoFB.Eof do
          begin
            // Busca Nome da pessoa
            vNomePessoa := dm._ConexaoFB.GetValue('select nome from TB_CLIENTE where codigo=' + QuotedStr(AtuaPedidoFBCLIENTE.AsString), 'nome');
            //
            // Insere Pedido Capa
            AtuaPedidoCli.Insert;
            AtuaPedidoCliCODEMP.Value := 1;
            AtuaPedidoCliNUMRES.Value := vCodProxPed;
            AtuaPedidoCliDATARES.Value := StrToDate(formatdatetime('dd/mm/yyyy', AtuaPedidoFBDATA_PEDIDO.AsDateTime));
            AtuaPedidoCliCODSITUACAO.Value := 1;
            AtuaPedidoCliCODOPER.Value := 13;
            AtuaPedidoCliNUMMOVPED.AsString := Copy(AtuaPedidoFBCODIGO.AsString, 14, 6);
            AtuaPedidoCliDATAMOVPED.Value := StrToDate(formatdatetime('dd/mm/yyyy', AtuaPedidoFBDATA_PEDIDO.AsDateTime));
            AtuaPedidoCliCODVEND.Value := AtuaPedidoFBVENDEDOR.AsInteger;
            AtuaPedidoCliUSUARIO.Value := AtuaPedidoCliUSUARIO.AsInteger;
            AtuaPedidoCliDATAATU.Value := date;
            AtuaPedidoCliHORAATU.Value := TimeToStr(time);
            AtuaPedidoCliCODPESSOA.Value := AtuaPedidoFBCLIENTE.AsInteger;
            AtuaPedidoCliNOMEPESSOA.AsString := vNomePessoa;
            AtuaPedidoCliCODCOND.Value := AtuaPedidoFBCOD_PAGTO.Value;
            AtuaPedidoCliCODMOEDA.Value := vGlbCodMoeda;
            AtuaPedidoCliVLTOTMOV.Value := AtuaPedidoFBTOTAL_PEDIDO.Value;
            AtuaPedidoCli.Post;
            // insere itens
            AtuaItensFB.Close;
            AtuaItensFB.SQL.Clear;
            AtuaItensFB.SQL.Add('select * from TB_ITENS_PEDIDO where COD_PEDIDO = :COD order by SEQ');
            AtuaItensFB.ParamByName('COD').Value := AtuaPedidoFBCODIGO.Value;
            AtuaItensFB.Open;
            AtuaItensFB.First;
            while not AtuaItensFB.Eof do
            begin
              AtuaItensCli.Insert;
              AtuaItensCliCODEMP.Value := 1;
              AtuaItensCliDATARES.Value := StrToDate(formatdatetime('dd/mm/yyyy', AtuaPedidoFBDATA_PEDIDO.AsDateTime));
              AtuaItensCliNUMRES.Value := vCodProxPed; // AtuaPedidoCliNUMRES.Value;
              AtuaItensCliNUMITEM.Value := AtuaItensFBSEQ.Value;
              AtuaItensCliCODPROD.Value := AtuaItensFBCOD_PRODUTO.AsInteger;
              AtuaItensCliCODVEND.Value := AtuaPedidoCliCODVEND.Value;
              AtuaItensCliUSUARIO.Value := AtuaPedidoCliCODVEND.Value;
              AtuaItensCliDATAATU.Value := date;
              AtuaItensCliTIPOOPER.Value := 'S';
              AtuaItensCliHORAATU.Value := TimeToStr(time);
              AtuaItensCliQTMOV.Value := AtuaItensFBQTD.Value;
              AtuaItensCliVLUNITMOV.Value := AtuaItensFBVALOR_UNITARIO.Value;
              AtuaItensCliVLTOTMOV.Value := AtuaItensFBVALOR_TOTAL.AsCurrency;
              AtuaItensCliCODSITUACAO.Value := 1;
              AtuaItensCli.Post;
              AtuaItensFB.Next;
            end;
            AtuaPedidoFB.Edit;
            AtuaPedidoFBENV.Value := 'S';
            AtuaPedidoFB.Post;
            AtuaPedidoFB.Next;
          end;
        end;
        AtuaPedidoCli.Close;
        AtuaItensCli.Close;
        AtuaPedidoFB.Close;
        AtuaItensFB.Close;
      end;
    except
      on E : Exception do begin
        uLogger.Instance.Erro(cMETHOD, 'Erro ao atualizar pedido serv', '', E);
      end;
    end;
  finally
  end;
end;
procedure TfrmMain.AtualizaReceberServ;
const
  cMETHOD = 'TfrmMain.AtualizaReceberServ';
var
  vQryReceberFB: TFDQuery;
  vCmd, vTip : String;
begin
  try
    try
      vTip := TipReceberCmdToStr(trProcessado);
      vQryReceberFB := dm._ConexaoFB.GetQuery(
        'select * from TB_RECEBER_REC ' +
        'where coalesce(SIT_CONTROLE,'''') <> ''' + vTip + ''' ', False);
      if (MinutesBetween(Now, gDtAtual) > 5) then
      begin
        uLogger.Instance.Debug(cMETHOD, 'SQL: ' + vQryReceberFB.SQL.Text);
        gDtAtual := Now;
      end;
      vQryReceberFB.Open;
      with vQryReceberFB do
      begin
        First;
        while not EOF do
        begin
          vCmd := TClsReceberCmd.getCmdUpdateCli(
            FieldByName('COD_EMP').AsInteger,
            FieldByName('COD_CLIENTE').AsInteger,
            FieldByName('NUM_FAT').AsInteger,
            FieldByName('NUM_PARC').AsInteger);
          dm._ConexaoCli.ExecComand(vCmd);
          vCmd := TClsReceberCmd.getCmdUpdateFB(
            FieldByName('COD_EMP').AsInteger,
            FieldByName('COD_CLIENTE').AsInteger,
            FieldByName('NUM_FAT').AsInteger,
            FieldByName('NUM_PARC').AsInteger);
          dm._ConexaoFB.ExecComand(vCmd);
          Next;
        end;
      end;
      vQryReceberFB.Free;
    except
      on E : Exception do begin
        uLogger.Instance.Erro(cMETHOD, 'Erro ao atualizar receber serv', '', E);
      end;
    end;
  finally
  end;
end;
procedure TfrmMain.AtualizaReceberRecServ;
const
  cMETHOD = 'TfrmMain.AtualizaReceberRecServ';
begin
  //
end;
procedure TfrmMain.AtualizaReceberPagServ;
const
  cMETHOD = 'TfrmMain.AtualizaReceberPagServ';
begin
  //
end;
procedure TfrmMain.AtualizaAdmEmpresa;
const
  cMETHOD = 'TfrmMain.AtualizaAdmEmpresa';
var
  vQryAtua: TFDQuery;
begin
  try
    try
      vQryAtua := dm._ConexaoCli.GetQuery('select * from ADM_EMPRESA');
      dm.qryAdmEmpresa.Close;
      dm.qryAdmEmpresa.Open;
      vQryAtua.First;
      while not vQryAtua.Eof do
      begin
        if not dm.qryAdmEmpresa.Locate('CODEMP', vQryAtua.FieldByName('CODEMP').AsString, []) then
        begin
          dm.qryAdmEmpresa.Insert;
        end
        else
        begin
          dm.qryAdmEmpresa.Edit;
        end;
        dm.qryAdmEmpresaCODEMP.Value := vQryAtua.FieldByName('CODEMP').AsInteger;
        dm.qryAdmEmpresaNOME.Value := vQryAtua.FieldByName('NOME').AsString;
        dm.qryAdmEmpresaNOMEFANTASIA.Value := vQryAtua.FieldByName('NOMEFANTASIA').AsString;
        dm.qryAdmEmpresaENDERTPLOGRAD.Value := vQryAtua.FieldByName('ENDERTPLOGRAD').AsString;
        dm.qryAdmEmpresaENDERLOGRAD.Value := vQryAtua.FieldByName('ENDERLOGRAD').AsString;
        dm.qryAdmEmpresaENDERNUMLOGRAD.Value := vQryAtua.FieldByName('ENDERNUMLOGRAD').AsString;
        dm.qryAdmEmpresaENDERCOMPLEMENTO.Value := vQryAtua.FieldByName('ENDERCOMPLEMENTO').AsString;
        dm.qryAdmEmpresaENDERBAIRRO.Value := vQryAtua.FieldByName('ENDERBAIRRO').AsString;
        dm.qryAdmEmpresaCODCIDADE.Value := vQryAtua.FieldByName('CODCIDADE').AsInteger;
        dm.qryAdmEmpresaNUMTELEFONE.Value := vQryAtua.FieldByName('NUMTELEFONE').AsString;
        dm.qryAdmEmpresaUSUARIO.Value := vQryAtua.FieldByName('USUARIO').AsInteger;
        dm.qryAdmEmpresaDATAATU.Value := vQryAtua.FieldByName('DATAATU').AsDateTime;
        dm.qryAdmEmpresaHORAATU.Value := vQryAtua.FieldByName('HORAATU').AsString;
        dm.qryAdmEmpresaINEXPORTADOR.Value := vQryAtua.FieldByName('INEXPORTADOR').AsString;
        dm.qryAdmEmpresaDOCFISCAL.Value := vQryAtua.FieldByName('DOCFISCAL').AsString;
        dm.qryAdmEmpresaDOCFISCALREPRLEGAL.Value := vQryAtua.FieldByName('DOCFISCALREPRLEGAL').AsString;
        dm.qryAdmEmpresaNOMEREPRLEGAL.Value := vQryAtua.FieldByName('NOMEREPRLEGAL').AsString;
        dm.qryAdmEmpresaTPREPRLEGAL.Value := vQryAtua.FieldByName('TPREPRLEGAL').AsString;
        dm.qryAdmEmpresaNACIONALIDADE.Value := vQryAtua.FieldByName('NACIONALIDADE').AsString;
        dm.qryAdmEmpresaESTADOCIVIL.Value := vQryAtua.FieldByName('ESTADOCIVIL').AsString;
        dm.qryAdmEmpresaDOCIDENTIDADE.Value := vQryAtua.FieldByName('DOCIDENTIDADE').AsString;
        dm.qryAdmEmpresa.Post;
        vQryAtua.Next;
      end;
    except
      on E : Exception do begin
        uLogger.Instance.Erro(cMETHOD, 'Erro ao atualizar bancos', '', E);
      end;
    end;
  finally
    vQryAtua.Free;
  end;
end;

procedure TfrmMain.AtualizaBanco;
const
  cMETHOD = 'TfrmMain.AtualizaBanco';
var
  vQryAtua: TFDQuery;
begin
  try
    try
      vQryAtua := dm._ConexaoCli.GetQuery('select * from FCC_BANCO');
      dm.qryBancoFB.Close;
      dm.qryBancoFB.Open;
      vQryAtua.First;
      while not vQryAtua.Eof do
      begin
        if not dm.qryBancoFB.Locate('NRO_CODIGO', vQryAtua.FieldByName('NUMCODIGO').AsString, []) then
        begin
          dm.qryBancoFB.Insert;
        end
        else
        begin
          dm.qryBancoFB.Edit;
        end;
        dm.qryBancoFBNRO_CODIGO.Value := vQryAtua.FieldByName('NUMCODIGO').AsInteger;
        dm.qryBancoFBNRO_BANCO.Value := vQryAtua.FieldByName('NUMBANCO').AsInteger;
        dm.qryBancoFBNRO_AGENCIA.Value := vQryAtua.FieldByName('NUMAGENCIA').AsString;
        dm.qryBancoFBDESC_BANCO.Value := vQryAtua.FieldByName('DESCBANCO').AsString;
        dm.qryBancoFBSIT_BANCO.Value := vQryAtua.FieldByName('TPSITUACAO').AsInteger;
        dm.qryBancoFB.Post;
        vQryAtua.Next;
      end;
    except
      on E : Exception do begin
        uLogger.Instance.Erro(cMETHOD, 'Erro ao atualizar bancos', '', E);
      end;
    end;
  finally
    vQryAtua.Free;
  end;
end;
procedure TfrmMain.AtualizaConta;
const
  cMETHOD = 'TfrmMain.AtualizaConta';
var
  vQryAtua: TFDQuery;
begin
  try
    try
      vQryAtua := dm._ConexaoCli.GetQuery('select * from FCC_CONTA');
      dm.qryContaFB.Close;
      dm.qryContaFB.Open;
      vQryAtua.First;
      while not vQryAtua.Eof do
      begin
        if not dm.qryContaFB.Locate('COD_EMPRESA;NRO_CODIGO',
          VarArrayOf([vQryAtua.FieldByName('CODEMP').AsInteger,
                     vQryAtua.FieldByName('NRCTAPES').AsInteger]), []) then
        begin
          dm.qryContaFB.Insert;
        end
        else
        begin
          dm.qryContaFB.Edit;
        end;
        dm.qryContaFBCOD_EMPRESA.Value := vQryAtua.FieldByName('CODEMP').AsInteger;
        dm.qryContaFBNRO_CODIGO.Value := vQryAtua.FieldByName('NRCTAPES').AsInteger;
        dm.qryContaFBNRO_BANCO.Value := vQryAtua.FieldByName('NUMBANCO').AsInteger;
        dm.qryContaFBCOD_CONTA.Value := vQryAtua.FieldByName('CODCONTA').AsString;
        dm.qryContaFBDESC_CONTA.Value := vQryAtua.FieldByName('DSCONTA').AsString;
        dm.qryContaFBTIP_CONTA.Value := vQryAtua.FieldByName('TPCONTA').AsInteger;
        dm.qryContaFBSIT_CONTA.Value := vQryAtua.FieldByName('INATIVO').AsString;
        dm.qryContaFBCOD_MOEDA.Value := vQryAtua.FieldByName('CODMOEDA').AsInteger;
        dm.qryContaFB.Post;
        vQryAtua.Next;
      end;
    except
      on E : Exception do begin
        uLogger.Instance.Erro(cMETHOD, 'Erro ao atualizar contas', '', E);
      end;
    end;
  finally
    vQryAtua.Free;
  end;
end;
procedure TfrmMain.AtualizaMoeda;
const
  cMETHOD = 'TfrmMain.AtualizaMoeda';
var
  vQryAtua: TFDQuery;
begin
  try
    try
      vQryAtua := dm._ConexaoCli.GetQuery('select * from CAD_MOEDA');
      dm.qryMoedaFB.Close;
      dm.qryMoedaFB.Open;
      vQryAtua.First;
      while not vQryAtua.Eof do
      begin
        if not dm.qryMoedaFB.Locate('COD_MOEDA', vQryAtua.FieldByName('CODMOEDA').AsInteger, []) then
        begin
          dm.qryMoedaFB.Insert;
        end
        else
        begin
          dm.qryMoedaFB.Edit;
        end;
        dm.qryMoedaFBCOD_MOEDA.Value := vQryAtua.FieldByName('CODMOEDA').AsInteger;
        dm.qryMoedaFBDESC_MOEDA.Value := vQryAtua.FieldByName('NOMEMOEDA').AsString;
        dm.qryMoedaFBSIMB_MOEDA.Value := vQryAtua.FieldByName('SIMBOLO').AsString;
        dm.qryMoedaFB.Post;
        vQryAtua.Next;
      end;
    except
      on E : Exception do begin
        uLogger.Instance.Erro(cMETHOD, 'Erro ao atualizar moedas', '', E);
      end;
    end;
  finally
    vQryAtua.Free;
  end;
end;
procedure TfrmMain.AtualizaRecibo;
const
  cMETHOD = 'TfrmMain.AtualizaRecibo';
var
  vQryAtua: TFDQuery;
begin
  try
    try
      vQryAtua := dm._ConexaoCli.GetQuery('select * from CAD_RECIBO');
      dm.qryReciboFB.Close;
      dm.qryReciboFB.Open;
      vQryAtua.First;
      while not vQryAtua.Eof do
      begin
        if not dm.qryReciboFB.Locate('COD_RECIBO', vQryAtua.FieldByName('CODRECIBO').AsString, []) then
        begin
          dm.qryReciboFB.Insert;
        end
        else
        begin
          dm.qryReciboFB.Edit;
        end;
        dm.qryReciboFBCOD_RECIBO.Value := vQryAtua.FieldByName('CODRECIBO').AsString;
        dm.qryReciboFBNRO_RECIBO.Value := vQryAtua.FieldByName('NRORECIBO').AsInteger;
        dm.qryReciboFB.Post;
        vQryAtua.Next;
      end;
    except
      on E : Exception do begin
        uLogger.Instance.Erro(cMETHOD, 'Erro ao atualizar recibos', '', E);
      end;
    end;
  finally
    vQryAtua.Free;
  end;
end;
end.
