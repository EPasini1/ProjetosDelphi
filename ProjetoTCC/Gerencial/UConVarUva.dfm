object FrmConVarUva: TFrmConVarUva
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Consulta de Variedade de Uva'
  ClientHeight = 443
  ClientWidth = 857
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
  object PnlPesquisa: TPanel
    Left = 0
    Top = 0
    Width = 857
    Height = 49
    Align = alTop
    TabOrder = 0
  end
  object PnlBotoes: TPanel
    Left = 0
    Top = 386
    Width = 857
    Height = 57
    Align = alBottom
    TabOrder = 1
    object BtnFechar: TBitBtn
      Left = 752
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Fechar'
      TabOrder = 0
      OnClick = BtnFecharClick
    end
    object BtnIncluir: TBitBtn
      Left = 519
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Incluir'
      TabOrder = 1
      OnClick = BtnIncluirClick
    end
    object BtnAlterar: TBitBtn
      Left = 597
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Alterar'
      TabOrder = 2
      OnClick = BtnAlterarClick
    end
    object BtnExcluir: TBitBtn
      Left = 674
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Excluir'
      TabOrder = 3
      OnClick = BtnExcluirClick
    end
    object BtnHorEntrega: TBitBtn
      Left = 398
      Top = 16
      Width = 115
      Height = 25
      Caption = 'Hor'#225'rios de Entrega'
      Enabled = False
      TabOrder = 4
      OnClick = BtnHorEntregaClick
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 49
    Width = 857
    Height = 337
    Align = alClient
    DataSource = DSTipoDeUva
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object QryTipoUva: TFDQuery
    Connection = DM.Conn
    SQL.Strings = (
      'sELECT * FROM VARIEDADE_DE_UVA')
    Left = 88
    Top = 96
    object QryTipoUvaVDU_ID: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'VDU_ID'
      Origin = 'VDU_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object QryTipoUvaVDU_EMP: TIntegerField
      DisplayLabel = 'Empresa'
      FieldName = 'VDU_EMP'
      Origin = 'VDU_EMP'
    end
    object QryTipoUvaVDU_NOME: TStringField
      DisplayLabel = 'Variedade'
      FieldName = 'VDU_NOME'
      Origin = 'VDU_NOME'
      Size = 100
    end
  end
  object DSTipoDeUva: TDataSource
    DataSet = QryTipoUva
    OnDataChange = DSTipoDeUvaDataChange
    Left = 88
    Top = 152
  end
end
