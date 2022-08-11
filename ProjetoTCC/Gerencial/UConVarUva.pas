unit UConVarUva;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.Grids, Vcl.DBGrids;

type
  TFrmConVarUva = class(TForm)
    PnlPesquisa: TPanel;
    PnlBotoes: TPanel;
    BtnFechar: TBitBtn;
    DBGrid1: TDBGrid;
    QryTipoUva: TFDQuery;
    DSTipoDeUva: TDataSource;
    BtnIncluir: TBitBtn;
    QryTipoUvaVDU_ID: TIntegerField;
    QryTipoUvaVDU_EMP: TIntegerField;
    QryTipoUvaVDU_NOME: TStringField;
    BtnAlterar: TBitBtn;
    BtnExcluir: TBitBtn;
    BtnHorEntrega: TBitBtn;
    procedure BtnFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnIncluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnAlterarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure DSTipoDeUvaDataChange(Sender: TObject; Field: TField);
    procedure BtnHorEntregaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmConVarUva: TFrmConVarUva;

implementation

uses
  UDM, UCadVarUva, UCadHorEntrega;

{$R *.dfm}

procedure TFrmConVarUva.BtnAlterarClick(Sender: TObject);
begin
  if FrmCadVarUva = Nil then
    Application.Createform(TFrmCadVarUva,FrmCadVarUva);
  FrmCadVarUva.TipoOP := 'A';
  FrmCadVarUva.Show;
end;

procedure TFrmConVarUva.BtnExcluirClick(Sender: TObject);
begin
  if Application.MessageBox('Deseja deletar o registro?', 'Excluir variedade',
    MB_YESNO + MB_ICONQUESTION) = IDYES then
  begin
    Try
      DM.QryAux.SQL.Text := 'DELETE FROM VARIEDADE_DE_UVA where VDU_ID = '+QryTipoUva.FieldByName('VDU_ID').AsString;
      DM.QryAux.ExecSQL;
      ShowMessage('Registro excluido com sucesso!');
      QryTipoUva.Refresh;
    Except
      on e:Exception do
        ShowMessage('Não foi possivel excluir o registro. '+e.Message);

    End;
  end;
end;

procedure TFrmConVarUva.BtnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmConVarUva.BtnHorEntregaClick(Sender: TObject);
begin
  if not Assigned(FrmCadHorEntrega) then
    Application.CreateForm(TFrmCadHorEntrega,FrmCadHorEntrega);
  FrmCadHorEntrega.DSE_VAR_UVA  := QryTipoUva.FieldByName('VDU_ID').AsInteger;
  FrmCadHorEntrega.DSE_EMP      := QryTipoUva.FieldByName('VDU_EMP').AsInteger;
  FrmCadHorEntrega.Show;
end;

procedure TFrmConVarUva.BtnIncluirClick(Sender: TObject);
begin
  if FrmCadVarUva = Nil then
    Application.Createform(TFrmCadVarUva,FrmCadVarUva);
  FrmCadVarUva.TipoOP := 'I';
  FrmCadVarUva.Show;
end;

procedure TFrmConVarUva.DSTipoDeUvaDataChange(Sender: TObject; Field: TField);
begin
  if QryTipoUva.FieldByName('VDU_ID').AsInteger <> 0 then
  begin
    BtnHorEntrega.Enabled := True;
  end;

end;

procedure TFrmConVarUva.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  FrmConVarUva := nil;
end;

procedure TFrmConVarUva.FormShow(Sender: TObject);
begin
  if QryTipoUva.Active = True then
    QryTipoUva.Active := False;
  QryTipoUva.Active := True;
end;

end.
