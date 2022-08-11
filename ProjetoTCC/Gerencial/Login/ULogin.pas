unit ULogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.Buttons;

type
  TFrmLogin = class(TForm)
    edtUsuario: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    edtSenha: TEdit;
    BtnSair: TBitBtn;
    BtnEntrar: TBitBtn;
    procedure BtnEntrarClick(Sender: TObject);
  private    { Private declarations }
    tentativas: Smallint;
    function loginValido(const usuario, senha: string): Boolean;
  public    { Public declarations }
  end;

var
  FrmLogin: TFrmLogin;


implementation

uses
  UDM;

{$R *.dfm}

procedure TFrmLogin.BtnEntrarClick(Sender: TObject);
begin
  if (edtUsuario.Text = '') then //Verifica se o campo "Usuário" foi preenchido
  begin
    Messagedlg('O campo "Usuário" deve ser preenchido!', mtInformation, [mbOk], 0);
    if edtUsuario.CanFocus then
      edtUsuario.SetFocus;
    Exit;
  end;
  if (edtSenha.Text = '') then //Verifica se o campo "Senha" foi preenchido
  begin
    Messagedlg('O campo "Senha" deve ser preenchido!', mtInformation, [mbOk], 0);
    if edtSenha.CanFocus then
      edtSenha.SetFocus;
    Exit;
  end;
  if loginValido(edtUsuario.Text, edtSenha.Text) then //Verifica se o login é válido
    ModalResult := mrOk
  else //Caso o login não seja válido então
  begin
    inc(tentativas); //Incrementa em 1 o valor da variável tentativas
    if tentativas < 3 then
    begin
      MessageDlg(Format('Tentativa %d de 3', [tentativas]), mtError, [mbOk], 0);
      if edtSenha.CanFocus then
        edtSenha.SetFocus;
    end
    else
    begin
      MessageDlg(Format('%dª tentativa de acesso ao sistema.', [tentativas]) + #13 + 'A aplicação será fechada!', mtError, [mbOk], 0);
      ModalResult := mrCancel;
    end;
  end;
end;

function TFrmLogin.loginValido(const usuario, senha: string): Boolean;
begin
  with DM.Conn, DM.QryAux do
  begin
    if not Connected then //Caso o componente ConLOGIN não esteja conectado ao BD
      Connected := True;
    Close;
    Sql.Text := 'SELECT COUNT(1) FROM USUARIO ' + ' WHERE UPPER(USU_NOME) = ' + QuotedStr(AnsiUpperCase(Trim(usuario))) + ' AND USU_SENHA = ' + QuotedStr(Trim(senha));
    Open;
    Result := (Fields[0].AsInteger > 0);
  end;
end;

end.

