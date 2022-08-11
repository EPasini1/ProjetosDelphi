program Aplicativo;

uses
  System.StartUpCopy,
  FMX.Forms,
  UPrincipal in 'UPrincipal.pas' {FrmPrincipal},
  UDM in 'UDM.pas' {DM: TDataModule},
  ULogin in 'ULogin.pas' {FrmLogin},
  u99Permissions in 'Units\u99Permissions.pas',
  UAgendamento in 'UAgendamento.pas' {FrmAgendamento},
  UCalendario in 'UCalendario.pas' {FrmCalendario};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmLogin, FrmLogin);
  Application.CreateForm(TFrmCalendario, FrmCalendario);
  Application.Run;
end.
