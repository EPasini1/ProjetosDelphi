unit UConAgendamentos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.Grids, Vcl.DBGrids;

type
  TFrmConAgengamentos = class(TForm)
    Panel1: TPanel;
    PnlBotoes: TPanel;
    BtnFechar: TBitBtn;
    BtnOk: TBitBtn;
    DBGrid1: TDBGrid;
    QryAgendamentos: TFDQuery;
    DSAgendamentos: TDataSource;
    BtnExcluir: TBitBtn;
    QryAgendamentosAGP_ID: TIntegerField;
    QryAgendamentosPRO_NOME: TStringField;
    QryAgendamentosAGP_DIA: TDateField;
    QryAgendamentosHOE_INI: TTimeField;
    QryAgendamentosVDU_NOME: TStringField;
    QryAgendamentosEMP_FANTASIA: TStringField;
    procedure BtnFecharClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmConAgengamentos: TFrmConAgengamentos;

implementation

uses
  UDM;

{$R *.dfm}

procedure TFrmConAgengamentos.BtnExcluirClick(Sender: TObject);
begin
  if Application.MessageBox('Deseja excluir o agendamento?',
    'Excluir Registro', MB_YESNO + MB_ICONWARNING) = IDYES then
  begin
    with DM.QryAux do begin
      SQL.Clear;
      SQL.Add('DELETE FROM AGENDAMENTO_PRODUTOR WHERE AGP_ID = '+QryAgendamentos.FieldByName('AGP_ID').AsString);
      ExecSQL;

    end;
  end;
  QryAgendamentos.Refresh;

end;

procedure TFrmConAgengamentos.BtnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmConAgengamentos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FrmConAgengamentos := nil;
  Action := caFree;
end;

Procedure TFrmConAgengamentos.FormShow(Sender: TObject);
begin
  QryAgendamentos.Open;
end;

end.
