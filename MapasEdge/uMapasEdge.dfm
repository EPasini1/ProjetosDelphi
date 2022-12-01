object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 715
  ClientWidth = 974
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnClose = FormClose
  OnCreate = FormCreate
  TextHeight = 15
  object EdgeBrowser1: TEdgeBrowser
    Left = 0
    Top = 0
    Width = 696
    Height = 715
    Align = alClient
    TabOrder = 0
    UserDataFolder = '%LOCALAPPDATA%\bds.exe.WebView2'
    ExplicitWidth = 692
    ExplicitHeight = 714
  end
  object Panel1: TPanel
    Left = 696
    Top = 0
    Width = 278
    Height = 715
    Align = alRight
    TabOrder = 1
    ExplicitLeft = 692
    ExplicitHeight = 714
    object PageControl1: TPageControl
      Left = 1
      Top = 42
      Width = 276
      Height = 672
      ActivePage = tsMarcador
      Align = alClient
      TabOrder = 0
      ExplicitHeight = 671
      object TabSheet1: TTabSheet
        Caption = 'Marcadores'
        object lbMarcadores: TListBox
          Left = 1
          Top = 3
          Width = 264
          Height = 286
          ItemHeight = 15
          TabOrder = 0
          OnClick = lbMarcadoresClick
        end
        object btnAdicionar: TButton
          Left = 3
          Top = 312
          Width = 75
          Height = 25
          Caption = 'Adicionar'
          TabOrder = 1
          OnClick = btnAdicionarClick
        end
        object btnExcluir: TButton
          Left = 190
          Top = 312
          Width = 75
          Height = 25
          Caption = 'Excluir'
          TabOrder = 2
        end
      end
      object tsMarcador: TTabSheet
        Caption = 'Marcador'
        ImageIndex = 1
        DesignSize = (
          268
          642)
        object Label1: TLabel
          Left = 14
          Top = 48
          Width = 49
          Height = 15
          Anchors = [akTop, akRight]
          Caption = 'Endere'#231'o'
        end
        object SpeedButton1: TSpeedButton
          Left = 240
          Top = 70
          Width = 23
          Height = 22
          Anchors = [akTop, akRight]
          OnClick = SpeedButton1Click
        end
        object Label4: TLabel
          Left = 14
          Top = 3
          Width = 55
          Height = 15
          Anchors = [akTop, akRight]
          Caption = 'Refer'#234'ncia'
        end
        object Label5: TLabel
          Left = 14
          Top = 98
          Width = 53
          Height = 15
          Anchors = [akTop, akRight]
          Caption = #205'cone URL'
        end
        object edtEndereco: TEdit
          Left = 14
          Top = 69
          Width = 220
          Height = 23
          Anchors = [akTop, akRight]
          TabOrder = 1
        end
        object GroupBox1: TGroupBox
          Left = 14
          Top = 150
          Width = 249
          Height = 111
          Anchors = [akTop, akRight]
          Caption = 'GroupBox1'
          TabOrder = 3
          object Label2: TLabel
            Left = 16
            Top = 16
            Width = 43
            Height = 15
            Caption = 'Latitude'
          end
          object Label3: TLabel
            Left = 16
            Top = 56
            Width = 54
            Height = 15
            Caption = 'Longitude'
          end
          object edtLat: TEdit
            Left = 16
            Top = 32
            Width = 224
            Height = 23
            TabOrder = 0
            OnChange = edtLatChange
          end
          object edtLon: TEdit
            Left = 16
            Top = 73
            Width = 224
            Height = 23
            TabOrder = 1
            OnChange = edtLonChange
          end
        end
        object Button1: TButton
          Left = 14
          Top = 271
          Width = 75
          Height = 25
          Anchors = [akTop, akRight]
          Caption = 'OK'
          TabOrder = 4
          OnClick = Button1Click
        end
        object edtReferencia: TEdit
          Left = 14
          Top = 22
          Width = 220
          Height = 23
          Anchors = [akTop, akRight]
          TabOrder = 0
          OnChange = edtReferenciaChange
        end
        object edtIcone: TEdit
          Left = 14
          Top = 119
          Width = 220
          Height = 23
          Anchors = [akTop, akRight]
          TabOrder = 2
          OnChange = edtIconeChange
        end
      end
    end
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 276
      Height = 41
      Align = alTop
      TabOrder = 1
      object cbAtivar: TCheckBox
        Left = 14
        Top = 13
        Width = 97
        Height = 17
        Caption = 'Ativar'
        TabOrder = 0
        OnClick = cbAtivarClick
      end
    end
  end
  object GMMapEdge1: TGMMapEdge
    Browser = EdgeBrowser1
    MapOptions.ClickableIcons = True
    MapOptions.GestureHandling = ghAuto
    MapOptions.IsFractionalZoomEnabled = True
    MapOptions.Restriction.StrictBounds = False
    MapOptions.Restriction.Enabled = False
    Markers.Markers = <>
    Markers.AutoUpdate = False
    APIKey = 'AIzaSyBYVmTYLNERYrjkvUwdf-ICGNRu-8SPPeo'
    APILang = lPortuguese_Br
    APIRegion = rBrazil
    IntervalEvents = 0
    TrafficLayer.Show = False
    TrafficLayer.TrafficLayerOptions.AutoRefresh = True
    TransitLayer.Show = False
    ByciclingLayer.Show = False
    KmlLayer.Show = False
    Left = 264
    Top = 232
  end
end
