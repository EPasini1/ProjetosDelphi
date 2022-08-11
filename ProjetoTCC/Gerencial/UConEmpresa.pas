unit UConEmpresa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.Grids, Vcl.DBGrids;

type
  TFrmConEmpresa = class(TForm)
    PnlBotoes: TPanel;
    BtnFechar: TBitBtn;
    PnlPesquisa: TPanel;
    DBGrid1: TDBGrid;
    QryEmpresa: TFDQuery;
    DSEmpresa: TDataSource;
    BtnIncluir: TBitBtn;
    QryEmpresaEMP_ID: TIntegerField;
    QryEmpresaEMP_RAZAO: TStringField;
    QryEmpresaEMP_FANTASIA: TStringField;
    QryEmpresaEMP_CNPJ: TStringField;
    QryEmpresaEMP_LOCA: TStringField;
    BtnAlterar: TBitBtn;
    BtnDeleta: TBitBtn;
    procedure BtnFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure BtnIncluirClick(Sender: TObject);
    procedure BtnAlterarClick(Sender: TObject);
    procedure BtnDeletaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmConEmpresa: TFrmConEmpresa;

implementation

uses
  UDM, UCadEmpresa;

{$R *.dfm}

procedure TFrmConEmpresa.BtnAlterarClick(Sender: TObject);
begin
  if FrmCadEmpresa = nil then
    Application.CreateForm(TFrmCadEmpresa,FrmCadEmpresa);
  FrmCadEmpresa.TIPOOP := 'A';
  FrmCadEmpresa.Show;
end;

procedure TFrmConEmpresa.BtnDeletaClick(Sender: TObject);
begin
  if Application.MessageBox('Deseja deletar o registro?', 'Deleta', MB_YESNO +
    MB_ICONWARNING) = IDYES then
  begin
    DM.QryAux.SQL.Text := 'delete from empresa where EMP_ID = '+QryEmpresa.FieldByName('EMP_ID').AsString;
    Try
      DM.QryAux.ExecSQL;
      QryEmpresa.Refresh;
    except
      on e:exception do
        ShowMessage('Erro ao deletar registro: '+e.Message);

    End;
  end;

end;

procedure TFrmConEmpresa.BtnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmConEmpresa.BtnIncluirClick(Sender: TObject);
begin
  if FrmCadEmpresa = nil then
    Application.CreateForm(TFrmCadEmpresa,FrmCadEmpresa);
  FrmCadEmpresa.TIPOOP := 'I';
  FrmCadEmpresa.Show;
end;

procedure TFrmConEmpresa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  FrmConEmpresa := nil;
end;

procedure TFrmConEmpresa.FormShow(Sender: TObject);
begin
  if QryEmpresa.Active then
    QryEmpresa.Active := False;
  QryEmpresa.Active := True;
end;

end.
