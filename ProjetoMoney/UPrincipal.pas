unit UPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Layouts,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView;

type
  TFrmPrincipal = class(TForm)
    Layout1: TLayout;
    imgMenu: TImage;
    Circle1: TCircle;
    Image1: TImage;
    Label1: TLabel;
    Layout2: TLayout;
    Label2: TLabel;
    Label3: TLabel;
    Layout3: TLayout;
    Layout4: TLayout;
    Layout5: TLayout;
    Image2: TImage;
    Label4: TLabel;
    Label5: TLabel;
    Layout6: TLayout;
    Image3: TImage;
    Label6: TLabel;
    Label7: TLabel;
    Rectangle1: TRectangle;
    Image4: TImage;
    Rectangle2: TRectangle;
    Layout7: TLayout;
    Label8: TLabel;
    LblTodosLanc: TLabel;
    LvLancamento: TListView;
    ImgCategoria: TImage;
    StyleBook1: TStyleBook;
    procedure FormShow(Sender: TObject);
    procedure LvLancamentoUpdateObjects(const Sender: TObject;
      const AItem: TListViewItem);
    procedure LblTodosLancClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure InsereLancamento(listView: TListView;
                              IdLancamento: Integer;
                              Descricao, Categoria:String;
                              dtLancamento:TDateTime;
                              Valor: double;
                              icone:TStream);
    procedure SetupLancamento(lv:TListView; Item: TListViewItem);
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

uses
  ULancamentos;

{$R *.fmx}

procedure TFrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(FrmLancamentos) then
  begin
    FrmLancamentos.DisposeOf;
    FrmLancamentos := nil;
  end;
end;

procedure TFrmPrincipal.FormShow(Sender: TObject);
var
  Icone : TStream;
begin
  Icone := TMemoryStream.Create;
  ImgCategoria.Bitmap.SaveToStream(Icone);
  Icone.Position := 0;
  InsereLancamento(FrmPrincipal.LvLancamento,1, 'Compra de passagem 123456789456789132 aAAAAAAAAAAAAAAA', 'Transporte', date, -45, Icone);

  Icone.DisposeOf;
end;

procedure TFrmPrincipal.InsereLancamento(listView: TListView;
IdLancamento: Integer;
Descricao,Categoria: String;
dtLancamento:TDateTime;
Valor: double;
icone: TStream);
var
  bmp : TBitmap;
begin
  with listView.Items.Add do
  begin
    TListItemText(Objects.FindDrawable('TxtDescricao')).Text := Descricao;
    TListItemText(Objects.FindDrawable('TxtCategoria')).Text := Categoria;
    TListItemText(Objects.FindDrawable('TxtValor')).Text := FormatFloat('#,##0.00', Valor);
    TListItemText(Objects.FindDrawable('TxtData')).Text := FormatDateTime('dd/mm', dtLancamento);
    if icone <> nil then
    begin
      bmp := TBitmap.Create;
      bmp.LoadFromStream(icone);
      TListItemImage(Objects.FindDrawable('ImgIcone')).OwnsBitmap := True;
      TListItemImage(Objects.FindDrawable('ImgIcone')).Bitmap := bmp;
    end;
  end;
end;

procedure TFrmPrincipal.SetupLancamento(lv:TListView; Item: TListViewItem);
var
  txtDescricao, txtCategoria: TListItemText;
begin
  txtDescricao := TListItemText(Item.Objects.FindDrawable('TxtDescricao'));
  txtCategoria := TListItemText(Item.Objects.FindDrawable('TxtCategoria'));
  txtDescricao.Width := lv.Width - txtDescricao.PlaceOffset.X - 80;
  txtCategoria.Width := lv.Width - txtDescricao.PlaceOffset.X - 80;
end;


procedure TFrmPrincipal.LblTodosLancClick(Sender: TObject);
begin
  if NOT Assigned(FrmLancamentos) then
    Application.CreateForm(TFrmLancamentos, FrmLancamentos);
  FrmLancamentos.Show;
end;

procedure TFrmPrincipal.LvLancamentoUpdateObjects(const Sender: TObject;
  const AItem: TListViewItem);
begin
  SetupLancamento(FrmPrincipal.LvLancamento,AItem);
end;

end.
