unit UCadEmpresa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Mask,
  Data.Cloud.AmazonAPI.LifeCycle, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFrmCadEmpresa = class(TForm)
    PnlBotoes: TPanel;
    BtnFechar: TBitBtn;
    PnlCadEmpresa: TPanel;
    EdtCodEmpresa: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    MkEdtCNPJEmpresa: TMaskEdit;
    Label3: TLabel;
    EdtRazaoSocial: TEdit;
    Label4: TLabel;
    EdtFantasia: TEdit;
    Label5: TLabel;
    EdtLocalizacao: TEdit;
    BtnIncluir: TBitBtn;
    QryCodEmpresa: TFDQuery;
    QryOperacao: TFDQuery;
    TransEmpresa: TFDTransaction;
    QryDados: TFDQuery;
    BtnAlterar: TBitBtn;
    procedure BtnFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure BtnIncluirClick(Sender: TObject);
    procedure BtnAlterarClick(Sender: TObject);
  private
    { Private declarations }
    procedure OPEmpresa(TIPOOP: string);
    procedure CarregaDados;
  public
    { Public declarations }
    TIPOOP : String;
  end;

var
  FrmCadEmpresa: TFrmCadEmpresa;

implementation

uses
  UDM, UConEmpresa;

{$R *.dfm}

procedure TFrmCadEmpresa.BtnAlterarClick(Sender: TObject);
begin
  OPEmpresa('A');
end;

procedure TFrmCadEmpresa.BtnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmCadEmpresa.BtnIncluirClick(Sender: TObject);
begin
  OPEmpresa('I');
end;

procedure TFrmCadEmpresa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  FrmCadEmpresa := nil;
end;

procedure TFrmCadEmpresa.FormShow(Sender: TObject);
begin
  if TIPOOP = 'I' then
  begin
    with QryCodEmpresa do
    begin
      Open;
      EdtCodEmpresa.Text := Fields[0].AsString;
      BtnIncluir.Visible := True;
    end;
  end
  else if TIPOOP = 'A' then
  begin
    BtnAlterar.Visible := True;
    CarregaDados;
  end;

end;

procedure TFrmCadEmpresa.OPEmpresa(TIPOOP: string);
begin
  if TIPOOP = 'I' then
  begin
    QryOperacao.SQL.Text :=
    'insert into EMPRESA (EMP_ID, EMP_RAZAO, EMP_FANTASIA, EMP_CNPJ, EMP_LOCA)' + #13 +
    'values (gen_id(GEN_EMPRESA_ID, 1), :EMP_RAZAO, :EMP_FANTASIA, :EMP_CNPJ, :EMP_LOCA);';
  end
  else if TIPOOP = 'A' then
  begin
    QryOperacao.SQL.Text :=
    'update EMPRESA' + #13 +
    'set EMP_RAZAO = :EMP_RAZAO,' + #13 +
    '    EMP_FANTASIA = :EMP_FANTASIA,' + #13 +
    '    EMP_CNPJ = :EMP_CNPJ,' + #13 +
    '    EMP_LOCA = :EMP_LOCA' + #13 +
    'where (EMP_ID = :EMP_ID);';
  end;

  with QryOperacao do
  begin
    if TIPOOP = 'A' then
      ParamByName('EMP_ID').AsInteger := StrToInt(EdtCodEmpresa.Text);
    ParamByName('EMP_RAZAO').AsString := EdtRazaoSocial.Text;
    ParamByName('EMP_FANTASIA').AsString := EdtFantasia.Text;
    ParamByName('EMP_CNPJ').AsString := MkEdtCNPJEmpresa.Text;
    ParamByName('EMP_LOCA').AsString := EdtLocalizacao.Text;
    try
      ExecSQL;
      if TIPOOP = 'A' then
        ShowMessage('Empresa alterada com sucesso!')
      else
      ShowMessage('Empresa incluída com sucesso!');
      FrmConEmpresa.QryEmpresa.Refresh;
      FrmCadEmpresa.Close;
    except
      on e: Exception do
        ShowMessage('Erro na operação: ' + e.Message);
    end;
  end;

end;

procedure TFrmCadEmpresa.CarregaDados;
begin
  QryDados.ParamByName('EMP_ID').AsInteger := FrmConEmpresa.QryEmpresa.FieldByName('EMP_ID').AsInteger;
  QryDados.Open;
  EdtCodEmpresa.Text := FrmConEmpresa.QryEmpresa.FieldByName('EMP_ID').AsString;
  MkEdtCNPJEmpresa.Text := QryDados.FieldByName('EMP_CNPJ').AsString;
  EdtRazaoSocial.Text := QryDados.FieldByName('EMP_RAZAO').AsString;
  EdtFantasia.Text := QryDados.FieldByName('EMP_FANTASIA').AsString;
  EdtLocalizacao.Text := QryDados.FieldByName('EMP_LOCA').AsString;
end;

end.

