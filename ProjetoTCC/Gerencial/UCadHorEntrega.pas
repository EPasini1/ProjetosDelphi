unit UCadHorEntrega;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.CheckLst, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.Buttons, Vcl.DBCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.DateUtils,
  Vcl.WinXPickers, System.TimeSpan;

type
  TFrmCadHorEntrega = class(TForm)
    PnlBotoes: TPanel;
    PnlDatas: TPanel;
    GBDiasDaSemana: TGroupBox;
    BtnOK: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    DBCBSeg: TDBCheckBox;
    QryDiaSemanaEntrega: TFDQuery;
    DBCBTer: TDBCheckBox;
    DBCBQua: TDBCheckBox;
    DBCBQui: TDBCheckBox;
    DBCBSex: TDBCheckBox;
    DBCBSab: TDBCheckBox;
    DBCBDom: TDBCheckBox;
    BitBtn1: TBitBtn;
    TPSegInicio: TTimePicker;
    TPTerInicio: TTimePicker;
    TPQuaInicio: TTimePicker;
    TPQuiInicio: TTimePicker;
    TPSexInicio: TTimePicker;
    TPSabInicio: TTimePicker;
    TPDomInicio: TTimePicker;
    DSDiaSemanaEntrega: TDataSource;
    TPSegFim: TTimePicker;
    TPTerFim: TTimePicker;
    TPQuaFim: TTimePicker;
    TPQuiFim: TTimePicker;
    TPSexFim: TTimePicker;
    TPSabFim: TTimePicker;
    TPDomFim: TTimePicker;
    QryHorarioEntregaEmpresa: TFDQuery;
    TPIntervalo: TTimePicker;
    QryDiaSemanaEntregaDSE_EMP: TIntegerField;
    QryDiaSemanaEntregaDSE_VAR_UVA: TIntegerField;
    QryDiaSemanaEntregaDSE_SEG: TStringField;
    QryDiaSemanaEntregaDSE_TER: TStringField;
    QryDiaSemanaEntregaDSE_QUA: TStringField;
    QryDiaSemanaEntregaDSE_QUI: TStringField;
    QryDiaSemanaEntregaDSE_SEX: TStringField;
    QryDiaSemanaEntregaDSE_SAB: TStringField;
    QryDiaSemanaEntregaDSE_DOM: TStringField;
    QryAux: TFDQuery;
    PnlCarrega: TPanel;
    ProgressBar1: TProgressBar;
    ProgressBar2: TProgressBar;
    procedure BtnOKClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure DBCBSegClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    DSE_EMP, DSE_VAR_UVA, DSE_ID : Integer;
    ContaSelecionado : Integer;
  end;

var
  FrmCadHorEntrega: TFrmCadHorEntrega;

implementation

uses
  UDM, UFuncoes;

{$R *.dfm}

procedure TFrmCadHorEntrega.BitBtn1Click(Sender: TObject);
begin
  if Application.MessageBox('Deseja copiar os horários da segunda para os outros dias da semana?',
    'Replicar Horários', MB_YESNO + MB_ICONQUESTION) = IDYES then
  begin
    TPTerInicio.Time  := TPSegInicio.Time;
    TPQuaInicio.Time  := TPSegInicio.Time;
    TPQuiInicio.Time  := TPSegInicio.Time;
    TPSexInicio.Time  := TPSegInicio.Time;
    TPSabInicio.Time  := TPSegInicio.Time;
    TPDomInicio.Time  := TPSegInicio.Time;

    TPTerFim.Time     := TPSegFim.Time;
    TPQuaFim.Time     := TPSegFim.Time;
    TPQuiFim.Time     := TPSegFim.Time;
    TPSexFim.Time     := TPSegFim.Time;
    TPSabFim.Time     := TPSegFim.Time;
    TPDomFim.Time     := TPSegFim.Time;
  end;
end;

procedure TFrmCadHorEntrega.BtnOKClick(Sender: TObject);
  procedure CadastraHorariosDeEntrega(EMP, DDS, DTE, VAR_UVA : integer; INI, FIM : TTime);
  var
    HoeIni,HoeFim : TTime;
    timeSpan: TTimeSpan;
  begin
    with QryAux do begin
      SQL.Clear;
      SQL.Add('INSERT INTO HORARIOS_ENTREGA (HOE_ID, HOE_EMP, HOE_DDS, HOE_DTE, HOE_VAR_UVA, HOE_INI, HOE_FIM)'+#13#10+
              'VALUES (gen_id(GEN_HORARIOS_ENTREGA_ID, 1), :HOE_EMP, :HOE_DDS, :HOE_DTE, :HOE_VAR_UVA, :HOE_INI, :HOE_FIM)');
      HoeIni := INI;
      ParamByName('HOE_EMP').AsInteger := EMP;
      ParamByName('HOE_DTE').AsInteger := DTE;
      ParamByName('HOE_VAR_UVA').AsInteger := VAR_UVA;
      ParamByName('HOE_DDS').AsInteger := DDS;
      timeSpan :=  TTimeSpan.Parse(FormatDateTime('HH:mm:ss', FIM - INI));

      ProgressBar2.Position := 0;
      ProgressBar2.Max := trunc(timeSpan.TotalMinutes / MinuteOfTheDay(TPIntervalo.Time));
      while not (HoeIni >= FIM) do
      begin
        ParamByName('HOE_INI').AsTime := HoeIni;
        ParamByName('HOE_FIM').AsTime := HoeIni + incMinute(TPIntervalo.Time, -1);
        HoeIni := HoeIni + TPIntervalo.Time;
        ExecSQL;
        ProgressBar2.Position := ProgressBar2.Position + 1;
        Application.ProcessMessages;
      end;
    end;
  end;

  procedure CadastraDiaDaSemana();
  var
    i:integer;
  begin
    with DM.QryAux do begin
      SQL.Clear;
      SQL.Add('update or insert into DIA_SEMANA_ENTREGA (DSE_EMP, DSE_VAR_UVA, DSE_SEG, DSE_TER, DSE_QUA, DSE_QUI, DSE_SEX, DSE_SAB, DSE_DOM)'+#13+
              'values (:DSE_EMP, :DSE_VAR_UVA, :DSE_SEG, :DSE_TER, :DSE_QUA, :DSE_QUI, :DSE_SEX, :DSE_SAB, :DSE_DOM)'+#13+
              'matching(DSE_EMP, DSE_VAR_UVA)');
      ParamByName('DSE_EMP').AsInteger      := DSE_EMP;
      ParamByName('DSE_VAR_UVA').AsInteger  := DSE_VAR_UVA;
      ParamByName('DSE_SEG').AsString       := FormatChecked(DBCBSeg.Checked);
      ParamByName('DSE_TER').AsString       := FormatChecked(DBCBTer.Checked);
      ParamByName('DSE_QUA').AsString       := FormatChecked(DBCBQua.Checked);
      ParamByName('DSE_QUI').AsString       := FormatChecked(DBCBQui.Checked);
      ParamByName('DSE_SEX').AsString       := FormatChecked(DBCBSex.Checked);
      ParamByName('DSE_SAB').AsString       := FormatChecked(DBCBSab.Checked);
      ParamByName('DSE_DOM').AsString       := FormatChecked(DBCBDom.Checked);
      ExecSQL;
    end;
  end;

  procedure CadastraHorariosDeEntregaEmpresa();
  var
    i : integer;
  begin
    with DM.QryAux do begin
      ProgressBar1.Position := 0;
      ProgressBar1.Max := ContaSelecionado;
      for I := 0 to ContaSelecionado -1 do
      begin
        SQL.Clear;
        SQL.Add('update or insert into HORARIOS_ENTREGA_EMPRESA (HEE_ID, HEE_EMP, HEE_DDS, HEE_DTE, HEE_VAR_UVA, HEE_INI, HEE_FIM, HEE_INT)'+#13+
                'values (gen_id(GEN_HORARIOS_ENTREGA_EMPRESA_ID, 1), :HEE_EMP, :HEE_DDS, :HEE_DTE, :HEE_VAR_UVA, :HEE_INI, :HEE_FIM, :HEE_INT)'+#13+
                'matching(HEE_EMP, HEE_DDS, HEE_DTE, HEE_VAR_UVA)');

        ParamByName('HEE_EMP').AsInteger          := DSE_EMP;
        ParamByName('HEE_VAR_UVA').AsInteger      := DSE_VAR_UVA;
        ParamByName('HEE_DTE').AsInteger          := DSE_ID;
        ParamByName('HEE_INT').AsDateTime         := TPIntervalo.Time;
        if i = 0 then
        begin
          ParamByName('HEE_DDS').AsInteger           := 1;
          ParamByName('HEE_INI').AsDateTime          := TPSegInicio.Time;
          ParamByName('HEE_FIM').AsDateTime          := TPSegFim.Time;
        end;
        if i = 1 then
        begin
          ParamByName('HEE_DDS').AsInteger           := 2;
          ParamByName('HEE_INI').AsDateTime          := TPTerInicio.Time;
          ParamByName('HEE_FIM').AsDateTime          := TPTerFim.Time;
        end;
        if i = 2 then
        begin
          ParamByName('HEE_DDS').AsInteger           := 3;
          ParamByName('HEE_INI').AsDateTime          := TPQuaInicio.Time;
          ParamByName('HEE_FIM').AsDateTime          := TPQuaFim.Time;
        end;
        if i = 3 then
        begin
          ParamByName('HEE_DDS').AsInteger           := 4;
          ParamByName('HEE_INI').AsDateTime          := TPQuiInicio.Time;
          ParamByName('HEE_FIM').AsDateTime          := TPQuiFim.Time;
        end;
        if i = 4 then
        begin
          ParamByName('HEE_DDS').AsInteger           := 5;
          ParamByName('HEE_INI').AsDateTime          := TPSexInicio.Time;
          ParamByName('HEE_FIM').AsDateTime          := TPSexFim.Time;
        end;
        if i = 5 then
        begin
          ParamByName('HEE_DDS').AsInteger           := 6;
          ParamByName('HEE_INI').AsDateTime          := TPSabInicio.Time;
          ParamByName('HEE_FIM').AsDateTime          := TPSabFim.Time;
        end;
        if i = 6 then
        begin
          ParamByName('HEE_DDS').AsInteger           := 7;
          ParamByName('HEE_INI').AsDateTime          := TPDomInicio.Time;
          ParamByName('HEE_FIM').AsDateTime          := TPDomFim.Time;
        end;
        ExecSQL;
        CadastraHorariosDeEntrega(DSE_EMP, i + 1, DSE_ID, DSE_VAR_UVA, ParamByName('HEE_INI').AsDateTime, ParamByName('HEE_FIM').AsDateTime );
        ProgressBar1.Position := ProgressBar1.Position + 1;
        Application.ProcessMessages;
      end;
    end;
  end;
begin
  Application.ProcessMessages;
  PnlCarrega.BringToFront;
  PnlCarrega.Visible := True;

  QryAux.SQl.Clear;
  QryAux.SQL.Add('DELETE FROM HORARIOS_ENTREGA WHERE HOE_EMP = :HOE_EMP and HOE_DTE = :HOE_DTE and HOE_VAR_UVA = :HOE_VAR_UVA');
  QryAux.ParamByName('HOE_EMP').AsInteger := DSE_EMP;
  QryAux.ParamByName('HOE_DTE').AsInteger := DSE_ID;
  QryAux.ParamByName('HOE_VAR_UVA').AsInteger := DSE_VAR_UVA;
  QryAux.ExecSQL;

  CadastraDiaDaSemana;
  CadastraHorariosDeEntregaEmpresa;
  close;
end;

procedure TFrmCadHorEntrega.DBCBSegClick(Sender: TObject);
begin
  if TCheckBox(Sender).Checked then
    ContaSelecionado := ContaSelecionado + 1
  else
    ContaSelecionado := ContaSelecionado - 1;
end;

procedure TFrmCadHorEntrega.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
  FrmCadHorEntrega := nil;
end;

procedure TFrmCadHorEntrega.FormCreate(Sender: TObject);
begin
  DBCBSeg.Checked := False;
  DBCBTer.Checked := False;
  DBCBQua.Checked := False;
  DBCBSab.Checked := False;
  DBCBSex.Checked := False;
  DBCBQui.Checked := False;
  DBCBDom.Checked := False;


  TPIntervalo.Time  := 0;
  TPSegInicio.Time  := 0;
  TPSegFim.Time     := 0;
  TPTerFim.Time     := 0;
  TPTerInicio.Time  := 0;
  TPQuaInicio.Time  := 0;
  TPQuaFim.Time     := 0;
  TPQuiFim.Time     := 0;
  TPQuiInicio.Time  := 0;
  TPSexInicio.Time  := 0;
  TPSexFim.Time     := 0;
  TPSabFim.Time     := 0;
  TPSabInicio.Time  := 0;
  TPDomInicio.Time  := 0;
  TPDomFim.Time     := 0;
end;

procedure TFrmCadHorEntrega.FormShow(Sender: TObject);
begin

  QryDiaSemanaEntrega.Close;
  QryDiaSemanaEntrega.ParamByName('DSE_EMP').AsInteger      := DSE_EMP;
  QryDiaSemanaEntrega.ParamByName('DSE_VAR_UVA').AsInteger  := DSE_VAR_UVA;
  QryDiaSemanaEntrega.Open;

  ContaSelecionado := 0;

  if DBCBSeg.Checked then
    ContaSelecionado := ContaSelecionado + 1;
  if DBCBTer.Checked then
    ContaSelecionado := ContaSelecionado + 1;
  if DBCBQua.Checked then
    ContaSelecionado := ContaSelecionado + 1;
  if DBCBQui.Checked then
    ContaSelecionado := ContaSelecionado + 1;
  if DBCBSex.Checked then
    ContaSelecionado := ContaSelecionado + 1;
  if DBCBSab.Checked then
    ContaSelecionado := ContaSelecionado + 1;
  if DBCBDom.Checked then
    ContaSelecionado := ContaSelecionado + 1;


  LocateSQL('DATA_ENTREGA', DM.QryPesGeral, ['DTE_EMP','DTE_VARIEDADE_UVA'], [DSE_EMP, DSE_VAR_UVA]);
  DSE_ID := DM.QryPesGeral.FieldByName('DTE_ID').AsInteger;

  if True then
  

  if LocateSQL('HORARIOS_ENTREGA_EMPRESA', DM.QryPesGeral, ['HEE_EMP','HEE_DTE','HEE_VAR_UVA'], [DSE_EMP, DSE_ID, DSE_VAR_UVA]) then
  begin
    while not DM.QryPesGeral.Eof do
    begin
      TPIntervalo.Time := TimeOf(DM.QryPesGeral.FieldByname('HEE_INT').AsDateTime);
      case DM.QryPesGeral.FieldByname('HEE_DDS').AsInteger of
        1 :
        begin
          TPSegInicio.Time  := TimeOf(DM.QryPesGeral.FieldByname('HEE_INI').AsDateTime);
          TPSegFim.Time     := TimeOf(DM.QryPesGeral.FieldByname('HEE_FIM').AsDateTime);
        end;
        2 :
        begin
          TPTerInicio.Time  := TimeOf(DM.QryPesGeral.FieldByname('HEE_INI').AsDateTime);
          TPTerFim.Time     := TimeOf(DM.QryPesGeral.FieldByname('HEE_FIM').AsDateTime);
        end;
        3 :
        begin
          TPQuaInicio.Time  := TimeOf(DM.QryPesGeral.FieldByname('HEE_INI').AsDateTime);
          TPQuaFim.Time     := TimeOf(DM.QryPesGeral.FieldByname('HEE_FIM').AsDateTime);
        end;
        4 :
        begin
          TPQuiInicio.Time  := TimeOf(DM.QryPesGeral.FieldByname('HEE_INI').AsDateTime);
          TPQuiFim.Time     := TimeOf(DM.QryPesGeral.FieldByname('HEE_FIM').AsDateTime);
        end;
        5 :
        begin
          TPSexInicio.Time  := TimeOf(DM.QryPesGeral.FieldByname('HEE_INI').AsDateTime);
          TPSexFim.Time     := TimeOf(DM.QryPesGeral.FieldByname('HEE_FIM').AsDateTime);
        end;
        6 :
        begin
          TPSabInicio.Time  := TimeOf(DM.QryPesGeral.FieldByname('HEE_INI').AsDateTime);
          TPSabFim.Time     := TimeOf(DM.QryPesGeral.FieldByname('HEE_FIM').AsDateTime);
        end;
        7 :
        begin
          TPDomInicio.Time  := TimeOf(DM.QryPesGeral.FieldByname('HEE_INI').AsDateTime);
          TPDomFim.Time     := TimeOf(DM.QryPesGeral.FieldByname('HEE_FIM').AsDateTime);
        end;
      end;
      DM.QryPesGeral.Next;
    end;

  end;



end;

end.
