unit Unit_Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client, Data.DBXFirebird, Data.SqlExpr, ZAbstractConnection,
  ZConnection;

type
  TForm_Principal = class(TForm)
    MainMenu1: TMainMenu;
    Cadastro1: TMenuItem;
    Clientes1: TMenuItem;
    Pedidos1: TMenuItem;
    ZConnection1: TZConnection;
    procedure Clientes1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Pedidos1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_Principal: TForm_Principal;

implementation

{$R *.dfm}

uses Unit_Con_Colaboradores, Unit_Con_Pedidos;

procedure TForm_Principal.Clientes1Click(Sender: TObject);
begin
  if Form_Con_Colaboradores = nil then
    Application.CreateForm(TForm_Con_Colaboradores,Form_Con_Colaboradores);
  with Form_Con_Colaboradores do begin
    ZTableColab.Close;
    ZTableColab.Open;
    Show;
  end;
end;

procedure TForm_Principal.FormCreate(Sender: TObject);
begin
  with ZConnection1 do begin
    Connected := False;
    Database := ExtractFileDir(Application.ExeName)+'\database.fdb';
    Connected := True;
  end;
end;

procedure TForm_Principal.Pedidos1Click(Sender: TObject);
begin
  if Form_Con_Pedidos = nil then
    Application.CreateForm(TForm_Con_Pedidos,Form_Con_Pedidos);
  with Form_Con_Pedidos do begin
    Show;
  end;
end;

end.
