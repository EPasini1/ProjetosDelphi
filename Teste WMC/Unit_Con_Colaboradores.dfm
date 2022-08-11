object Form_Con_Colaboradores: TForm_Con_Colaboradores
  Left = 0
  Top = 0
  Caption = 'Colaboradores'
  ClientHeight = 256
  ClientWidth = 622
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
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = -3
    Top = 0
    Width = 620
    Height = 217
    DataSource = DS_Colab
    Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'CODIGO'
        Title.Caption = 'C'#243'digo'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME'
        Title.Caption = 'Nome'
        Width = 250
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CPF'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATA_NASCIMENTO'
        Title.Caption = 'Data de Nascimento'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SALARIO'
        Title.Caption = 'Sal'#225'rio'
        Visible = True
      end>
  end
  object btn_Excluir: TButton
    Left = 542
    Top = 223
    Width = 75
    Height = 25
    Caption = 'Excluir'
    TabOrder = 1
    OnClick = btn_ExcluirClick
  end
  object btn_Alterar: TButton
    Left = 461
    Top = 223
    Width = 75
    Height = 25
    Caption = 'Alterar'
    TabOrder = 2
    OnClick = btn_AlterarClick
  end
  object btn_Cadastrar: TBitBtn
    Left = 380
    Top = 223
    Width = 75
    Height = 25
    Caption = 'Cadastrar'
    TabOrder = 3
    OnClick = btn_CadastrarClick
  end
  object DS_Colab: TDataSource
    DataSet = ZTableColab
    Left = 168
    Top = 152
  end
  object SSP_Colaboradores: TZStoredProc
    Connection = Form_Principal.ZConnection1
    Params = <
      item
        DataType = ftWideString
        Name = 'TIPO'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'NOME'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'ENDERECO'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'BAIRRO'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'NUMERO'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'COMPLEMENTO'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'CIDADE'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'CEP'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'CPF'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'RG'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'FONE'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'CELULAR'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'DATA_NASCIMENTO'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'EMAIL'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'SALARIO'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'CODIGO'
        ParamType = ptInput
      end>
    StoredProcName = 'PROC_COLABORADORES'
    Left = 48
    Top = 88
    ParamData = <
      item
        DataType = ftWideString
        Name = 'TIPO'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'NOME'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'ENDERECO'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'BAIRRO'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'NUMERO'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'COMPLEMENTO'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'CIDADE'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'CEP'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'CPF'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'RG'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'FONE'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'CELULAR'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'DATA_NASCIMENTO'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'EMAIL'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'SALARIO'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'CODIGO'
        ParamType = ptInput
      end>
  end
  object ZTableColab: TZTable
    Connection = Form_Principal.ZConnection1
    TableName = 'COLABORADORES'
    Left = 168
    Top = 96
    object ZTableColabCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object ZTableColabNOME: TWideStringField
      FieldName = 'NOME'
      Size = 100
    end
    object ZTableColabENDERECO: TWideStringField
      FieldName = 'ENDERECO'
      Size = 100
    end
    object ZTableColabBAIRRO: TWideStringField
      FieldName = 'BAIRRO'
      Size = 50
    end
    object ZTableColabNUMERO: TIntegerField
      FieldName = 'NUMERO'
    end
    object ZTableColabCOMPLEMENTO: TWideStringField
      FieldName = 'COMPLEMENTO'
      Size = 300
    end
    object ZTableColabCIDADE: TIntegerField
      FieldName = 'CIDADE'
    end
    object ZTableColabCEP: TWideStringField
      FieldName = 'CEP'
      Size = 9
    end
    object ZTableColabCPF: TWideStringField
      FieldName = 'CPF'
      Size = 11
    end
    object ZTableColabRG: TWideStringField
      FieldName = 'RG'
      Size = 10
    end
    object ZTableColabFONE: TWideStringField
      FieldName = 'FONE'
      Size = 11
    end
    object ZTableColabCELULAR: TWideStringField
      FieldName = 'CELULAR'
      Size = 11
    end
    object ZTableColabDATA_NASCIMENTO: TDateField
      FieldName = 'DATA_NASCIMENTO'
    end
    object ZTableColabEMAIL: TWideStringField
      FieldName = 'EMAIL'
      Size = 100
    end
    object ZTableColabSALARIO: TFloatField
      FieldName = 'SALARIO'
      EditFormat = '###,###.00'
    end
  end
end
