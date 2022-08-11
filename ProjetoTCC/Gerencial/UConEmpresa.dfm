object FrmConEmpresa: TFrmConEmpresa
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Consulta de Empresa'
  ClientHeight = 442
  ClientWidth = 695
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PnlBotoes: TPanel
    Left = 0
    Top = 386
    Width = 695
    Height = 56
    Align = alBottom
    TabOrder = 0
    object BtnFechar: TBitBtn
      Left = 600
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Fechar'
      TabOrder = 0
      OnClick = BtnFecharClick
    end
    object BtnIncluir: TBitBtn
      Left = 357
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Incluir'
      TabOrder = 1
      OnClick = BtnIncluirClick
    end
    object BtnAlterar: TBitBtn
      Left = 438
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Alterar'
      TabOrder = 2
      OnClick = BtnAlterarClick
    end
    object BtnDeleta: TBitBtn
      Left = 519
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Deleta'
      TabOrder = 3
      OnClick = BtnDeletaClick
    end
  end
  object PnlPesquisa: TPanel
    Left = 0
    Top = 0
    Width = 695
    Height = 41
    Align = alTop
    TabOrder = 1
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 41
    Width = 695
    Height = 345
    Align = alClient
    DataSource = DSEmpresa
    Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgTitleClick, dgTitleHotTrack]
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object QryEmpresa: TFDQuery
    Connection = DM.Conn
    SQL.Strings = (
      'select * from empresa')
    Left = 72
    Top = 88
    object QryEmpresaEMP_ID: TIntegerField
      DisplayLabel = 'C'#243'digo'
      DisplayWidth = 5
      FieldName = 'EMP_ID'
      Origin = 'EMP_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object QryEmpresaEMP_RAZAO: TStringField
      DisplayLabel = 'Raz'#227'o Social'
      DisplayWidth = 30
      FieldName = 'EMP_RAZAO'
      Origin = 'EMP_RAZAO'
      Size = 100
    end
    object QryEmpresaEMP_FANTASIA: TStringField
      DisplayLabel = 'Fantasia'
      DisplayWidth = 30
      FieldName = 'EMP_FANTASIA'
      Origin = 'EMP_FANTASIA'
      Size = 100
    end
    object QryEmpresaEMP_CNPJ: TStringField
      DisplayLabel = 'CNPJ'
      DisplayWidth = 20
      FieldName = 'EMP_CNPJ'
      Origin = 'EMP_CNPJ'
      Size = 50
    end
    object QryEmpresaEMP_LOCA: TStringField
      DisplayLabel = 'Localiza'#231#227'o'
      FieldName = 'EMP_LOCA'
      Origin = 'EMP_LOCA'
      Size = 100
    end
  end
  object DSEmpresa: TDataSource
    DataSet = QryEmpresa
    Left = 72
    Top = 152
  end
end
