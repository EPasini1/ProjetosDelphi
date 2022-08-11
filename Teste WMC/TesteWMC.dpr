program TesteWMC;

uses
  Vcl.Forms,
  Unit_Principal in 'Unit_Principal.pas' {Form_Principal},
  Unit_Con_Colaboradores in 'Unit_Con_Colaboradores.pas' {Form_Con_Colaboradores},
  Unit_Cad_Colaboradores in 'Unit_Cad_Colaboradores.pas' {Form_Cad_Colaboradores},
  Unit_Con_Pedidos in 'Unit_Con_Pedidos.pas' {Form_Con_Pedidos};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm_Principal, Form_Principal);
  Application.CreateForm(TForm_Con_Pedidos, Form_Con_Pedidos);
  Application.Run;
end.
