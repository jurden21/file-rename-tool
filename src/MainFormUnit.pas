unit MainFormUnit;

interface

uses
    System.SysUtils, System.Classes, System.StrUtils, Winapi.Windows, Vcl.Forms, Vcl.Controls, Vcl.ComCtrls,
    Vcl.StdCtrls, Vcl.Samples.Spin, Vcl.Buttons, Vcl.Dialogs, Vcl.ExtCtrls,
    {$WARN UNIT_PLATFORM OFF}
    Vcl.FileCtrl,
    {$WARN UNIT_PLATFORM ON}
    ListClassUnit;

const
    REGISTRY_KEY = 'Software\Exx23\FileRenamer\';

type
    TfrmMain = class(TForm)
        FolderPanel: TPanel;
        FolderLabel: TLabel;
        FolderEdit: TEdit;
        FolderButton: TBitBtn;
        MainPanel: TPanel;
        TemplatePanel: TPanel;
        FilesPanel: TPanel;
        FilesListView: TListView;
        CounterGroupBox: TGroupBox;
        CounterStartLabel: TLabel;
        CounterStartEdit: TSpinEdit;
        CounterStepEdit: TSpinEdit;
        CounterStepLabel: TLabel;
        CounterDigitsLabel: TLabel;
        CounterDigitsComboBox: TComboBox;
        TemplateGroupBox: TGroupBox;
        NameTemplateLabel: TLabel;
        NameTemplateEdit: TEdit;
        ExtTemplateLabel: TLabel;
        ExtTemplateEdit: TEdit;
        ButtonsPanel: TPanel;
        GoButton: TBitBtn;
        procedure FormShow(Sender: TObject);
        procedure FormDestroy(Sender: TObject);
        procedure RefreshList(Sender: TObject);
        procedure SelectFolder(Sender: TObject);
        procedure ProcessList(Sender: TObject);
    private
        List: TListClass;
    public
    end;

var
    frmMain: TfrmMain;

implementation

uses
    RegistryServiceUnit, CounterRecordUnit, ParserClassUnit;

{$R *.dfm}

procedure TfrmMain.FormShow(Sender: TObject);
begin

    List := TListClass.Create;

    ReportMemoryLeaksOnShutdown := True;

    Height := TRegistryService.ReadInteger(REGISTRY_KEY, 'MainForm.Height', 500);
    Width := TRegistryService.ReadInteger(REGISTRY_KEY, 'MainForm.Width', 800);
    Top := TRegistryService.ReadInteger(REGISTRY_KEY, 'MainForm.Top', 300);
    Left := TRegistryService.ReadInteger(REGISTRY_KEY, 'MainForm.Left', 300);

    NameTemplateEdit.Text := TRegistryService.ReadString(REGISTRY_KEY, 'Name.Template', '[N]');
    ExtTemplateEdit.Text := TRegistryService.ReadString(REGISTRY_KEY, 'Extension.Template', '[E]');
    CounterStartEdit.Value := TRegistryService.ReadInteger(REGISTRY_KEY, 'Counter.Start', 1);
    CounterStepEdit.Value := TRegistryService.ReadInteger(REGISTRY_KEY, 'Counter.Step', 1);
    if TRegistryService.ReadInteger(REGISTRY_KEY, 'Counter.Digits', 1) < CounterDigitsComboBox.Items.Count
    then CounterDigitsComboBox.ItemIndex := TRegistryService.ReadInteger(REGISTRY_KEY, 'Counter.Digits', 1);

end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin

    TRegistryService.WriteString(REGISTRY_KEY, 'Name.Template', NameTemplateEdit.Text);
    TRegistryService.WriteString(REGISTRY_KEY, 'Extension.Template', ExtTemplateEdit.Text);
    TRegistryService.WriteInteger(REGISTRY_KEY, 'Counter.Start', CounterStartEdit.Value);
    TRegistryService.WriteInteger(REGISTRY_KEY, 'Counter.Step', CounterStepEdit.Value);
    TRegistryService.WriteInteger(REGISTRY_KEY, 'Counter.Digits', CounterDigitsComboBox.ItemIndex);
    TRegistryService.WriteInteger(REGISTRY_KEY, 'MainForm.Height', Height);
    TRegistryService.WriteInteger(REGISTRY_KEY, 'MainForm.Width', Width);
    TRegistryService.WriteInteger(REGISTRY_KEY, 'MainForm.Top', Top);
    TRegistryService.WriteInteger(REGISTRY_KEY, 'Mainform.Left', Left);

    List.Free;

end;

procedure TfrmMain.SelectFolder(Sender: TObject);
var
    Path: String;
begin

    Path := ExtractFilePath(ParamStr(0));

    if SelectDirectory('Select folder', '', Path)
    then begin
        FolderEdit.Text := Path;
        RefreshList(Sender);
    end;

end;

procedure TfrmMain.RefreshList(Sender: TObject);
var
    Item: TListItem;
    Index: Integer;
begin

    List.Load(FolderEdit.Text);

    TParserClass.ParseList(
        List,
        NameTemplateEdit.Text + IfThen(ExtTemplateEdit.Text <> '', '.' + ExtTemplateEdit.Text, ''),
        TCounterRecord.Create(CounterStartEdit.Value, CounterStepEdit.Value, CounterDigitsComboBox.ItemIndex + 1));

    FilesListView.Items.Clear;

    for Index := 0 to List.Count - 1 do
    begin
        Item := FilesListView.Items.Add;
        Item.Caption := List.Items[Index].FileName;
        Item.SubItems.Add(List.Items[Index].ResultName);
        Item.SubItems.Add(List.Items[Index].FullName);
    end;

end;

procedure TfrmMain.ProcessList(Sender: TObject);
var
    Index : Integer;
begin

    for Index := 0 to List.Count - 1 do
        RenameFile(List.Items[Index].FullName, List.Items[Index].FullResultName);

    RefreshList(Sender);

    ShowMessage('Complete!');

end;

end.
