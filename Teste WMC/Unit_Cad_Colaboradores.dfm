object Form_Cad_Colaboradores: TForm_Cad_Colaboradores
  Left = 0
  Top = 0
  Caption = 'Cadastro de Colaboradores'
  ClientHeight = 289
  ClientWidth = 654
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object gb_Colaborador: TGroupBox
    Left = 8
    Top = 8
    Width = 641
    Height = 121
    Caption = 'Colaborador'
    TabOrder = 0
    object lbl_Codigo: TLabel
      Left = 16
      Top = 16
      Width = 33
      Height = 13
      Caption = 'C'#243'digo'
    end
    object lbl_Nome: TLabel
      Left = 141
      Top = 16
      Width = 27
      Height = 13
      Caption = 'Nome'
    end
    object lbl_CPF: TLabel
      Left = 420
      Top = 16
      Width = 19
      Height = 13
      Caption = 'CPF'
    end
    object lbl_RG: TLabel
      Left = 517
      Top = 16
      Width = 14
      Height = 13
      Caption = 'RG'
    end
    object lbl_Fone: TLabel
      Left = 14
      Top = 56
      Width = 24
      Height = 13
      Caption = 'Fone'
    end
    object lbl_Celular: TLabel
      Left = 106
      Top = 56
      Width = 33
      Height = 13
      Caption = 'Celular'
    end
    object lbl_DataNascimento: TLabel
      Left = 201
      Top = 56
      Width = 95
      Height = 13
      Caption = 'Data de nascimento'
    end
    object lbl_Email: TLabel
      Left = 303
      Top = 56
      Width = 24
      Height = 13
      Caption = 'Email'
    end
    object lbl_Salario: TLabel
      Left = 430
      Top = 56
      Width = 32
      Height = 13
      Caption = 'Sal'#225'rio'
    end
    object edt_CodigoColaborador: TEdit
      Tag = 1
      Left = 14
      Top = 35
      Width = 121
      Height = 21
      Enabled = False
      TabOrder = 0
      Text = '0'
    end
    object edt_NomeColaborador: TEdit
      Tag = 1
      Left = 141
      Top = 35
      Width = 273
      Height = 21
      TabOrder = 1
    end
    object me_RG: TMaskEdit
      Tag = 1
      Left = 517
      Top = 35
      Width = 89
      Height = 21
      EditMask = '0000000000'
      MaxLength = 10
      TabOrder = 3
      Text = '          '
    end
    object me_Fone: TMaskEdit
      Left = 14
      Top = 75
      Width = 82
      Height = 21
      EditMask = '(00)00000-0000;1;_'
      MaxLength = 14
      TabOrder = 4
      Text = '(  )     -    '
    end
    object me_Celular: TMaskEdit
      Tag = 1
      Left = 107
      Top = 75
      Width = 84
      Height = 21
      EditMask = '(00)00000-0000;1;_'
      MaxLength = 14
      TabOrder = 5
      Text = '(  )     -    '
    end
    object dtp_DataNascimento: TDateTimePicker
      Tag = 1
      Left = 201
      Top = 75
      Width = 96
      Height = 21
      Date = 44280.000000000000000000
      Time = 0.860175289351900600
      TabOrder = 6
    end
    object edt_Email: TEdit
      Tag = 1
      Left = 303
      Top = 75
      Width = 121
      Height = 21
      TabOrder = 7
    end
    object edt_Salario: TEdit
      Left = 430
      Top = 75
      Width = 121
      Height = 21
      TabOrder = 8
    end
    object me_CPF: TMaskEdit
      Tag = 1
      Left = 420
      Top = 35
      Width = 91
      Height = 21
      EditMask = '000.000.000-00'
      MaxLength = 14
      TabOrder = 2
      Text = '   .   .   -  '
    end
  end
  object gb_Endereco: TGroupBox
    Left = 8
    Top = 135
    Width = 641
    Height = 122
    Caption = 'Endere'#231'o'
    TabOrder = 1
    object lbl_Endereco: TLabel
      Left = 16
      Top = 16
      Width = 45
      Height = 13
      Caption = 'Endere'#231'o'
    end
    object Label2: TLabel
      Left = 18
      Top = 66
      Width = 65
      Height = 13
      Caption = 'Complemento'
    end
    object Label3: TLabel
      Left = 440
      Top = 66
      Width = 33
      Height = 13
      Caption = 'Cidade'
    end
    object Label4: TLabel
      Left = 369
      Top = 16
      Width = 37
      Height = 13
      Caption = 'N'#250'mero'
    end
    object lbl_Bairro: TLabel
      Left = 497
      Top = 16
      Width = 28
      Height = 13
      Caption = 'Bairro'
    end
    object Label1: TLabel
      Left = 369
      Top = 66
      Width = 19
      Height = 13
      Caption = 'CEP'
    end
    object edt_Endereco: TEdit
      Tag = 1
      Left = 14
      Top = 35
      Width = 347
      Height = 21
      TabOrder = 0
    end
    object edt_Complemento: TEdit
      Tag = 1
      Left = 16
      Top = 85
      Width = 345
      Height = 21
      TabOrder = 3
    end
    object edt_Numero: TEdit
      Tag = 1
      Left = 367
      Top = 35
      Width = 121
      Height = 21
      TabOrder = 1
    end
    object edt_Bairro: TEdit
      Tag = 1
      Left = 495
      Top = 35
      Width = 121
      Height = 21
      TabOrder = 2
    end
    object me_CEP: TMaskEdit
      Tag = 1
      Left = 367
      Top = 85
      Width = 67
      Height = 21
      EditMask = '00000-000'
      MaxLength = 9
      TabOrder = 4
      Text = '     -   '
    end
    object edt_CodCidade: TEdit
      Left = 440
      Top = 85
      Width = 65
      Height = 21
      Enabled = False
      TabOrder = 6
      OnKeyUp = edt_CodCidadeKeyUp
    end
    object edt_Cidade: TEdit
      Tag = 1
      Left = 511
      Top = 85
      Width = 121
      Height = 21
      TabOrder = 5
      OnKeyUp = edt_CidadeKeyUp
    end
  end
  object btn_Inserir: TButton
    Left = 571
    Top = 263
    Width = 75
    Height = 25
    Caption = 'Inserir'
    TabOrder = 2
    OnClick = btn_InserirClick
  end
  object btn_Alterar: TButton
    Left = 571
    Top = 263
    Width = 75
    Height = 25
    Caption = 'Alterar'
    TabOrder = 3
    OnClick = btn_AlterarClick
  end
  object DS_Municipios: TDataSource
    Left = 584
    Top = 72
  end
  object SQL_Municipios: TZQuery
    Connection = Form_Principal.ZConnection1
    SQL.Strings = (
      'select MUNICIPIO  from MUNICIPIOS'
      'order by MUNICIPIO')
    Params = <>
    DataSource = DS_Municipios
    Left = 584
    Top = 16
  end
  object SQLColaboradores: TZQuery
    Connection = Form_Principal.ZConnection1
    SQL.Strings = (
      'select * from colaboradores where codigo = :codigo')
    Params = <
      item
        DataType = ftUnknown
        Name = 'codigo'
        ParamType = ptUnknown
      end>
    Left = 584
    Top = 200
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'codigo'
        ParamType = ptUnknown
      end>
  end
  object SSP_Colaboradores: TZStoredProc
    Connection = Form_Principal.ZConnection1
    Params = <
      item
        DataType = ftWideString
        Name = 'TIPO'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'NOME'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'ENDERECO'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'BAIRRO'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'NUMERO'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'COMPLEMENTO'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'CIDADE'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'CEP'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'CPF'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'RG'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'FONE'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'CELULAR'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'DATA_NASCIMENTO'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'EMAIL'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'SALARIO'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'CODIGO'
        ParamType = ptInput
      end>
    StoredProcName = 'PROC_COLABORADORES'
    Left = 584
    Top = 136
    ParamData = <
      item
        DataType = ftWideString
        Name = 'TIPO'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'NOME'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'ENDERECO'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'BAIRRO'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'NUMERO'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'COMPLEMENTO'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'CIDADE'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'CEP'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'CPF'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'RG'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'FONE'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'CELULAR'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'DATA_NASCIMENTO'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'EMAIL'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'SALARIO'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'CODIGO'
        ParamType = ptInput
      end>
  end
end
