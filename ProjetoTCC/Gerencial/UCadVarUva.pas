unit UCadVarUva;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Vcl.DBCtrls, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TFrmCadVarUva = class(TForm)
    PnlBotoes: TPanel;
    BtnFechar: TBitBtn;
    PnlCadastro: TPanel;
    Label1: TLabel;
    EdtVariedade: TEdit;
    QryOperacao: TFDQuery;
    BtnIncluir: TBitBtn;
    Label2: TLabel;
    EdtCodigo: TEdit;
    QryEmpresa: TFDQuery;
    QryCodVariedade: TFDQuery;
    DSEmpresa: TDataSource;
    Label3: TLabel;
    DBLkpEmpresaVarUva: TDBLookupComboBox;
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
    procedure OPVarUva(TIPOOP:String);
    procedure CarregaDados;
  public
    { Public declarations }
    TipoOP: string;
  end;

var
  FrmCadVarUva: TFrmCadVarUva;

implementation

{$R *.dfm}

uses UConVarUva, UDM;

procedure TFrmCadVarUva.BtnAlterarClick(Sender: TObject);
begin
  OPVarUva('A');
end;

procedure TFrmCadVarUva.BtnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmCadVarUva.BtnIncluirClick(Sender: TObject);
begin
  if Trim(EdtVariedade.Text) = '' then
  begin
    ShowMessage('Favor inserir um nome para a variedade!');
    EdtVariedade.SetFocus;
    Exit;
  end;

  if DBLkpEmpresaVarUva.Text = '' then
  Begin
    ShowMessage('Favor selecionar a empresa da variedade!');
    DBLkpEmpresaVarUva.SetFocus;
    Exit;
  End;

  OPVarUva('I');
end;

procedure TFrmCadVarUva.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  FrmCadVarUva := nil;
end;

procedure TFrmCadVarUva.FormCreate(Sender: TObject);
begin
  QryEmpresa.Active := True;
end;

procedure TFrmCadVarUva.FormShow(Sender: TObject);
begin
  if TipoOp = 'I' then
  begin
    with QryCodVariedade do
    begin
      Open;
      EdtCodigo.Text := Fields[0].AsString;
      BtnIncluir.Visible := True;
    end;
  end else if TIPOOP = 'A' then
  begin
    BtnAlterar.Visible := True;
    CarregaDados;
  end;
end;

procedure TFrmCadVarUva.OPVarUva(TIPOOP:String);
begin
  if TIPOOP = 'I' then
  begin
    QryOperacao.SQL.Text :=
    'INSERT INTO VARIEDADE_DE_UVA (VDU_ID, VDU_EMP, VDU_NOME)'+#13+
    'VALUES (gen_id(GEN_VARIEDADE_DE_UVA_ID, 1), :VDU_EMP, :VDU_NOME);';
  end
  else if TIPOOP = 'A' then
  begin
    QryOperacao.SQL.Text :=
    'UPDATE VARIEDADE_DE_UVA'+#13+
    'SET VDU_EMP = :VDU_EMP,'+#13+
    '    VDU_NOME = :VDU_NOME'+#13+
    'WHERE (VDU_ID = :VDU_ID)';
  end;

  with QryOperacao do
  begin
    if TIPOOP = 'A' then
       ParamByName('VDU_ID').AsInteger := StrToInt(EdtCodigo.Text);
    ParamByName('VDU_EMP').AsInteger := DBLkpEmpresaVarUva.ListSource.DataSet.FieldByName(DBLkpEmpresaVarUva.KeyField).Value;
    ParamByName('VDU_NOME').AsString := EdtVariedade.Text;
    try
      ExecSQL;
      if TIPOOP = 'A' then
        ShowMessage('Variedade ' + EdtVariedade.Text + ' alterada com sucesso!')
      else
        ShowMessage('Variedade ' + EdtVariedade.Text + ' inserida com sucesso!');
      FrmConVarUva.QryTipoUva.Refresh;
      FrmCadVarUva.Close;
    except
      on e: Exception do
        ShowMessage('Erro na operação: ' + e.Message);
    end;
  end;
end;

procedure TFrmCadVarUva.CarregaDados;
begin
  QryDados.ParamByName('VDU_ID').AsInteger := FrmConVarUva.QryTipoUva.FieldByName('VDU_ID').AsInteger;
  QryDados.Open;
  EdtCodigo.Text := FrmConVarUva.QryTipoUva.FieldByName('VDU_ID').AsString;
  EdtVariedade.Text := QryDados.FieldByName('VDU_NOME').AsString;
  DBLkpEmpresaVarUva.KeyValue := QryDados.FieldByName('VDU_EMP').AsInteger;
end;

end.
