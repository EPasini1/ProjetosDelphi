unit UPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls, ShellApi;

type
  TFPrincipal = class(TForm)
    edt_BaseOriginal: TEdit;
    SpeedButton1: TSpeedButton;
    OpenDialog1: TOpenDialog;
    Label1: TLabel;
    edt_BaseMigrada: TEdit;
    Label2: TLabel;
    SpeedButton2: TSpeedButton;
    SaveDialog1: TSaveDialog;
    btn_Iniciar: TButton;
    rg_VersaoFB: TRadioGroup;
    rg_VersaoFBMig: TRadioGroup;
    procedure SpeedButton1Click(Sender: TObject);
    procedure edt_BaseMigradaChange(Sender: TObject);
    procedure edt_BaseOriginalChange(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure btn_IniciarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FPrincipal: TFPrincipal;

implementation

{$R *.dfm}

procedure TFPrincipal.SpeedButton1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    edt_BaseOriginal.Text := OpenDialog1.FileName;
end;

procedure TFPrincipal.SpeedButton2Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
    edt_BaseMigrada.Text := ExtractFilePath(SaveDialog1.FileName);
end;

procedure TFPrincipal.btn_IniciarClick(Sender: TObject);
var
  F: TextFile;
  BaseOriginal, BaseMigracao, BaseRenomeada: string;
  CaminhoOriginal, CaminhoMigracao: string;
  NomeOriginal, NomeNovo: string;
  VersaoFB, VersaoFBMig: string;
  output: ansistring;
begin
  CaminhoOriginal := ExtractFilePath(edt_BaseOriginal.Text);
  CaminhoMigracao := ExtractFilePath(edt_BaseMigrada.Text);
  BaseOriginal := Copy(extractfilename(edt_BaseOriginal.Text), 0, Pos('.', extractfilename(edt_BaseOriginal.Text)) - 1);

  NomeOriginal := CaminhoOriginal + BaseOriginal + '.fdb';
  NomeNovo := CaminhoOriginal + BaseOriginal + 'OLD.fdb';

  BaseOriginal := NomeNovo;
  BaseMigracao := NomeOriginal;

  RenameFile(NomeOriginal, NomeNovo);

  case rg_VersaoFB.ItemIndex of
    0:
      VersaoFB := '25';
    1:
      VersaoFB := '30';

  end;

  case rg_VersaoFBMig.ItemIndex of
    0: VersaoFBMig := '30';
    1: VersaoFBMig := '40';
  end;

  if VersaoFB = VersaoFBMig then begin
    ShowMessage('Versão da base não pode ser a mesma que a versão migrada!');
    exit;
  end;

  if FileExists(ExtractFilePath(edt_BaseOriginal.Text) + 'migracao.bat') then
    DeleteFile(ExtractFilePath(edt_BaseOriginal.Text) + 'migracao.bat');

  if FileExists(ExtractFilePath(edt_BaseOriginal.Text)+'bd'+VersaoFB+'.gbk') then
    DeleteFile(ExtractFilePath(edt_BaseOriginal.Text)+'bd'+VersaoFB+'.gbk');



  AssignFile(F, ExtractFilePath(edt_BaseOriginal.Text) + 'migracao.bat');
  Rewrite(F);
  Writeln(F, 'set ISC_USER=sysdba');
  Writeln(F, 'set ISC_PASSWORD=masterkey');
//  Writeln(F, '"' + VersaoFB + '/gbak" -g -b -z -l -v ' + BaseOriginal + ' '+BaseMigracao+'BKP.gbk');
//  Writeln(F, '"' + VersaoFB + '/gfix" -rollback all ' + BaseOriginal);
//  Writeln(F, '"' + VersaoFB + '/gfix" -shut -force 0 ' + BaseOriginal);
//  Writeln(F, '"' + VersaoFB + '/gfix" -m -i ' + BaseOriginal);
//  Writeln(F, '"' + VersaoFB + '/gbak" -g -b -z -l -v ' + BaseOriginal + ' bd25.gbk');
//  Writeln(F, '"40/gbak" -c -z -v bd25.gbk ' + BaseMigracao);
//  Writeln(F, '"40/gfix" -online ' + BaseMigracao);
//  Writeln(F, '"' + VersaoFB + '/gbak" -g -b -z -l -v ' + BaseOriginal + ' '+BaseMigracao+'BKP.gbk');

  Writeln(F, '"'+VersaoFB+'/gbak" -z -b -g -v -st t '+BaseOriginal+' bd'+VersaoFB+'.gbk');
  Writeln(F, '"'+VersaoFBMig+'/gbak" -z -c -v -st t bd'+VersaoFB+'.gbk ' + BaseMigracao);
  CloseFile(F);

  ShellExecute(application.handle, 'open', 'cmd', PWideChar('/c'+ExtractFilePath(edt_BaseOriginal.Text) + 'migracao.bat'), nil, SW_SHOWNORMAL)

end;

procedure TFPrincipal.edt_BaseMigradaChange(Sender: TObject);
begin
  if (edt_BaseOriginal.Text <> EmptyStr) and (edt_BaseMigrada.Text <> EmptyStr) then
    btn_Iniciar.Enabled := True;

end;

procedure TFPrincipal.edt_BaseOriginalChange(Sender: TObject);
begin
  if (edt_BaseOriginal.Text <> EmptyStr) and (edt_BaseMigrada.Text <> EmptyStr) then
    btn_Iniciar.Enabled := True;
end;
end.

