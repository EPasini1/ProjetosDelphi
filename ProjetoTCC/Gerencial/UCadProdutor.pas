unit UCadProdutor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.DBCtrls, Vcl.Mask;

type
  TFrmCadProdutor = class(TForm)
    PnlBotoes: TPanel;
    BtnFechar: TBitBtn;
    PnlCadastro: TPanel;
    EdtCodProdutor: TEdit;
    QryCodProdutor: TFDQuery;
    Label1: TLabel;
    Label2: TLabel;
    DBLkpEmpresaProdutor: TDBLookupComboBox;
    QryEmpresa: TFDQuery;
    DSEmpresa: TDataSource;
    Label3: TLabel;
    MkEdtCPFProdutor: TMaskEdit;
    Label4: TLabel;
    EdtNomeProdutor: TEdit;
    Label5: TLabel;
    EdtSenhaProdutor: TEdit;
    BtnIncluir: TBitBtn;
    QryOperacao: TFDQuery;
    TransProdutor: TFDTransaction;
    BtnAlterar: TBitBtn;
    QryDados: TFDQuery;
    procedure BtnFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnIncluirClick(Sender: TObject);
    procedure BtnAlterarClick(Sender: TObject);
  private
    { Private declarations }
    procedure OPProdutor(TIPOOP: string);
    procedure CarregaDados;
  public
    { Public declarations }
    TipoOP: string;
  end;

var
  FrmCadProdutor: TFrmCadProdutor;

implementation

uses
  UDM, UConProdutor;

{$R *.dfm}

procedure TFrmCadProdutor.BtnAlterarClick(Sender: TObject);
begin
  OPProdutor('A');
end;

procedure TFrmCadProdutor.BtnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmCadProdutor.BtnIncluirClick(Sender: TObject);
begin
  OPProdutor('I');
end;

procedure TFrmCadProdutor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := CaFree;
  FrmCadProdutor := Nil;
end;

procedure TFrmCadProdutor.FormCreate(Sender: TObject);
begin
  QryEmpresa.Active := True;
end;

procedure TFrmCadProdutor.FormShow(Sender: TObject);
begin
  if TipoOp = 'I' then
  begin
    with QryCodProdutor do
    begin
      Open;
      EdtCodProdutor.Text := Fields[0].AsString;
      BtnIncluir.Visible := True;
    end;
  end
  else if TIPOOP = 'A' then
  begin
    BtnAlterar.Visible := True;
    CarregaDados;
  end;
end;

procedure TFrmCadProdutor.OPProdutor(TIPOOP: string);
begin
  if TIPOOP = 'I' then
  begin
    QryOperacao.SQL.Text :=
    'insert into PRODUTOR (PRO_ID, PRO_EMP, PRO_CPF, PRO_SENHA, PRO_NOME)' + #13#10 +
    'values (gen_id(GEN_PRODUTOR_ID, 1), :PRO_EMP, :PRO_CPF, :PRO_SENHA, :PRO_NOME);';
  end
  else if TIPOOP = 'A' then
  begin
    QryOperacao.SQL.Text :=
    'update PRODUTOR' + #13#10 +
    'set PRO_EMP = :PRO_EMP,' + #13#10 +
    '    PRO_CPF = :PRO_CPF,' + #13#10 +
    '    PRO_SENHA = :PRO_SENHA,' + #13#10 +
    '    PRO_NOME = :PRO_NOME ' + #13#10 +
    'where (PRO_ID = :PRO_ID);';
  end;

  with QryOperacao do
  begin
    if TIPOOP = 'A' then
      ParamByName('PRO_ID').AsInteger := StrToInt(EdtCodProdutor.Text);
    ParamByName('PRO_EMP').AsInteger := DBLkpEmpresaProdutor.ListSource.DataSet.FieldByName(DBLkpEmpresaProdutor.KeyField).Value;
    ParamByName('PRO_CPF').AsString := MkEdtCPFProdutor.Text;
    ParamByName('PRO_SENHA').AsString := EdtSenhaProdutor.Text;
    ParamByName('PRO_NOME').AsString := EdtNomeProdutor.Text;
    try
      ExecSQL;
      ShowMessage('Produtor ' + EdtCodProdutor.Text + ' inserido com sucesso!');
      FrmConProdutor.QryProdutor.Refresh;
      FrmCadProdutor.Close;
    except
      on e: Exception do
        ShowMessage('Erro na operação: ' + e.Message);
    end;
  end;
end;

procedure TFrmCadProdutor.CarregaDados;
Begin
  QryDados.ParamByName('PRO_ID').AsInteger := FrmConProdutor.QryProdutor.FieldByName('PRO_ID').AsInteger;
  QryDados.Open;
  EdtCodProdutor.Text := FrmConProdutor.QryProdutor.FieldByName('PRO_ID').AsString;
  DBLkpEmpresaProdutor.KeyValue := QryDados.FieldByName('PRO_EMP').AsInteger;
  EdtNomeProdutor.Text :=  QryDados.FieldByName('PRO_NOME').AsString;
  MkEdtCPFProdutor.Text := QryDados.FieldByName('PRO_CPF').AsString;
  EdtSenhaProdutor.Text := QryDados.FieldByName('PRO_SENHA').AsString;
End;

end.

