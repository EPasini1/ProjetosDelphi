unit Lib.GoogleMaps;

interface

uses
  Pkg.Json.DTO, System.Generics.Collections, REST.Json.Types;

{$M+}

type
  TSouthwestDTO = class
  private
    [JSONName('lat')]
    FLat: Double;
    [JSONName('lng')]
    FLng: Double;
  published
    property Lat: Double read FLat write FLat;
    property Lng: Double read FLng write FLng;
  end;
  
  TNortheastDTO = class
  private
    [JSONName('lat')]
    FLat: Double;
    [JSONName('lng')]
    FLng: Double;
  published
    property Lat: Double read FLat write FLat;
    property Lng: Double read FLng write FLng;
  end;
  
  TViewportDTO = class
  private
    [JSONName('northeast')]
    FNortheast: TNortheastDTO;
    [JSONName('southwest')]
    FSouthwest: TSouthwestDTO;
  published
    property Northeast: TNortheastDTO read FNortheast write FNortheast;
    property Southwest: TSouthwestDTO read FSouthwest write FSouthwest;
  public
    constructor Create;
    destructor Destroy; override;
  end;
  
  TLocationDTO = class
  private
    [JSONName('lat')]
    FLat: Double;
    [JSONName('lng')]
    FLng: Double;
  published
    property Lat: Double read FLat write FLat;
    property Lng: Double read FLng write FLng;
  end;
  
  TGeometryDTO = class
  private
    [JSONName('location')]
    FLocation: TLocationDTO;
    [JSONName('location_type')]
    FLocation_Type: string;
    [JSONName('viewport')]
    FViewport: TViewportDTO;
  published
    property Location: TLocationDTO read FLocation write FLocation;
    property Location_Type: string read FLocation_Type write FLocation_Type;
    property Viewport: TViewportDTO read FViewport write FViewport;
  public
    constructor Create;
    destructor Destroy; override;
  end;
  
  TAddress_ComponentsDTO = class
  private
    [JSONName('long_name')]
    FLong_Name: string;
    [JSONName('short_name')]
    FShort_Name: string;
    [JSONName('types')]
    FTypes: TArray<string>;
  published
    property Long_Name: string read FLong_Name write FLong_Name;
    property Short_Name: string read FShort_Name write FShort_Name;
    property Types: TArray<string> read FTypes write FTypes;
  end;
  
  TResultadoRotaDTO = class
  private
    [JSONName('address_components')]
    FAddress_ComponentsArray: TArray<TAddress_ComponentsDTO>;
    [GenericListReflect]
    FAddress_Components: TObjectList<TAddress_ComponentsDTO>;
    [JSONName('formatted_address')]
    FFormatted_Address: string;
    [JSONName('geometry')]
    FGeometry: TGeometryDTO;
    [JSONName('place_id')]
    FPlace_Id: string;
    [JSONName('types')]
    FTypes: TArray<string>;
    function GetAddress_Components: TObjectList<TAddress_ComponentsDTO>;
  published
    property Address_Components: TObjectList<TAddress_ComponentsDTO> read GetAddress_Components;
    property Formatted_Address: string read FFormatted_Address write FFormatted_Address;
    property Geometry: TGeometryDTO read FGeometry write FGeometry;
    property Place_Id: string read FPlace_Id write FPlace_Id;
    property Types: TArray<string> read FTypes write FTypes;
  public
    constructor Create;
    destructor Destroy; override;
  end;
  
  TGoogleMapsDTO = class(TJsonDTO)
  private
    [JSONName('results')]
    FResultadoRotaArray: TArray<TResultadoRotaDTO>;
    [GenericListReflect]
    FResultadoRota: TObjectList<TResultadoRotaDTO>;
    [JSONName('status')]
    FStatus: string;
    function GetResultadoRota: TObjectList<TResultadoRotaDTO>;
  published
    property ResultadoRota: TObjectList<TResultadoRotaDTO> read GetResultadoRota;
    property Status: string read FStatus write FStatus;
    destructor Destroy; override;
  end;
  
implementation

{ TViewportDTO }

constructor TViewportDTO.Create;
begin
  inherited;
  FNortheast := TNortheastDTO.Create;
  FSouthwest := TSouthwestDTO.Create;
end;

destructor TViewportDTO.Destroy;
begin
  FNortheast.Free;
  FSouthwest.Free;
  inherited;
end;

{ TGeometryDTO }

constructor TGeometryDTO.Create;
begin
  inherited;
  FLocation := TLocationDTO.Create;
  FViewport := TViewportDTO.Create;
end;

destructor TGeometryDTO.Destroy;
begin
  FLocation.Free;
  FViewport.Free;
  inherited;
end;

{ TResultadoRotaDTO }

constructor TResultadoRotaDTO.Create;
begin
  inherited;
  FGeometry := TGeometryDTO.Create;
end;

destructor TResultadoRotaDTO.Destroy;
begin
  FGeometry.Free;
  GetAddress_Components.Free;
  inherited;
end;

function TResultadoRotaDTO.GetAddress_Components: TObjectList<TAddress_ComponentsDTO>;
begin
  if not Assigned(FAddress_Components) then
  begin
    FAddress_Components := TObjectList<TAddress_ComponentsDTO>.Create;
    FAddress_Components.AddRange(FAddress_ComponentsArray);
  end;
  Result := FAddress_Components;
end;

{ TGoogleMapsDTO }

destructor TGoogleMapsDTO.Destroy;
begin
  GetResultadoRota.Free;
  inherited;
end;

function TGoogleMapsDTO.GetResultadoRota: TObjectList<TResultadoRotaDTO>;
begin
  if not Assigned(FResultadoRota) then
  begin
    FResultadoRota := TObjectList<TResultadoRotaDTO>.Create;
    FResultadoRota.AddRange(FResultadoRotaArray);
  end;
  Result := FResultadoRota;
end;

end.