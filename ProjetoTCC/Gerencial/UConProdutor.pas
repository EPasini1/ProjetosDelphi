unit UConProdutor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ExtCtrls, Vcl.Grids,
  Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Vcl.StdCtrls, Vcl.Buttons,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFrmConProdutor = class(TForm)
    DBGrid1: TDBGrid;
    PnlBotoes: TPanel;
    PnlPesquisa: TPanel;
    QryProdutor: TFDQuery;
    DSProdutor: TDataSource;
    BtnFechar: TBitBtn;
    BtnIncluir: TBitBtn;
    QryProdutorPRO_ID: TIntegerField;
    QryProdutorPRO_EMP: TIntegerField;
    QryProdutorPRO_CPF: TStringField;
    QryProdutorPRO_NOME: TStringField;
    BtnAlterar: TBitBtn;
    procedure BtnFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnIncluirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnAlterarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmConProdutor: TFrmConProdutor;

implementation

uses
  UDM, UCadProdutor;

{$R *.dfm}

procedure TFrmConProdutor.BtnAlterarClick(Sender: TObject);
begin
  if FrmCadProdutor = Nil then
    Application.CreateForm(TFrmCadProdutor, FrmCadProdutor);
  FrmCadProdutor.TipoOP := 'A';
  FrmCadProdutor.Show;
end;

procedure TFrmConProdutor.BtnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmConProdutor.BtnIncluirClick(Sender: TObject);
begin
  if FrmCadProdutor = Nil then
    Application.CreateForm(TFrmCadProdutor, FrmCadProdutor);
  FrmCadProdutor.TipoOP := 'I';
  FrmCadProdutor.Show;
end;

procedure TFrmConProdutor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := CaFree;
  FrmConProdutor := Nil;
end;

procedure TFrmConProdutor.FormCreate(Sender: TObject);
begin
  QryProdutor.Active := True;
end;

end.
