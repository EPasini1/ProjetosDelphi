program Gerencial;

uses
  Vcl.Forms,
  Controls,
  SysUtils,
  UPrincipal in 'UPrincipal.pas' {FrmPrincipal},
  UDM in 'UDM.pas' {DM: TDataModule},
  ULogin in 'Login\ULogin.pas' {FrmLogin},
  UConProdutor in 'UConProdutor.pas' {FrmConProdutor},
  UCadProdutor in 'UCadProdutor.pas' {FrmCadProdutor},
  UConEmpresa in 'UConEmpresa.pas' {FrmConEmpresa},
  UCadEmpresa in 'UCadEmpresa.pas' {FrmCadEmpresa},
  UConVarUva in 'UConVarUva.pas' {FrmConVarUva},
  UCadVarUva in 'UCadVarUva.pas' {FrmCadVarUva},
  UConData in 'UConData.pas' {FrmConData},
  UCadData in 'UCadData.pas' {FrmCadData},
  UConAgendamentos in 'UConAgendamentos.pas' {FrmConAgengamentos},
  UCadHorEntrega in 'UCadHorEntrega.pas' {FrmCadHorEntrega},
  UFuncoes in 'Units\UFuncoes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFrmLogin, FrmLogin);
  if FrmLogin.ShowModal = mrOk then //Caso o retorno da tela seja Ok
  begin
    FreeAndNil(FrmLogin); //Libera o form de Login da memória
    Application.CreateForm(TFrmPrincipal, FrmPrincipal); //Cria a janela main
    Application.Run; //Roda a aplicação
  end
  else //Caso o retorno da tela de Login seja mrCancel então
    Application.Terminate; //Encerra a aplicação
end.
