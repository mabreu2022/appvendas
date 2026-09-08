object frmMain: TfrmMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Servidor'
  ClientHeight = 170
  ClientWidth = 355
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 146
    Width = 355
    Height = 24
    Panels = <
      item
        Text = 'Desenvolvido por Marcelo Bernardi - (17)99125-4844'
        Width = 300
      end
      item
        Width = 150
      end
      item
        Width = 150
      end
      item
        Width = 50
      end>
  end
  object TrayIcon1: TTrayIcon
    Animate = True
    Hint = 'FVendas Servidor'
    PopupMenu = PopupMenu1
    Visible = True
    OnDblClick = TrayIcon1DblClick
    Left = 32
    Top = 16
  end
  object ApplicationEvents1: TApplicationEvents
    OnMinimize = ApplicationEvents1Minimize
    OnRestore = ApplicationEvents1Restore
    Left = 88
    Top = 16
  end
  object PopupMenu1: TPopupMenu
    Left = 144
    Top = 16
    object AtualizarDados1: TMenuItem
      Caption = 'Atualizar Dados'
      OnClick = AtualizarDados1Click
    end
    object AtualizarDadosServ1: TMenuItem
      Caption = 'Atualizar Dados Serv'
      OnClick = AtualizarDadosServ1Click
    end
    object Restaurar1: TMenuItem
      Caption = 'Restaurar'
      OnClick = Restaurar1Click
    end
    object Sair1: TMenuItem
      Caption = 'Sair'
      OnClick = Sair1Click
    end
  end
  object TimerAtualizar: TTimer
    Enabled = False
    Interval = 900000
    OnTimer = AtualizarDados1Click
    Left = 32
    Top = 72
  end
  object Server: TIdHTTPServer
    Bindings = <>
    DefaultPort = 3200
    OnCommandGet = ServerCommandGet
    Left = 200
    Top = 16
  end
  object TimerAtualizarServ: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = AtualizarDadosServ1Click
    Left = 88
    Top = 72
  end
  object TimerMinimizar: TTimer
    OnTimer = TimerMinimizarTimer
    Left = 144
    Top = 72
  end
end
