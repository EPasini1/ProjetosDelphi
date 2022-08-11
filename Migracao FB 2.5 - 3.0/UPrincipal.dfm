object FPrincipal: TFPrincipal
  Left = 0
  Top = 0
  Caption = 'Migra'#231#227'o Firebird 2.5 para 4.0'
  ClientHeight = 177
  ClientWidth = 385
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object SpeedButton1: TSpeedButton
    Left = 343
    Top = 24
    Width = 23
    Height = 22
    Caption = '...'
    OnClick = SpeedButton1Click
  end
  object Label1: TLabel
    Left = 24
    Top = 8
    Width = 138
    Height = 13
    Caption = 'Selecione a Base Original 2.5'
  end
  object Label2: TLabel
    Left = 24
    Top = 51
    Width = 184
    Height = 13
    Caption = 'Selecione onde salvar a base migrada:'
  end
  object SpeedButton2: TSpeedButton
    Left = 343
    Top = 64
    Width = 23
    Height = 22
    Caption = '...'
    OnClick = SpeedButton2Click
  end
  object edt_BaseOriginal: TEdit
    Left = 24
    Top = 24
    Width = 313
    Height = 21
    ReadOnly = True
    TabOrder = 0
    OnChange = edt_BaseOriginalChange
  end
  object edt_BaseMigrada: TEdit
    Left = 24
    Top = 64
    Width = 313
    Height = 21
    ReadOnly = True
    TabOrder = 1
    OnChange = edt_BaseMigradaChange
  end
  object btn_Iniciar: TButton
    Left = 144
    Top = 139
    Width = 75
    Height = 25
    Caption = 'Iniciar'
    Enabled = False
    TabOrder = 2
    OnClick = btn_IniciarClick
  end
  object rg_VersaoFB: TRadioGroup
    Left = 24
    Top = 91
    Width = 153
    Height = 42
    Caption = 'Vers'#227'o do FB - Base Original'
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      '2.5'
      '3.0')
    TabOrder = 3
  end
  object rg_VersaoFBMig: TRadioGroup
    Left = 183
    Top = 91
    Width = 153
    Height = 42
    Caption = 'Vers'#227'o do FB - Base Migrada'
    Columns = 2
    ItemIndex = 1
    Items.Strings = (
      '3.0'
      '4.0')
    TabOrder = 4
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Firebird Database|*.fdb'
    Left = 40
    Top = 136
  end
  object SaveDialog1: TSaveDialog
    FileName = 'Base_Migracao'
    Filter = 'Firebird Database|*.fdb'
    Left = 104
    Top = 136
  end
end
