object FrmConProdutor: TFrmConProdutor
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Consulta de Produtor'
  ClientHeight = 345
  ClientWidth = 490
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
  object DBGrid1: TDBGrid
    Left = 0
    Top = 49
    Width = 490
    Height = 243
    Align = alClient
    DataSource = DSProdutor
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object PnlBotoes: TPanel
    Left = 0
    Top = 292
    Width = 490
    Height = 53
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      490
      53)
    object BtnFechar: TBitBtn
      Left = 406
      Top = 16
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Fechar'
      TabOrder = 0
      OnClick = BtnFecharClick
    end
    object BtnIncluir: TBitBtn
      Left = 244
      Top = 16
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Incluir'
      TabOrder = 1
      OnClick = BtnIncluirClick
    end
    object BtnAlterar: TBitBtn
      Left = 325
      Top = 16
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
    Width = 490
    Height = 49
    Align = alTop
    TabOrder = 2
  end
  object QryProdutor: TFDQuery
    Connection = DM.Conn
    SQL.Strings = (
      'select * from produtor')
    Left = 136
    Top = 112
    object QryProdutorPRO_ID: TIntegerField
      DisplayLabel = 'C'#243'digo'
      DisplayWidth = 5
      FieldName = 'PRO_ID'
      Origin = 'PRO_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object QryProdutorPRO_EMP: TIntegerField
      DisplayLabel = 'Empresa'
      DisplayWidth = 5
      FieldName = 'PRO_EMP'
      Origin = 'PRO_EMP'
    end
    object QryProdutorPRO_CPF: TStringField
      DisplayLabel = 'CPF'
      DisplayWidth = 15
      FieldName = 'PRO_CPF'
      Origin = 'PRO_CPF'
      Size = 50
    end
    object QryProdutorPRO_NOME: TStringField
      DisplayLabel = 'Nome'
      DisplayWidth = 40
      FieldName = 'PRO_NOME'
      Origin = 'PRO_NOME'
      Size = 100
    end
  end
  object DSProdutor: TDataSource
    DataSet = QryProdutor
    Left = 136
    Top = 176
  end
end
