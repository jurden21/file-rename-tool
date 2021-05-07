unit ListClassUnit;

interface

uses
    System.Classes, System.SysUtils, System.Generics.Collections, System.Generics.Defaults, ItemClassUnit;

type
    TListClass = class sealed
    private
        FItems: TObjectList<TItemClass>;
    public
        property Items: TObjectList<TItemClass> read FItems;
        constructor Create;
        destructor Destroy; override;
        function Count: Integer;
        procedure Load(const APath: String);
    end;

implementation

{ TListClass }

constructor TListClass.Create;
begin
    FItems := TObjectList<TItemClass>.Create;
end;

destructor TListClass.Destroy;
begin
    FItems.Free;
    inherited;
end;

function TListClass.Count: Integer;
begin
    Result := Items.Count;
end;

procedure TListClass.Load(const APath: String);
var
    SearchRec: TSearchRec;
begin

    Items.Clear;

    if APath <> ''
    then begin

        if FindFirst(IncludeTrailingPathDelimiter(APath) + '*.*', faAnyFile, SearchRec) = 0
        then begin

            repeat

                if (SearchRec.Name <> '.') and (SearchRec.Name <> '..') and ((SearchRec.Attr and faDirectory) = 0)
                then
                    FItems.Add(TItemClass.Create(IncludeTrailingPathDelimiter(APath) + SearchRec.Name));

            until FindNext(SearchRec) <> 0;

            FindClose(SearchRec);

        end;

        Items.Sort(
            TComparer<TItemClass>.Construct(
                function(const Left, Right: TItemClass): Integer
                begin
                    Result := String.Compare(Left.FileName, Right.FileName);
                end));

    end;

end;

end.
