unit UCalendario;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Calendar,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, System.DateUtils, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView, FMX.DialogService;

type
  TFrmCalendario = class(TForm)
    Layout3: TLayout;
    ImgVolta: TImage;
    QryDataEntrega: TFDQuery;
    Layout1: TLayout;
    Calendar: TCalendar;
    Layout2: TLayout;
    QryHoraEntrega: TFDQuery;
    LvHorarios: TListView;
    procedure ImgVoltaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CalendarChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure LvHorariosItemClick(const Sender: TObject;
      const AItem: TListViewItem);
  private
    { Private declarations }
    Procedure MontaHorariosEntrega;
    procedure InsereHorario(listView: TListView; IdHorario: Integer; Horario:TDateTime);
  public
    { Public declarations }
    DTE_ID, DTE_EMP, DTE_VAR_UVA : Integer;
  end;

var
  FrmCalendario: TFrmCalendario;

implementation

uses
  UDM;

{$R *.fmx}

procedure TFrmCalendario.CalendarChange(Sender: TObject);
begin
  QryDataEntrega.SQl.Clear;
  QryDataEntrega.SQL.Add('SELECT * FROM DATA_ENTREGA WHERE DTE_ID = :DTE_ID');
  QryDataEntrega.ParamByName('DTE_ID').AsInteger := DTE_ID;
  QryDataEntrega.Open;

  if (Calendar.Date <  QryDataEntrega.FieldByName('DTE_INI').AsDateTime) or (Calendar.Date >  QryDataEntrega.FieldByName('DTE_FIM').AsDateTime) then
  begin
    Calendar.Date := QryDataEntrega.FieldByName('DTE_INI').AsDateTime;
    ShowMessage('Data selecionada fora do período de entrega!');
    exit;
  end;

  LvHorarios.Items.Clear;
  MontaHorariosEntrega;
end;

procedure TFrmCalendario.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
  FrmCalendario := nil;
end;

procedure TFrmCalendario.FormShow(Sender: TObject);
begin
  CalendarChange(sender);
end;

procedure TFrmCalendario.ImgVoltaClick(Sender: TObject);
begin
  Close;
end;

Procedure TFrmCalendario.MontaHorariosEntrega;
  function DiaDaSemana(Dia: TDateTime):integer;
  begin
    if DayOfWeek(Dia) = 1 then
     Result := 7
    else
      Result := DayOfWeek(Dia) - 1;
  end;
begin
  with QryHoraEntrega do
  begin
    SQL.Clear;
    SQL.Add('select *'+#13#10+
            'from HORARIOS_ENTREGA'+#13#10+
            'where HOE_EMP = :HOE_EMP'+#13#10+
            '      and HOE_DTE = :HOE_DTE'+#13#10+
            '      and HOE_VAR_UVA = :HOE_VAR_UVA'+#13#10+
            '      and HOE_DDS = :HOE_DDS'+#13#10+
            '      and not exists (select AGP_HOE from AGENDAMENTO_PRODUTOR where AGP_HOE = HOE_ID)');

    ParamByName('HOE_EMP').AsInteger      := DTE_EMP;
    ParamByName('HOE_DTE').AsInteger      := DTE_ID;
    ParamByname('HOE_VAR_UVA').AsInteger  := DTE_VAR_UVA;
    ParamByName('HOE_DDS').AsInteger      := DiaDaSemana(Calendar.Date);
    Open;
    while not Eof do
    begin
      InsereHorario(LvHorarios, FieldByName('HOE_ID').AsInteger, FieldByName('HOE_INI').AsDateTime);
      next;
    end;

  end;

end;

procedure TFrmCalendario.InsereHorario(listView: TListView;
IdHorario: Integer;
Horario:TDateTime);
var
  bmp : TBitmap;
begin
  with listView.Items.Add do
  begin
    TListItemText(Objects.FindDrawable('TxtID')).Text := IntToStr(IdHorario);
    TListItemText(Objects.FindDrawable('TxtHorario')).Text := FormatDateTime('HH:mm', Horario);
  end;
end;

procedure TFrmCalendario.LvHorariosItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  TDialogService.MessageDialog(('Deseja agendar horário?'), system.UITypes.TMsgDlgType.mtConfirmation,
  [system.UITypes.TMsgDlgBtn.mbYes, system.UITypes.TMsgDlgBtn.mbNo], system.UITypes.TMsgDlgBtn.mbYes,0,
  procedure (const AResult: System.UITypes.TModalResult)
  begin
    case AResult of
      mrYES:
      begin
        with DM.QryAux do begin
          SQl.Clear;
          SQL.Add('update or insert into AGENDAMENTO_PRODUTOR (AGP_ID, AGP_PRO, AGP_DTE, AGP_HOE, AGP_EMP, AGP_VAR_UVA, AGP_DIA)'+#13+
                  'values (gen_id(GEN_AGENDAMENTO_PRODUTOR_ID,1), :AGP_PRO, :AGP_DTE, :AGP_HOE, :AGP_EMP, :AGP_VAR_UVA, :AGP_DIA)'+#13+
                  'matching(AGP_ID, AGP_PRO)');
          ParamByName('AGP_PRO').AsInteger      := DM.CodUsuario;
          ParamByName('AGP_DTE').AsInteger      := DTE_ID;
          ParamByName('AGP_HOE').AsInteger      := StrToInt(AItem.Objects.FindObjectT<TListItemText>('TxtID').Text);
          ParamByName('AGP_EMP').AsInteger      := DTE_EMP;
          ParamByName('AGP_VAR_UVA').AsInteger  := DTE_VAR_UVA;
          ParamByname('AGP_DIA').AsDateTime     := Calendar.Date;
          ExecSQL;
        end;
        CalendarChange(sender);
      end;
    end;
  end
  );
end;

end.
