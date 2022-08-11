object FrmCadHorEntrega: TFrmCadHorEntrega
  Left = 0
  Top = 0
  Caption = 'Cadastro de Hor'#225'rios de Entrega'
  ClientHeight = 498
  ClientWidth = 498
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PnlCarrega: TPanel
    Left = 20
    Top = 128
    Width = 459
    Height = 204
    Caption = 'Aguarde carregando...'
    TabOrder = 2
    Visible = False
    object ProgressBar1: TProgressBar
      Left = 61
      Top = 115
      Width = 340
      Height = 17
      TabOrder = 0
    end
    object ProgressBar2: TProgressBar
      Left = 61
      Top = 138
      Width = 340
      Height = 17
      TabOrder = 1
    end
  end
  object PnlBotoes: TPanel
    Left = 0
    Top = 436
    Width = 498
    Height = 62
    Align = alBottom
    TabOrder = 0
    object BtnOK: TBitBtn
      Left = 404
      Top = 16
      Width = 75
      Height = 25
      Caption = 'OK'
      TabOrder = 0
      OnClick = BtnOKClick
    end
  end
  object PnlDatas: TPanel
    Left = 0
    Top = 0
    Width = 498
    Height = 436
    Align = alClient
    TabOrder = 1
    object Label1: TLabel
      Left = 20
      Top = 196
      Width = 70
      Height = 13
      Caption = 'Segunda-Feira'
    end
    object Label2: TLabel
      Left = 20
      Top = 129
      Width = 171
      Height = 13
      Caption = 'Tempo de intervalo entre entregas:'
    end
    object Label3: TLabel
      Left = 20
      Top = 244
      Width = 55
      Height = 13
      Caption = 'Ter'#231'a-Feira'
    end
    object Label4: TLabel
      Left = 18
      Top = 275
      Width = 62
      Height = 13
      Caption = 'Quarta-Feira'
    end
    object Label5: TLabel
      Left = 20
      Top = 307
      Width = 60
      Height = 13
      Caption = 'Quinta-Feira'
    end
    object Label6: TLabel
      Left = 20
      Top = 338
      Width = 56
      Height = 13
      Caption = 'Sexta-Feira'
    end
    object Label7: TLabel
      Left = 20
      Top = 369
      Width = 36
      Height = 13
      Caption = 'S'#225'bado'
    end
    object Label8: TLabel
      Left = 20
      Top = 400
      Width = 41
      Height = 13
      Caption = 'Domingo'
    end
    object Label9: TLabel
      Left = 123
      Top = 175
      Width = 25
      Height = 13
      Caption = 'In'#237'cio'
    end
    object Label10: TLabel
      Left = 197
      Top = 175
      Width = 16
      Height = 13
      Caption = 'Fim'
    end
    object GBDiasDaSemana: TGroupBox
      Left = 8
      Top = 0
      Width = 481
      Height = 122
      Caption = 'Dias da Semana'
      TabOrder = 0
      object DBCBSeg: TDBCheckBox
        Left = 12
        Top = 24
        Width = 97
        Height = 17
        Caption = 'Segunda-Feira'
        DataField = 'DSE_SEG'
        DataSource = DSDiaSemanaEntrega
        TabOrder = 0
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        OnClick = DBCBSegClick
      end
      object DBCBTer: TDBCheckBox
        Left = 12
        Top = 47
        Width = 97
        Height = 17
        Caption = 'Ter'#231'a-Feira'
        DataField = 'DSE_TER'
        DataSource = DSDiaSemanaEntrega
        TabOrder = 1
        ValueChecked = 'T'
        ValueUnchecked = 'F'
      end
      object DBCBQua: TDBCheckBox
        Left = 12
        Top = 70
        Width = 97
        Height = 17
        Caption = 'Quarta-Feira'
        DataField = 'DSE_QUA'
        DataSource = DSDiaSemanaEntrega
        TabOrder = 2
        ValueChecked = 'T'
        ValueUnchecked = 'F'
      end
      object DBCBQui: TDBCheckBox
        Left = 115
        Top = 24
        Width = 97
        Height = 17
        Caption = 'Quinta-Feira'
        DataField = 'DSE_QUI'
        DataSource = DSDiaSemanaEntrega
        TabOrder = 3
        ValueChecked = 'T'
        ValueUnchecked = 'F'
      end
      object DBCBSex: TDBCheckBox
        Left = 115
        Top = 47
        Width = 97
        Height = 17
        Caption = 'Sexta-Feira'
        DataField = 'DSE_SEX'
        DataSource = DSDiaSemanaEntrega
        TabOrder = 4
        ValueChecked = 'T'
        ValueUnchecked = 'F'
      end
      object DBCBSab: TDBCheckBox
        Left = 115
        Top = 70
        Width = 97
        Height = 17
        Caption = 'S'#225'bado'
        DataField = 'DSE_SAB'
        DataSource = DSDiaSemanaEntrega
        TabOrder = 5
        ValueChecked = 'T'
        ValueUnchecked = 'F'
      end
      object DBCBDom: TDBCheckBox
        Left = 228
        Top = 24
        Width = 97
        Height = 17
        Caption = 'Domingo'
        DataField = 'DSE_DOM'
        DataSource = DSDiaSemanaEntrega
        TabOrder = 6
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        OnClick = DBCBSegClick
      end
    end
    object BitBtn1: TBitBtn
      Left = 20
      Top = 216
      Width = 211
      Height = 21
      Caption = 'Replicar Hor'#225'rios'
      TabOrder = 1
      OnClick = BitBtn1Click
    end
    object TPSegInicio: TTimePicker
      Left = 99
      Top = 192
      Width = 60
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ShowOkCancel = False
      TabOrder = 2
      Time = 44700.573903865740000000
      TimeFormat = 'hh:mm'
    end
    object TPTerInicio: TTimePicker
      Left = 99
      Top = 240
      Width = 60
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      TabOrder = 3
      Time = 44700.573903877320000000
      TimeFormat = 'hh:mm'
    end
    object TPQuaInicio: TTimePicker
      Left = 99
      Top = 271
      Width = 60
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      TabOrder = 4
      Time = 44700.573903877320000000
      TimeFormat = 'hh:mm'
    end
    object TPQuiInicio: TTimePicker
      Left = 99
      Top = 303
      Width = 60
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      TabOrder = 5
      Time = 44700.573903877320000000
      TimeFormat = 'hh:mm'
    end
    object TPSexInicio: TTimePicker
      Left = 99
      Top = 334
      Width = 60
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      TabOrder = 6
      Time = 44700.573903877320000000
      TimeFormat = 'hh:mm'
    end
    object TPSabInicio: TTimePicker
      Left = 99
      Top = 365
      Width = 60
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      TabOrder = 7
      Time = 44700.573903877320000000
      TimeFormat = 'hh:mm'
    end
    object TPDomInicio: TTimePicker
      Left = 99
      Top = 396
      Width = 60
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      TabOrder = 8
      Time = 44700.573903877320000000
      TimeFormat = 'hh:mm'
    end
    object TPSegFim: TTimePicker
      Left = 179
      Top = 192
      Width = 60
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ShowOkCancel = False
      TabOrder = 9
      Time = 44700.573903877320000000
      TimeFormat = 'hh:mm'
    end
    object TPTerFim: TTimePicker
      Left = 179
      Top = 240
      Width = 60
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      TabOrder = 10
      Time = 44700.573903877320000000
      TimeFormat = 'hh:mm'
    end
    object TPQuaFim: TTimePicker
      Left = 179
      Top = 271
      Width = 60
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      TabOrder = 11
      Time = 44700.573903877320000000
      TimeFormat = 'hh:mm'
    end
    object TPQuiFim: TTimePicker
      Left = 179
      Top = 303
      Width = 60
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      TabOrder = 12
      Time = 44700.573903877320000000
      TimeFormat = 'hh:mm'
    end
    object TPSexFim: TTimePicker
      Left = 179
      Top = 334
      Width = 60
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      TabOrder = 13
      Time = 44700.573903877320000000
      TimeFormat = 'hh:mm'
    end
    object TPSabFim: TTimePicker
      Left = 179
      Top = 365
      Width = 60
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      TabOrder = 14
      Time = 44700.573903877320000000
      TimeFormat = 'hh:mm'
    end
    object TPDomFim: TTimePicker
      Left = 179
      Top = 396
      Width = 60
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      TabOrder = 15
      Time = 44700.573903877320000000
      TimeFormat = 'hh:mm'
    end
    object TPIntervalo: TTimePicker
      Left = 197
      Top = 128
      Width = 60
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ShowOkCancel = False
      TabOrder = 16
      Time = 44700.573903877320000000
      TimeFormat = 'hh:mm'
    end
  end
  object QryDiaSemanaEntrega: TFDQuery
    Connection = DM.Conn
    Transaction = DM.Transaction
    SQL.Strings = (
      'SELECT * FROM DIA_SEMANA_ENTREGA'
      'WHERE DSE_EMP = :DSE_EMP'
      'and DSE_VAR_UVA = :DSE_VAR_UVA')
    Left = 320
    Top = 144
    ParamData = <
      item
        Name = 'DSE_EMP'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end
      item
        Name = 'DSE_VAR_UVA'
        ArrayType = atArray
        ArraySize = 5
        DataType = ftInteger
        ParamType = ptInput
      end>
    object QryDiaSemanaEntregaDSE_EMP: TIntegerField
      FieldName = 'DSE_EMP'
      Origin = 'DSE_EMP'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object QryDiaSemanaEntregaDSE_VAR_UVA: TIntegerField
      FieldName = 'DSE_VAR_UVA'
      Origin = 'DSE_VAR_UVA'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object QryDiaSemanaEntregaDSE_SEG: TStringField
      FieldName = 'DSE_SEG'
      Origin = 'DSE_SEG'
      FixedChar = True
      Size = 1
    end
    object QryDiaSemanaEntregaDSE_TER: TStringField
      FieldName = 'DSE_TER'
      Origin = 'DSE_TER'
      FixedChar = True
      Size = 1
    end
    object QryDiaSemanaEntregaDSE_QUA: TStringField
      FieldName = 'DSE_QUA'
      Origin = 'DSE_QUA'
      FixedChar = True
      Size = 1
    end
    object QryDiaSemanaEntregaDSE_QUI: TStringField
      FieldName = 'DSE_QUI'
      Origin = 'DSE_QUI'
      FixedChar = True
      Size = 1
    end
    object QryDiaSemanaEntregaDSE_SEX: TStringField
      FieldName = 'DSE_SEX'
      Origin = 'DSE_SEX'
      FixedChar = True
      Size = 1
    end
    object QryDiaSemanaEntregaDSE_SAB: TStringField
      FieldName = 'DSE_SAB'
      Origin = 'DSE_SAB'
      FixedChar = True
      Size = 1
    end
    object QryDiaSemanaEntregaDSE_DOM: TStringField
      FieldName = 'DSE_DOM'
      Origin = 'DSE_DOM'
      FixedChar = True
      Size = 1
    end
  end
  object DSDiaSemanaEntrega: TDataSource
    DataSet = QryDiaSemanaEntrega
    Left = 320
    Top = 200
  end
  object QryHorarioEntregaEmpresa: TFDQuery
    MasterSource = DSDiaSemanaEntrega
    Connection = DM.Conn
    Transaction = DM.Transaction
    SQL.Strings = (
      'SELECT * FROM HORARIOS_ENTREGA_EMPRESA'
      'WHERE HEE_EMP = :HEE_EMP'
      'and HEE_VAR_UVA = :HEE_VAR_UVA'
      'and HEE_DTE = :HEE_DTE')
    Left = 320
    Top = 256
    ParamData = <
      item
        Name = 'HEE_EMP'
        ParamType = ptInput
      end
      item
        Name = 'HEE_VAR_UVA'
        ParamType = ptInput
      end
      item
        Name = 'HEE_DTE'
        ParamType = ptInput
      end>
  end
  object QryAux: TFDQuery
    Connection = DM.Conn
    Transaction = DM.Transaction
    Left = 320
    Top = 328
  end
end
