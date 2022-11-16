object FrmCadEmpresa: TFrmCadEmpresa
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Cadastro de Empresa'
  ClientHeight = 286
  ClientWidth = 358
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
    Top = 240
    Width = 358
    Height = 46
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      358
      46)
    object BtnFechar: TBitBtn
      Left = 269
      Top = 7
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Fechar'
      TabOrder = 0
      OnClick = BtnFecharClick
    end
    object BtnIncluir: TBitBtn
      Left = 188
      Top = 7
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Incluir'
      TabOrder = 1
      Visible = False
      OnClick = BtnIncluirClick
    end
    object BtnAlterar: TBitBtn
      Left = 188
      Top = 7
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Alterar'
      TabOrder = 2
      Visible = False
      OnClick = BtnAlterarClick
    end
  end
  object PnlCadEmpresa: TPanel
    Left = 0
    Top = 0
    Width = 358
    Height = 240
    Align = alClient
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 5
      Width = 33
      Height = 13
      Caption = 'C'#243'digo'
    end
    object Label2: TLabel
      Left = 160
      Top = 5
      Width = 25
      Height = 13
      Caption = 'CNPJ'
    end
    object Label3: TLabel
      Left = 16
      Top = 53
      Width = 60
      Height = 13
      Caption = 'Razao Social'
    end
    object Label4: TLabel
      Left = 16
      Top = 101
      Width = 41
      Height = 13
      Caption = 'Fantasia'
    end
    object Label5: TLabel
      Left = 16
      Top = 151
      Width = 54
      Height = 13
      Caption = 'Localiza'#231#227'o'
    end
    object EdtCodEmpresa: TEdit
      Left = 16
      Top = 24
      Width = 121
      Height = 21
      Enabled = False
      TabOrder = 0
    end
    object MkEdtCNPJEmpresa: TMaskEdit
      Left = 160
      Top = 24
      Width = 118
      Height = 21
      EditMask = '00.000.000/0000-00;1;'
      MaxLength = 18
      TabOrder = 1
      Text = '  .   .   /    -  '
    end
    object EdtRazaoSocial: TEdit
      Left = 16
      Top = 72
      Width = 262
      Height = 21
      TabOrder = 2
    end
    object EdtFantasia: TEdit
      Left = 16
      Top = 120
      Width = 262
      Height = 21
      TabOrder = 3
    end
    object EdtLocalizacao: TEdit
      Left = 16
      Top = 170
      Width = 262
      Height = 21
      TabOrder = 4
    end
  end
  object QryCodEmpresa: TFDQuery
    Connection = DM.Conn
    SQL.Strings = (
      'select GEN_ID(gen_empresa_id, 0) + 1 FROM RDB$DATABASE;')
    Left = 288
    Top = 24
  end
  object QryOperacao: TFDQuery
    Connection = DM.Conn
    Transaction = TransEmpresa
    Left = 296
    Top = 104
  end
  object TransEmpresa: TFDTransaction
    Connection = DM.Conn
    Left = 288
    Top = 160
  end
  object QryDados: TFDQuery
    Connection = DM.Conn
    SQL.Strings = (
      'select * from empresa'
      'where EMP_ID = :EMP_ID')
    Left = 136
    Top = 96
    ParamData = <
      item
        Name = 'EMP_ID'
        ParamType = ptInput
      end>
  end
end
