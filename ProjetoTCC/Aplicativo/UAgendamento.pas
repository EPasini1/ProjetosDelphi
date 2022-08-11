unit UAgendamento;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.ListBox, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts;

type
  TFrmAgendamento = class(TForm)
    Layout1: TLayout;
    Label1: TLabel;
    CBVariedadeUva: TComboBox;
    Layout2: TLayout;
    Label2: TLabel;
    CBDataDescarregamento: TComboBox;
    Image1: TImage;
    Layout3: TLayout;
    ImgVolta: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ImgVoltaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CBVariedadeUvaChange(Sender: TObject);
    procedure Image1Click(Sender: TObject);
  private
    { Private declarations }
    procedure GetVariedades(Empresa:Integer);
    procedure GetDataDescarregamento(Empresa, VariedadeUva:Integer);
  public
    { Public declarations }
  end;

var
  FrmAgendamento: TFrmAgendamento;

implementation

{$R *.fmx}

uses UDM, UCalendario, UPrincipal;

procedure TFrmAgendamento.CBVariedadeUvaChange(Sender: TObject);
begin
  if CBVariedadeUva.Items.Text <> '' then
  begin
    CBDataDescarregamento.Enabled := True;
    GetDataDescarregamento(DM.EmpUsuario, Integer(CBVariedadeUva.Items.Objects[CBVariedadeUva.ItemIndex]));
  end;
end;

procedure TFrmAgendamento.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
  FrmAgendamento := nil;
end;

procedure TFrmAgendamento.FormShow(Sender: TObject);
begin
  GetVariedades(DM.EmpUsuario);
end;

procedure TFrmAgendamento.Image1Click(Sender: TObject);
begin
  if CBVariedadeUva.Items.Text <> '' then
    if CBDataDescarregamento.Items.Text <> '' then
    begin
      if not Assigned(FrmCalendario) then
        Application.CreateForm(TFrmCalendario,FrmCalendario);
      FrmCalendario.Calendar.OnChange := nil;
      FrmCalendario.Calendar.Date := DM.QryAux.FieldByName('DTE_INI').AsDateTime;
      FrmCalendario.DTE_ID := DM.QryAux.FieldByName('DTE_ID').AsInteger;
      FrmCalendario.DTE_EMP := DM.QryAux.FieldByName('DTE_EMP').AsInteger;
      FrmCalendario.DTE_VAR_UVA := DM.QryAux.FieldByName('DTE_VARIEDADE_UVA').AsInteger;
      FrmCalendario.Calendar.OnChange := FrmCalendario.CalendarChange;
      FrmCalendario.Show;
    end;
end;

procedure TFrmAgendamento.ImgVoltaClick(Sender: TObject);
begin
  FrmPrincipal.GetAgendamentos();
  Close;
end;

procedure TFrmAgendamento.GetVariedades(Empresa:Integer);
begin
  with DM.QryAux do
  begin
    SQL.Clear;
    SQL.Add('SELECT * FROM VARIEDADE_DE_UVA where VDU_EMP = :VDU_EMP');
    ParamByName('VDU_EMP').AsInteger := Empresa;
    Open;
    CBVariedadeUva.Items.Clear;
    while not Eof do
    begin
      CBVariedadeUva.Items.AddObject(FieldByName('VDU_NOME').AsString, TObject(FieldByName('VDU_ID').AsInteger));
      Next;
    end;
  end;
end;

procedure TFrmAgendamento.GetDataDescarregamento(Empresa, VariedadeUva:Integer);
begin
  with DM.QryAux do
  begin
    SQL.Clear;
    SQL.Add('SELECT * FROM DATA_ENTREGA where DTE_EMP = :DTE_EMP and DTE_VARIEDADE_UVA = :DTE_VARIEDADE_UVA');
    ParamByName('DTE_EMP').AsInteger := Empresa;
    ParamByName('DTE_VARIEDADE_UVA').AsInteger := VariedadeUva;
    Open;
    CBDataDescarregamento.Items.Clear;
    while not Eof do
    begin
      CBDataDescarregamento.Items.Add(FieldByName('DTE_INI').AsString + ' à '+FieldByName('DTE_FIM').AsString );
      Next;
    end;
  end;
end;

end.
