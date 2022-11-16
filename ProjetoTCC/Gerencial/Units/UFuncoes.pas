unit UFuncoes;

interface

uses Data.SQlExpr, System.Sysutils, VCL.Dialogs, FireDAC.Comp.Client;

function FormatChecked(checked:boolean):String;

function LocateSQL(TableName: String; DataSet: TFDQuery; const KeyFields: Array of Const; const KeyValues: Array of Variant; const SQLPadrao: string = ''; const WhereAdicional: string = '';
  const OrderByAdicional: string = '';const GroupByAdicional: string = ''): Boolean;

function PreparaSQLPadrao(SQLPadrao: String): String;

function isCNPJ(CNPJ: string): boolean;

function ClrDig(fField: String): String;

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

function isCNPJ(CNPJ: string): boolean;
var
  dig13, dig14: string;
  sm, i, r, peso: integer;
begin
  // length - retorna o tamanho da string do CNPJ (CNPJ é um número formado por 14 dígitos)
  if ((CNPJ = '00000000000000') or (CNPJ = '11111111111111') or
      (CNPJ = '22222222222222') or (CNPJ = '33333333333333') or
      (CNPJ = '44444444444444') or (CNPJ = '55555555555555') or
      (CNPJ = '66666666666666') or (CNPJ = '77777777777777') or
      (CNPJ = '88888888888888') or (CNPJ = '99999999999999') or
      (length(CNPJ) <> 14)) then
  begin
    isCNPJ := false;
    exit;
  end;

  // "try" - protege o código para eventuais erros de conversão de tipo através da função "StrToInt"
  try
    { *-- Cálculo do 1o. Digito Verificador --* }
    sm := 0;
    peso := 2;
    for i := 12 downto 1 do
    begin
      // StrToInt converte o i-ésimo caractere do CNPJ em um número
      sm := sm + (StrToInt(CNPJ[i]) * peso);
      peso := peso + 1;
      if (peso = 10) then
        peso := 2;
    end;
    r := sm mod 11;
    if ((r = 0) or (r = 1)) then
      dig13 := '0'
    else
      str((11 - r): 1, dig13); // converte um número no respectivo caractere numérico

    { *-- Cálculo do 2o. Digito Verificador --* }
    sm := 0;
    peso := 2;
    for i := 13 downto 1 do
    begin
      sm := sm + (StrToInt(CNPJ[i]) * peso);
      peso := peso + 1;
      if (peso = 10) then
        peso := 2;
    end;
    r := sm mod 11;
    if ((r = 0) or (r = 1)) then
      dig14 := '0'
    else
      str((11 - r): 1, dig14);

    { Verifica se os digitos calculados conferem com os digitos informados. }
    if ((dig13 = CNPJ[13]) and (dig14 = CNPJ[14])) then
      isCNPJ := true
    else
      isCNPJ := false;
  except
    isCNPJ := false
  end;
end;

function ClrDig(fField: String): String;
var
  I : Byte;
begin
  result := '';
  for I := 0 to Length(fField) do
    if fField [I] In ['1','2','3','4','5','6','7','8','9','0'] Then
      Result := Result + fField [I];
end;

end.
