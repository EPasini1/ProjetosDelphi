object FrmLogin: TFrmLogin
  Left = 0
  Top = 0
  Caption = 'Login'
  ClientHeight = 147
  ClientWidth = 265
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 36
    Height = 13
    Caption = 'Usu'#225'rio'
  end
  object Label2: TLabel
    Left = 8
    Top = 48
    Width = 30
    Height = 13
    Caption = 'Senha'
  end
  object edtUsuario: TEdit
    Left = 8
    Top = 24
    Width = 249
    Height = 21
    TabOrder = 0
  end
  object edtSenha: TEdit
    Left = 8
    Top = 64
    Width = 249
    Height = 21
    PasswordChar = '*'
    TabOrder = 1
  end
  object BtnSair: TBitBtn
    Left = 182
    Top = 104
    Width = 75
    Height = 25
    Caption = 'Sair'
    ModalResult = 2
    TabOrder = 2
  end
  object BtnEntrar: TBitBtn
    Left = 8
    Top = 104
    Width = 75
    Height = 25
    Caption = 'Entrar'
    Default = True
    TabOrder = 3
    OnClick = BtnEntrarClick
  end
end
