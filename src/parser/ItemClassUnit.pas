unit ItemClassUnit;

interface

uses
    System.SysUtils, System.IOUtils;

type
    TItemClass = class sealed
    private
        FFullName: String;
        FFileName: String;
        FName: String;
        FExt: String;
        FModified: TDateTime;
        FModifiedYear: Word;
        FModifiedMonth: Word;
        FModifiedDay: Word;
        FModifiedHour: Word;
        FModifiedMin: Word;
        FModifiedSec: Word;
        FModifiedMSec: Word;
        FResultName: String;
    public
        property FullName: String read FFullName;
        property FileName: String read FFileName;
        property Name: String read FName;
        property Ext: String read FExt;
        property Modified: TDateTime read FModified;
        property ModifiedYear: Word read FModifiedYear;
        property ModifiedMonth: Word read FModifiedMonth;
        property ModifiedDay: Word read FModifiedDay;
        property ModifiedHour: Word read FModifiedHour;
        property ModifiedMin: Word read FModifiedMin;
        property ModifiedSec: Word read FModifiedSec;
        property ModifiedMSec: Word read FModifiedMSec;
        property ResultName: String read FResultName write FResultName;
        constructor Create(const AFullName: String);
        function FullResultName: String;
    end;

implementation

{ TItemClass }

constructor TItemClass.Create(const AFullName: String);
begin
    FFullName := AFullName;
    FFileName := ExtractFileName(AFullName);
    FExt := ExtractFileExt(AFullName);
    FName := Copy(FFileName, 1, Length(FFileName) - Length(FExt));
    FExt := FExt.Substring(1);
    FModified := TFile.GetLastWriteTime(AFullName);
    DecodeDate(FModified, FModifiedYear, FModifiedMonth, FModifiedDay);
    DecodeTime(FModified, FModifiedHour, FModifiedMin, FModifiedSec, FModifiedMSec);
    FResultName := FFileName;
end;

function TItemClass.FullResultName: String;
begin
    Result := IncludeTrailingPathDelimiter(ExtractFilePath(FullName)) + ResultName;
end;

end.
