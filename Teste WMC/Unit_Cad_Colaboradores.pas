unit Unit_Cad_Colaboradores;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async,
  FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls,
  Vcl.DBCtrls, Data.FMTBcd, Data.SqlExpr, Vcl.Mask, Vcl.ComCtrls,
  ZStoredProcedure, ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TForm_Cad_Colaboradores = class(TForm)
    gb_Colaborador: TGroupBox;
    edt_CodigoColaborador: TEdit;
    lbl_Codigo: TLabel;
    lbl_Nome: TLabel;
    edt_NomeColaborador: TEdit;
    gb_Endereco: TGroupBox;
    lbl_Endereco: TLabel;
    edt_Endereco: TEdit;
    Label2: TLabel;
    edt_Complemento: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    edt_Numero: TEdit;
    lbl_Bairro: TLabel;
    edt_Bairro: TEdit;
    DS_Municipios: TDataSource;
    Label1: TLabel;
    me_CEP: TMaskEdit;
    lbl_CPF: TLabel;
    lbl_RG: TLabel;
    me_RG: TMaskEdit;
    lbl_Fone: TLabel;
    me_Fone: TMaskEdit;
    lbl_Celular: TLabel;
    me_Celular: TMaskEdit;
    dtp_DataNascimento: TDateTimePicker;
    lbl_DataNascimento: TLabel;
    lbl_Email: TLabel;
    edt_Email: TEdit;
    lbl_Salario: TLabel;
    btn_Inserir: TButton;
    edt_CodCidade: TEdit;
    edt_Cidade: TEdit;
    edt_Salario: TEdit;
    btn_Alterar: TButton;
    me_CPF: TMaskEdit;
    SQL_Municipios: TZQuery;
    SQLColaboradores: TZQuery;
    SSP_Colaboradores: TZStoredProc;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edt_CidadeKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btn_InserirClick(Sender: TObject);
    procedure edt_CodCidadeKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btn_AlterarClick(Sender: TObject);
    procedure InsereAltera(TIPOOP: string);
    procedure TrazDados(cod_colab: integer);
    function StrToFloat_Universal(pText: string): Extended;
    function ValidaCamposTag: Boolean;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_Cad_Colaboradores: TForm_Cad_Colaboradores;

implementation

uses
  Unit_Principal, Unit_Con_Colaboradores;

{$R *.dfm}

procedure TForm_Cad_Colaboradores.btn_AlterarClick(Sender: TObject);
begin
  InsereAltera('A');
end;

procedure TForm_Cad_Colaboradores.btn_InserirClick(Sender: TObject);
begin
  InsereAltera('I');
end;

procedure TForm_Cad_Colaboradores.edt_CidadeKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Aux: Integer;
  Posicao: Integer;
begin
  if (Key <> VK_BACK) then
  try
    SQL_Municipios.Active := False;
    SQL_Municipios.SQL.Clear;
    if edt_Cidade.Text <> '' then
    begin
      SQL_Municipios.SQL.Add('select * from municipios where (UPPER(MUNICIPIO) CONTAINING UPPER(' + QuotedStr(edt_Cidade.Text) + ')) ORDER BY MUNICIPIO');
      SQL_Municipios.Active := True;
      if SQL_Municipios.FieldByName('MUNICIPIO').AsString <> '' then
      begin
        Posicao := length(edt_Cidade.Text);
        for Aux := length(edt_Cidade.Text) + 1 to Length(SQL_Municipios.FieldByName('MUNICIPIO').AsString) do
        begin
          edt_Cidade.Text := edt_Cidade.Text + SQL_Municipios.FieldByName('MUNICIPIO').AsString[Aux];
          edt_CodCidade.Text := SQL_Municipios.FieldByName('COD_MUN_IBGE').AsString;
        end;
        edt_Cidade.SelStart := Posicao;
        edt_Cidade.SelLength := length(edt_Cidade.Text);
      end;
    end;
  except

  end;
end;

procedure TForm_Cad_Colaboradores.edt_CodCidadeKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Aux: Integer;
  Posicao: Integer;
begin
  if (Key <> VK_BACK) then
  try
    SQL_Municipios.Active := False;
    SQL_Municipios.SQL.Clear;
    if edt_CodCidade.Text <> '' then
    begin
      SQL_Municipios.SQL.Add('select * from municipios where (UPPER(COD_MUN_IBGE) CONTAINING UPPER(' + QuotedStr(edt_CodCidade.Text) + ')) ORDER BY MUNICIPIO');
      SQL_Municipios.Active := True;
      if SQL_Municipios.FieldByName('COD_MUN_IBGE').AsString <> '' then
      begin
        Posicao := length(edt_CodCidade.Text);
        for Aux := length(edt_CodCidade.Text) + 1 to Length(SQL_Municipios.FieldByName('COD_MUN_IBGE').AsString) do
        begin
          edt_CodCidade.Text := edt_Cidade.Text + SQL_Municipios.FieldByName('COD_MUN_IBGE').AsString[Aux];
          edt_Cidade.Text := SQL_Municipios.FieldByName('MUNICIPIO').AsString;
        end;
        edt_CodCidade.SelStart := Posicao;
        edt_CodCidade.SelLength := length(edt_Cidade.Text);
      end;
    end;
  except

  end;
end;

procedure TForm_Cad_Colaboradores.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Form_Cad_Colaboradores := Nil;
  Action := CaFree;
end;

procedure TForm_Cad_Colaboradores.FormCreate(Sender: TObject);
begin
  SQL_Municipios.Active := True;
end;

procedure TForm_Cad_Colaboradores.InsereAltera(TIPOOP: string);
var
  CPF, fone, celular, salario: string;
begin
  if ValidaCamposTag then
    Exit;

  if Trim(edt_Numero.Text) = '' then
    edt_Numero.Text := '0';
  try
    with SSP_Colaboradores do
    begin
      if TIPOOP = 'A' then
        ParamByName('CODIGO').AsInteger := StrToInt(Trim(edt_CodigoColaborador.Text));

      ParamByName('TIPO').AsString := TIPOOP;
      ParamByName('NOME').AsString := Trim(edt_NomeColaborador.Text);
      ParamByName('ENDERECO').AsString := Trim(edt_Endereco.Text);
      ParamByName('BAIRRO').AsString := trim(edt_Bairro.Text);
      ParamByName('NUMERO').AsInteger := StrToInt(Trim(edt_Numero.Text));
      ParamByName('COMPLEMENTO').AsString := trim(edt_Complemento.Text);
      ParamByName('CIDADE').AsInteger := StrToInt(Trim(edt_CodCidade.Text));
      ParamByName('CEP').AsString := Trim(me_CEP.Text);

      me_CPF.EditMask := '';
      ParamByName('CPF').AsString := Trim(me_CPF.Text);
      me_CPF.EditMask := '000.000.000-00';

      me_RG.EditMask := '';
      ParamByName('RG').AsString := Trim(me_RG.Text);
      me_RG.EditMask := '0000000000';

      me_Fone.EditMask := '';
      ParamByName('FONE').AsString := Trim(me_Fone.Text);
      me_Fone.EditMask := '(00)00000-0000';

      me_Celular.EditMask := '';
      ParamByName('CELULAR').AsString := Trim(me_Celular.Text);
      me_Celular.EditMask := '(00)00000-0000';

      me_CEP.EditMask := '';
      ParamByName('CEP').AsString := Trim(me_CEP.Text);
      me_CEP.EditMask := '00000-000';

      ParamByName('DATA_NASCIMENTO').AsDate := dtp_DataNascimento.Date;
      ParamByName('EMAIL').AsString := trim(edt_Email.Text);
      ParamByName('SALARIO').AsFloat := StrToFloatDef(edt_Salario.Text, 0);
      ExecProc();
    end;

    if TIPOOP = 'A' then
      ShowMessage('Colaborador alterado com sucesso!');
    if TIPOOP = 'I' then
      ShowMessage('Colaborador inserido com sucesso!');
    Form_Con_Colaboradores.ZTableColab.Refresh;
    close;

  except
    on e: exception do
    begin
      if TIPOOP = 'A' then
        ShowMessage('Erro ao alterar colaborador! ' + e.Message);
      if TIPOOP = 'I' then
        ShowMessage('Erro ao inserir colaborador! ' + e.Message);

    end;
  end;
end;

procedure TForm_Cad_Colaboradores.TrazDados(cod_colab: integer);
begin
  with SQLColaboradores do
  begin
    ParamByName('CODIGO').AsInteger := cod_colab;
    Open;

    edt_NomeColaborador.Text := FieldByName('NOME').AsString;

    me_CPF.EditMask := '';
    me_CPF.Text := FieldByName('CPF').AsString;
    me_CPF.EditMask := '000.000.000-00';

    me_RG.EditMask := '';
    me_RG.Text := FieldByName('RG').AsString;
    me_RG.EditMask := '0000000000';

    me_Fone.EditMask := '';
    me_Fone.Text := FieldByName('FONE').AsString;
    me_Fone.EditMask := '(00)00000-0000';

    me_Celular.EditMask := '';
    me_Celular.Text := FieldByName('CELULAR').AsString;
    me_Celular.EditMask := '(00)00000-0000';

    me_CEP.EditMask := '';
    me_CEP.Text := FieldByName('CEP').AsString;
    me_CEP.EditMask := '00000-000';

    dtp_DataNascimento.Date := FieldByName('DATA_NASCIMENTO').AsDateTime;

    edt_Email.Text := FieldByName('EMAIL').AsString;

    edt_Salario.Text := FormatFloat('#,##0.00', FieldByName('SALARIO').AsFloat);

    edt_Endereco.Text := FieldByName('ENDERECO').AsString;
    edt_Bairro.Text := FieldByName('BAIRRO').AsString;
    edt_Numero.Text := FieldByName('NUMERO').AsString;
    edt_Complemento.Text := FieldByName('COMPLEMENTO').AsString;

    edt_CodCidade.Text := FieldByName('CIDADE').AsString;
    SQL_Municipios.SQL.Clear;
    SQL_Municipios.SQL.Text := 'Select municipio from municipios where COD_MUN_IBGE = ' + FieldByName('CIDADE').AsString;
    SQL_Municipios.Open;
    edt_Cidade.Text := SQL_Municipios.FieldByName('municipio').AsString;
  end;
end;

function TForm_Cad_Colaboradores.StrToFloat_Universal(pText: string): Extended;
const
  EUROPEAN_ST = ',';
  AMERICAN_ST = '.';
var
  lformatSettings: TFormatSettings;
  lFinalValue: string;
  lAmStDecimalPos: integer;
  lIndx: Byte;
  lIsAmerican: Boolean;
  lIsEuropean: Boolean;
begin
  lIsAmerican := False;
  lIsEuropean := False;
  for lIndx := Length(pText) - 1 downto 0 do
  begin
    if (pText[lIndx] = AMERICAN_ST) then
    begin
      lIsAmerican := True;
      pText := StringReplace(pText, ',', '', [rfIgnoreCase, rfReplaceAll]);  //get rid of thousand incidental separators
      Break;
    end;
    if (pText[lIndx] = EUROPEAN_ST) then
    begin
      lIsEuropean := True;
      pText := StringReplace(pText, '.', '', [rfIgnoreCase, rfReplaceAll]);  //get rid of thousand incidental separators
      Break;
    end;
  end;
  GetLocaleFormatSettings(LOCALE_SYSTEM_DEFAULT, lformatSettings);
  if (lformatSettings.DecimalSeparator = EUROPEAN_ST) and (lIsEuropean) then
  begin
    lFinalValue := StringReplace(pText, '.', ',', [rfIgnoreCase, rfReplaceAll]);
  end
  else if (lformatSettings.DecimalSeparator = AMERICAN_ST) and (lIsAmerican) then
  begin
    lFinalValue := StringReplace(pText, ',', '.', [rfIgnoreCase, rfReplaceAll]);
  end
  else
    lFinalValue := pText;
  pText := lFinalValue;
  Result := StrToFloat(pText, lformatSettings);
end;

function TForm_Cad_Colaboradores.ValidaCamposTag: Boolean;
var
  I: Integer;
  EditMask: string;
begin
  result := False;
  for I := 0 to ComponentCount - 1 do
  begin
    if Components[I].ClassType = TEdit then
      if (TEdit(Components[I]).Text = '') and (TEdit(Components[I]).Tag = 1) then
      begin
        Result := true;
        ShowMessage('Campos obrigatórios não preenchidos!');
        TEdit(Components[I]).TextHint := 'Campo Obrigatório';
        TEdit(Components[I]).SetFocus;
        Exit;
      end;

    if Components[I].ClassType = TMaskEdit then
    begin
      EditMask := TMaskEdit(Components[I]).EditMask;
      TMaskEdit(Components[I]).EditMask := '';
      if (TMaskEdit(Components[I]).Text = '') and (TMaskEdit(Components[I]).Tag = 1) then
      begin
        Result := true;
        ShowMessage('Campos obrigatórios não preenchidos!');
        TEdit(Components[I]).TextHint := 'Campo Obrigatório';
        TEdit(Components[I]).SetFocus;
        TMaskEdit(Components[I]).EditMask := EditMask;
        Exit;
      end;
    end;

    if Components[I].ClassType = TComboBox then
      if (TComboBox(Components[I]).Text = '') and (TComboBox(Components[I]).Tag = 1) then
      begin
        Result := true;
        ShowMessage('Campos obrigatórios não preenchidos!');
        TComboBox(Components[I]).TextHint := 'Campo Obrigatório';
        TComboBox(Components[I]).SetFocus;
        Exit;
      end;

    if Components[I].ClassType = TMemo then
      if (TMemo(Components[I]).Text = '') and (TMemo(Components[I]).Tag = 1) then
      begin
        Result := true;
        ShowMessage('Campos obrigatórios não preenchidos!');
        TMemo(Components[I]).SetFocus;
        Exit;
      end;
  end;
end;

end.

