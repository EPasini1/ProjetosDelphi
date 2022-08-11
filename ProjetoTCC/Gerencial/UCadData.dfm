object FrmCadData: TFrmCadData
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Cadastro de Datas de Entrega'
  ClientHeight = 233
  ClientWidth = 416
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PnlBotoes: TPanel
    Left = 0
    Top = 192
    Width = 416
    Height = 41
    Align = alBottom
    TabOrder = 0
    ExplicitTop = 169
    ExplicitWidth = 415
    DesignSize = (
      416
      41)
    object BtnFechar: TBitBtn
      Left = 332
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Fechar'
      TabOrder = 0
      OnClick = BtnFecharClick
      ExplicitLeft = 331
    end
    object BtnAlterar: TBitBtn
      Left = 251
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Alterar'
      TabOrder = 1
      Visible = False
      OnClick = BtnAlterarClick
      ExplicitLeft = 250
    end
    object BtnIncluir: TBitBtn
      Left = 251
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Incluir'
      TabOrder = 2
      Visible = False
      OnClick = BtnIncluirClick
      ExplicitLeft = 250
    end
  end
  object PnlCadastro: TPanel
    Left = 0
    Top = 0
    Width = 416
    Height = 192
    Align = alClient
    TabOrder = 1
    ExplicitWidth = 415
    ExplicitHeight = 169
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 33
      Height = 13
      Caption = 'C'#243'digo'
    end
    object Label2: TLabel
      Left = 8
      Top = 56
      Width = 41
      Height = 13
      Caption = 'Empresa'
    end
    object Label3: TLabel
      Left = 216
      Top = 56
      Width = 85
      Height = 13
      Caption = 'Variedade de Uva'
    end
    object Label4: TLabel
      Left = 8
      Top = 102
      Width = 51
      Height = 13
      Caption = 'Data In'#237'cio'
    end
    object Label5: TLabel
      Left = 216
      Top = 102
      Width = 42
      Height = 13
      Caption = 'Data Fim'
    end
    object EdtCodData: TEdit
      Left = 8
      Top = 27
      Width = 121
      Height = 21
      TabOrder = 0
    end
    object DBLkpEmpresa: TDBLookupComboBox
      Left = 8
      Top = 75
      Width = 185
      Height = 21
      KeyField = 'EMP_ID'
      ListField = 'EMP_FANTASIA'
      ListSource = DSEmpresa
      TabOrder = 1
    end
    object DBLkpVariedade: TDBLookupComboBox
      Left = 216
      Top = 75
      Width = 185
      Height = 21
      KeyField = 'VDU_ID'
      ListField = 'VDU_NOME'
      ListSource = DSVariedade
      TabOrder = 2
    end
    object DTPFim: TDateTimePicker
      Left = 216
      Top = 121
      Width = 186
      Height = 21
      Date = 44663.000000000000000000
      Time = 0.936083402775693700
      TabOrder = 3
    end
    object DTPInicio: TDateTimePicker
      Left = 8
      Top = 121
      Width = 186
      Height = 21
      Date = 44663.000000000000000000
      Time = 0.936083402775693700
      TabOrder = 4
    end
  end
  object QryEmpresa: TFDQuery
    Connection = DM.Conn
    Transaction = DM.Transaction
    SQL.Strings = (
      'select EMP_ID, EMP_FANTASIA from empresa')
    Left = 440
    Top = 8
    object QryEmpresaEMP_ID: TIntegerField
      FieldName = 'EMP_ID'
      Origin = 'EMP_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object QryEmpresaEMP_FANTASIA: TStringField
      FieldName = 'EMP_FANTASIA'
      Origin = 'EMP_FANTASIA'
      Size = 100
    end
  end
  object DSEmpresa: TDataSource
    DataSet = QryEmpresa
    Left = 440
    Top = 56
  end
  object QryVariedade: TFDQuery
    Connection = DM.Conn
    Transaction = DM.Transaction
    SQL.Strings = (
      'select VDU_ID, VDU_NOME from VARIEDADE_DE_UVA')
    Left = 504
    Top = 8
    object QryVariedadeVDU_ID: TIntegerField
      FieldName = 'VDU_ID'
      Origin = 'VDU_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object QryVariedadeVDU_NOME: TStringField
      FieldName = 'VDU_NOME'
      Origin = 'VDU_NOME'
      Size = 100
    end
  end
  object DSVariedade: TDataSource
    DataSet = QryVariedade
    Left = 504
    Top = 56
  end
  object QryDados: TFDQuery
    Connection = DM.Conn
    Transaction = DM.Transaction
    SQL.Strings = (
      'select DATA_ENTREGA.*, VDU_NOME'
      'from DATA_ENTREGA'
      'left outer join EMPRESA on EMP_ID = DTE_EMP'
      'left outer join VARIEDADE_DE_UVA on VDU_ID = DTE_VARIEDADE_UVA'
      'where DTE_ID = :DTE_ID')
    Left = 440
    Top = 104
    ParamData = <
      item
        Name = 'DTE_ID'
        ParamType = ptInput
      end>
  end
  object QryOperacao: TFDQuery
    Connection = DM.Conn
    Transaction = DM.Transaction
    Left = 504
    Top = 104
  end
  object QryCodData: TFDQuery
    Connection = DM.Conn
    Transaction = DM.Transaction
    SQL.Strings = (
      'select coalesce(max(DTE_ID),0) + 1 from DATA_ENTREGA')
    Left = 584
    Top = 8
  end
end
