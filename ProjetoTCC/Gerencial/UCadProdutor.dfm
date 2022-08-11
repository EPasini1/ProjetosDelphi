object FrmCadProdutor: TFrmCadProdutor
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Cadastro de Produtor'
  ClientHeight = 260
  ClientWidth = 638
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
    Top = 214
    Width = 638
    Height = 46
    Align = alBottom
    TabOrder = 1
    ExplicitWidth = 382
    DesignSize = (
      638
      46)
    object BtnFechar: TBitBtn
      Left = 551
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Fechar'
      TabOrder = 0
      OnClick = BtnFecharClick
      ExplicitLeft = 295
    end
    object BtnIncluir: TBitBtn
      Left = 214
      Top = 10
      Width = 75
      Height = 25
      Caption = 'Incluir'
      TabOrder = 1
      Visible = False
      OnClick = BtnIncluirClick
    end
    object BtnAlterar: TBitBtn
      Left = 214
      Top = 10
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
    Width = 638
    Height = 214
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 382
    object Label1: TLabel
      Left = 16
      Top = 8
      Width = 33
      Height = 13
      Caption = 'C'#243'digo'
    end
    object Label2: TLabel
      Left = 168
      Top = 8
      Width = 41
      Height = 13
      Caption = 'Empresa'
    end
    object Label3: TLabel
      Left = 16
      Top = 112
      Width = 19
      Height = 13
      Caption = 'CPF'
    end
    object Label4: TLabel
      Left = 16
      Top = 64
      Width = 27
      Height = 13
      Caption = 'Nome'
    end
    object Label5: TLabel
      Left = 152
      Top = 112
      Width = 116
      Height = 13
      Caption = 'Senha Acesso Aplicativo'
    end
    object EdtCodProdutor: TEdit
      Left = 16
      Top = 27
      Width = 121
      Height = 21
      Enabled = False
      TabOrder = 0
    end
    object DBLkpEmpresaProdutor: TDBLookupComboBox
      Left = 168
      Top = 27
      Width = 185
      Height = 21
      KeyField = 'EMP_ID'
      ListField = 'EMP_FANTASIA'
      ListSource = DSEmpresa
      TabOrder = 1
    end
    object MkEdtCPFProdutor: TMaskEdit
      Left = 16
      Top = 131
      Width = 118
      Height = 21
      EditMask = '000.000.000-00;1;'
      MaxLength = 14
      TabOrder = 3
      Text = '   .   .   -  '
    end
    object EdtNomeProdutor: TEdit
      Left = 16
      Top = 83
      Width = 337
      Height = 21
      TabOrder = 2
    end
    object EdtSenhaProdutor: TEdit
      Left = 152
      Top = 131
      Width = 201
      Height = 21
      TabOrder = 4
    end
  end
  object QryCodProdutor: TFDQuery
    Connection = DM.Conn
    SQL.Strings = (
      'select coalesce(max(PRO_ID),0) + 1 from produtor')
    Left = 384
    Top = 8
  end
  object QryEmpresa: TFDQuery
    Connection = DM.Conn
    SQL.Strings = (
      'select EMP_ID, EMP_FANTASIA from empresa')
    Left = 384
    Top = 56
  end
  object DSEmpresa: TDataSource
    DataSet = QryEmpresa
    Left = 464
    Top = 56
  end
  object QryOperacao: TFDQuery
    Connection = DM.Conn
    Transaction = TransProdutor
    Left = 464
    Top = 8
  end
  object TransProdutor: TFDTransaction
    Connection = DM.Conn
    Left = 536
    Top = 8
  end
  object QryDados: TFDQuery
    Connection = DM.Conn
    SQL.Strings = (
      'select *'
      'from PRODUTOR'
      'where PRO_ID = :PRO_ID')
    Left = 168
    Top = 160
    ParamData = <
      item
        Name = 'PRO_ID'
        ParamType = ptInput
      end>
  end
end
