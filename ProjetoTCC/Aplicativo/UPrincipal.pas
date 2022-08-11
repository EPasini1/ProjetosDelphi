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
    Layout2: TLayout;
    Layout3: TLayout;
    Layout4: TLayout;
    Label1: TLabel;
    Image1: TImage;
    Label5: TLabel;
    Layout5: TLayout;
    lblBemVindo: TLabel;
    LvAgendamentos: TListView;
    procedure Image1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure InsereAgendamento(listView: TListView;
    EmpresaAgend, VariedadeAgend : String;
    DataAgendamento, HorarioAgendamento:TDateTime);
  public
    { Public declarations }
    ProdID : Integer;
    procedure GetAgendamentos();
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.fmx}

uses UAgendamento, UDM;

procedure TFrmPrincipal.FormShow(Sender: TObject);
begin
  with DM.QryAux do begin
    SQL.Clear;
    SQl.Add('select PRO_NOME from PRODUTOR where PRO_ID = '+IntToStr(DM.CodUsuario));
    Open;
    lblBemVindo.Text := 'Bem Vindo '+DM.QryAux.Fields[0].AsString+'!';

    GetAgendamentos()
  end;
end;

procedure TFrmPrincipal.Image1Click(Sender: TObject);
begin
  if not Assigned(FrmAgendamento) then
    Application.CreateForm(TFrmAgendamento,FrmAgendamento);
  FrmAgendamento.Show;
end;

procedure TFrmPrincipal.InsereAgendamento(listView: TListView;
EmpresaAgend, VariedadeAgend : String;
DataAgendamento, HorarioAgendamento:TDateTime);
var
  bmp : TBitmap;
begin
  with listView.Items.Add do
  begin
    TListItemText(Objects.FindDrawable('TxtEmpresa')).Text := 'Empresa: '+EmpresaAgend;
    TListItemText(Objects.FindDrawable('TxtVariedade')).Text := 'Variedade: '+VariedadeAgend;
    TListItemText(Objects.FindDrawable('TxtData')).Text := 'Data: '+FormatDateTime('DD/mm/yyyy', DataAgendamento);
    TListItemText(Objects.FindDrawable('TxtHorario')).Text := 'Horário: '+FormatDateTime('HH:mm', HorarioAgendamento);
  end;
end;

procedure TFrmPrincipal.GetAgendamentos();
begin
  with DM.QryAux do
  begin
    SQL.Clear;
    SQL.Add('select AGP_DIA, HOE_INI, VDU_NOME, EMP_FANTASIA'+#13+
            'from AGENDAMENTO_PRODUTOR'+#13+
            'join DATA_ENTREGA on DTE_ID = AGP_DTE'+#13+
            'join HORARIOS_ENTREGA on HOE_ID = AGP_HOE'+#13+
            'join VARIEDADE_DE_UVA on VDU_ID = AGP_VAR_UVA '+#13+
            'join EMPRESA on EMP_ID = AGP_EMP'+#13+
            'where AGP_PRO = '+IntToStr(DM.CodUsuario));
    Open;
    LvAgendamentos.Items.Clear;
    while not Eof do
    begin
      InsereAgendamento(lvAgendamentos, FieldByName('EMP_FANTASIA').AsString,FieldByName('VDU_NOME').AsString, FieldByName('AGP_DIA').AsDateTime, FieldByName('HOE_INI').AsDateTime);
      Next;
    end;
  end;
end;

end.
