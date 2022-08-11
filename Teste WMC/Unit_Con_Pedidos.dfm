object Form_Con_Pedidos: TForm_Con_Pedidos
  Left = 0
  Top = 0
  Caption = 'Form_Con_Pedidos'
  ClientHeight = 126
  ClientWidth = 218
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 0
    Width = 60
    Height = 13
    Caption = 'Quantidade:'
  end
  object Label2: TLabel
    Left = 104
    Top = 0
    Width = 28
    Height = 13
    Caption = 'Valor:'
  end
  object Label3: TLabel
    Left = 8
    Top = 46
    Width = 24
    Height = 13
    Caption = 'Total'
  end
  object edtQuantidade: TEdit
    Left = 8
    Top = 19
    Width = 79
    Height = 21
    TabOrder = 0
    Text = '5'
  end
  object edt_Valor: TEdit
    Left = 104
    Top = 19
    Width = 79
    Height = 21
    TabOrder = 1
  end
  object Calcular: TButton
    Left = 104
    Top = 63
    Width = 75
    Height = 25
    Caption = 'Calcular'
    TabOrder = 2
    OnClick = CalcularClick
  end
  object Edit1: TEdit
    Left = 8
    Top = 65
    Width = 79
    Height = 21
    TabOrder = 3
  end
end
