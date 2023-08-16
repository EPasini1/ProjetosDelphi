object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 453
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Login'
    TabOrder = 0
    OnClick = Button1Click
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 39
    Width = 619
    Height = 178
    Caption = 'Assinar'
    Enabled = False
    TabOrder = 1
    object Button2: TButton
      Left = 541
      Top = 143
      Width = 75
      Height = 25
      Caption = 'Assinar'
      Enabled = False
      TabOrder = 0
      OnClick = Button2Click
    end
    object GroupBox3: TGroupBox
      Left = 3
      Top = 20
      Width = 605
      Height = 53
      Caption = 'Arquivo'
      TabOrder = 1
      object SpeedButton1: TSpeedButton
        Left = 576
        Top = 17
        Width = 27
        Height = 22
        Caption = '...'
        OnClick = SpeedButton1Click
      end
      object Edit1: TEdit
        Left = 3
        Top = 18
        Width = 570
        Height = 21
        Enabled = False
        TabOrder = 0
      end
    end
    object GroupBox4: TGroupBox
      Left = 0
      Top = 79
      Width = 608
      Height = 58
      Caption = 'Signat'#225'rio'
      TabOrder = 2
      object SpeedButton2: TSpeedButton
        Left = 579
        Top = 21
        Width = 27
        Height = 21
        Caption = 'Add'
        OnClick = SpeedButton2Click
      end
      object Edit2: TEdit
        Left = 6
        Top = 21
        Width = 567
        Height = 21
        TabOrder = 0
      end
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 232
    Width = 619
    Height = 209
    Caption = 'Log de Erros:'
    TabOrder = 2
    object Memo1: TMemo
      Left = 2
      Top = 15
      Width = 615
      Height = 186
      Align = alTop
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 'PDF|*.pdf'
    Left = 136
    Top = 65535
  end
end
