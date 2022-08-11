unit ULogin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Controls.Presentation, FMX.Edit, FMX.StdCtrls, FMX.TabControl,
  System.Actions, FMX.ActnList, u99Permissions, FMX.MediaLibrary.Actions,
  {$IFDEF ANDROID}
  FMX.VirtualKeyboard, FMX.Platform,
  {$ENDIF}
  FMX.StdActns, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef,
  FireDAC.FMXUI.Wait, Data.DB, FireDAC.Comp.Client;

type
  TFrmLogin = class(TForm)
    Layout2: TLayout;
    LayoutEmail: TLayout;
    RoundRect1: TRoundRect;
    edtUser: TEdit;
    StyleBook1: TStyleBook;
    LayoutSenha: TLayout;
    RoundRect2: TRoundRect;
    EditLoginSenha: TEdit;
    LayoutAcessar: TLayout;
    RectLogin: TRoundRect;
    Label1: TLabel;
    TabControl1: TTabControl;
    TabLogin: TTabItem;
    TabCadConta: TTabItem;
    Layout1: TLayout;
    LayoutCadNome: TLayout;
    RoundRect4: TRoundRect;
    EditCadNome: TEdit;
    LayoutCadSenha: TLayout;
    RoundRect5: TRoundRect;
    EditCadSenha: TEdit;
    LayoutProximo: TLayout;
    RectContaProximo: TRoundRect;
    LabelCadProximo: TLabel;
    LayoutCadEmail: TLayout;
    RoundRect7: TRoundRect;
    EditCadEmail: TEdit;
    TabFoto: TTabItem;
    Layout3: TLayout;
    CircFotoEditar: TCircle;
    Layout4: TLayout;
    RoundRect8: TRoundRect;
    Label2: TLabel;
    TabEscolher: TTabItem;
    Layout5: TLayout;
    Label3: TLabel;
    ImgFoto: TImage;
    ImgLibrary: TImage;
    Layout6: TLayout;
    ImgFotoVoltar: TImage;
    Layout7: TLayout;
    ImgEscolherVolta: TImage;
    ActionList1: TActionList;
    ActConta: TChangeTabAction;
    ActEscolher: TChangeTabAction;
    ActFoto: TChangeTabAction;
    ActLogin: TChangeTabAction;
    Layout8: TLayout;
    Layout9: TLayout;
    lblLoginTab: TLabel;
    lblCriarConta: TLabel;
    Line1: TLine;
    Layout10: TLayout;
    Layout11: TLayout;
    lblContaLogin: TLabel;
    lblContaCriar: TLabel;
    Line2: TLine;
    ActCamera: TTakePhotoFromCameraAction;
    ActLibrary: TTakePhotoFromLibraryAction;
    procedure lblCriarContaClick(Sender: TObject);
    procedure lblContaLoginClick(Sender: TObject);
    procedure RectContaProximoClick(Sender: TObject);
    procedure CircFotoEditarClick(Sender: TObject);
    procedure ImgFotoVoltarClick(Sender: TObject);
    procedure ImgEscolherVoltaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ImgFotoClick(Sender: TObject);
    procedure ImgLibraryClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ActLibraryDidFinishTaking(Image: TBitmap);
    procedure ActCameraDidFinishTaking(Image: TBitmap);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure RectLoginClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtUserKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
  private    { Private declarations }
    permissao: T99Permissions;
    procedure TrataErroPermissao(Sender: TObject);
  public    { Public declarations }
  end;

var
  FrmLogin: TFrmLogin;


implementation

uses
  UPrincipal, UDM;

{$R *.fmx}

procedure TFrmLogin.ActCameraDidFinishTaking(Image: TBitmap);
begin
  CircFotoEditar.Fill.Bitmap.Bitmap := Image;
  ActFoto.Execute;
end;

procedure TFrmLogin.ActLibraryDidFinishTaking(Image: TBitmap);
begin
  CircFotoEditar.Fill.Bitmap.Bitmap := Image;
  ActFoto.Execute;
end;

procedure TFrmLogin.CircFotoEditarClick(Sender: TObject);
begin
  ActEscolher.Execute;
end;

procedure TFrmLogin.edtUserKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if (not (KeyChar in ['0'..'9'])) then
    Keychar := #0;

end;

procedure TFrmLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
  FrmLogin := nil;
end;

procedure TFrmLogin.FormCreate(Sender: TObject);
begin
  permissao := T99Permissions.Create;
end;

procedure TFrmLogin.FormDestroy(Sender: TObject);
begin
  permissao.DisposeOf;
end;

procedure TFrmLogin.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
{$IFDEF ANDROID}
var
  FService: IFMXVirtualKeyboardService;
{$ENDIF}
begin
  {$IFDEF ANDROID}
  if (Key = vkHardwareBack) then
  begin
    TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService, IInterface(FService));

    if (FService <> nil) and (TVirtualKeyboardState.Visible in FService.VirtualKeyBoardState) then
    begin
       //Botão back pressionado e teclado visível
       //(apensa fecha o teclado)
    end
    else
    begin
       //botão back pressionado e teclado NAO visivel
      if TabControl1.ActiveTab = TabCadConta then
      begin
        Key := 0;
        ActLogin.execute
      end
      else if TabControl1.ActiveTab = TabFoto then
      begin
        Key := 0;
        ActConta.Execute
      end
      else if TabControl1.ActiveTab = TabEscolher then
      begin
        Key := 0;
        ActFoto.Execute
      end
      else
        close;
    end;
  end;

  {$ENDIF}
end;

procedure TFrmLogin.FormShow(Sender: TObject);
begin
  TabControl1.ActiveTab := TabLogin;
end;

procedure TFrmLogin.ImgEscolherVoltaClick(Sender: TObject);
begin
  ActFoto.Execute;
end;

procedure TFrmLogin.ImgFotoClick(Sender: TObject);
begin
  permissao.Camera(ActCamera, TrataErroPermissao);
end;

procedure TFrmLogin.ImgFotoVoltarClick(Sender: TObject);
begin
  ActConta.Execute;
end;

procedure TFrmLogin.ImgLibraryClick(Sender: TObject);
begin
  permissao.PhotoLibrary(ActLibrary, TrataErroPermissao);
end;

procedure TFrmLogin.lblContaLoginClick(Sender: TObject);
begin
  ActLogin.Execute;
end;

procedure TFrmLogin.lblCriarContaClick(Sender: TObject);
begin
  ActConta.Execute;
end;

procedure TFrmLogin.RectContaProximoClick(Sender: TObject);
begin
  ActFoto.Execute;
end;

procedure TFrmLogin.RectLoginClick(Sender: TObject);
begin
  if not Assigned(DM) then
    Application.CreateForm(TDM, DM);
  if DM.loginValido(edtUser.Text, EditLoginSenha.Text) then begin
    if not Assigned(FrmPrincipal) then
      Application.CreateForm(TFrmPrincipal, FrmPrincipal);
    Application.MainForm := FrmPrincipal;
    FrmPrincipal.Show;
    FrmLogin.Close;
  end else
    ShowMessage('Usuário ou senha incorretos!');
end;

procedure TFrmLogin.TrataErroPermissao(Sender: TObject);
begin
  ShowMessage('Você não possui permissão de acesso para este recurso!');
end;

end.

