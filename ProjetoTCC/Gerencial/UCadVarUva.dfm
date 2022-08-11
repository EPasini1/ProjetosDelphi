object FrmCadVarUva: TFrmCadVarUva
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Cadastro de Variedade de Uva'
  ClientHeight = 227
  ClientWidth = 386
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PnlBotoes: TPanel
    Left = 0
    Top = 186
    Width = 386
    Height = 41
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      386
      41)
    object BtnFechar: TBitBtn
      Left = 291
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Fechar'
      TabOrder = 0
      OnClick = BtnFecharClick
    end
    object BtnIncluir: TBitBtn
      Left = 210
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Incluir'
      TabOrder = 1
      Visible = False
      OnClick = BtnIncluirClick
    end
    object BtnAlterar: TBitBtn
      Left = 210
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Alterar'
      TabOrder = 2
      Visible = False
      OnClick = BtnAlterarClick
    end
  end
  object PnlCadastro: TPanel
    Left = 0
    Top = 0
    Width = 386
    Height = 186
    Align = alClient
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 62
      Width = 52
      Height = 13
      Caption = 'Variedade:'
    end
    object Label2: TLabel
      Left = 16
      Top = 16
      Width = 33
      Height = 13
      Caption = 'C'#243'digo'
    end
    object Label3: TLabel
      Left = 16
      Top = 112
      Width = 41
      Height = 13
      Caption = 'Empresa'
    end
    object EdtVariedade: TEdit
      Left = 16
      Top = 81
      Width = 345
      Height = 21
      TabOrder = 0
    end
    object EdtCodigo: TEdit
      Left = 16
      Top = 35
      Width = 97
      Height = 21
      Enabled = False
      TabOrder = 1
    end
    object DBLkpEmpresaVarUva: TDBLookupComboBox
      Left = 16
      Top = 131
      Width = 185
      Height = 21
      KeyField = 'EMP_ID'
      ListField = 'EMP_FANTASIA'
      ListSource = DSEmpresa
      TabOrder = 2
    end
  end
  object QryOperacao: TFDQuery
    Connection = DM.Conn
    Transaction = DM.Transaction
    Left = 224
    Top = 16
  end
  object QryEmpresa: TFDQuery
    Connection = DM.Conn
    Transaction = DM.Transaction
    SQL.Strings = (
      'select EMP_ID, EMP_FANTASIA from empresa')
    Left = 304
    Top = 16
  end
  object QryCodVariedade: TFDQuery
    Connection = DM.Conn
    Transaction = DM.Transaction
    SQL.Strings = (
      'select coalesce(max(VDU_ID),0) + 1 from VARIEDADE_DE_UVA')
    Left = 144
    Top = 16
  end
  object DSEmpresa: TDataSource
    DataSet = QryEmpresa
    Left = 304
    Top = 72
  end
  object QryDados: TFDQuery
    Connection = DM.Conn
    Transaction = DM.Transaction
    SQL.Strings = (
      'select *'
      'from VARIEDADE_DE_UVA'
      'where VDU_ID = :VDU_ID')
    Left = 224
    Top = 96
    ParamData = <
      item
        Name = 'VDU_ID'
        ParamType = ptInput
      end>
  end
end
