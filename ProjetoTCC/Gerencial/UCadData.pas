unit UCadData;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Vcl.ComCtrls, Vcl.DBCtrls, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFrmCadData = class(TForm)
    PnlBotoes: TPanel;
    PnlCadastro: TPanel;
    BtnFechar: TBitBtn;
    BtnAlterar: TBitBtn;
    BtnIncluir: TBitBtn;
    Label1: TLabel;
    EdtCodData: TEdit;
    QryEmpresa: TFDQuery;
    DSEmpresa: TDataSource;
    Label2: TLabel;
    DBLkpEmpresa: TDBLookupComboBox;
    Label3: TLabel;
    DBLkpVariedade: TDBLookupComboBox;
    QryVariedade: TFDQuery;
    DSVariedade: TDataSource;
    DTPFim: TDateTimePicker;
    Label4: TLabel;
    Label5: TLabel;
    DTPInicio: TDateTimePicker;
    QryDados: TFDQuery;
    QryOperacao: TFDQuery;
    QryCodData: TFDQuery;
    QryVariedadeVDU_ID: TIntegerField;
    QryVariedadeVDU_NOME: TStringField;
    QryEmpresaEMP_ID: TIntegerField;
    QryEmpresaEMP_FANTASIA: TStringField;
    procedure BtnFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnIncluirClick(Sender: TObject);
    procedure BtnAlterarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure OPData(TIPOOP: string);
    procedure CarregaDados;
  public
    { Public declarations }
    TIPOOP : String;
  end;

var
  FrmCadData: TFrmCadData;

implementation

{$R *.dfm}

uses UConData, UDM;

procedure TFrmCadData.BtnAlterarClick(Sender: TObject);
begin
  OPData('A');
end;

procedure TFrmCadData.BtnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmCadData.BtnIncluirClick(Sender: TObject);
begin
  OPData('I');
end;

procedure TFrmCadData.FormCreate(Sender: TObject);
begin
  QryEmpresa.Active := True;
  QryVariedade.Active := True;
  DTPInicio.Date := Date;
  DTPFim.Date := Date + 7;
end;

procedure TFrmCadData.FormShow(Sender: TObject);
begin
  if TipoOp = 'I' then
  begin
    with QryCodData do
    begin
      Open;
      EdtCodData.Text := Fields[0].AsString;
      BtnIncluir.Visible := True;
    end;
  end
  else if TIPOOP = 'A' then
  begin
    BtnAlterar.Visible := True;
    CarregaDados;
  end;
end;

procedure TFrmCadData.OPData(TIPOOP: string);
begin
  if TIPOOP = 'I' then
  begin
    QryOperacao.SQL.Text :=
    'insert into DATA_ENTREGA (DTE_ID, DTE_EMP, DTE_INI, DTE_FIM, DTE_VARIEDADE_UVA)' + #13#10 +
    'values (gen_id(GEN_DATA_ENTREGA_ID, 1), :DTE_EMP, :DTE_INI, :DTE_FIM, :DTE_VARIEDADE_UVA);';
  end
  else if TIPOOP = 'A' then
  begin
    QryOperacao.SQL.Text :=
    'UPDATE DATA_ENTREGA'+#13+
    'SET DTE_EMP = :DTE_EMP,'+#13+
    '    DTE_INI = :DTE_INI,'+#13+
    '    DTE_FIM = :DTE_FIM,'+#13+
    '    DTE_VARIEDADE_UVA = :DTE_VARIEDADE_UVA'+#13+
    'WHERE (DTE_ID = :DTE_ID)';
  end;

  with QryOperacao do
  begin
    if TIPOOP = 'A' then
      ParamByName('DTE_ID').AsInteger := StrToInt(EdtCodData.Text);
    ParamByName('DTE_EMP').AsInteger := DBLkpEmpresa.ListSource.DataSet.FieldByName(DBLkpEmpresa.KeyField).Value;
    ParamByName('DTE_VARIEDADE_UVA').AsInteger := DBLkpVariedade.ListSource.DataSet.FieldByName(DBLkpVariedade.KeyField).Value;
    ParamByName('DTE_INI').AsDate := DTPInicio.Date;
    ParamByName('DTE_FIM').AsDate := DTPFim.Date;
    try
      ExecSQL;
      if TIPOOP = 'I' then
        ShowMessage('Data de Entrega inserida com sucesso!')
      else
        ShowMessage('Data de Entrega alterada com sucesso!');
      FrmConData.QryData.Refresh;
      FrmCadData.Close;
    except
      on e: Exception do
        ShowMessage('Erro na operação: ' + e.Message);
    end;
  end;
end;

procedure TFrmCadData.CarregaDados;
begin
  QryDados.ParamByName('DTE_ID').AsInteger := FrmConData.QryData.FieldByName('DTE_ID').AsInteger;
  QryDados.Open;
  EdtCodData.Text := FrmConData.QryData.FieldByName('DTE_ID').AsString;
  DBLkpEmpresa.KeyValue := QryDados.FieldByName('DTE_EMP').AsInteger;
  DBLkpVariedade.KeyValue := QryDados.FieldByName('DTE_VARIEDADE_UVA').AsInteger;
  DTPInicio.Date := QryDados.FieldByName('DTE_INI').AsDateTime;
  DTPFim.Date := QryDados.FieldByName('DTE_FIM').AsDateTime;
end;

end.
