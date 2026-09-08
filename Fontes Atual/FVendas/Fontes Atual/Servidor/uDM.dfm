object DM: TDM
  OldCreateOrder = False
  Height = 571
  Width = 744
  object ConexaoFB: TFDConnection
    Params.Strings = (
      'User_Name=sysdba'
      'Password=masterkey'
      
        'Database=D:\Github\Freenlancer\ClaudineiCamargo\Fontes Atual\Bin' +
        '\Dados\FB_DADOS.FDB'
      'Protocol=TCPIP'
      'Server=127.0.0.1'
      'Port=3050'
      'DriverID=FB')
    LoginPrompt = False
    BeforeConnect = ConexaoFBBeforeConnect
    Left = 48
    Top = 16
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 592
    Top = 80
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    VendorLib = 'C:\Program Files (x86)\Firebird\Firebird_2_5\bin\fbclient.dll'
    Left = 592
    Top = 24
  end
  object qryVendedoresFB: TFDQuery
    Connection = ConexaoFB
    SQL.Strings = (
      'select * from TB_VENDEDOR')
    Left = 48
    Top = 80
    object qryVendedoresFBCODIGO: TStringField
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 3
    end
    object qryVendedoresFBNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 50
    end
    object qryVendedoresFBUSUARIO: TStringField
      FieldName = 'USUARIO'
      Origin = 'USUARIO'
      Size = 50
    end
    object qryVendedoresFBSENHA: TStringField
      FieldName = 'SENHA'
      Origin = 'SENHA'
      Size = 50
    end
    object qryVendedoresFBEMAIL: TStringField
      FieldName = 'EMAIL'
      Origin = 'EMAIL'
      Size = 80
    end
    object qryVendedoresFBPORC_DESC: TSingleField
      FieldName = 'PORC_DESC'
      Origin = 'PORC_DESC'
    end
    object qryVendedoresFBPORC_ADIC: TSingleField
      FieldName = 'PORC_ADIC'
      Origin = 'PORC_ADIC'
    end
    object qryVendedoresFBPORC_DESC_ITEM: TSingleField
      FieldName = 'PORC_DESC_ITEM'
      Origin = 'PORC_DESC_ITEM'
    end
    object qryVendedoresFBCAD_CLI: TStringField
      FieldName = 'CAD_CLI'
      Origin = 'CAD_CLI'
      FixedChar = True
      Size = 1
    end
    object qryVendedoresFBCAD_PED: TStringField
      FieldName = 'CAD_PED'
      Origin = 'CAD_PED'
      FixedChar = True
      Size = 1
    end
    object qryVendedoresFBBONIFICA: TStringField
      FieldName = 'BONIFICA'
      Origin = 'BONIFICA'
      FixedChar = True
      Size = 1
    end
    object qryVendedoresFBACESSO: TStringField
      FieldName = 'ACESSO'
      Origin = 'ACESSO'
      FixedChar = True
      Size = 1
    end
  end
  object ConexaoCli: TFDConnection
    Params.Strings = (
      
        'Database=D:\Github\Freenlancer\ClaudineiCamargo\Fontes Atual\Bin' +
        '\Dados\CLI_DADOS.FDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'Protocol=TCPIP'
      'Server=127.0.0.1'
      'Port=3050'
      'DriverID=FB')
    LoginPrompt = False
    BeforeConnect = ConexaoCliBeforeConnect
    Left = 336
    Top = 16
  end
  object qryProdutosCli: TFDQuery
    Connection = ConexaoCli
    SQL.Strings = (
      'select * from V_PRD_PRDVL_FV')
    Left = 336
    Top = 128
    object qryProdutosCliCODPROD: TIntegerField
      FieldName = 'CODPROD'
      Origin = 'CODPROD'
    end
    object qryProdutosCliDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Size = 30
    end
    object qryProdutosCliDESCCOMPLETA: TStringField
      FieldName = 'DESCCOMPLETA'
      Origin = 'DESCCOMPLETA'
      Size = 150
    end
    object qryProdutosCliUNIDMEDIDA: TStringField
      FieldName = 'UNIDMEDIDA'
      Origin = 'UNIDMEDIDA'
      Size = 3
    end
    object qryProdutosCliCODBAR: TStringField
      FieldName = 'CODBAR'
      Origin = 'CODBAR'
      Size = 40
    end
    object qryProdutosCliVLVENDA: TBCDField
      FieldName = 'VLVENDA'
      Origin = 'VLVENDA'
      Precision = 18
    end
    object qryProdutosCliVLVENDAMIN: TBCDField
      FieldName = 'VLVENDAMIN'
      Origin = 'VLVENDAMIN'
      Precision = 18
    end
    object qryProdutosCliVLVENDAATACADO: TBCDField
      FieldName = 'VLVENDAATACADO'
      Origin = 'VLVENDAATACADO'
      Precision = 18
    end
    object qryProdutosCliVLCTOULTCOMP: TFMTBCDField
      FieldName = 'VLCTOULTCOMP'
      Origin = 'VLCTOULTCOMP'
      Precision = 18
      Size = 6
    end
  end
  object qryProdutosFB: TFDQuery
    Connection = ConexaoFB
    SQL.Strings = (
      'select * from TB_PRODUTO')
    Left = 48
    Top = 128
    object qryProdutosFBCODIGO: TStringField
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      Required = True
      Size = 6
    end
    object qryProdutosFBDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Size = 50
    end
    object qryProdutosFBDESCRICAO_RED: TStringField
      FieldName = 'DESCRICAO_RED'
      Origin = 'DESCRICAO_RED'
      Size = 30
    end
    object qryProdutosFBBARRAS: TStringField
      FieldName = 'BARRAS'
      Origin = 'BARRAS'
      Size = 15
    end
    object qryProdutosFBUNIDADE: TStringField
      FieldName = 'UNIDADE'
      Origin = 'UNIDADE'
      FixedChar = True
      Size = 2
    end
    object qryProdutosFBPRECO_VENDA: TFMTBCDField
      FieldName = 'PRECO_VENDA'
      Origin = 'PRECO_VENDA'
      Precision = 18
      Size = 2
    end
    object qryProdutosFBINFO_ADIC: TBlobField
      FieldName = 'INFO_ADIC'
      Origin = 'INFO_ADIC'
    end
    object qryProdutosFBIMAGEM: TBlobField
      FieldName = 'IMAGEM'
      Origin = 'IMAGEM'
    end
    object qryProdutosFBPRECO_MIN: TFMTBCDField
      FieldName = 'PRECO_MIN'
      Origin = 'PRECO_MIN'
      Precision = 18
      Size = 2
    end
    object qryProdutosFBPRECO_ATACADO: TFMTBCDField
      FieldName = 'PRECO_ATACADO'
      Origin = 'PRECO_ATACADO'
      Precision = 18
      Size = 2
    end
    object qryProdutosFBPRECO_COMPRA: TFMTBCDField
      FieldName = 'PRECO_COMPRA'
      Origin = 'PRECO_COMPRA'
      Precision = 18
      Size = 2
    end
  end
  object qryClientesCli: TFDQuery
    Connection = ConexaoCli
    SQL.Strings = (
      'select * from V_CAD_CLIENTE')
    Left = 336
    Top = 176
    object qryClientesCliCODCLIENTE: TIntegerField
      FieldName = 'CODCLIENTE'
      Origin = 'CODCLIENTE'
    end
    object qryClientesCliNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 60
    end
    object qryClientesCliRAZAOSOCIAL: TStringField
      FieldName = 'RAZAOSOCIAL'
      Origin = 'RAZAOSOCIAL'
      Size = 60
    end
    object qryClientesCliTIPOCADASTRO: TStringField
      FieldName = 'TIPOCADASTRO'
      Origin = 'TIPOCADASTRO'
      Size = 1
    end
    object qryClientesCliTIPOCLIENTE: TSmallintField
      FieldName = 'TIPOCLIENTE'
      Origin = 'TIPOCLIENTE'
    end
    object qryClientesCliDESCRTIPOCLIENTE: TStringField
      FieldName = 'DESCRTIPOCLIENTE'
      Origin = 'DESCRTIPOCLIENTE'
      Size = 40
    end
    object qryClientesCliTIPOFISCAL: TStringField
      FieldName = 'TIPOFISCAL'
      Origin = 'TIPOFISCAL'
      Size = 1
    end
    object qryClientesCliSEXO: TStringField
      FieldName = 'SEXO'
      Origin = 'SEXO'
      Size = 1
    end
    object qryClientesCliESTADOCIVIL: TSmallintField
      FieldName = 'ESTADOCIVIL'
      Origin = 'ESTADOCIVIL'
    end
    object qryClientesCliDATANASCFUND: TDateField
      FieldName = 'DATANASCFUND'
      Origin = 'DATANASCFUND'
    end
    object qryClientesCliINATIVO: TStringField
      FieldName = 'INATIVO'
      Origin = 'INATIVO'
      Size = 1
    end
    object qryClientesCliCODREGVEN: TIntegerField
      FieldName = 'CODREGVEN'
      Origin = 'CODREGVEN'
    end
    object qryClientesCliNOMEREGVEN: TStringField
      FieldName = 'NOMEREGVEN'
      Origin = 'NOMEREGVEN'
      Size = 40
    end
    object qryClientesCliCODVEND: TIntegerField
      FieldName = 'CODVEND'
      Origin = 'CODVEND'
    end
    object qryClientesCliNOMEVEND: TStringField
      FieldName = 'NOMEVEND'
      Origin = 'NOMEVEND'
      Size = 40
    end
    object qryClientesCliATACVAR: TStringField
      FieldName = 'ATACVAR'
      Origin = 'ATACVAR'
      Size = 1
    end
    object qryClientesCliENDERTPLOGRAD: TStringField
      FieldName = 'ENDERTPLOGRAD'
      Origin = 'ENDERTPLOGRAD'
      Size = 10
    end
    object qryClientesCliENDERLOGRAD: TStringField
      FieldName = 'ENDERLOGRAD'
      Origin = 'ENDERLOGRAD'
      Size = 100
    end
    object qryClientesCliENDERNUMLOGRAD: TStringField
      FieldName = 'ENDERNUMLOGRAD'
      Origin = 'ENDERNUMLOGRAD'
      Size = 10
    end
    object qryClientesCliENDERCOMPLEMENTO: TStringField
      FieldName = 'ENDERCOMPLEMENTO'
      Origin = 'ENDERCOMPLEMENTO'
      Size = 15
    end
    object qryClientesCliENDERBAIRRO: TStringField
      FieldName = 'ENDERBAIRRO'
      Origin = 'ENDERBAIRRO'
      Size = 30
    end
    object qryClientesCliCODCIDADE: TIntegerField
      FieldName = 'CODCIDADE'
      Origin = 'CODCIDADE'
    end
    object qryClientesCliNOMECIDADE: TStringField
      FieldName = 'NOMECIDADE'
      Origin = 'NOMECIDADE'
      Size = 60
    end
    object qryClientesCliCODPAIS: TStringField
      FieldName = 'CODPAIS'
      Origin = 'CODPAIS'
      Size = 3
    end
    object qryClientesCliCODUF: TStringField
      FieldName = 'CODUF'
      Origin = 'CODUF'
      Size = 2
    end
    object qryClientesCliCEP: TStringField
      FieldName = 'CEP'
      Origin = 'CEP'
      Size = 10
    end
    object qryClientesCliDOCFISCAL: TStringField
      FieldName = 'DOCFISCAL'
      Origin = 'DOCFISCAL'
    end
    object qryClientesCliDOCFISCAL2: TStringField
      FieldName = 'DOCFISCAL2'
      Origin = 'DOCFISCAL2'
    end
    object qryClientesCliDOCIDENTIDADE: TStringField
      FieldName = 'DOCIDENTIDADE'
      Origin = 'DOCIDENTIDADE'
    end
    object qryClientesCliTIPOTELEFONE1: TStringField
      FieldName = 'TIPOTELEFONE1'
      Origin = 'TIPOTELEFONE1'
    end
    object qryClientesCliTIPOTELEFONE2: TStringField
      FieldName = 'TIPOTELEFONE2'
      Origin = 'TIPOTELEFONE2'
    end
    object qryClientesCliTIPOTELEFONE3: TStringField
      FieldName = 'TIPOTELEFONE3'
      Origin = 'TIPOTELEFONE3'
    end
    object qryClientesCliNUMTELEFONE1: TStringField
      FieldName = 'NUMTELEFONE1'
      Origin = 'NUMTELEFONE1'
    end
    object qryClientesCliNUMTELEFONE2: TStringField
      FieldName = 'NUMTELEFONE2'
      Origin = 'NUMTELEFONE2'
    end
    object qryClientesCliNUMTELEFONE3: TStringField
      FieldName = 'NUMTELEFONE3'
      Origin = 'NUMTELEFONE3'
    end
    object qryClientesCliPESSOACONTATO: TStringField
      FieldName = 'PESSOACONTATO'
      Origin = 'PESSOACONTATO'
      Size = 30
    end
    object qryClientesCliEMAIL1: TStringField
      FieldName = 'EMAIL1'
      Origin = 'EMAIL1'
      Size = 100
    end
    object qryClientesCliEMAIL2: TStringField
      FieldName = 'EMAIL2'
      Origin = 'EMAIL2'
      Size = 100
    end
    object qryClientesCliNOMEPAI: TStringField
      FieldName = 'NOMEPAI'
      Origin = 'NOMEPAI'
      Size = 60
    end
    object qryClientesCliNOMEMAE: TStringField
      FieldName = 'NOMEMAE'
      Origin = 'NOMEMAE'
      Size = 60
    end
    object qryClientesCliNOMECONJUGE: TStringField
      FieldName = 'NOMECONJUGE'
      Origin = 'NOMECONJUGE'
      Size = 60
    end
    object qryClientesCliNACIONALIDADE: TStringField
      FieldName = 'NACIONALIDADE'
      Origin = 'NACIONALIDADE'
    end
    object qryClientesCliFOTO: TStringField
      FieldName = 'FOTO'
      Origin = 'FOTO'
      Size = 100
    end
    object qryClientesCliOBS: TStringField
      FieldName = 'OBS'
      Origin = 'OBS'
      Size = 1000
    end
    object qryClientesCliPROFISSAO: TStringField
      FieldName = 'PROFISSAO'
      Origin = 'PROFISSAO'
      Size = 40
    end
    object qryClientesCliNOMEEMPPROF: TStringField
      FieldName = 'NOMEEMPPROF'
      Origin = 'NOMEEMPPROF'
      Size = 40
    end
    object qryClientesCliNUMTELEFONEEMP: TStringField
      FieldName = 'NUMTELEFONEEMP'
      Origin = 'NUMTELEFONEEMP'
    end
    object qryClientesCliTEMPOEMP: TStringField
      FieldName = 'TEMPOEMP'
      Origin = 'TEMPOEMP'
      Size = 10
    end
    object qryClientesCliGRAUESC: TSmallintField
      FieldName = 'GRAUESC'
      Origin = 'GRAUESC'
    end
    object qryClientesCliCODTIPOCLIENTE: TIntegerField
      FieldName = 'CODTIPOCLIENTE'
      Origin = 'CODTIPOCLIENTE'
    end
    object qryClientesCliUSUINC: TIntegerField
      FieldName = 'USUINC'
      Origin = 'USUINC'
    end
    object qryClientesCliDATAINC: TSQLTimeStampField
      FieldName = 'DATAINC'
      Origin = 'DATAINC'
    end
    object qryClientesCliCODEMPINC: TIntegerField
      FieldName = 'CODEMPINC'
      Origin = 'CODEMPINC'
    end
    object qryClientesCliUSUARIO: TIntegerField
      FieldName = 'USUARIO'
      Origin = 'USUARIO'
    end
    object qryClientesCliDATAATU: TDateField
      FieldName = 'DATAATU'
      Origin = 'DATAATU'
    end
    object qryClientesCliHORAATU: TStringField
      FieldName = 'HORAATU'
      Origin = 'HORAATU'
      Size = 8
    end
  end
  object qryClientesFB: TFDQuery
    Connection = ConexaoFB
    SQL.Strings = (
      'select * from TB_CLIENTE')
    Left = 48
    Top = 176
    object qryClientesFBCODIGO: TStringField
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 6
    end
    object qryClientesFBCODIGO_MOBILE: TStringField
      FieldName = 'CODIGO_MOBILE'
      Origin = 'CODIGO_MOBILE'
      Size = 50
    end
    object qryClientesFBTIPO: TStringField
      FieldName = 'TIPO'
      Origin = 'TIPO'
      FixedChar = True
      Size = 1
    end
    object qryClientesFBNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 50
    end
    object qryClientesFBFANTASIA: TStringField
      FieldName = 'FANTASIA'
      Origin = 'FANTASIA'
      Size = 50
    end
    object qryClientesFBCNPJ_CPF: TStringField
      FieldName = 'CNPJ_CPF'
      Origin = 'CNPJ_CPF'
      Size = 14
    end
    object qryClientesFBIE_RG: TStringField
      FieldName = 'IE_RG'
      Origin = 'IE_RG'
      Size = 15
    end
    object qryClientesFBLOGRADOURO: TStringField
      FieldName = 'LOGRADOURO'
      Origin = 'LOGRADOURO'
      Size = 50
    end
    object qryClientesFBNUMERO: TStringField
      FieldName = 'NUMERO'
      Origin = 'NUMERO'
      Size = 10
    end
    object qryClientesFBBAIRRO: TStringField
      FieldName = 'BAIRRO'
      Origin = 'BAIRRO'
      Size = 50
    end
    object qryClientesFBCOMPLEMENTO: TStringField
      FieldName = 'COMPLEMENTO'
      Origin = 'COMPLEMENTO'
      Size = 50
    end
    object qryClientesFBCIDADE_IBGE: TStringField
      FieldName = 'CIDADE_IBGE'
      Origin = 'CIDADE_IBGE'
      Size = 10
    end
    object qryClientesFBCIDADE_DESCRICAO: TStringField
      FieldName = 'CIDADE_DESCRICAO'
      Origin = 'CIDADE_DESCRICAO'
      Size = 50
    end
    object qryClientesFBUF: TStringField
      FieldName = 'UF'
      Origin = 'UF'
      Size = 2
    end
    object qryClientesFBTELEFONE: TStringField
      FieldName = 'TELEFONE'
      Origin = 'TELEFONE'
      Size = 15
    end
    object qryClientesFBCOMERCIAL: TStringField
      FieldName = 'COMERCIAL'
      Origin = 'COMERCIAL'
      Size = 15
    end
    object qryClientesFBCELULAR: TStringField
      FieldName = 'CELULAR'
      Origin = 'CELULAR'
      Size = 15
    end
    object qryClientesFBWATSAPP: TStringField
      FieldName = 'WATSAPP'
      Origin = 'WATSAPP'
      Size = 15
    end
    object qryClientesFBCONTATO: TStringField
      FieldName = 'CONTATO'
      Origin = 'CONTATO'
      Size = 30
    end
    object qryClientesFBEMAIL1: TStringField
      FieldName = 'EMAIL1'
      Origin = 'EMAIL1'
      Size = 80
    end
    object qryClientesFBEMAIL2: TStringField
      FieldName = 'EMAIL2'
      Origin = 'EMAIL2'
      Size = 80
    end
    object qryClientesFBATIVIDADE: TStringField
      FieldName = 'ATIVIDADE'
      Origin = 'ATIVIDADE'
      Size = 50
    end
    object qryClientesFBOBS: TBlobField
      FieldName = 'OBS'
      Origin = 'OBS'
    end
    object qryClientesFBLIMITE_COMPRA_PED: TFMTBCDField
      FieldName = 'LIMITE_COMPRA_PED'
      Origin = 'LIMITE_COMPRA_PED'
      Precision = 18
      Size = 2
    end
    object qryClientesFBDIAS_BLOQ_ATRASO: TIntegerField
      FieldName = 'DIAS_BLOQ_ATRASO'
      Origin = 'DIAS_BLOQ_ATRASO'
    end
    object qryClientesFBDATA_SINC: TSQLTimeStampField
      FieldName = 'DATA_SINC'
      Origin = 'DATA_SINC'
    end
  end
  object qryCondPagtoFB: TFDQuery
    Connection = ConexaoFB
    SQL.Strings = (
      'select * from TB_COND_PAGTO')
    Left = 48
    Top = 272
    object qryCondPagtoFBCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryCondPagtoFBDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Size = 50
    end
  end
  object memPedidos: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 240
    Top = 320
  end
  object qryPedidosFB: TFDQuery
    Connection = ConexaoFB
    SQL.Strings = (
      'select * from TB_PEDIDO')
    Left = 48
    Top = 320
    object qryPedidosFBCODIGO: TStringField
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 50
    end
    object qryPedidosFBDATA_PEDIDO: TSQLTimeStampField
      FieldName = 'DATA_PEDIDO'
      Origin = 'DATA_PEDIDO'
    end
    object qryPedidosFBVENDEDOR: TStringField
      FieldName = 'VENDEDOR'
      Origin = 'VENDEDOR'
      Size = 3
    end
    object qryPedidosFBTIPO: TStringField
      FieldName = 'TIPO'
      Origin = 'TIPO'
      FixedChar = True
      Size = 1
    end
    object qryPedidosFBTOTAL_PEDIDO: TFMTBCDField
      FieldName = 'TOTAL_PEDIDO'
      Origin = 'TOTAL_PEDIDO'
      Precision = 18
      Size = 2
    end
    object qryPedidosFBOBS: TBlobField
      FieldName = 'OBS'
      Origin = 'OBS'
    end
    object qryPedidosFBDATA_SINC: TSQLTimeStampField
      FieldName = 'DATA_SINC'
      Origin = 'DATA_SINC'
    end
    object qryPedidosFBCLIENTE: TStringField
      FieldName = 'CLIENTE'
      Origin = 'CLIENTE'
      Size = 10
    end
    object qryPedidosFBCOD_PAGTO: TIntegerField
      FieldName = 'COD_PAGTO'
      Origin = 'COD_PAGTO'
    end
    object qryPedidosFBENV: TStringField
      FieldName = 'ENV'
      Origin = 'ENV'
      FixedChar = True
      Size = 1
    end
    object qryPedidosFBCODEMP: TIntegerField
      FieldName = 'CODEMP'
      Origin = 'CODEMP'
    end
  end
  object qryItensPedidoFB: TFDQuery
    Connection = ConexaoFB
    SQL.Strings = (
      'select * from TB_ITENS_PEDIDO')
    Left = 48
    Top = 368
    object qryItensPedidoFBSEQ: TIntegerField
      FieldName = 'SEQ'
      Origin = 'SEQ'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryItensPedidoFBCOD_PEDIDO: TStringField
      FieldName = 'COD_PEDIDO'
      Origin = 'COD_PEDIDO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 50
    end
    object qryItensPedidoFBTIPO: TStringField
      FieldName = 'TIPO'
      Origin = 'TIPO'
      FixedChar = True
      Size = 1
    end
    object qryItensPedidoFBCOD_PRODUTO: TStringField
      FieldName = 'COD_PRODUTO'
      Origin = 'COD_PRODUTO'
      Size = 6
    end
    object qryItensPedidoFBQTD: TSingleField
      FieldName = 'QTD'
      Origin = 'QTD'
    end
    object qryItensPedidoFBVALOR_UNITARIO: TFMTBCDField
      FieldName = 'VALOR_UNITARIO'
      Origin = 'VALOR_UNITARIO'
      Precision = 18
      Size = 2
    end
    object qryItensPedidoFBVALOR_TOTAL: TFMTBCDField
      FieldName = 'VALOR_TOTAL'
      Origin = 'VALOR_TOTAL'
      Precision = 18
      Size = 2
    end
  end
  object AtuaItensFB: TFDQuery
    Connection = ConexaoFB
    SQL.Strings = (
      'select * from TB_ITENS_PEDIDO')
    Left = 144
    Top = 368
    object AtuaItensFBSEQ: TIntegerField
      FieldName = 'SEQ'
      Origin = 'SEQ'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object AtuaItensFBCOD_PEDIDO: TStringField
      FieldName = 'COD_PEDIDO'
      Origin = 'COD_PEDIDO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 50
    end
    object AtuaItensFBTIPO: TStringField
      FieldName = 'TIPO'
      Origin = 'TIPO'
      FixedChar = True
      Size = 1
    end
    object AtuaItensFBCOD_PRODUTO: TStringField
      FieldName = 'COD_PRODUTO'
      Origin = 'COD_PRODUTO'
      Size = 6
    end
    object AtuaItensFBQTD: TSingleField
      FieldName = 'QTD'
      Origin = 'QTD'
    end
    object AtuaItensFBVALOR_UNITARIO: TFMTBCDField
      FieldName = 'VALOR_UNITARIO'
      Origin = 'VALOR_UNITARIO'
      Precision = 18
      Size = 2
    end
    object AtuaItensFBVALOR_TOTAL: TFMTBCDField
      FieldName = 'VALOR_TOTAL'
      Origin = 'VALOR_TOTAL'
      Precision = 18
      Size = 2
    end
  end
  object AtuaPedidoFB: TFDQuery
    Connection = ConexaoFB
    SQL.Strings = (
      'select * from TB_PEDIDO')
    Left = 144
    Top = 320
    object AtuaPedidoFBCODIGO: TStringField
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 50
    end
    object AtuaPedidoFBDATA_PEDIDO: TSQLTimeStampField
      FieldName = 'DATA_PEDIDO'
      Origin = 'DATA_PEDIDO'
    end
    object AtuaPedidoFBVENDEDOR: TStringField
      FieldName = 'VENDEDOR'
      Origin = 'VENDEDOR'
      Size = 3
    end
    object AtuaPedidoFBTIPO: TStringField
      FieldName = 'TIPO'
      Origin = 'TIPO'
      FixedChar = True
      Size = 1
    end
    object AtuaPedidoFBTOTAL_PEDIDO: TFMTBCDField
      FieldName = 'TOTAL_PEDIDO'
      Origin = 'TOTAL_PEDIDO'
      Precision = 18
      Size = 2
    end
    object AtuaPedidoFBOBS: TBlobField
      FieldName = 'OBS'
      Origin = 'OBS'
    end
    object AtuaPedidoFBDATA_SINC: TSQLTimeStampField
      FieldName = 'DATA_SINC'
      Origin = 'DATA_SINC'
    end
    object AtuaPedidoFBCLIENTE: TStringField
      FieldName = 'CLIENTE'
      Origin = 'CLIENTE'
      Size = 10
    end
    object AtuaPedidoFBCOD_PAGTO: TIntegerField
      FieldName = 'COD_PAGTO'
      Origin = 'COD_PAGTO'
    end
    object AtuaPedidoFBENV: TStringField
      FieldName = 'ENV'
      Origin = 'ENV'
      FixedChar = True
      Size = 1
    end
  end
  object AtuaItensCli: TFDQuery
    FieldOptions.UpdatePersistent = True
    Connection = ConexaoCli
    FormatOptions.AssignedValues = [fvMaxBcdPrecision]
    FormatOptions.MaxBcdPrecision = 20
    SQL.Strings = (
      'select * from MOV_RESI where 1=2')
    Left = 432
    Top = 368
    object AtuaItensCliCODEMP: TIntegerField
      FieldName = 'CODEMP'
      Origin = 'CODEMP'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object AtuaItensCliDATARES: TDateField
      FieldName = 'DATARES'
      Origin = 'DATARES'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object AtuaItensCliNUMRES: TIntegerField
      FieldName = 'NUMRES'
      Origin = 'NUMRES'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object AtuaItensCliNUMITEM: TIntegerField
      FieldName = 'NUMITEM'
      Origin = 'NUMITEM'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object AtuaItensCliCODPROD: TIntegerField
      FieldName = 'CODPROD'
      Origin = 'CODPROD'
      Required = True
    end
    object AtuaItensCliCODVEND: TIntegerField
      FieldName = 'CODVEND'
      Origin = 'CODVEND'
    end
    object AtuaItensCliQTMOV: TBCDField
      FieldName = 'QTMOV'
      Origin = 'QTMOV'
      Required = True
      Precision = 18
      Size = 2
    end
    object AtuaItensCliVLUNITMOV: TFMTBCDField
      FieldName = 'VLUNITMOV'
      Origin = 'VLUNITMOV'
      Precision = 18
      Size = 6
    end
    object AtuaItensCliVLTOTMOV: TBCDField
      FieldName = 'VLTOTMOV'
      Origin = 'VLTOTMOV'
      Precision = 18
      Size = 2
    end
    object AtuaItensCliPERDESC: TFMTBCDField
      FieldName = 'PERDESC'
      Origin = 'PERDESC'
      Precision = 9
      Size = 6
    end
    object AtuaItensCliUSUARIO: TIntegerField
      FieldName = 'USUARIO'
      Origin = 'USUARIO'
      Required = True
    end
    object AtuaItensCliDATAATU: TDateField
      FieldName = 'DATAATU'
      Origin = 'DATAATU'
      Required = True
    end
    object AtuaItensCliHORAATU: TStringField
      FieldName = 'HORAATU'
      Origin = 'HORAATU'
      Required = True
      Size = 8
    end
    object AtuaItensCliVLCUSTOMOV: TBCDField
      FieldName = 'VLCUSTOMOV'
      Origin = 'VLCUSTOMOV'
      Precision = 18
      Size = 2
    end
    object AtuaItensCliNUMMOVPED: TIntegerField
      FieldName = 'NUMMOVPED'
      Origin = 'NUMMOVPED'
    end
    object AtuaItensCliDATAMOVPED: TDateField
      FieldName = 'DATAMOVPED'
      Origin = 'DATAMOVPED'
    end
    object AtuaItensCliCODSITUACAO: TIntegerField
      FieldName = 'CODSITUACAO'
      Origin = 'CODSITUACAO'
    end
    object AtuaItensCliQTMOVANT: TBCDField
      FieldName = 'QTMOVANT'
      Origin = 'QTMOVANT'
      Precision = 18
      Size = 3
    end
    object AtuaItensCliTIPOOPER: TStringField
      FieldName = 'TIPOOPER'
      Origin = 'TIPOOPER'
      Size = 1
    end
    object AtuaItensCliVLTOTDESC: TBCDField
      FieldName = 'VLTOTDESC'
      Origin = 'VLTOTDESC'
      Precision = 18
      Size = 2
    end
  end
  object AtuaPedidoCli: TFDQuery
    Connection = ConexaoCli
    SQL.Strings = (
      'select * from MOV_RESC where 1=2')
    Left = 432
    Top = 320
    object AtuaPedidoCliCODEMP: TIntegerField
      FieldName = 'CODEMP'
      Origin = 'CODEMP'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object AtuaPedidoCliDATARES: TDateField
      FieldName = 'DATARES'
      Origin = 'DATARES'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object AtuaPedidoCliNUMRES: TIntegerField
      FieldName = 'NUMRES'
      Origin = 'NUMRES'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object AtuaPedidoCliCODSITUACAO: TSmallintField
      FieldName = 'CODSITUACAO'
      Origin = 'CODSITUACAO'
      Required = True
    end
    object AtuaPedidoCliCODVEND: TIntegerField
      FieldName = 'CODVEND'
      Origin = 'CODVEND'
    end
    object AtuaPedidoCliNOMEPESSOA: TStringField
      FieldName = 'NOMEPESSOA'
      Origin = 'NOMEPESSOA'
      Size = 40
    end
    object AtuaPedidoCliUSUARIO: TIntegerField
      FieldName = 'USUARIO'
      Origin = 'USUARIO'
      Required = True
    end
    object AtuaPedidoCliDATAATU: TDateField
      FieldName = 'DATAATU'
      Origin = 'DATAATU'
      Required = True
    end
    object AtuaPedidoCliHORAATU: TStringField
      FieldName = 'HORAATU'
      Origin = 'HORAATU'
      Required = True
      Size = 8
    end
    object AtuaPedidoCliCODPESSOA: TIntegerField
      FieldName = 'CODPESSOA'
      Origin = 'CODPESSOA'
    end
    object AtuaPedidoCliCODCOND: TIntegerField
      FieldName = 'CODCOND'
      Origin = 'CODCOND'
      Required = True
    end
    object AtuaPedidoCliCODMOEDA: TIntegerField
      FieldName = 'CODMOEDA'
      Origin = 'CODMOEDA'
      Required = True
    end
    object AtuaPedidoCliNUMMOVPED: TIntegerField
      FieldName = 'NUMMOVPED'
      Origin = 'NUMMOVPED'
    end
    object AtuaPedidoCliDATAMOVPED: TDateField
      FieldName = 'DATAMOVPED'
      Origin = 'DATAMOVPED'
    end
    object AtuaPedidoCliSTATUSATU: TIntegerField
      FieldName = 'STATUSATU'
      Origin = 'STATUSATU'
    end
    object AtuaPedidoCliCODOPER: TIntegerField
      FieldName = 'CODOPER'
      Origin = 'CODOPER'
    end
    object AtuaPedidoCliQTMOV: TFMTBCDField
      FieldName = 'QTMOV'
      Origin = 'QTMOV'
      Precision = 18
      Size = 3
    end
    object AtuaPedidoCliVLTOTMOV: TFMTBCDField
      FieldName = 'VLTOTMOV'
      Origin = 'VLTOTMOV'
      Precision = 18
      Size = 2
    end
    object AtuaPedidoCliVLTOTDESC: TFMTBCDField
      FieldName = 'VLTOTDESC'
      Origin = 'VLTOTDESC'
      Precision = 18
      Size = 2
    end
    object AtuaPedidoCliOBS: TStringField
      FieldName = 'OBS'
      Origin = 'OBS'
      Size = 500
    end
    object AtuaPedidoCliDATAPREV: TDateField
      FieldName = 'DATAPREV'
      Origin = 'DATAPREV'
    end
    object AtuaPedidoCliHORAPREV: TStringField
      FieldName = 'HORAPREV'
      Origin = 'HORAPREV'
      Size = 8
    end
    object AtuaPedidoCliNUMRESORI: TIntegerField
      FieldName = 'NUMRESORI'
      Origin = 'NUMRESORI'
    end
    object AtuaPedidoCliDATARESORI: TDateField
      FieldName = 'DATARESORI'
      Origin = 'DATARESORI'
    end
    object AtuaPedidoCliCODGUIA: TIntegerField
      FieldName = 'CODGUIA'
      Origin = 'CODGUIA'
    end
    object AtuaPedidoCliNOMEGUIA: TStringField
      FieldName = 'NOMEGUIA'
      Origin = 'NOMEGUIA'
      Size = 50
    end
  end
  object AtuaUsuariosCli: TFDQuery
    Connection = ConexaoCli
    SQL.Strings = (
      'select * from ADM_USUARIO')
    Left = 432
    Top = 224
    object AtuaUsuariosCliCODUSU: TIntegerField
      FieldName = 'CODUSU'
      Origin = 'CODUSU'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object AtuaUsuariosCliNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Required = True
      Size = 40
    end
    object AtuaUsuariosCliLOGIN: TStringField
      FieldName = 'LOGIN'
      Origin = 'LOGIN'
      Required = True
    end
    object AtuaUsuariosCliTIPO: TStringField
      FieldName = 'TIPO'
      Origin = 'TIPO'
      Required = True
      Size = 3
    end
    object AtuaUsuariosCliSENHA: TStringField
      FieldName = 'SENHA'
      Origin = 'SENHA'
      Required = True
      Size = 6
    end
    object AtuaUsuariosCliDEPTO: TStringField
      FieldName = 'DEPTO'
      Origin = 'DEPTO'
      Size = 15
    end
    object AtuaUsuariosCliUSUBD: TStringField
      FieldName = 'USUBD'
      Origin = 'USUBD'
    end
    object AtuaUsuariosCliSENHAUSUBD: TStringField
      FieldName = 'SENHAUSUBD'
      Origin = 'SENHAUSUBD'
    end
    object AtuaUsuariosCliINATIVO: TStringField
      FieldName = 'INATIVO'
      Origin = 'INATIVO'
      Size = 1
    end
    object AtuaUsuariosCliCORPORATIVO: TStringField
      FieldName = 'CORPORATIVO'
      Origin = 'CORPORATIVO'
      Size = 1
    end
    object AtuaUsuariosCliCODUSUEQ: TIntegerField
      FieldName = 'CODUSUEQ'
      Origin = 'CODUSUEQ'
    end
    object AtuaUsuariosCliUSUARIO: TIntegerField
      FieldName = 'USUARIO'
      Origin = 'USUARIO'
      Required = True
    end
    object AtuaUsuariosCliDATAATU: TDateField
      FieldName = 'DATAATU'
      Origin = 'DATAATU'
      Required = True
    end
    object AtuaUsuariosCliHORAATU: TStringField
      FieldName = 'HORAATU'
      Origin = 'HORAATU'
      Required = True
      Size = 8
    end
    object AtuaUsuariosCliINABRECAIXA: TStringField
      FieldName = 'INABRECAIXA'
      Origin = 'INABRECAIXA'
      Size = 1
    end
    object AtuaUsuariosCliINFECHACAIXA: TStringField
      FieldName = 'INFECHACAIXA'
      Origin = 'INFECHACAIXA'
      Size = 1
    end
    object AtuaUsuariosCliINCONFCAIXA: TStringField
      FieldName = 'INCONFCAIXA'
      Origin = 'INCONFCAIXA'
      Size = 1
    end
    object AtuaUsuariosCliINCONSOUTROCAIXA: TStringField
      FieldName = 'INCONSOUTROCAIXA'
      Origin = 'INCONSOUTROCAIXA'
      Size = 1
    end
    object AtuaUsuariosCliINRECEBEVENDA: TStringField
      FieldName = 'INRECEBEVENDA'
      Origin = 'INRECEBEVENDA'
      Size = 1
    end
    object AtuaUsuariosCliINCANCELAVENDA: TStringField
      FieldName = 'INCANCELAVENDA'
      Origin = 'INCANCELAVENDA'
      Size = 1
    end
    object AtuaUsuariosCliINCANCELACOMP: TStringField
      FieldName = 'INCANCELACOMP'
      Origin = 'INCANCELACOMP'
      Size = 1
    end
    object AtuaUsuariosCliINAUTORVENDA: TStringField
      FieldName = 'INAUTORVENDA'
      Origin = 'INAUTORVENDA'
      Size = 1
    end
    object AtuaUsuariosCliINALTERADTSIS: TStringField
      FieldName = 'INALTERADTSIS'
      Origin = 'INALTERADTSIS'
      Size = 1
    end
    object AtuaUsuariosCliINDIGITNFCOMP: TStringField
      FieldName = 'INDIGITNFCOMP'
      Origin = 'INDIGITNFCOMP'
      Size = 1
    end
    object AtuaUsuariosCliINBAIXAFATCLI: TStringField
      FieldName = 'INBAIXAFATCLI'
      Origin = 'INBAIXAFATCLI'
      Size = 1
    end
    object AtuaUsuariosCliINBAIXAFATFOR: TStringField
      FieldName = 'INBAIXAFATFOR'
      Origin = 'INBAIXAFATFOR'
      Size = 1
    end
    object AtuaUsuariosCliINRECONSSALDO: TStringField
      FieldName = 'INRECONSSALDO'
      Origin = 'INRECONSSALDO'
      Size = 1
    end
    object AtuaUsuariosCliINCONSVENDAOUTVEND: TStringField
      FieldName = 'INCONSVENDAOUTVEND'
      Origin = 'INCONSVENDAOUTVEND'
      Size = 1
    end
    object AtuaUsuariosCliINLANCTOCAIXA: TStringField
      FieldName = 'INLANCTOCAIXA'
      Origin = 'INLANCTOCAIXA'
      Size = 1
    end
    object AtuaUsuariosCliINTRANSFCAIXA: TStringField
      FieldName = 'INTRANSFCAIXA'
      Origin = 'INTRANSFCAIXA'
      Size = 1
    end
    object AtuaUsuariosCliINTRANSFPROD: TStringField
      FieldName = 'INTRANSFPROD'
      Origin = 'INTRANSFPROD'
      Size = 1
    end
    object AtuaUsuariosCliCODVEND: TIntegerField
      FieldName = 'CODVEND'
      Origin = 'CODVEND'
    end
    object AtuaUsuariosCliINPERMITECONSCUSTO: TStringField
      FieldName = 'INPERMITECONSCUSTO'
      Origin = 'INPERMITECONSCUSTO'
      Size = 1
    end
    object AtuaUsuariosCliINPERMITECONSVEND: TStringField
      FieldName = 'INPERMITECONSVEND'
      Origin = 'INPERMITECONSVEND'
      Size = 1
    end
    object AtuaUsuariosCliINPERMITECONSCUSTOPED: TStringField
      FieldName = 'INPERMITECONSCUSTOPED'
      Origin = 'INPERMITECONSCUSTOPED'
      Size = 1
    end
  end
  object qryUsuariosFB: TFDQuery
    Connection = ConexaoFB
    SQL.Strings = (
      'select * from TB_USUARIO')
    Left = 48
    Top = 224
    object qryUsuariosFBCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryUsuariosFBNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 50
    end
    object qryUsuariosFBLOGIN: TStringField
      FieldName = 'LOGIN'
      Origin = 'LOGIN'
      Size = 40
    end
    object qryUsuariosFBSENHA: TStringField
      FieldName = 'SENHA'
      Origin = 'SENHA'
      Size = 50
    end
  end
  object memReceber: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 240
    Top = 416
  end
  object qryReceberCli: TFDQuery
    Connection = ConexaoCli
    SQL.Strings = (
      'select * from V_FCR_REC_FV')
    Left = 336
    Top = 416
    object qryReceberCliCODEMP: TIntegerField
      FieldName = 'CODEMP'
      Origin = 'CODEMP'
    end
    object qryReceberCliCODCLIENTE: TIntegerField
      FieldName = 'CODCLIENTE'
      Origin = 'CODCLIENTE'
    end
    object qryReceberCliNUMFAT: TIntegerField
      FieldName = 'NUMFAT'
      Origin = 'NUMFAT'
    end
    object qryReceberCliNUMPARC: TSmallintField
      FieldName = 'NUMPARC'
      Origin = 'NUMPARC'
    end
    object qryReceberCliNOMCLIENTE: TStringField
      FieldName = 'NOMCLIENTE'
      Origin = 'NOMCLIENTE'
      Size = 60
    end
    object qryReceberCliSITUACAO: TStringField
      FieldName = 'SITUACAO'
      Origin = 'SITUACAO'
      Size = 1
    end
    object qryReceberCliDATAEMISSAO: TDateField
      FieldName = 'DATAEMISSAO'
      Origin = 'DATAEMISSAO'
    end
    object qryReceberCliDATAVENCTO: TDateField
      FieldName = 'DATAVENCTO'
      Origin = 'DATAVENCTO'
    end
    object qryReceberCliCODPORT: TIntegerField
      FieldName = 'CODPORT'
      Origin = 'CODPORT'
    end
    object qryReceberCliCODMOEDA: TIntegerField
      FieldName = 'CODMOEDA'
      Origin = 'CODMOEDA'
    end
    object qryReceberCliVLFATURA: TFMTBCDField
      FieldName = 'VLFATURA'
      Origin = 'VLFATURA'
      Precision = 18
      Size = 2
    end
    object qryReceberCliTPDOC: TSmallintField
      FieldName = 'TPDOC'
      Origin = 'TPDOC'
    end
    object qryReceberCliNUMDOC: TIntegerField
      FieldName = 'NUMDOC'
      Origin = 'NUMDOC'
    end
    object qryReceberCliUSUARIO: TIntegerField
      FieldName = 'USUARIO'
      Origin = 'USUARIO'
    end
    object qryReceberCliCODVEND: TIntegerField
      FieldName = 'CODVEND'
      Origin = 'CODVEND'
    end
    object qryReceberCliNUMNOTA: TIntegerField
      FieldName = 'NUMNOTA'
      Origin = 'NUMNOTA'
    end
    object qryReceberCliNUMMOV: TIntegerField
      FieldName = 'NUMMOV'
      Origin = 'NUMMOV'
    end
    object qryReceberCliDATAMOV: TDateField
      FieldName = 'DATAMOV'
      Origin = 'DATAMOV'
    end
  end
  object AtuaReceberFB: TFDQuery
    Connection = ConexaoFB
    SQL.Strings = (
      'select * from TB_RECEBER')
    Left = 144
    Top = 416
  end
  object qryReceberFB: TFDQuery
    Connection = ConexaoFB
    SQL.Strings = (
      'select * from TB_RECEBER')
    Left = 48
    Top = 416
    object qryReceberFBCOD_EMP: TIntegerField
      FieldName = 'COD_EMP'
      Origin = 'COD_EMP'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryReceberFBCOD_CLIENTE: TIntegerField
      FieldName = 'COD_CLIENTE'
      Origin = 'COD_CLIENTE'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryReceberFBNUM_FAT: TIntegerField
      FieldName = 'NUM_FAT'
      Origin = 'NUM_FAT'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryReceberFBNUM_PARC: TIntegerField
      FieldName = 'NUM_PARC'
      Origin = 'NUM_PARC'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryReceberFBNOM_CLIENTE: TStringField
      FieldName = 'NOM_CLIENTE'
      Origin = 'NOM_CLIENTE'
      Required = True
      Size = 60
    end
    object qryReceberFBSITUACAO: TStringField
      FieldName = 'SITUACAO'
      Origin = 'SITUACAO'
      Required = True
      Size = 1
    end
    object qryReceberFBDATA_EMISSAO: TSQLTimeStampField
      FieldName = 'DATA_EMISSAO'
      Origin = 'DATA_EMISSAO'
      Required = True
    end
    object qryReceberFBDATA_VENCTO: TSQLTimeStampField
      FieldName = 'DATA_VENCTO'
      Origin = 'DATA_VENCTO'
      Required = True
    end
    object qryReceberFBCOD_PORT: TIntegerField
      FieldName = 'COD_PORT'
      Origin = 'COD_PORT'
      Required = True
    end
    object qryReceberFBCOD_MOEDA: TIntegerField
      FieldName = 'COD_MOEDA'
      Origin = 'COD_MOEDA'
    end
    object qryReceberFBVLR_FATURA: TFMTBCDField
      FieldName = 'VLR_FATURA'
      Origin = 'VLR_FATURA'
      Required = True
      Precision = 18
      Size = 2
    end
    object qryReceberFBTIP_DOC: TSmallintField
      FieldName = 'TIP_DOC'
      Origin = 'TIP_DOC'
      Required = True
    end
    object qryReceberFBNUM_DOC: TIntegerField
      FieldName = 'NUM_DOC'
      Origin = 'NUM_DOC'
    end
    object qryReceberFBUSUARIO: TIntegerField
      FieldName = 'USUARIO'
      Origin = 'USUARIO'
      Required = True
    end
    object qryReceberFBCOD_VEND: TIntegerField
      FieldName = 'COD_VEND'
      Origin = 'COD_VEND'
    end
    object qryReceberFBNUM_NOTA: TIntegerField
      FieldName = 'NUM_NOTA'
      Origin = 'NUM_NOTA'
    end
    object qryReceberFBNUM_MOV: TIntegerField
      FieldName = 'NUM_MOV'
      Origin = 'NUM_MOV'
    end
    object qryReceberFBDATA_MOV: TSQLTimeStampField
      FieldName = 'DATA_MOV'
      Origin = 'DATA_MOV'
    end
  end
  object AtuaReceberCli: TFDQuery
    Connection = ConexaoCli
    SQL.Strings = (
      'select * from FCR_FAT where 1=2')
    Left = 432
    Top = 416
  end
  object qryBancoFB: TFDQuery
    Connection = ConexaoFB
    SQL.Strings = (
      'select * from TB_BANCO')
    Left = 144
    Top = 80
    object qryBancoFBNRO_CODIGO: TIntegerField
      FieldName = 'NRO_CODIGO'
      Origin = 'NRO_CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryBancoFBNRO_BANCO: TIntegerField
      FieldName = 'NRO_BANCO'
      Origin = 'NRO_BANCO'
      Required = True
    end
    object qryBancoFBNRO_AGENCIA: TStringField
      FieldName = 'NRO_AGENCIA'
      Origin = 'NRO_AGENCIA'
      Required = True
      Size = 10
    end
    object qryBancoFBDESC_BANCO: TStringField
      FieldName = 'DESC_BANCO'
      Origin = 'DESC_BANCO'
      Required = True
      Size = 40
    end
    object qryBancoFBSIT_BANCO: TIntegerField
      FieldName = 'SIT_BANCO'
      Origin = 'SIT_BANCO'
      Required = True
    end
  end
  object qryContaFB: TFDQuery
    Connection = ConexaoFB
    SQL.Strings = (
      'select * from TB_CONTA')
    Left = 144
    Top = 128
    object qryContaFBCOD_EMPRESA: TIntegerField
      FieldName = 'COD_EMPRESA'
      Origin = 'COD_EMPRESA'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryContaFBNRO_CODIGO: TIntegerField
      FieldName = 'NRO_CODIGO'
      Origin = 'NRO_CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryContaFBNRO_BANCO: TIntegerField
      FieldName = 'NRO_BANCO'
      Origin = 'NRO_BANCO'
      Required = True
    end
    object qryContaFBCOD_CONTA: TStringField
      FieldName = 'COD_CONTA'
      Origin = 'COD_CONTA'
      Required = True
    end
    object qryContaFBDESC_CONTA: TStringField
      FieldName = 'DESC_CONTA'
      Origin = 'DESC_CONTA'
      Required = True
      Size = 30
    end
    object qryContaFBTIP_CONTA: TIntegerField
      FieldName = 'TIP_CONTA'
      Origin = 'TIP_CONTA'
      Required = True
    end
    object qryContaFBSIT_CONTA: TStringField
      FieldName = 'SIT_CONTA'
      Origin = 'SIT_CONTA'
      Required = True
      Size = 1
    end
    object qryContaFBCOD_MOEDA: TIntegerField
      FieldName = 'COD_MOEDA'
      Origin = 'COD_MOEDA'
      Required = True
    end
  end
  object qryMoedaFB: TFDQuery
    Connection = ConexaoFB
    SQL.Strings = (
      'select * from TB_MOEDA')
    Left = 144
    Top = 176
    object qryMoedaFBCOD_MOEDA: TIntegerField
      FieldName = 'COD_MOEDA'
      Origin = 'COD_MOEDA'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryMoedaFBDESC_MOEDA: TStringField
      FieldName = 'DESC_MOEDA'
      Origin = 'DESC_MOEDA'
      Required = True
      Size = 40
    end
    object qryMoedaFBSIMB_MOEDA: TStringField
      FieldName = 'SIMB_MOEDA'
      Origin = 'SIMB_MOEDA'
      Required = True
      Size = 5
    end
  end
  object qryReciboFB: TFDQuery
    Connection = ConexaoFB
    SQL.Strings = (
      'select * from TB_RECIBO')
    Left = 144
    Top = 224
    object qryReciboFBCOD_RECIBO: TStringField
      FieldName = 'COD_RECIBO'
      Origin = 'COD_RECIBO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 40
    end
    object qryReciboFBNRO_RECIBO: TIntegerField
      FieldName = 'NRO_RECIBO'
      Origin = 'NRO_RECIBO'
      Required = True
    end
  end
  object AtuaReceberPagCli: TFDQuery
    Connection = ConexaoCli
    SQL.Strings = (
      'select * from FCR_FAT where 1=2')
    Left = 432
    Top = 464
  end
  object qryReceberPagFB: TFDQuery
    Connection = ConexaoFB
    SQL.Strings = (
      'select * from TB_RECEBER_PAG')
    Left = 48
    Top = 464
    object IntegerField1: TIntegerField
      FieldName = 'COD_EMP'
      Origin = 'COD_EMP'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object IntegerField2: TIntegerField
      FieldName = 'COD_CLIENTE'
      Origin = 'COD_CLIENTE'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object IntegerField3: TIntegerField
      FieldName = 'NUM_FAT'
      Origin = 'NUM_FAT'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object IntegerField4: TIntegerField
      FieldName = 'NUM_PARC'
      Origin = 'NUM_PARC'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object StringField1: TStringField
      FieldName = 'NOM_CLIENTE'
      Origin = 'NOM_CLIENTE'
      Required = True
      Size = 60
    end
    object StringField2: TStringField
      FieldName = 'SITUACAO'
      Origin = 'SITUACAO'
      Required = True
      Size = 1
    end
    object SQLTimeStampField1: TSQLTimeStampField
      FieldName = 'DATA_EMISSAO'
      Origin = 'DATA_EMISSAO'
      Required = True
    end
    object SQLTimeStampField2: TSQLTimeStampField
      FieldName = 'DATA_VENCTO'
      Origin = 'DATA_VENCTO'
      Required = True
    end
    object IntegerField5: TIntegerField
      FieldName = 'COD_PORT'
      Origin = 'COD_PORT'
      Required = True
    end
    object IntegerField6: TIntegerField
      FieldName = 'COD_MOEDA'
      Origin = 'COD_MOEDA'
    end
    object FMTBCDField1: TFMTBCDField
      FieldName = 'VLR_FATURA'
      Origin = 'VLR_FATURA'
      Required = True
      Precision = 18
      Size = 2
    end
    object SmallintField1: TSmallintField
      FieldName = 'TIP_DOC'
      Origin = 'TIP_DOC'
      Required = True
    end
    object IntegerField7: TIntegerField
      FieldName = 'NUM_DOC'
      Origin = 'NUM_DOC'
    end
    object IntegerField8: TIntegerField
      FieldName = 'USUARIO'
      Origin = 'USUARIO'
      Required = True
    end
    object IntegerField9: TIntegerField
      FieldName = 'COD_VEND'
      Origin = 'COD_VEND'
    end
    object IntegerField10: TIntegerField
      FieldName = 'NUM_NOTA'
      Origin = 'NUM_NOTA'
    end
    object IntegerField11: TIntegerField
      FieldName = 'NUM_MOV'
      Origin = 'NUM_MOV'
    end
    object SQLTimeStampField3: TSQLTimeStampField
      FieldName = 'DATA_MOV'
      Origin = 'DATA_MOV'
    end
  end
  object AtuaReceberPagFB: TFDQuery
    Connection = ConexaoFB
    SQL.Strings = (
      'select * from TB_RECEBER_PAG')
    Left = 144
    Top = 464
  end
  object memReceberPag: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 240
    Top = 464
  end
  object qryReceberPagCli: TFDQuery
    Connection = ConexaoCli
    SQL.Strings = (
      'select * from V_FCR_REC_FV')
    Left = 336
    Top = 464
  end
  object qryAdmEmpresa: TFDQuery
    Connection = ConexaoFB
    SQL.Strings = (
      'select * from ADM_EMPRESA')
    Left = 224
    Top = 80
    object qryAdmEmpresaCODEMP: TIntegerField
      FieldName = 'CODEMP'
      Origin = 'CODEMP'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryAdmEmpresaNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 40
    end
    object qryAdmEmpresaNOMEFANTASIA: TStringField
      FieldName = 'NOMEFANTASIA'
      Origin = 'NOMEFANTASIA'
      Size = 60
    end
    object qryAdmEmpresaENDERTPLOGRAD: TStringField
      FieldName = 'ENDERTPLOGRAD'
      Origin = 'ENDERTPLOGRAD'
      Size = 10
    end
    object qryAdmEmpresaENDERLOGRAD: TStringField
      FieldName = 'ENDERLOGRAD'
      Origin = 'ENDERLOGRAD'
      Size = 100
    end
    object qryAdmEmpresaENDERNUMLOGRAD: TStringField
      FieldName = 'ENDERNUMLOGRAD'
      Origin = 'ENDERNUMLOGRAD'
      Size = 10
    end
    object qryAdmEmpresaENDERCOMPLEMENTO: TStringField
      FieldName = 'ENDERCOMPLEMENTO'
      Origin = 'ENDERCOMPLEMENTO'
      Size = 15
    end
    object qryAdmEmpresaENDERBAIRRO: TStringField
      FieldName = 'ENDERBAIRRO'
      Origin = 'ENDERBAIRRO'
      Size = 30
    end
    object qryAdmEmpresaCODCIDADE: TIntegerField
      FieldName = 'CODCIDADE'
      Origin = 'CODCIDADE'
    end
    object qryAdmEmpresaNUMTELEFONE: TStringField
      FieldName = 'NUMTELEFONE'
      Origin = 'NUMTELEFONE'
    end
    object qryAdmEmpresaUSUARIO: TIntegerField
      FieldName = 'USUARIO'
      Origin = 'USUARIO'
      Required = True
    end
    object qryAdmEmpresaDATAATU: TDateField
      FieldName = 'DATAATU'
      Origin = 'DATAATU'
      Required = True
    end
    object qryAdmEmpresaHORAATU: TStringField
      FieldName = 'HORAATU'
      Origin = 'HORAATU'
      Required = True
      Size = 8
    end
    object qryAdmEmpresaINEXPORTADOR: TStringField
      FieldName = 'INEXPORTADOR'
      Origin = 'INEXPORTADOR'
      Size = 4
    end
    object qryAdmEmpresaDOCFISCAL: TStringField
      FieldName = 'DOCFISCAL'
      Origin = 'DOCFISCAL'
      Size = 25
    end
    object qryAdmEmpresaDOCFISCALREPRLEGAL: TStringField
      FieldName = 'DOCFISCALREPRLEGAL'
      Origin = 'DOCFISCALREPRLEGAL'
      Size = 25
    end
    object qryAdmEmpresaNOMEREPRLEGAL: TStringField
      FieldName = 'NOMEREPRLEGAL'
      Origin = 'NOMEREPRLEGAL'
      Size = 40
    end
    object qryAdmEmpresaTPREPRLEGAL: TStringField
      FieldName = 'TPREPRLEGAL'
      Origin = 'TPREPRLEGAL'
      Size = 1
    end
    object qryAdmEmpresaNACIONALIDADE: TStringField
      FieldName = 'NACIONALIDADE'
      Origin = 'NACIONALIDADE'
    end
    object qryAdmEmpresaESTADOCIVIL: TStringField
      FieldName = 'ESTADOCIVIL'
      Origin = 'ESTADOCIVIL'
    end
    object qryAdmEmpresaDOCIDENTIDADE: TStringField
      FieldName = 'DOCIDENTIDADE'
      Origin = 'DOCIDENTIDADE'
    end
  end
end
