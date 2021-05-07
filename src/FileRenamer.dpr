program FileRenamer;

uses
  Vcl.Forms,
  MainFormUnit in 'MainFormUnit.pas' {frmMain},
  RegistryServiceUnit in 'service\RegistryServiceUnit.pas',
  ItemClassUnit in 'parser\ItemClassUnit.pas',
  ListClassUnit in 'parser\ListClassUnit.pas',
  ParserClassUnit in 'parser\ParserClassUnit.pas',
  TemplateClassUnit in 'parser\TemplateClassUnit.pas',
  CounterRecordUnit in 'parser\CounterRecordUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
