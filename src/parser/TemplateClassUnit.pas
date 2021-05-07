unit TemplateClassUnit;

interface

uses
    System.SysUtils, ItemClassUnit, CounterRecordUnit;

type
    TTemplateClass = class sealed
    private
        const MAX_LENGTH = 1000;
    private
        class function IsRangeTemplate(const AText: String; var AFirst, ALast: Integer): Boolean;
    public
        class function IsDateTimeTemplate(const AText: String): Boolean;
        class function GetDateTimeText(const AText: String; const AItem: TItemClass): String;
        class function IsNameTemplate(const AText: String): Boolean;
        class function GetNameText(const AText: String; const AItem: TItemClass): String;
        class function IsExtTemplate(const AText: String): Boolean;
        class function GetExtText(const AText: String; const AItem: TItemClass): String;
        class function IsCounterTemplate(const AText: String): Boolean;
        class function GetCounterText(const ACounter: TCounterRecord; const AItemIndex: Integer): String;
    end;

implementation

{ TTemplateClass }

class function TTemplateClass.IsDateTimeTemplate(const AText: String): Boolean;
var
    Ch: Char;
begin

    Result := AText.Length > 0;

    for Ch in AText do
        Result := Result and CharInSet(Ch, ['Y', 'M', 'D', 'H', 'I', 'S', 'Z', 'y', 'm', 'd', 'h', 'i', 's', 'z']);

end;

class function TTemplateClass.GetDateTimeText(const AText: String; const AItem: TItemClass): String;
var
    Ch: Char;
    Year, Month, Day, Hour, Min, Sec, MSec: Word;
begin

    Result := '';

    DecodeDate(Now, Year, Month, Day);
    DecodeTime(Now, Hour, Min, Sec, MSec);

    for Ch in AText do
        case Ch of
            'Y': Result := Result + FormatFloat('0000', Year);
            'M': Result := Result + FormatFloat('00', Month);
            'D': Result := Result + FormatFloat('00', Day);
            'H': Result := Result + FormatFloat('00', Hour);
            'I': Result := Result + FormatFloat('00', Min);
            'S': Result := Result + FormatFloat('00', Sec);
            'Z': Result := Result + FormatFloat('000', MSec);
            'y': Result := Result + FormatFloat('0000', AItem.ModifiedYear);
            'm': Result := Result + FormatFloat('00', AItem.ModifiedMonth);
            'd': Result := Result + FormatFloat('00', AItem.ModifiedDay);
            'h': Result := Result + FormatFloat('00', AItem.ModifiedHour);
            'i': Result := Result + FormatFloat('00', AItem.ModifiedMin);
            's': Result := Result + FormatFloat('00', AItem.ModifiedSec);
            'z': Result := Result + FormatFloat('000', AItem.ModifiedMSec);
        end;

end;

class function TTemplateClass.IsRangeTemplate(const AText: String; var AFirst, ALast: Integer): Boolean;
var
    PosIndex: Integer;
begin

    PosIndex := Pos('-', AText);

    if AText = ''
    then begin
        Result := True;
        AFirst := 1;
        ALast := MAX_LENGTH;
    end

    else if PosIndex = 0
    then begin
        Result := Integer.TryParse(AText, AFirst);
        ALast := AFirst;
    end

    else if PosIndex = 1
    then begin
        Result := Integer.TryParse(Copy(AText, 2, Length(AText) - 1), ALast);
        AFirst := 1;
    end

    else if  PosIndex = Length(AText)
    then begin
        Result := Integer.TryParse(Copy(AText, 1, Length(AText) - 1), AFirst);
        ALast := MAX_LENGTH;
    end

    else
        Result := Integer.TryParse(Copy(AText, 1, PosIndex - 1), AFirst) and
                  Integer.TryParse(Copy(AText, PosIndex + 1, Length(AText)), ALast);

end;

class function TTemplateClass.IsNameTemplate(const AText: String): Boolean;
var
    First, Last: Integer;
begin
    Result := (AText.Length > 0) and (AText[1] = 'N') and IsRangeTemplate(AText.Substring(1), First, Last);
end;

class function TTemplateClass.GetNameText(const AText: String; const AItem: TItemClass): String;
var
    First, Last: Integer;
begin

    Result := '';

    if IsRangeTemplate(AText.Substring(1), First, Last)
    then
        Result := Copy(AItem.Name, First, Last - First + 1);

end;

class function TTemplateClass.IsExtTemplate(const AText: String): Boolean;
var
    First, Last: Integer;
begin
    Result := (AText.Length > 0) and (AText[1] = 'E') and IsRangeTemplate(AText.Substring(1), First, Last);
end;

class function TTemplateClass.GetExtText(const AText: String; const AItem: TItemClass): String;
var
    First, Last: Integer;
begin

    Result := '';

    if IsRangeTemplate(AText.Substring(1), First, Last)
    then
        Result := Copy(AItem.Ext, First, Last - First + 1);

end;

class function TTemplateClass.IsCounterTemplate(const AText: String): Boolean;
begin
    Result := AText = 'C';
end;

class function TTemplateClass.GetCounterText(const ACounter: TCounterRecord; const AItemIndex: Integer): String;
begin
    Result := FormatFloat(StringOfChar('0', ACounter.Digits), ACounter.Start + AItemIndex * ACounter.Step);
end;

end.
