object dmBanco: TdmBanco
  OldCreateOrder = False
  Height = 376
  Width = 882
  object Conexao: TFDConnection
    Params.Strings = (
      'Database=C:\Projetos\Delphi\camargo\FVENDAS\Dados\app.db3'
      'OpenMode=ReadWrite'
      'DriverID=SQLite')
    LoginPrompt = False
    BeforeConnect = ConexaoBeforeConnect
    Left = 48
    Top = 16
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 120
    Top = 16
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 192
    Top = 16
  end
  object qryVendedor: TFDQuery
    Connection = Conexao
    SQL.Strings = (
      'select * from TB_VENDEDOR')
    Left = 48
    Top = 96
    object qryVendedorCODIGO: TStringField
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      Required = True
      Size = 3
    end
    object qryVendedorNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 50
    end
    object qryVendedorUSUARIO: TStringField
      FieldName = 'USUARIO'
      Origin = 'USUARIO'
      Size = 50
    end
    object qryVendedorSENHA: TStringField
      FieldName = 'SENHA'
      Origin = 'SENHA'
      Size = 50
    end
    object qryVendedorEMAIL: TStringField
      FieldName = 'EMAIL'
      Origin = 'EMAIL'
      Size = 80
    end
    object qryVendedorPORC_DESC: TFloatField
      FieldName = 'PORC_DESC'
      Origin = 'PORC_DESC'
    end
    object qryVendedorPORC_ADIC: TFloatField
      FieldName = 'PORC_ADIC'
      Origin = 'PORC_ADIC'
    end
    object qryVendedorPORC_DESC_ITEM: TFloatField
      FieldName = 'PORC_DESC_ITEM'
      Origin = 'PORC_DESC_ITEM'
    end
    object qryVendedorCAD_CLI: TStringField
      FieldName = 'CAD_CLI'
      Origin = 'CAD_CLI'
      FixedChar = True
      Size = 1
    end
    object qryVendedorCAD_PED: TStringField
      FieldName = 'CAD_PED'
      Origin = 'CAD_PED'
      FixedChar = True
      Size = 1
    end
    object qryVendedorBONIFICA: TStringField
      FieldName = 'BONIFICA'
      Origin = 'BONIFICA'
      FixedChar = True
      Size = 1
    end
    object qryVendedorACESSO: TStringField
      FieldName = 'ACESSO'
      Origin = 'ACESSO'
      FixedChar = True
      Size = 1
    end
  end
  object ClientVendedor: TRESTClient
    Authenticator = HTTPBasicAuthenticator1
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    AcceptEncoding = 'identity'
    Params = <>
    Left = 376
    Top = 16
  end
  object ResponseVendedor: TRESTResponse
    Left = 376
    Top = 64
  end
  object RequestVendedor: TRESTRequest
    Client = ClientVendedor
    Params = <>
    Response = ResponseVendedor
    SynchronizedEvents = False
    Left = 376
    Top = 112
  end
  object memVendedor: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 376
    Top = 160
  end
  object dsVendedor: TDataSource
    DataSet = memVendedor
    Left = 376
    Top = 208
  end
  object HTTPBasicAuthenticator1: THTTPBasicAuthenticator
    Username = 'fv'
    Password = 'fv2019'
    Left = 304
    Top = 16
  end
  object qryConf: TFDQuery
    Connection = Conexao
    SQL.Strings = (
      'select * from TB_CONF')
    Left = 48
    Top = 152
    object qryConfSERVIDOR: TStringField
      FieldName = 'SERVIDOR'
      Origin = 'SERVIDOR'
      Size = 50
    end
    object qryConfPORTA: TStringField
      FieldName = 'PORTA'
      Origin = 'PORTA'
      Size = 10
    end
    object qryConfUSUARIO: TStringField
      FieldName = 'USUARIO'
      Origin = 'USUARIO'
      Size = 50
    end
  end
  object ClientClientes: TRESTClient
    Authenticator = HTTPBasicAuthenticator1
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    AcceptEncoding = 'identity'
    Params = <>
    Left = 448
    Top = 16
  end
  object ResponseClientes: TRESTResponse
    Left = 448
    Top = 64
  end
  object RequestClientes: TRESTRequest
    Client = ClientClientes
    Params = <>
    Response = ResponseClientes
    SynchronizedEvents = False
    Left = 448
    Top = 112
  end
  object memClientes: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 448
    Top = 160
  end
  object dsClientes: TDataSource
    DataSet = memClientes
    Left = 448
    Top = 208
  end
  object qryClientes: TFDQuery
    Connection = Conexao
    SQL.Strings = (
      'select * from TB_CLIENTE order by nome')
    Left = 120
    Top = 96
    object qryClientesCODIGO: TStringField
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      Required = True
      Size = 6
    end
    object qryClientesCODIGO_MOBILE: TStringField
      FieldName = 'CODIGO_MOBILE'
      Origin = 'CODIGO_MOBILE'
      Size = 50
    end
    object qryClientesTIPO: TStringField
      FieldName = 'TIPO'
      Origin = 'TIPO'
      FixedChar = True
      Size = 1
    end
    object qryClientesNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 50
    end
    object qryClientesFANTASIA: TStringField
      FieldName = 'FANTASIA'
      Origin = 'FANTASIA'
      Size = 50
    end
    object qryClientesCNPJ_CPF: TStringField
      FieldName = 'CNPJ_CPF'
      Origin = 'CNPJ_CPF'
      Size = 14
    end
    object qryClientesIE_RG: TStringField
      FieldName = 'IE_RG'
      Origin = 'IE_RG'
      Size = 15
    end
    object qryClientesLOGRADOURO: TStringField
      FieldName = 'LOGRADOURO'
      Origin = 'LOGRADOURO'
      Size = 50
    end
    object qryClientesNUMERO: TStringField
      FieldName = 'NUMERO'
      Origin = 'NUMERO'
      Size = 10
    end
    object qryClientesBAIRRO: TStringField
      FieldName = 'BAIRRO'
      Origin = 'BAIRRO'
      Size = 50
    end
    object qryClientesCOMPLEMENTO: TStringField
      FieldName = 'COMPLEMENTO'
      Origin = 'COMPLEMENTO'
      Size = 50
    end
    object qryClientesCIDADE_IBGE: TStringField
      FieldName = 'CIDADE_IBGE'
      Origin = 'CIDADE_IBGE'
      Size = 10
    end
    object qryClientesCIDADE_DESCRICAO: TStringField
      FieldName = 'CIDADE_DESCRICAO'
      Origin = 'CIDADE_DESCRICAO'
      Size = 50
    end
    object qryClientesUF: TStringField
      FieldName = 'UF'
      Origin = 'UF'
      Size = 2
    end
    object qryClientesTELEFONE: TStringField
      FieldName = 'TELEFONE'
      Origin = 'TELEFONE'
      Size = 15
    end
    object qryClientesCOMERCIAL: TStringField
      FieldName = 'COMERCIAL'
      Origin = 'COMERCIAL'
      Size = 15
    end
    object qryClientesCELULAR: TStringField
      FieldName = 'CELULAR'
      Origin = 'CELULAR'
      Size = 15
    end
    object qryClientesWATSAPP: TStringField
      FieldName = 'WATSAPP'
      Origin = 'WATSAPP'
      Size = 15
    end
    object qryClientesCONTATO: TStringField
      FieldName = 'CONTATO'
      Origin = 'CONTATO'
      Size = 30
    end
    object qryClientesEMAIL1: TStringField
      FieldName = 'EMAIL1'
      Origin = 'EMAIL1'
      Size = 80
    end
    object qryClientesEMAIL2: TStringField
      FieldName = 'EMAIL2'
      Origin = 'EMAIL2'
      Size = 80
    end
    object qryClientesATIVIDADE: TStringField
      FieldName = 'ATIVIDADE'
      Origin = 'ATIVIDADE'
      Size = 50
    end
    object qryClientesOBS: TBlobField
      FieldName = 'OBS'
      Origin = 'OBS'
    end
    object qryClientesLIMITE_COMPRA_PED: TBCDField
      FieldName = 'LIMITE_COMPRA_PED'
      Origin = 'LIMITE_COMPRA_PED'
      Precision = 15
      Size = 2
    end
    object qryClientesDIAS_BLOQ_ATRASO: TIntegerField
      FieldName = 'DIAS_BLOQ_ATRASO'
      Origin = 'DIAS_BLOQ_ATRASO'
    end
    object qryClientesDATA_SINC: TSQLTimeStampField
      FieldName = 'DATA_SINC'
      Origin = 'DATA_SINC'
    end
  end
  object qryAux: TFDQuery
    Connection = Conexao
    Left = 192
    Top = 96
  end
  object qryProdutos: TFDQuery
    Connection = Conexao
    SQL.Strings = (
      'select * from TB_PRODUTO order by Descricao')
    Left = 120
    Top = 152
    object qryProdutosCODIGO: TStringField
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      Required = True
      Size = 6
    end
    object qryProdutosDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Size = 50
    end
    object qryProdutosDESCRICAO_RED: TStringField
      FieldName = 'DESCRICAO_RED'
      Origin = 'DESCRICAO_RED'
      Size = 30
    end
    object qryProdutosBARRAS: TStringField
      FieldName = 'BARRAS'
      Origin = 'BARRAS'
      Size = 15
    end
    object qryProdutosUNIDADE: TStringField
      FieldName = 'UNIDADE'
      Origin = 'UNIDADE'
      FixedChar = True
      Size = 2
    end
    object qryProdutosPRECO_VENDA: TBCDField
      FieldName = 'PRECO_VENDA'
      Origin = 'PRECO_VENDA'
      Precision = 15
      Size = 2
    end
    object qryProdutosINFO_ADIC: TBlobField
      FieldName = 'INFO_ADIC'
      Origin = 'INFO_ADIC'
    end
    object qryProdutosIMAGEM: TBlobField
      FieldName = 'IMAGEM'
      Origin = 'IMAGEM'
    end
    object qryProdutosPRECO_MIN: TBCDField
      FieldName = 'PRECO_MIN'
      Origin = 'PRECO_MIN'
      Precision = 15
      Size = 2
    end
    object qryProdutosPRECO_ATACADO: TBCDField
      FieldName = 'PRECO_ATACADO'
      Origin = 'PRECO_ATACADO'
      Precision = 15
      Size = 2
    end
    object qryProdutosPRECO_COMPRA: TBCDField
      FieldName = 'PRECO_COMPRA'
      Origin = 'PRECO_COMPRA'
      Precision = 15
      Size = 2
    end
  end
  object ClientProdutos: TRESTClient
    Authenticator = HTTPBasicAuthenticator1
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    AcceptEncoding = 'identity'
    Params = <>
    Left = 520
    Top = 16
  end
  object ResponseProdutos: TRESTResponse
    Left = 520
    Top = 64
  end
  object RequestProdutos: TRESTRequest
    Client = ClientProdutos
    Params = <>
    Response = ResponseProdutos
    SynchronizedEvents = False
    Left = 520
    Top = 112
  end
  object memProdutos: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 520
    Top = 160
  end
  object dsProdutos: TDataSource
    DataSet = memProdutos
    Left = 520
    Top = 208
  end
  object qryPedidos: TFDQuery
    Connection = Conexao
    SQL.Strings = (
      'select * from TB_PEDIDO')
    Left = 48
    Top = 208
    object qryPedidosCODIGO: TStringField
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      Required = True
      Size = 50
    end
    object qryPedidosDATA_PEDIDO: TSQLTimeStampField
      FieldName = 'DATA_PEDIDO'
      Origin = 'DATA_PEDIDO'
    end
    object qryPedidosVENDEDOR: TStringField
      FieldName = 'VENDEDOR'
      Origin = 'VENDEDOR'
      Size = 3
    end
    object qryPedidosTIPO: TStringField
      FieldName = 'TIPO'
      Origin = 'TIPO'
      FixedChar = True
      Size = 1
    end
    object qryPedidosTOTAL_PEDIDO: TBCDField
      FieldName = 'TOTAL_PEDIDO'
      Origin = 'TOTAL_PEDIDO'
      Precision = 15
      Size = 2
    end
    object qryPedidosOBS: TBlobField
      FieldName = 'OBS'
      Origin = 'OBS'
    end
    object qryPedidosDATA_SINC: TSQLTimeStampField
      FieldName = 'DATA_SINC'
      Origin = 'DATA_SINC'
    end
    object qryPedidosCLIENTE: TStringField
      FieldName = 'CLIENTE'
      Origin = 'CLIENTE'
      Size = 10
    end
    object qryPedidosCOD_PAGTO: TIntegerField
      FieldName = 'COD_PAGTO'
      Origin = 'COD_PAGTO'
    end
  end
  object qryItensPedido: TFDQuery
    Connection = Conexao
    SQL.Strings = (
      'select * from TB_ITENS_PEDIDO')
    Left = 120
    Top = 208
    object qryItensPedidoSEQ: TIntegerField
      FieldName = 'SEQ'
      Origin = 'SEQ'
      Required = True
    end
    object qryItensPedidoCOD_PEDIDO: TStringField
      FieldName = 'COD_PEDIDO'
      Origin = 'COD_PEDIDO'
      Required = True
      Size = 50
    end
    object qryItensPedidoTIPO: TStringField
      FieldName = 'TIPO'
      Origin = 'TIPO'
      FixedChar = True
      Size = 1
    end
    object qryItensPedidoCOD_PRODUTO: TStringField
      FieldName = 'COD_PRODUTO'
      Origin = 'COD_PRODUTO'
      Size = 6
    end
    object qryItensPedidoQTD: TFloatField
      FieldName = 'QTD'
      Origin = 'QTD'
    end
    object qryItensPedidoVALOR_UNITARIO: TBCDField
      FieldName = 'VALOR_UNITARIO'
      Origin = 'VALOR_UNITARIO'
      Precision = 15
      Size = 2
    end
    object qryItensPedidoVALOR_TOTAL: TBCDField
      FieldName = 'VALOR_TOTAL'
      Origin = 'VALOR_TOTAL'
      Precision = 15
      Size = 2
    end
  end
  object ClientCondicao: TRESTClient
    Authenticator = HTTPBasicAuthenticator1
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    AcceptEncoding = 'identity'
    Params = <>
    Left = 592
    Top = 16
  end
  object ResponseCondicao: TRESTResponse
    Left = 592
    Top = 64
  end
  object RequestCondicao: TRESTRequest
    Client = ClientCondicao
    Params = <>
    Response = ResponseCondicao
    SynchronizedEvents = False
    Left = 592
    Top = 112
  end
  object memCondicao: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 592
    Top = 160
  end
  object dsCondicao: TDataSource
    DataSet = memCondicao
    Left = 592
    Top = 208
  end
  object qryCondicaoPagto: TFDQuery
    Connection = Conexao
    SQL.Strings = (
      'select * from TB_COND_PAGTO')
    Left = 192
    Top = 152
    object qryCondicaoPagtoCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryCondicaoPagtoDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Size = 50
    end
  end
  object memItens: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 664
    Top = 160
    object memItensSEQ: TIntegerField
      FieldName = 'SEQ'
    end
    object memItensCOD_PRODUTO: TStringField
      FieldName = 'COD_PRODUTO'
      Size = 10
    end
    object memItensDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 50
    end
    object memItensQTD: TFloatField
      FieldName = 'QTD'
    end
    object memItensVLR_UNITARIO: TCurrencyField
      FieldName = 'VLR_UNITARIO'
    end
    object memItensVLR_TOTAL: TCurrencyField
      FieldName = 'VLR_TOTAL'
    end
  end
  object ClientPedidos: TRESTClient
    Authenticator = HTTPBasicAuthenticator1
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    AcceptEncoding = 'identity'
    Params = <>
    Left = 664
    Top = 16
  end
  object ResponsePedidos: TRESTResponse
    Left = 664
    Top = 64
  end
  object RequestPedidos: TRESTRequest
    Client = ClientPedidos
    Params = <>
    Response = ResponsePedidos
    SynchronizedEvents = False
    Left = 664
    Top = 112
  end
  object memUsuario: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 736
    Top = 160
  end
  object dsUsuario: TDataSource
    DataSet = memUsuario
    Left = 736
    Top = 208
  end
  object RequestUsuario: TRESTRequest
    Client = ClientUsuario
    Params = <>
    Response = ResponseUsuario
    SynchronizedEvents = False
    Left = 736
    Top = 112
  end
  object ResponseUsuario: TRESTResponse
    Left = 736
    Top = 64
  end
  object ClientUsuario: TRESTClient
    Authenticator = HTTPBasicAuthenticator1
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    AcceptEncoding = 'identity'
    Params = <>
    Left = 736
    Top = 16
  end
  object qryUsuario: TFDQuery
    Connection = Conexao
    SQL.Strings = (
      'select * from TB_USUARIO')
    Left = 192
    Top = 208
    object qryUsuarioCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qryUsuarioNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 50
    end
    object qryUsuarioLOGIN: TStringField
      FieldName = 'LOGIN'
      Origin = 'LOGIN'
      Size = 40
    end
    object qryUsuarioSENHA: TStringField
      FieldName = 'SENHA'
      Origin = 'SENHA'
      Size = 50
    end
  end
  object memReceber: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 808
    Top = 160
  end
  object dsReceber: TDataSource
    DataSet = memReceber
    Left = 808
    Top = 208
  end
  object RequestReceber: TRESTRequest
    Client = ClientReceber
    Params = <>
    Response = ResponseReceber
    SynchronizedEvents = False
    Left = 808
    Top = 112
  end
  object ResponseReceber: TRESTResponse
    Left = 808
    Top = 64
  end
  object ClientReceber: TRESTClient
    Authenticator = HTTPBasicAuthenticator1
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    AcceptEncoding = 'identity'
    Params = <>
    Left = 808
    Top = 16
  end
  object qryReceber: TFDQuery
    Connection = Conexao
    SQL.Strings = (
      'select * from TB_RECEBER')
    Left = 48
    Top = 264
    object qryReceberCOD_EMP: TIntegerField
      FieldName = 'COD_EMP'
      Origin = 'COD_EMP'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryReceberCOD_CLIENTE: TIntegerField
      FieldName = 'COD_CLIENTE'
      Origin = 'COD_CLIENTE'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryReceberNUM_FAT: TIntegerField
      FieldName = 'NUM_FAT'
      Origin = 'NUM_FAT'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryReceberNUM_PARC: TIntegerField
      FieldName = 'NUM_PARC'
      Origin = 'NUM_PARC'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryReceberNOM_CLIENTE: TStringField
      FieldName = 'NOM_CLIENTE'
      Origin = 'NOM_CLIENTE'
      Required = True
      Size = 60
    end
    object qryReceberSITUACAO: TStringField
      FieldName = 'SITUACAO'
      Origin = 'SITUACAO'
      Required = True
      Size = 1
    end
    object qryReceberDATA_EMISSAO: TSQLTimeStampField
      FieldName = 'DATA_EMISSAO'
      Origin = 'DATA_EMISSAO'
      Required = True
    end
    object qryReceberDATA_VENCTO: TSQLTimeStampField
      FieldName = 'DATA_VENCTO'
      Origin = 'DATA_VENCTO'
      Required = True
    end
    object qryReceberCOD_PORT: TIntegerField
      FieldName = 'COD_PORT'
      Origin = 'COD_PORT'
      Required = True
    end
    object qryReceberCOD_MOEDA: TIntegerField
      FieldName = 'COD_MOEDA'
      Origin = 'COD_MOEDA'
    end
    object qryReceberVLR_FATURA: TBCDField
      FieldName = 'VLR_FATURA'
      Origin = 'VLR_FATURA'
      Required = True
      Precision = 16
      Size = 2
    end
    object qryReceberTIP_DOC: TShortintField
      FieldName = 'TIP_DOC'
      Origin = 'TIP_DOC'
      Required = True
    end
    object qryReceberNUM_DOC: TIntegerField
      FieldName = 'NUM_DOC'
      Origin = 'NUM_DOC'
    end
    object qryReceberUSUARIO: TIntegerField
      FieldName = 'USUARIO'
      Origin = 'USUARIO'
      Required = True
    end
    object qryReceberCOD_VEND: TIntegerField
      FieldName = 'COD_VEND'
      Origin = 'COD_VEND'
    end
    object qryReceberNUM_NOTA: TIntegerField
      FieldName = 'NUM_NOTA'
      Origin = 'NUM_NOTA'
    end
    object qryReceberNUM_MOV: TIntegerField
      FieldName = 'NUM_MOV'
      Origin = 'NUM_MOV'
    end
    object qryReceberDATA_MOV: TSQLTimeStampField
      FieldName = 'DATA_MOV'
      Origin = 'DATA_MOV'
    end
  end
  object qryReceberRec: TFDQuery
    Connection = Conexao
    SQL.Strings = (
      'select * from TB_RECEBER_REC')
    Left = 120
    Top = 264
    object qryReceberRecCOD_PAGTO: TStringField
      FieldName = 'COD_PAGTO'
      Origin = 'COD_PAGTO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 40
    end
    object qryReceberRecCOD_EMP: TIntegerField
      FieldName = 'COD_EMP'
      Origin = 'COD_EMP'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryReceberRecCOD_CLIENTE: TIntegerField
      FieldName = 'COD_CLIENTE'
      Origin = 'COD_CLIENTE'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryReceberRecNUM_FAT: TIntegerField
      FieldName = 'NUM_FAT'
      Origin = 'NUM_FAT'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryReceberRecNUM_PARC: TIntegerField
      FieldName = 'NUM_PARC'
      Origin = 'NUM_PARC'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryReceberRecDATA_REC: TSQLTimeStampField
      FieldName = 'DATA_REC'
      Origin = 'DATA_REC'
    end
    object qryReceberRecVLR_RECEBIDO: TBCDField
      FieldName = 'VLR_RECEBIDO'
      Origin = 'VLR_RECEBIDO'
      Precision = 16
      Size = 2
    end
    object qryReceberRecUSU_REC: TIntegerField
      FieldName = 'USU_REC'
      Origin = 'USU_REC'
    end
    object qryReceberRecSIT_CONTROLE: TStringField
      FieldName = 'SIT_CONTROLE'
      Origin = 'SIT_CONTROLE'
      Size = 1
    end
  end
end
