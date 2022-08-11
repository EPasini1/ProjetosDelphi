unit UFuncoes;

interface

uses Data.SQlExpr, System.Sysutils, VCL.Dialogs, FireDAC.Comp.Client;

function FormatChecked(checked:boolean):String;

function LocateSQL(TableName: String; DataSet: TFDQuery; const KeyFields: Array of Const; const KeyValues: Array of Variant; const SQLPadrao: string = ''; const WhereAdicional: string = '';
  const OrderByAdicional: string = '';const GroupByAdicional: string = ''): Boolean;

function PreparaSQLPadrao(SQLPadrao: String): String;

implementation

function FormatChecked(checked:boolean):String;
begin
  if checked then
    Result := 'T'
  else
    Result := 'F';
end;

function LocateSQL(TableName: String; DataSet: TFDQuery; const KeyFields: Array of Const; const KeyValues: Array of Variant; const SQLPadrao: string = ''; const WhereAdicional: string = '';
  const OrderByAdicional: string = '';const GroupByAdicional: string = ''): Boolean;
var
  i: Integer;
  aWhere: String;
  mKeyFields: String;
begin
  try
    with DataSet do
    begin
      // monta cláusula where.
      for i := 0 to High(KeyFields) do
      begin
         case KeyFields[i].VType of
            0  : mKeyFields := String(shortString(KeyFields[i].VString^));
            9  : mKeyFields := Char(KeyFields[i].VString);
            17 : mKeyFields := String(KeyFields[i].VString);
         end;

         if TVarData(KeyValues[i]).VType = varDate then
            aWhere := aWhere + mKeyFields + ' = ' + QuotedStr(FormatDateTime('mm/dd/yyyy',KeyValues[i])) + ' '
         else
            if TVarData(KeyValues[i]).VType = varInteger then
               aWhere := aWhere + mKeyFields + ' = ' + IntToStr(KeyValues[i]) + ' '
            else
               if TVarData(KeyValues[i]).VType = varCurrency then
                  aWhere := aWhere + mKeyFields + ' = ' + StringReplace(CurrToStr(KeyValues[i]),',','.',[]) + ' '
               else
                  if UpperCase(KeyValues[i]) = '' then
                     aWhere := aWhere + mKeyFields + ' is Null '
                  else
                    aWhere := aWhere + mKeyFields + ' = ' + QuotedStr(UpperCase(KeyValues[i])) + ' ';

         if i < High(KeyFields) then
            aWhere := aWhere + ' AND ';
      end;

      if WhereAdicional <> '' then
      begin
         if aWhere = '' then
            aWhere := WhereAdicional
         else
            aWhere := aWhere + ' AND ' + WhereAdicional;
      end;

      // monta Select.
      Close;
      if SQLPadrao<>'' then
         SQL.Text := Format('%s where %s ', [PreparaSQLPadrao(SQLPadrao), aWhere])
      else
         SQL.Text := Format('Select * From %s where %s', [TableName, aWhere]);

      if GroupByAdicional <> '' then
         SQL.Text := SQL.Text + Format(' group by %s', [GroupByAdicional]);

      if OrderByAdicional <> '' then
         SQL.Text := SQL.Text + Format(' order by %s', [OrderByAdicional]);

      Open;
      Result := not IsEmpty;
    end;
  except on E: Exception do
    begin
      ShowMessage('Erro no LocateSQL: '+E.Message);
      Result := False;
    end;
  end;
end;

function PreparaSQLPadrao(SQLPadrao: String): String;
var
  i: Integer;
begin
  Result := SQLPadrao;
  i := Pos('WHERE', UpperCase(SQLPadrao));
  if i > 0 then
    Delete(Result, i, Length(SQLPadrao)-i+1);
end;

end.
