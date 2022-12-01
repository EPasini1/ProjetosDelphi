unit uMapasEdge;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Winapi.WebView2, Winapi.ActiveX,
  Vcl.StdCtrls, Vcl.ExtCtrls, GMLib.Classes, GMLib.Map, GMLib.Map.Vcl, Vcl.Edge,
  Vcl.Buttons, System.Net.URLClient, System.Net.HttpClient,
  System.Net.HttpClientComponent, system.Generics.Collections, system.NetEncoding,
  Vcl.ComCtrls, gmlib.Marker.Vcl, gmlib.Transform.Vcl;

const
  APIKey = 'AIzaSyBYVmTYLNERYrjkvUwdf-ICGNRu-8SPPeo';

type
  TLocalizacao = record
     Latitude   : Double;
     Longitude  : Double;
  end;

  TForm1 = class(TForm)
    EdgeBrowser1: TEdgeBrowser;
    GMMapEdge1: TGMMapEdge;
    Panel1: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Panel2: TPanel;
    cbAtivar: TCheckBox;
    tsMarcador: TTabSheet;
    Label1: TLabel;
    edtEndereco: TEdit;
    SpeedButton1: TSpeedButton;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    edtLat: TEdit;
    edtLon: TEdit;
    Button1: TButton;
    lbMarcadores: TListBox;
    btnAdicionar: TButton;
    btnExcluir: TButton;
    Label4: TLabel;
    edtReferencia: TEdit;
    Label5: TLabel;
    edtIcone: TEdit;
    procedure cbAtivarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButton1Click(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure lbMarcadoresClick(Sender: TObject);
    procedure edtIconeChange(Sender: TObject);
    procedure edtLatChange(Sender: TObject);
    procedure edtLonChange(Sender: TObject);
    procedure edtReferenciaChange(Sender: TObject);
  private
    { Private declarations }
    Localizacao : TLocalizacao;
    function GetLocalizacao(Endereco: string): TLocalizacao;
    procedure SetPropToComponents;
    procedure LoadMarkers;
    procedure GetInfoMarker;
    procedure GetAnimation;
    procedure GetCollisionBehavior;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  Lib.GoogleMaps;

{$R *.dfm}

procedure TForm1.btnAdicionarClick(Sender: TObject);
var
  Marker: TGMMarker;
begin
  Marker := GMMapEdge1.Markers.Markers.Add;
  Marker.Title := 'Novo';
  LoadMarkers;
  GetInfoMarker;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  GMMapEdge1.Markers.Markers[lbMarcadores.ItemIndex].Visible := True;
  PageControl1.ActivePageIndex := 0;
end;

procedure TForm1.cbAtivarClick(Sender: TObject);
begin
  GMMapEdge1.Active := cbAtivar.Checked;
end;

procedure TForm1.edtIconeChange(Sender: TObject);
begin
  GMMapEdge1.Markers.Markers[lbMarcadores.ItemIndex].Icon.Url := edtIcone.Text;
end;

procedure TForm1.edtLatChange(Sender: TObject);
begin
  GMMapEdge1.Markers.Markers[lbMarcadores.ItemIndex].Position.Lat := TGMTransform.GetStrToDouble(edtLat.Text);
end;

procedure TForm1.edtLonChange(Sender: TObject);
begin
  GMMapEdge1.Markers.Markers[lbMarcadores.ItemIndex].Position.Lng := TGMTransform.GetStrToDouble(edtLon.Text);
end;

procedure TForm1.edtReferenciaChange(Sender: TObject);
begin
  GMMapEdge1.Markers.Markers[lbMarcadores.ItemIndex].LabelText.Text := edtReferencia.Text;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  GMMapEdge1.Destroy;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  GMMapEdge1.MapOptions.Center.Lat := -27;
  GMMapEdge1.MapOptions.Center.Lng := -50;
  GMMapEdge1.APIKey := APIKey;
  PageControl1.ActivePageIndex := 0;
end;

procedure TForm1.GetAnimation;
begin

end;

procedure TForm1.GetCollisionBehavior;
begin

end;

procedure TForm1.GetInfoMarker;
begin
  tsmarcador.Caption := 'Marcador';

  if lbmarcadores.ItemIndex = -1 then
    Exit;

  tsmarcador.Caption := lbmarcadores.Items[lbmarcadores.ItemIndex];
end;

function TForm1.GetLocalizacao(Endereco: string): TLocalizacao;
var
  LHTTP: TNETHTTPClient;
  request, response: string;
  JsonPure: string;
  JsonParsed: TGoogleMapsDTO;
  RetornoRota: TObjectList<TResultadoRotaDTO>;
begin
  LHTTP := TNetHTTPClient.Create(nil);
  request := 'https://maps.googleapis.com/maps/api/geocode/json?address=' + TNetEncoding.Url.Encode(Endereco) + '&key=' + APIKey;
  response := LHTTP.Get(request).ContentAsString;
  JsonPure := response;
  JsonParsed := TGoogleMapsDTO.Create;
  JsonParsed.AsJson := JsonPure;

  RetornoRota := JsonParsed.ResultadoRota;

  Result.Latitude   :=  RetornoRota[0].Geometry.Location.Lat;
  Result.Longitude  :=  RetornoRota[0].Geometry.Location.Lng;
  edtLat.Text       :=  RetornoRota[0].Geometry.Location.Lat.ToString;
  edtLon.Text       :=  RetornoRota[0].Geometry.Location.Lng.ToString;
end;

procedure TForm1.lbMarcadoresClick(Sender: TObject);
begin
  GetInfoMarker;
  PageControl1.ActivePageIndex := 1;
end;

procedure TForm1.LoadMarkers;
var
  i: Integer;
begin
  lbMarcadores.Clear;
  for i := 0 to GMMapEdge1.Markers.Markers.Count - 1 do
    lbMarcadores.AddItem(GMMapEdge1.Markers.Markers[i].Name, GMMapEdge1.Markers.Markers[i]);
end;

procedure TForm1.SetPropToComponents;
begin
  LoadMarkers;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  Localizacao := GetLocalizacao(edtEndereco.Text);
end;

end.
