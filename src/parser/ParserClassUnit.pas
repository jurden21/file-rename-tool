unit ParserClassUnit;

interface

uses
    System.SysUtils, ListClassUnit, ItemClassUnit, CounterRecordUnit;

type
    EParserException = class(Exception)
    end;

    TParserClass = class sealed
    private
        class function ParseTemplate(const ATemplate: String; const AItem: TItemClass; const ACounter: TCounterRecord; const AItemIndex: Integer): String;
        class function Parse(const ATemplate: String; const AItem: TItemClass; const ACounter: TCounterRecord; const AItemIndex: Integer): String;
    public
        class procedure ParseList(const AList: TListClass; const ATemplate: String; const ACounter: TCounterRecord);
    end;

implementation

{ TParserClass }

uses
    TemplateClassUnit;

class function TParserClass.ParseTemplate(const ATemplate: String; const AItem: TItemClass; const ACounter: TCounterRecord; const AItemIndex: Integer): String;
var
    Found: Boolean;
begin

    Result := '';
    Found := False;

    if TTemplateClass.IsNameTemplate(ATemplate)
    then begin
        Result := TTemplateClass.GetNameText(ATemplate, AItem);
        Found := True;
    end;

    if TTemplateClass.IsExtTemplate(ATemplate)
    then begin
        Result := TTemplateClass.GetExtText(ATemplate, AItem);
        Found := True;
    end;

    if TTemplateClass.IsCounterTemplate(ATemplate)
    then begin
        Result := TTemplateClass.GetCounterText(ACounter, AItemIndex);
        Found := True;
    end;

    if TTemplateClass.IsDateTimeTemplate(ATemplate)
    then begin
        Result := TTemplateClass.GetDateTimeText(ATemplate, AItem);
        Found := True;
    end;

    if not Found
    then
        raise EParserException.Create('Invalid Template');

end;

class function TParserClass.Parse(const ATemplate: String; const AItem: TItemClass; const ACounter: TCounterRecord; const AItemIndex: Integer): String;
var
    Index: Integer;
    Template: String;
begin

    try

        Index := 1;
        Result := '';

        while Index <= Length(ATemplate) do
        begin

            if ATemplate[Index] <> '['
            then
                Result := Result + ATemplate[Index];

            if ATemplate[Index] = ']'
            then
                raise EParserException.Create('Invalid Template');

            if ATemplate[Index] = '['
            then begin
                Template := ATemplate.Substring(Index);
                Template := Copy(Template, 1, Pos(']', Template) - 1);
                Result := Result + TParserClass.ParseTemplate(Template, AItem, ACounter, AItemIndex);
                Index := Index + Length(Template) + 1;
            end;

            Index := Index + 1;

        end;

    except
        on E: Exception do
             Result := E.Message;
    end;

end;

class procedure TParserClass.ParseList(const AList: TListClass; const ATemplate: String; const ACounter: TCounterRecord);
var
    Index: Integer;
begin
    for Index := 0 to AList.Count - 1 do
        AList.Items[Index].ResultName := Parse(ATemplate, AList.Items[Index], ACounter, Index);
end;

end.
