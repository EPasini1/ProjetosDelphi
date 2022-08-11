object FrmConData: TFrmConData
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Consulta de Datas de Entrega'
  ClientHeight = 455
  ClientWidth = 660
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PnlBotoes: TPanel
    Left = 0
    Top = 414
    Width = 660
    Height = 41
    Align = alBottom
    TabOrder = 0
    ExplicitTop = 404
    ExplicitWidth = 650
    object BtnFechar: TBitBtn
      Left = 560
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Fechar'
      TabOrder = 0
      OnClick = BtnFecharClick
    end
    object BtnIncluir: TBitBtn
      Left = 398
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Incluir'
      TabOrder = 1
      OnClick = BtnIncluirClick
    end
    object BtnAlterar: TBitBtn
      Left = 479
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Alterar'
      TabOrder = 2
      OnClick = BtnAlterarClick
    end
  end
  object PnlPesquisa: TPanel
    Left = 0
    Top = 0
    Width = 660
    Height = 41
    Align = alTop
    TabOrder = 1
    ExplicitWidth = 650
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 41
    Width = 660
    Height = 373
    Align = alClient
    DataSource = DSData
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object QryData: TFDQuery
    Connection = DM.Conn
    SQL.Strings = (
      'select DATA_ENTREGA.*, VDU_NOME'
      'from DATA_ENTREGA'
      'left outer join EMPRESA on EMP_ID = DTE_EMP'
      'left outer join VARIEDADE_DE_UVA on VDU_ID = DTE_VARIEDADE_UVA')
    Left = 136
    Top = 120
    object QryDataDTE_ID: TIntegerField
      FieldName = 'DTE_ID'
      Origin = 'DTE_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Visible = False
    end
    object QryDataDTE_EMP: TIntegerField
      DisplayLabel = 'Empresa'
      FieldName = 'DTE_EMP'
      Origin = 'DTE_EMP'
    end
    object QryDataDTE_INI: TDateField
      DisplayLabel = 'In'#237'cio'
      FieldName = 'DTE_INI'
      Origin = 'DTE_INI'
    end
    object QryDataDTE_FIM: TDateField
      DisplayLabel = 'Fim'
      FieldName = 'DTE_FIM'
      Origin = 'DTE_FIM'
    end
    object QryDataDTE_VARIEDADE_UVA: TIntegerField
      FieldName = 'DTE_VARIEDADE_UVA'
      Origin = 'DTE_VARIEDADE_UVA'
      Visible = False
    end
    object QryDataVDU_NOME: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Variedade'
      DisplayWidth = 50
      FieldName = 'VDU_NOME'
      Origin = 'VDU_NOME'
      ProviderFlags = []
      ReadOnly = True
      Size = 100
    end
  end
  object DSData: TDataSource
    DataSet = QryData
    Left = 136
    Top = 184
  end
end
