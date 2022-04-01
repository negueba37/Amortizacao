unit Model.Helpers.Edit;

interface
  uses
    Vcl.StdCtrls,
    System.SysUtils;
  type
  TModelHelpersEdit = class helper for TEdit
  private
    class function GetStrNumber(const S: string): string; static;
    class function RemoveCaracteres(aValue: string): string; static;
    public
    function ToCurrency:Currency;
    function ToInteger:Integer;
    procedure FormatCurrency;
  end;
implementation

{ TModelHelpersEdit }

procedure TModelHelpersEdit.FormatCurrency;
var
  LText,LValue,LValueFormat:string;
  I,LLengtnValue: Integer;
begin
  LText := Self.Text;
  if (LText = '') or (LText = '0,00') then
  begin
    Self.Text := '0,00';
    Exit;
  end;

  LText := GetStrNumber(RemoveCaracteres(LText));
  for I := 1 to Length(LText) do
  begin
    if LText[i]<>'0' then
    begin
      LValue := Copy(LText,i);
      Break;
    end;
  end;
  LLengtnValue := Length(LValue);
  if LLengtnValue <= 3 then
  begin
    if LLengtnValue = 1 then
      LValue := '0,0'+LValue
    else if LLengtnValue = 2 then
      LValue := '0,'+LValue
    else if LLengtnValue = 3 then
      LValue := Copy(LValue,1,1)+','+Copy(LValue,2);
  end
  else
  begin
    LValueFormat := LValue;
    LValueFormat := ','+Copy(LValue,LValue.Length-1);
    LValue := Copy(LValue,1,LValue.Length-2);
    if Length(LValue) <= 3 then
      LValue := LValue+LValueFormat
    else
    begin
      while Length(LValue) > 3 do
      begin
        LValueFormat := '.'+Copy(LValue,LValue.Length-2) +LValueFormat;
        LValue := Copy(LValue,1,Length(LValue)-3);
      end;
      LValue := LValue + LValueFormat;
    end;
  end;
  Self.Text := LValue;
  Self.SelStart := Length(Self.Text);  
end;

function TModelHelpersEdit.ToCurrency: Currency;
var
  LValue:string;
begin
  LValue := StringReplace(Self.Text,'.','',[rfReplaceAll]);
                 //.Replace(',','.',[rfReplaceAll]); 
  Result := StrToCurrDef(LValue,0);
end;

function TModelHelpersEdit.ToInteger: Integer;
begin
  Result := StrToIntDef(Self.Text,0);
end;

class function TModelHelpersEdit.GetStrNumber(const S: string): string;
var
  vText : PChar;
begin
  vText := PChar(S);
  Result := '';

  while (vText^ <> #0) do
  begin
    {$IFDEF UNICODE}
    if CharInSet(vText^, ['0'..'9']) then
    {$ELSE}
    if vText^ in ['0'..'9'] then
    {$ENDIF}
      Result := Result + vText^;

    Inc(vText);
  end;
end;
class function TModelHelpersEdit.RemoveCaracteres(aValue:string):string;
begin
  if Trim(aValue) = '' then
  begin
    Result := '';
    exit;
  end;
  aValue := aValue.Replace('.','',[rfReplaceAll])
        .Replace('-','',[rfReplaceAll])
        .Replace('/','',[rfReplaceAll])        
        .Replace(',','',[rfReplaceAll])        
        .Replace(';','',[rfReplaceAll]);                        
  Result := aValue;
end;

end.
