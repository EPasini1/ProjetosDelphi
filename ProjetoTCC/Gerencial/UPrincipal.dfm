object FrmPrincipal: TFrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Gerencial'
  ClientHeight = 343
  ClientWidth = 708
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesktopCenter
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu1: TMainMenu
    Left = 208
    Top = 120
    object Cadastro1: TMenuItem
      Caption = 'Cadastro'
      object Agendamentos1: TMenuItem
        Caption = 'Agendamentos'
        OnClick = Agendamentos1Click
      end
      object DatadeEntrega1: TMenuItem
        Caption = 'Data de Entrega'
        OnClick = DatadeEntrega1Click
      end
      object Empresa1: TMenuItem
        Caption = 'Empresa'
        OnClick = Empresa1Click
      end
      object Produtor1: TMenuItem
        Caption = 'Produtor'
        OnClick = Produtor1Click
      end
      object VariedadedeUva1: TMenuItem
        Caption = 'Variedade de Uva'
        OnClick = VariedadedeUva1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Sair1: TMenuItem
        Caption = 'Sair'
        OnClick = Sair1Click
      end
    end
  end
end
