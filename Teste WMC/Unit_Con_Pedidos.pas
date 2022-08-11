unit Unit_Con_Pedidos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm_Con_Pedidos = class(TForm)
    Label1: TLabel;
    edtQuantidade: TEdit;
    Label2: TLabel;
    edt_Valor: TEdit;
    Calcular: TButton;
    Label3: TLabel;
    Edit1: TEdit;
    procedure CalcularClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_Con_Pedidos: TForm_Con_Pedidos;

implementation

{$R *.dfm}

procedure TForm_Con_Pedidos.CalcularClick(Sender: TObject);
var
  Total: Double;
begin
  Total := StrToFloat(edtQuantidade.Text) * StrToFloat(edt_Valor.Text);
  Edit1.Text := FloatToStr(Total);
end;

procedure TForm_Con_Pedidos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Form_Con_Pedidos := nil;
  Action := caFree;
end;

end.
