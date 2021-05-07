unit CounterRecordUnit;

interface

type
    TCounterRecord = record
        Start: Integer;
        Step: Integer;
        Digits: Integer;
        constructor Create(const AStart, AStep, ADigits: Integer);
    end;

implementation

{ TCounterRecord }

constructor TCounterRecord.Create(const AStart, AStep, ADigits: Integer);
begin
    Start := AStart;
    Step := AStep;
    Digits := ADigits;
end;

end.
