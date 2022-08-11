unit ULancamentosCad;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Edit,
  FMX.DateTimeCtrls;

type
  TFrmLancamentosCad = class(TForm)
    Layout1: TLayout;
    Label1: TLabel;
    ImgVoltar: TImage;
    Image1: TImage;
    Rectangle1: TRectangle;
    Image4: TImage;
    Layout2: TLayout;
    Label2: TLabel;
    edtEmail: TEdit;
    Line1: TLine;
    Layout4: TLayout;
    Label4: TLabel;
    Layout5: TLayout;
    Label5: TLabel;
    Edit3: TEdit;
    Line4: TLine;
    Layout6: TLayout;
    Label6: TLabel;
    Edit4: TEdit;
    Line5: TLine;
    ImgHoje: TImage;
    ImgOntem: TImage;
    DateEdit1: TDateEdit;
    procedure ImgVoltarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmLancamentosCad: TFrmLancamentosCad;

implementation

uses
  UPrincipal;

{$R *.fmx}

procedure TFrmLancamentosCad.ImgVoltarClick(Sender: TObject);
begin
  Close;
end;

end.
