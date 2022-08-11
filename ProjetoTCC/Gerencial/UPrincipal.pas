unit UPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus;

type
  TFrmPrincipal = class(TForm)
    MainMenu1: TMainMenu;
    Cadastro1: TMenuItem;
    N1: TMenuItem;
    Sair1: TMenuItem;
    Empresa1: TMenuItem;
    Produtor1: TMenuItem;
    VariedadedeUva1: TMenuItem;
    DatadeEntrega1: TMenuItem;
    Agendamentos1: TMenuItem;
    procedure Sair1Click(Sender: TObject);
    procedure Produtor1Click(Sender: TObject);
    procedure Empresa1Click(Sender: TObject);
    procedure VariedadedeUva1Click(Sender: TObject);
    procedure DatadeEntrega1Click(Sender: TObject);
    procedure Agendamentos1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

uses
  UDM, UConProdutor, UConEmpresa, UConVarUva, UConData, UConAgendamentos;

{$R *.dfm}

procedure TFrmPrincipal.Agendamentos1Click(Sender: TObject);
begin
  if FrmConAgengamentos = Nil then
    Application.Createform(TFrmConAgengamentos,FrmConAgengamentos);
  FrmConAgengamentos.Show;
end;

procedure TFrmPrincipal.DatadeEntrega1Click(Sender: TObject);
begin
  if FrmConData = Nil then
    Application.Createform(TFrmConData,FrmConData);
  FrmConData.Show;
end;

procedure TFrmPrincipal.Empresa1Click(Sender: TObject);
begin
  if FrmConEmpresa = Nil then
    Application.Createform(TFrmConEmpresa,FrmConEmpresa);
  FrmConEmpresa.Show;
end;

procedure TFrmPrincipal.Produtor1Click(Sender: TObject);
begin
  if FrmConProdutor = Nil then
    Application.Createform(TFrmConProdutor,FrmConProdutor);
  FrmConProdutor.Show;
end;

procedure TFrmPrincipal.Sair1Click(Sender: TObject);
begin
  Close;
end;

procedure TFrmPrincipal.VariedadedeUva1Click(Sender: TObject);
begin
  if FrmConVarUva = Nil then
    Application.Createform(TFrmConVarUva,FrmConVarUva);
  FrmConVarUva.Show;
end;

end.
