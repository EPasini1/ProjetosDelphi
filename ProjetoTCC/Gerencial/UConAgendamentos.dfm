object FrmConAgengamentos: TFrmConAgengamentos
  Left = 0
  Top = 0
  Caption = 'Agendamentos'
  ClientHeight = 537
  ClientWidth = 857
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 857
    Height = 484
    Align = alClient
    TabOrder = 0
    object DBGrid1: TDBGrid
      Left = 1
      Top = 1
      Width = 855
      Height = 482
      Align = alClient
      DataSource = DSAgendamentos
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
  end
  object PnlBotoes: TPanel
    Left = 0
    Top = 484
    Width = 857
    Height = 53
    Align = alBottom
    TabOrder = 1
    object BtnFechar: TBitBtn
      Left = 752
      Top = 14
      Width = 75
      Height = 25
      Caption = 'Fechar'
      TabOrder = 0
      OnClick = BtnFecharClick
    end
    object BtnOk: TBitBtn
      Left = 671
      Top = 14
      Width = 75
      Height = 25
      Caption = 'OK'
      TabOrder = 1
    end
    object BtnExcluir: TBitBtn
      Left = 590
      Top = 15
      Width = 75
      Height = 25
      Caption = 'Excluir'
      TabOrder = 2
      OnClick = BtnExcluirClick
    end
  end
  object QryAgendamentos: TFDQuery
    Connection = DM.Conn
    Transaction = DM.Transaction
    SQL.Strings = (
      
        'select AGP_ID, PRO_NOME, AGP_DIA, HOE_INI, VDU_NOME, EMP_FANTASI' +
        'A'
      'from AGENDAMENTO_PRODUTOR'
      'join DATA_ENTREGA on DTE_ID = AGP_DTE'
      'join HORARIOS_ENTREGA on HOE_ID = AGP_HOE'
      'join VARIEDADE_DE_UVA on VDU_ID = AGP_VAR_UVA'
      'join EMPRESA on EMP_ID = AGP_EMP'
      'join PRODUTOR on PRO_ID = AGP_PRO')
    Left = 160
    Top = 168
    object QryAgendamentosAGP_ID: TIntegerField
      FieldName = 'AGP_ID'
      Origin = 'AGP_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Visible = False
    end
    object QryAgendamentosPRO_NOME: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Produtor'
      DisplayWidth = 20
      FieldName = 'PRO_NOME'
      Origin = 'PRO_NOME'
      ProviderFlags = []
      ReadOnly = True
      Size = 100
    end
    object QryAgendamentosAGP_DIA: TDateField
      DisplayLabel = 'Data'
      FieldName = 'AGP_DIA'
      Origin = 'AGP_DIA'
    end
    object QryAgendamentosHOE_INI: TTimeField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Hor'#225'rio'
      FieldName = 'HOE_INI'
      Origin = 'HOE_INI'
      ProviderFlags = []
      ReadOnly = True
    end
    object QryAgendamentosVDU_NOME: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Variedade'
      DisplayWidth = 20
      FieldName = 'VDU_NOME'
      Origin = 'VDU_NOME'
      ProviderFlags = []
      ReadOnly = True
      Size = 100
    end
    object QryAgendamentosEMP_FANTASIA: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Empresa'
      DisplayWidth = 20
      FieldName = 'EMP_FANTASIA'
      Origin = 'EMP_FANTASIA'
      ProviderFlags = []
      ReadOnly = True
      Size = 100
    end
  end
  object DSAgendamentos: TDataSource
    DataSet = QryAgendamentos
    Left = 160
    Top = 224
  end
end
