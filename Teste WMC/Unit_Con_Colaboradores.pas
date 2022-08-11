unit Unit_Con_Colaboradores;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB,
  Vcl.Buttons, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Data.FMTBcd,
  Datasnap.DBClient, Datasnap.Provider, Data.SqlExpr, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, ZStoredProcedure, ZAbstractTable;

type
  TForm_Con_Colaboradores = class(TForm)
    DBGrid1: TDBGrid;
    btn_Excluir: TButton;
    btn_Alterar: TButton;
    btn_Cadastrar: TBitBtn;
    DS_Colab: TDataSource;
    SSP_Colaboradores: TZStoredProc;
    ZTableColab: TZTable;
    ZTableColabCODIGO: TIntegerField;
    ZTableColabNOME: TWideStringField;
    ZTableColabENDERECO: TWideStringField;
    ZTableColabBAIRRO: TWideStringField;
    ZTableColabNUMERO: TIntegerField;
    ZTableColabCOMPLEMENTO: TWideStringField;
    ZTableColabCIDADE: TIntegerField;
    ZTableColabCEP: TWideStringField;
    ZTableColabCPF: TWideStringField;
    ZTableColabRG: TWideStringField;
    ZTableColabFONE: TWideStringField;
    ZTableColabCELULAR: TWideStringField;
    ZTableColabDATA_NASCIMENTO: TDateField;
    ZTableColabEMAIL: TWideStringField;
    ZTableColabSALARIO: TFloatField;
    procedure btn_CadastrarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_AlterarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_ExcluirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_Con_Colaboradores: TForm_Con_Colaboradores;

implementation

{$R *.dfm}

uses
  Unit_Cad_Colaboradores, Unit_Principal;

procedure TForm_Con_Colaboradores.btn_AlterarClick(Sender: TObject);
begin
  if ZTableColab.RecordCount <= 0 then
    exit;
  if Form_Cad_Colaboradores = nil then
    Application.CreateForm(TForm_Cad_Colaboradores, Form_Cad_Colaboradores);
  with Form_Cad_Colaboradores do
  begin
    btn_Inserir.Visible := false;
    edt_CodigoColaborador.Text := ZTableColab.FieldByName('CODIGO').AsString;
    TrazDados(ZTableColab.FieldByName('CODIGO').AsInteger);
  end;
  Form_Cad_Colaboradores.Show;
end;

procedure TForm_Con_Colaboradores.btn_CadastrarClick(Sender: TObject);
begin
  if Form_Cad_Colaboradores = nil then
    Application.CreateForm(TForm_Cad_Colaboradores, Form_Cad_Colaboradores);
  with Form_Cad_Colaboradores do
  begin
    btn_Alterar.Visible := false;
  end;
  Form_Cad_Colaboradores.Show;
end;

procedure TForm_Con_Colaboradores.btn_ExcluirClick(Sender: TObject);
begin
  if Application.MessageBox('Deseja excluir o colaborador?', 'Exclusão', MB_YESNO + MB_ICONWARNING + MB_DEFBUTTON2) = IDYES then
  begin
    try
      with SSP_Colaboradores do
      begin
        ParamByName('TIPO').AsString := 'D';
        ParamByName('CODIGO').AsInteger := ZTableColab.FieldByName('CODIGO').AsInteger;
        ExecProc();
      end;
      ZTableColab.Refresh;
    except
      on e: exception do
      begin
        ShowMessage('Erro ao excluir colaborador! ' + e.Message);
      end;

    end;
  end;

end;

procedure TForm_Con_Colaboradores.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Form_Con_Colaboradores := Nil;
  Action := CaFree;
end;

procedure TForm_Con_Colaboradores.FormCreate(Sender: TObject);
begin
  ZTableColab.Active := False;
  ZTableColab.Active := True;
end;

end.

