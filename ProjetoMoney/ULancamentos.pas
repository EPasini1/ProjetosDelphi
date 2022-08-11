unit ULancamentos;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView;

type
  TFrmLancamentos = class(TForm)
    Layout1: TLayout;
    Label1: TLabel;
    ImgVoltar: TImage;
    Layout2: TLayout;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    LblMes: TLabel;
    Rectangle1: TRectangle;
    ImgAdd: TImage;
    Layout3: TLayout;
    Label4: TLabel;
    Label5: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    LvLancamento: TListView;
    procedure ImgVoltarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure LvLancamentoUpdateObjects(const Sender: TObject;
      const AItem: TListViewItem);
    procedure LvLancamentoItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure ImgAddClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure EditarLancamento(id_lancamento:String);
  end;

var
  FrmLancamentos: TFrmLancamentos;

implementation

uses
  UPrincipal, ULancamentosCad;

{$R *.fmx}

procedure TFrmLancamentos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //Destroi no Close do FrmPrincipal
  //Action := TCloseAction.caFree;
  //FrmLancamentos := nil;

end;

procedure TFrmLancamentos.FormShow(Sender: TObject);
var
  Icone : TStream;
begin
  Icone := TMemoryStream.Create;
  FrmPrincipal.ImgCategoria.Bitmap.SaveToStream(Icone);
  Icone.Position := 0;
  FrmPrincipal.InsereLancamento(FrmLancamentos.LvLancamento,1, 'Compra de passagem', 'Transporte', date, -45, Icone);

  Icone.DisposeOf;
end;

procedure TFrmLancamentos.ImgAddClick(Sender: TObject);
begin
  EditarLancamento('');
end;

procedure TFrmLancamentos.ImgVoltarClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmLancamentos.LvLancamentoItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  EditarLancamento('');
end;

procedure TFrmLancamentos.EditarLancamento(id_lancamento:String);
begin
  if not Assigned(FrmLancamentosCad) then
    Application.CreateForm(TFrmLancamentosCad, FrmLancamentosCad);
  FrmLancamentosCad.Show;
end;

procedure TFrmLancamentos.LvLancamentoUpdateObjects(const Sender: TObject;
  const AItem: TListViewItem);
begin
  FrmPrincipal.SetupLancamento(FrmLancamentos.LvLancamento, AItem);
end;

end.
