object dmClaudinei: TdmClaudinei
  OldCreateOrder = False
  Height = 255
  Width = 399
  object ConexaoFB: TFDConnection
    Params.Strings = (
      'Database=C:\Fontes\FVendas\Dados\CLAUDINEI.FDB'
      'Server=localhost'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'DriverID=FB')
    LoginPrompt = False
    Left = 32
    Top = 16
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 96
    Top = 16
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    VendorLib = 'Fbclient.dll'
    Left = 128
    Top = 16
  end
end
