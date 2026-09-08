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
    function GetMethodCommand(ACmd: String) : String;
    procedure ServerCommandGet(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
    procedure AtualizarDados1Click(Sender: TObject);
    procedure AtualizarDadosServ1Click(Sender: TObject);
    procedure TimerMinimizarTimer(Sender: TObject);
  private
    { Private declarations }
    procedure AtualizaVendedores;
    procedure AtualizaProdutos;
    procedure AtualizaClientes;
    procedure AtualizaCondicaoPagto;
    procedure AtualizaUsuarios;
    procedure AtualizaPedidos;
    procedure AtualizaPedidosServ;
    procedure AtualizaReceber;
    procedure AtualizaReceberServ;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses
  uFuncoes, uDM, uServerMethods, uEntidadeMap, uRepassaMap, uDataSet,
  uReceberCmd, uLogger;

var
  gDtAtual : TDateTime;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  dm.FDPhysFBDriverLink1.VendorLib := ExtractFilePath(Application.ExeName) + 'fbclient.dll';
  if dm.ConectaBaseCliente = false then
  begin
    TimerAtualizar.Enabled := false;
    TimerAtualizarServ.Enabled := false;
    ErrorBox('Erro ao conectar base de dados !!!');
    Application.Terminate;
  end
  else
  begin
    TimerAtualizar.Enabled := True;
    TimerAtualizarServ.Enabled := True;
  end;

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

function TfrmMain.GetMethodCommand(ACmd: String) : String;
begin
  if (UpperCase(Copy(ACmd, 1, 3)) = 'GET') then
    Result := 'GET'
  else if (UpperCase(Copy(ACmd, 1, 4)) = 'POST') then
    Result := 'POST'
  else if (UpperCase(Copy(ACmd, 1, 4)) = 'HEAD') then
    Result := 'HEAD'
  else
    Result := '';
end;

procedure TfrmMain.ServerCommandGet(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
const
  cMETHOD = 'TfrmMain.ServerCommandGet';
var
  JSONStr, Param1, Param2, Cmd, Met: string;
  ServerMethod1: TServerMethods1;
  vMet : TMetServerMethods;
  vReq : TReqServerMethods;
begin
  Cmd := ARequestInfo.RawHTTPCommand;
  Met := GetMethodCommand(Cmd);
  uLogger.Instance.Debug(cMETHOD, 'Cmd: ' + Cmd + ' / Met: ' + Met + ' / URI: ' + ARequestInfo.URI);

  vMet := StrToMetServer(Met);
  vReq := StrToReqServer(ARequestInfo.URI);

  {if ((ARequestInfo.AuthUsername  = 'pandin')
  and (ARequestInfo.AuthPassword = 'pandin@2019')) Then
  begin}
    if (vMet in [tmGET, tmPOST, tmHEAD]) then
    begin
      ServerMethod1 := TServerMethods1.Create(nil);
      try
        if vMet in [tmGET] Then
        begin
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
          end;

          uLogger.Instance.Debug(cMETHOD, 'GET / URI: ' + ARequestInfo.URI + ' / JSONStr: ' + JSONStr);
        end;

        if vMet in [tmPOST] Then
        begin
          JSONStr := ARequestInfo.Params.Values['json'];

          uLogger.Instance.Debug(cMETHOD, 'POST / URI: ' + ARequestInfo.URI + ' / JSONStr: ' + JSONStr);

          case vReq of
            trSetPedido : ServerMethod1.SetPedido(JSONStr);
            trSetReceber : ServerMethod1.SetReceber(JSONStr);
          end;
        end;

        AResponseInfo.ContentText := JSONStr;
        AResponseInfo.WriteContent;
      finally
        ServerMethod1.Free;
      end;
    end;
  {end
  else
  begin
    //AResponseInfo.AuthRealm := 'Forneça autenticação';
    AResponseInfo.ContentText := 'AUTENTICAÇÃO INVÁLIDA !!!';
    AResponseInfo.WriteContent;
    Exit;
  end;}
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

    AtualizaUsuarios;
    AtualizaVendedores;
    AtualizaProdutos;
    AtualizaClientes;
    AtualizaCondicaoPagto;
    AtualizaPedidos;
    AtualizaReceber;

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

end.
