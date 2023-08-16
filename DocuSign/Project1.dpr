program Project1;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  FileAccess in 'chilkat\FileAccess.pas',
  OAuth2 in 'chilkat\OAuth2.pas',
  Http in 'chilkat\Http.pas',
  BinData in 'chilkat\BinData.pas',
  StringBuilder in 'chilkat\StringBuilder.pas',
  HttpResponse in 'chilkat\HttpResponse.pas',
  JsonObject in 'chilkat\JsonObject.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
