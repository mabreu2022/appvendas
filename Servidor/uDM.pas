unit uDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Phys.FBDef, FireDAC.Phys.IBBase, FireDAC.Phys.FB, FireDAC.Comp.UI,
  Data.DB, FireDAC.Comp.Client, IdBaseComponent, IdComponent, IdCustomTCPServer,
  IdCustomHTTPServer, IdHTTPServer, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
  Winapi.Windows, Winapi.Messages, System.Variants, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ComCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, Vcl.Imaging.jpeg, Vcl.StdCtrls, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, System.IniFiles,
  uDatabaseConfig, uConexao, FireDAC.Phys.IB, FireDAC.Phys.IBDef;

type
  TDM = class(TDataModule)
    ConexaoFB: TFDConnection;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    qryVendedoresFB: TFDQuery;
    qryVendedoresFBCODIGO: TStringField;
    qryVendedoresFBNOME: TStringField;
    qryVendedoresFBUSUARIO: TStringField;
    qryVendedoresFBSENHA: TStringField;
    qryVendedoresFBEMAIL: TStringField;
    qryVendedoresFBPORC_DESC: TSingleField;
    qryVendedoresFBPORC_ADIC: TSingleField;
    qryVendedoresFBPORC_DESC_ITEM: TSingleField;
    qryVendedoresFBCAD_CLI: TStringField;
    qryVendedoresFBCAD_PED: TStringField;
    qryVendedoresFBBONIFICA: TStringField;
    qryVendedoresFBACESSO: TStringField;
    ConexaoCli: TFDConnection;
    qryProdutosCli: TFDQuery;
    qryProdutosFB: TFDQuery;
    qryClientesCli: TFDQuery;
    qryClientesFB: TFDQuery;
    qryCondPagtoFB: TFDQuery;
    qryCondPagtoFBCODIGO: TIntegerField;
    qryCondPagtoFBDESCRICAO: TStringField;
    memPedidos: TFDMemTable;
    qryPedidosFB: TFDQuery;
    qryItensPedidoFB: TFDQuery;
    AtuaItensFB: TFDQuery;
    AtuaPedidoFB: TFDQuery;
    AtuaItensCli: TFDQuery;
    AtuaPedidoCli: TFDQuery;
    AtuaPedidoCliCODEMP: TIntegerField;
    AtuaPedidoCliDATARES: TDateField;
    AtuaPedidoCliNUMRES: TIntegerField;
    AtuaPedidoCliCODSITUACAO: TSmallintField;
    AtuaPedidoCliCODVEND: TIntegerField;
    AtuaPedidoCliNOMEPESSOA: TStringField;
    AtuaPedidoCliUSUARIO: TIntegerField;
    AtuaPedidoCliDATAATU: TDateField;
    AtuaPedidoCliHORAATU: TStringField;
    AtuaPedidoCliCODPESSOA: TIntegerField;
    AtuaPedidoCliCODCOND: TIntegerField;
    AtuaPedidoCliCODMOEDA: TIntegerField;
    AtuaPedidoCliNUMMOVPED: TIntegerField;
    AtuaPedidoCliDATAMOVPED: TDateField;
    AtuaPedidoCliSTATUSATU: TIntegerField;
    AtuaPedidoCliCODOPER: TIntegerField;
    AtuaPedidoCliQTMOV: TFMTBCDField;
    AtuaPedidoCliVLTOTMOV: TFMTBCDField;
    AtuaPedidoCliVLTOTDESC: TFMTBCDField;
    AtuaPedidoCliOBS: TStringField;
    AtuaPedidoCliDATAPREV: TDateField;
    AtuaPedidoCliHORAPREV: TStringField;
    AtuaPedidoCliNUMRESORI: TIntegerField;
    AtuaPedidoCliDATARESORI: TDateField;
    AtuaPedidoCliCODGUIA: TIntegerField;
    AtuaPedidoCliNOMEGUIA: TStringField;
    AtuaItensCliCODEMP: TIntegerField;
    AtuaItensCliDATARES: TDateField;
    AtuaItensCliNUMRES: TIntegerField;
    AtuaItensCliNUMITEM: TIntegerField;
    AtuaItensCliCODPROD: TIntegerField;
    AtuaItensCliCODVEND: TIntegerField;
    AtuaItensCliQTMOV: TBCDField;
    AtuaItensCliVLUNITMOV: TFMTBCDField;
    AtuaItensCliVLTOTMOV: TBCDField;
    AtuaItensCliPERDESC: TFMTBCDField;
    AtuaItensCliUSUARIO: TIntegerField;
    AtuaItensCliDATAATU: TDateField;
    AtuaItensCliHORAATU: TStringField;
    AtuaItensCliVLCUSTOMOV: TBCDField;
    AtuaItensCliNUMMOVPED: TIntegerField;
    AtuaItensCliDATAMOVPED: TDateField;
    AtuaItensCliCODSITUACAO: TIntegerField;
    AtuaItensCliQTMOVANT: TBCDField;
    AtuaItensCliTIPOOPER: TStringField;
    AtuaItensCliVLTOTDESC: TBCDField;
    qryClientesCliCODCLIENTE: TIntegerField;
    qryClientesCliNOME: TStringField;
    qryClientesCliRAZAOSOCIAL: TStringField;
    qryClientesCliTIPOCADASTRO: TStringField;
    qryClientesCliTIPOCLIENTE: TSmallintField;
    qryClientesCliDESCRTIPOCLIENTE: TStringField;
    qryClientesCliTIPOFISCAL: TStringField;
    qryClientesCliSEXO: TStringField;
    qryClientesCliESTADOCIVIL: TSmallintField;
    qryClientesCliDATANASCFUND: TDateField;
    qryClientesCliINATIVO: TStringField;
    qryClientesCliCODREGVEN: TIntegerField;
    qryClientesCliNOMEREGVEN: TStringField;
    qryClientesCliCODVEND: TIntegerField;
    qryClientesCliNOMEVEND: TStringField;
    qryClientesCliATACVAR: TStringField;
    qryClientesCliENDERTPLOGRAD: TStringField;
    qryClientesCliENDERLOGRAD: TStringField;
    qryClientesCliENDERNUMLOGRAD: TStringField;
    qryClientesCliENDERCOMPLEMENTO: TStringField;
    qryClientesCliENDERBAIRRO: TStringField;
    qryClientesCliCODCIDADE: TIntegerField;
    qryClientesCliNOMECIDADE: TStringField;
    qryClientesCliCODPAIS: TStringField;
    qryClientesCliCODUF: TStringField;
    qryClientesCliCEP: TStringField;
    qryClientesCliDOCFISCAL: TStringField;
    qryClientesCliDOCFISCAL2: TStringField;
    qryClientesCliDOCIDENTIDADE: TStringField;
    qryClientesCliTIPOTELEFONE1: TStringField;
    qryClientesCliTIPOTELEFONE2: TStringField;
    qryClientesCliTIPOTELEFONE3: TStringField;
    qryClientesCliNUMTELEFONE1: TStringField;
    qryClientesCliNUMTELEFONE2: TStringField;
    qryClientesCliNUMTELEFONE3: TStringField;
    qryClientesCliPESSOACONTATO: TStringField;
    qryClientesCliEMAIL1: TStringField;
    qryClientesCliEMAIL2: TStringField;
    qryClientesCliNOMEPAI: TStringField;
    qryClientesCliNOMEMAE: TStringField;
    qryClientesCliNOMECONJUGE: TStringField;
    qryClientesCliNACIONALIDADE: TStringField;
    qryClientesCliFOTO: TStringField;
    qryClientesCliOBS: TStringField;
    qryClientesCliPROFISSAO: TStringField;
    qryClientesCliNOMEEMPPROF: TStringField;
    qryClientesCliNUMTELEFONEEMP: TStringField;
    qryClientesCliTEMPOEMP: TStringField;
    qryClientesCliGRAUESC: TSmallintField;
    qryClientesCliCODTIPOCLIENTE: TIntegerField;
    qryClientesCliUSUINC: TIntegerField;
    qryClientesCliDATAINC: TSQLTimeStampField;
    qryClientesCliCODEMPINC: TIntegerField;
    qryClientesCliUSUARIO: TIntegerField;
    qryClientesCliDATAATU: TDateField;
    qryClientesCliHORAATU: TStringField;
    AtuaPedidoFBCODIGO: TStringField;
    AtuaPedidoFBDATA_PEDIDO: TSQLTimeStampField;
    AtuaPedidoFBVENDEDOR: TStringField;
    AtuaPedidoFBTIPO: TStringField;
    AtuaPedidoFBTOTAL_PEDIDO: TFMTBCDField;
    AtuaPedidoFBOBS: TBlobField;
    AtuaPedidoFBDATA_SINC: TSQLTimeStampField;
    AtuaPedidoFBCLIENTE: TStringField;
    AtuaPedidoFBCOD_PAGTO: TIntegerField;
    AtuaPedidoFBENV: TStringField;
    AtuaItensFBSEQ: TIntegerField;
    AtuaItensFBCOD_PEDIDO: TStringField;
    AtuaItensFBTIPO: TStringField;
    AtuaItensFBCOD_PRODUTO: TStringField;
    AtuaItensFBQTD: TSingleField;
    AtuaItensFBVALOR_UNITARIO: TFmtBCDField;
    AtuaItensFBVALOR_TOTAL: TFmtBCDField;
    qryItensPedidoFBSEQ: TIntegerField;
    qryItensPedidoFBCOD_PEDIDO: TStringField;
    qryItensPedidoFBTIPO: TStringField;
    qryItensPedidoFBCOD_PRODUTO: TStringField;
    qryItensPedidoFBQTD: TSingleField;
    qryItensPedidoFBVALOR_UNITARIO: TFmtBCDField;
    qryItensPedidoFBVALOR_TOTAL: TFmtBCDField;
    qryPedidosFBCODIGO: TStringField;
    qryPedidosFBDATA_PEDIDO: TSQLTimeStampField;
    qryPedidosFBVENDEDOR: TStringField;
    qryPedidosFBTIPO: TStringField;
    qryPedidosFBTOTAL_PEDIDO: TFmtBCDField;
    qryPedidosFBOBS: TBlobField;
    qryPedidosFBDATA_SINC: TSQLTimeStampField;
    qryPedidosFBCLIENTE: TStringField;
    qryPedidosFBCOD_PAGTO: TIntegerField;
    qryPedidosFBENV: TStringField;
    qryClientesFBCODIGO: TStringField;
    qryClientesFBCODIGO_MOBILE: TStringField;
    qryClientesFBTIPO: TStringField;
    qryClientesFBNOME: TStringField;
    qryClientesFBFANTASIA: TStringField;
    qryClientesFBCNPJ_CPF: TStringField;
    qryClientesFBIE_RG: TStringField;
    qryClientesFBLOGRADOURO: TStringField;
    qryClientesFBNUMERO: TStringField;
    qryClientesFBBAIRRO: TStringField;
    qryClientesFBCOMPLEMENTO: TStringField;
    qryClientesFBCIDADE_IBGE: TStringField;
    qryClientesFBCIDADE_DESCRICAO: TStringField;
    qryClientesFBUF: TStringField;
    qryClientesFBTELEFONE: TStringField;
    qryClientesFBCOMERCIAL: TStringField;
    qryClientesFBCELULAR: TStringField;
    qryClientesFBWATSAPP: TStringField;
    qryClientesFBCONTATO: TStringField;
    qryClientesFBEMAIL1: TStringField;
    qryClientesFBEMAIL2: TStringField;
    qryClientesFBATIVIDADE: TStringField;
    qryClientesFBOBS: TBlobField;
    qryClientesFBLIMITE_COMPRA_PED: TFmtBCDField;
    qryClientesFBDIAS_BLOQ_ATRASO: TIntegerField;
    qryClientesFBDATA_SINC: TSQLTimeStampField;
    AtuaUsuariosCli: TFDQuery;
    AtuaUsuariosCliCODUSU: TIntegerField;
    AtuaUsuariosCliNOME: TStringField;
    AtuaUsuariosCliLOGIN: TStringField;
    AtuaUsuariosCliTIPO: TStringField;
    AtuaUsuariosCliSENHA: TStringField;
    AtuaUsuariosCliDEPTO: TStringField;
    AtuaUsuariosCliUSUBD: TStringField;
    AtuaUsuariosCliSENHAUSUBD: TStringField;
    AtuaUsuariosCliINATIVO: TStringField;
    AtuaUsuariosCliCORPORATIVO: TStringField;
    AtuaUsuariosCliCODUSUEQ: TIntegerField;
    AtuaUsuariosCliUSUARIO: TIntegerField;
    AtuaUsuariosCliDATAATU: TDateField;
    AtuaUsuariosCliHORAATU: TStringField;
    AtuaUsuariosCliINABRECAIXA: TStringField;
    AtuaUsuariosCliINFECHACAIXA: TStringField;
    AtuaUsuariosCliINCONFCAIXA: TStringField;
    AtuaUsuariosCliINCONSOUTROCAIXA: TStringField;
    AtuaUsuariosCliINRECEBEVENDA: TStringField;
    AtuaUsuariosCliINCANCELAVENDA: TStringField;
    AtuaUsuariosCliINCANCELACOMP: TStringField;
    AtuaUsuariosCliINAUTORVENDA: TStringField;
    AtuaUsuariosCliINALTERADTSIS: TStringField;
    AtuaUsuariosCliINDIGITNFCOMP: TStringField;
    AtuaUsuariosCliINBAIXAFATCLI: TStringField;
    AtuaUsuariosCliINBAIXAFATFOR: TStringField;
    AtuaUsuariosCliINRECONSSALDO: TStringField;
    AtuaUsuariosCliINCONSVENDAOUTVEND: TStringField;
    AtuaUsuariosCliINLANCTOCAIXA: TStringField;
    AtuaUsuariosCliINTRANSFCAIXA: TStringField;
    AtuaUsuariosCliINTRANSFPROD: TStringField;
    AtuaUsuariosCliCODVEND: TIntegerField;
    AtuaUsuariosCliINPERMITECONSCUSTO: TStringField;
    AtuaUsuariosCliINPERMITECONSVEND: TStringField;
    AtuaUsuariosCliINPERMITECONSCUSTOPED: TStringField;
    qryUsuariosFB: TFDQuery;
    qryUsuariosFBCODIGO: TIntegerField;
    qryUsuariosFBNOME: TStringField;
    qryUsuariosFBLOGIN: TStringField;
    qryUsuariosFBSENHA: TStringField;
    memReceber: TFDMemTable;
    qryReceberCli: TFDQuery;
    qryReceberFB: TFDQuery;
    AtuaReceberCli: TFDQuery;
    qryReceberFBCOD_EMP: TIntegerField;
    qryReceberFBCOD_CLIENTE: TIntegerField;
    qryReceberFBNUM_FAT: TIntegerField;
    qryReceberFBNUM_PARC: TIntegerField;
    qryReceberFBNOM_CLIENTE: TStringField;
    qryReceberFBSITUACAO: TStringField;
    qryReceberFBDATA_EMISSAO: TSQLTimeStampField;
    qryReceberFBDATA_VENCTO: TSQLTimeStampField;
    qryReceberFBCOD_PORT: TIntegerField;
    qryReceberFBCOD_MOEDA: TIntegerField;
    qryReceberFBVLR_FATURA: TFMTBCDField;
    qryReceberFBTIP_DOC: TSmallintField;
    qryReceberFBNUM_DOC: TIntegerField;
    qryReceberFBUSUARIO: TIntegerField;
    qryReceberFBCOD_VEND: TIntegerField;
    qryReceberFBNUM_NOTA: TIntegerField;
    qryReceberFBNUM_MOV: TIntegerField;
    qryReceberFBDATA_MOV: TSQLTimeStampField;
    qryReceberCliCODEMP: TIntegerField;
    qryReceberCliCODCLIENTE: TIntegerField;
    qryReceberCliNUMFAT: TIntegerField;
    qryReceberCliNUMPARC: TSmallintField;
    qryReceberCliNOMCLIENTE: TStringField;
    qryReceberCliSITUACAO: TStringField;
    qryReceberCliDATAEMISSAO: TDateField;
    qryReceberCliDATAVENCTO: TDateField;
    qryReceberCliCODPORT: TIntegerField;
    qryReceberCliCODMOEDA: TIntegerField;
    qryReceberCliVLFATURA: TFMTBCDField;
    qryReceberCliTPDOC: TSmallintField;
    qryReceberCliNUMDOC: TIntegerField;
    qryReceberCliUSUARIO: TIntegerField;
    qryReceberCliCODVEND: TIntegerField;
    qryReceberCliNUMNOTA: TIntegerField;
    qryReceberCliNUMMOV: TIntegerField;
    qryReceberCliDATAMOV: TDateField;
    qryBancoFB: TFDQuery;
    qryContaFB: TFDQuery;
    qryMoedaFB: TFDQuery;
    qryReciboFB: TFDQuery;
    qryBancoFBNRO_CODIGO: TIntegerField;
    qryBancoFBNRO_BANCO: TIntegerField;
    qryBancoFBNRO_AGENCIA: TStringField;
    qryBancoFBDESC_BANCO: TStringField;
    qryBancoFBSIT_BANCO: TIntegerField;
    qryContaFBCOD_EMPRESA: TIntegerField;
    qryContaFBNRO_CODIGO: TIntegerField;
    qryContaFBNRO_BANCO: TIntegerField;
    qryContaFBCOD_CONTA: TStringField;
    qryContaFBDESC_CONTA: TStringField;
    qryContaFBTIP_CONTA: TIntegerField;
    qryContaFBSIT_CONTA: TStringField;
    qryContaFBCOD_MOEDA: TIntegerField;
    qryMoedaFBCOD_MOEDA: TIntegerField;
    qryMoedaFBDESC_MOEDA: TStringField;
    qryReciboFBCOD_RECIBO: TStringField;
    qryReciboFBNRO_RECIBO: TIntegerField;
    AtuaReceberPagCli: TFDQuery;
    qryReceberPagFB: TFDQuery;
    IntegerField1: TIntegerField;
    IntegerField2: TIntegerField;
    IntegerField3: TIntegerField;
    IntegerField4: TIntegerField;
    StringField1: TStringField;
    StringField2: TStringField;
    SQLTimeStampField1: TSQLTimeStampField;
    SQLTimeStampField2: TSQLTimeStampField;
    IntegerField5: TIntegerField;
    IntegerField6: TIntegerField;
    FMTBCDField1: TFMTBCDField;
    SmallintField1: TSmallintField;
    IntegerField7: TIntegerField;
    IntegerField8: TIntegerField;
    IntegerField9: TIntegerField;
    IntegerField10: TIntegerField;
    IntegerField11: TIntegerField;
    SQLTimeStampField3: TSQLTimeStampField;
    AtuaReceberPagFB: TFDQuery;
    memReceberPag: TFDMemTable;
    qryReceberPagCli: TFDQuery;
    qryMoedaFBSIMB_MOEDA: TStringField;
    qryProdutosFBCODEMP: TIntegerField;
    qryProdutosFBCODIGO: TStringField;
    qryProdutosFBDESCRICAO: TStringField;
    qryProdutosFBDESCRICAO_RED: TStringField;
    qryProdutosFBBARRAS: TStringField;
    qryProdutosFBUNIDADE: TStringField;
    qryProdutosFBPRECO_VENDA: TFMTBCDField;
    qryProdutosFBINFO_ADIC: TBlobField;
    qryProdutosFBIMAGEM: TBlobField;
    qryProdutosFBPRECO_MIN: TFMTBCDField;
    qryProdutosFBPRECO_ATACADO: TFMTBCDField;
    qryProdutosFBPRECO_COMPRA: TFMTBCDField;
    qryProdutosFBSALDO: TFMTBCDField;
    qryProdutosFBDAT_ALTERADO: TSQLTimeStampField;
    qryProdutosFBCODMOEDA: TIntegerField;
    qryProdutosCliCODEMP: TIntegerField;
    qryProdutosCliCODPROD: TIntegerField;
    qryProdutosCliDESCRICAO: TStringField;
    qryProdutosCliDESCCOMPLETA: TStringField;
    qryProdutosCliUNIDMEDIDA: TStringField;
    qryProdutosCliCODBAR: TStringField;
    qryProdutosCliDTULTALT: TDateField;
    qryProdutosCliVLVENDA: TBCDField;
    qryProdutosCliVLVENDAMIN: TBCDField;
    qryProdutosCliVLVENDAATACADO: TBCDField;
    qryProdutosCliVLCTOULTCOMP: TFMTBCDField;
    qryAdmEmpresasFB: TFDQuery;
    qryAdmEmpresasFBCODEMP: TIntegerField;
    qryAdmEmpresasFBNOME: TStringField;
    qryAdmEmpresasFBNOMEFANTASIA: TStringField;
    qryAdmEmpresasFBENDERTPLOGRAD: TStringField;
    qryAdmEmpresasFBENDERLOGRAD: TStringField;
    qryAdmEmpresasFBENDERNUMLOGRAD: TStringField;
    qryAdmEmpresasFBENDERCOMPLEMENTO: TStringField;
    qryAdmEmpresasFBENDERBAIRRO: TStringField;
    qryAdmEmpresasFBCODCIDADE: TIntegerField;
    qryAdmEmpresasFBNUMTELEFONE: TStringField;
    qryAdmEmpresasFBUSUARIO: TIntegerField;
    qryAdmEmpresasFBDATAATU: TDateField;
    qryAdmEmpresasFBHORAATU: TStringField;
    qryAdmEmpresasFBINEXPORTADOR: TStringField;
    qryAdmEmpresasFBDOCFISCAL: TStringField;
    qryAdmEmpresasFBDOCFISCALREPRLEGAL: TStringField;
    qryAdmEmpresasFBNOMEREPRLEGAL: TStringField;
    qryAdmEmpresasFBTPREPRLEGAL: TStringField;
    qryAdmEmpresasFBNACIONALIDADE: TStringField;
    qryAdmEmpresasFBESTADOCIVIL: TStringField;
    qryAdmEmpresasFBDOCIDENTIDADE: TStringField;
    qryAdmEmpresasCli: TFDQuery;
    qryAdmEmpresasCliCODEMP: TIntegerField;
    qryAdmEmpresasCliNOME: TStringField;
    qryAdmEmpresasCliNOMEFANTASIA: TStringField;
    qryAdmEmpresasCliENDERTPLOGRAD: TStringField;
    qryAdmEmpresasCliENDERLOGRAD: TStringField;
    qryAdmEmpresasCliENDERNUMLOGRAD: TStringField;
    qryAdmEmpresasCliENDERCOMPLEMENTO: TStringField;
    qryAdmEmpresasCliENDERBAIRRO: TStringField;
    qryAdmEmpresasCliCODCIDADE: TIntegerField;
    qryAdmEmpresasCliCODCIDADEPY: TIntegerField;
    qryAdmEmpresasCliNUMTELEFONE: TStringField;
    qryAdmEmpresasCliUSUARIO: TIntegerField;
    qryAdmEmpresasCliDATAATU: TDateField;
    qryAdmEmpresasCliHORAATU: TStringField;
    qryAdmEmpresasCliINEXPORTADOR: TStringField;
    qryAdmEmpresasCliDOCFISCAL: TStringField;
    qryAdmEmpresasCliDOCFISCALREPRLEGAL: TStringField;
    qryAdmEmpresasCliNOMEREPRLEGAL: TStringField;
    qryAdmEmpresasCliTPREPRLEGAL: TStringField;
    qryAdmEmpresasCliNACIONALIDADE: TStringField;
    qryAdmEmpresasCliESTADOCIVIL: TStringField;
    qryAdmEmpresasCliDSEMAIL: TStringField;
    qryAdmEmpresasCliDSSENHAEMAIL: TStringField;
    qryAdmEmpresasCliDOCIDENTIDADE: TStringField;
    qryAdmEmpresasCliNOMECIDADE: TStringField;
    qryAdmEmpresasCliCODPAIS: TStringField;
    qryAdmEmpresasCliCODUF: TStringField;
    qryAdmEmpresasCliCEP: TStringField;
    qryAdmEmpresasCliCIDADEEMP: TStringField;
    qryAdmEmpresasCliCIDADEEMP1: TStringField;
    qryAdmEmpresasCliPAISCLI: TStringField;
    qryAdmEmpresasCliCODDISTRITO: TIntegerField;
    qryAdmEmpresasCliNOMEDISTRITO: TStringField;
    qryAdmEmpresasCliCODDEPARTAMENTO: TStringField;
    qryAdmEmpresasCliNOMEDEPARTAMENTO: TStringField;
    qryAdmEmpresasCliCHAVEELETRONICA: TStringField;
    qryAdmEmpresasCliDSAPIDE: TStringField;
    qryAdmEmpresasCliTIPOCOMERCIO: TIntegerField;
    procedure ConexaoCliBeforeConnect(Sender: TObject);
    procedure ConexaoFBBeforeConnect(Sender: TObject);
  private
    { Private declarations }
    function GetConexaoCli : TClsConexao;
    function GetConexaoFB : TClsConexao;
  public
    { Public declarations }
    conf: TIniFile;
    senha_banco, user_banco: string;
    function ConectaBaseCliente: Boolean;
    property _ConexaoCli : TClsConexao read GetConexaoCli;
    property _ConexaoFB : TClsConexao read GetConexaoFB;
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses 
  uLogger;

//------------------------

function TDM.ConectaBaseCliente: Boolean;
begin
  ConexaoCli.Connected := false;
  ConexaoFB.Connected := false;

  try
    ConexaoCli.Connected := True;
    ConexaoFB.Connected := True;
    result := True;
  except
    result := false;
  end;
end;

procedure TDM.ConexaoCliBeforeConnect(Sender: TObject);
var
  vDatabaseCli : TClsDatabaseModel;
begin
  vDatabaseCli := TClsDatabaseConfig.GetDatabase(tdbCli);

  with ConexaoCli.Params, vDatabaseCli do
  begin
    Clear;
    Values['DriverID']  := 'FB';
    Values['Database']  := Database;
    Values['User_name'] := Username;
    Values['Password']  := Password;
  end;
end;

procedure TDM.ConexaoFBBeforeConnect(Sender: TObject);
var
  vDatabaseFB : TClsDatabaseModel;
begin
  vDatabaseFB := TClsDatabaseConfig.GetDatabase(tdbFB);

  with ConexaoFB.Params, vDatabaseFB do
  begin
    Clear;
    Values['DriverID']  := 'FB';
    Values['Database']  := Database;
    Values['User_name'] := Username;
    Values['Password']  := Password;
  end;
end;

//---------------------

function TDM.GetConexaoCli : TClsConexao;
begin
  Result := TClsConexao(ConexaoCli);
end;

function TDM.GetConexaoFB : TClsConexao;
begin
  Result := TClsConexao(ConexaoFB);
end;

end.
