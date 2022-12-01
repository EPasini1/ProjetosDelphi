program MapasEdge;

uses
  Vcl.Forms,
  uMapasEdge in 'uMapasEdge.pas' {Form1},
  Lib.GoogleMaps in 'Lib.GoogleMaps.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
