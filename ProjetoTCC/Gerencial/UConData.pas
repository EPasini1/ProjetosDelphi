unit UConData;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons;

type
  TFrmConData = class(TForm)
    PnlBotoes: TPanel;
    PnlPesquisa: TPanel;
    DBGrid1: TDBGrid;
    QryData: TFDQuery;
    DSData: TDataSource;
    QryDataDTE_ID: TIntegerField;
    QryDataDTE_EMP: TIntegerField;
    QryDataDTE_VARIEDADE_UVA: TIntegerField;
    QryDataVDU_NOME: TStringField;
    BtnFechar: TBitBtn;
    BtnIncluir: TBitBtn;
    BtnAlterar: TBitBtn;
    QryDataDTE_INI: TDateField;
    QryDataDTE_FIM: TDateField;
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
  FrmConData: TFrmConData;

implementation

uses
  UDM, UCadData;

{$R *.dfm}

procedure TFrmConData.BtnAlterarClick(Sender: TObject);
begin
  if FrmCadData = nil then
    Application.CreateForm(TFrmCadData, FrmCadData);
  FrmCadData.TIPOOP := 'A';
  FrmCadData.Show;
end;

procedure TFrmConData.BtnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmConData.BtnIncluirClick(Sender: TObject);
begin
  if FrmCadData = nil then
    Application.CreateForm(TFrmCadData, FrmCadData);
  FrmCadData.TIPOOP := 'I';
  FrmCadData.Show;
end;

procedure TFrmConData.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  FrmConData := nil;
end;

procedure TFrmConData.FormCreate(Sender: TObject);
begin
  QryData.Active := True;
end;

end.
