unit UDM;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.SqlExpr,
  Data.FMTBcd, System.IOUtils, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.FMXUI.Wait,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet;

type
  TDM = class(TDataModule)
    QryAux: TFDQuery;
    Conn: TFDConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    CodUsuario, EmpUsuario : Integer;
    procedure SetCodUsuario(const usuario, senha: string);
    function loginValido(const usuario, senha: string): Boolean;
    function CriaConta(const nome, usuario, senha:string; imagem:TStream):boolean;

  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  with Conn do begin
//    SaveInCloud
//    Params.Values['DriverID']   := 'FB';
//    Params.Values['User_Name']  := 'SYSDBA';
//    Params.Values['Password']   := '6UGyg5pr6GpbgA6IAa78';
//    Params.Values['Server']     := 'pasdevfb.jelastic.saveincloud.net';
//    Params.Values['Port']       := '11145';
//    Params.Values['Database']   := '/opt/firebird/data/DATABASE.FDB';

//    Local
//    Params.Values['DriverID']   := 'FB';
//    Params.Values['User_Name']  := 'SYSDBA';
//    Params.Values['Password']   := 'masterkey';
//    Params.Values['Server']     := '10.0.0.100';
//    Params.Values['Database']   := 'F:\Sistema\DATABASE.FDB';


    try
      Connected := True;
    except
      on e:exception do
        raise Exception.Create('Erro na conexão com o banco de dados: '+e.Message);
    end;
  end;
end;

function TDM.loginValido(const usuario, senha: string): Boolean;
begin
  with DM.Conn, DM.QryAux do
  begin
    if not Connected then //Caso o componente ConLOGIN não esteja conectado ao BD
      Connected := True;
    Close;
    Sql.Text := 'SELECT COUNT(1) FROM PRODUTOR ' + ' WHERE UPPER(PRO_CPF) = ' + QuotedStr(AnsiUpperCase(Trim(usuario))) + ' AND PRO_SENHA = ' + QuotedStr(Trim(senha));
    Open;
    if Fields[0].AsInteger > 0 then
      SetCodUsuario(usuario, senha);

    Result := (Fields[0].AsInteger > 0);
  end;
end;

function TDM.CriaConta(const nome, usuario, senha:string; imagem:TStream):boolean;
begin
  with DM.Conn, DM.QryAux do
  begin
    if not Connected then //Caso o componente ConLOGIN não esteja conectado ao BD
      Connected := True;
    Close;
    Sql.Text := 'SELECT COUNT(1) FROM USUARIO ' + ' WHERE UPPER(USU_NOME) = ' + QuotedStr(AnsiUpperCase(Trim(usuario))) + ' AND USU_SENHA = ' + QuotedStr(Trim(senha));
    Open;
    Result := (Fields[0].AsInteger > 0);
  end;
end;

procedure TDM.SetCodUsuario(const usuario, senha: string);
begin
  with DM.Conn, DM.QryAux do
  begin
    if not Connected then //Caso o componente ConLOGIN não esteja conectado ao BD
      Connected := True;
    Close;
    Sql.Text := 'SELECT PRO_ID, PRO_EMP FROM PRODUTOR ' + ' WHERE UPPER(PRO_CPF) = ' + QuotedStr(AnsiUpperCase(Trim(usuario))) + ' AND PRO_SENHA = ' + QuotedStr(Trim(senha));
    Open;
    CodUsuario := Fields[0].AsInteger;
    EmpUsuario := Fields[1].AsInteger;
  end;
end;


end.
