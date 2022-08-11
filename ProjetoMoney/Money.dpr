program Money;

uses
  System.StartUpCopy,
  FMX.Forms,
  ULogin in 'ULogin.pas' {FrmLogin},
  u99Permissions in 'Units\u99Permissions.pas',
  UPrincipal in 'UPrincipal.pas' {FrmPrincipal},
  ULancamentos in 'ULancamentos.pas' {FrmLancamentos},
  ULancamentosCad in 'ULancamentosCad.pas' {FrmLancamentosCad};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmLogin, FrmLogin);
  Application.Run;
end.
