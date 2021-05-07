object frmMain: TfrmMain
  Left = 300
  Top = 224
  Caption = 'FileRenamer - File rename tool'
  ClientHeight = 447
  ClientWidth = 748
  Color = clBtnFace
  Constraints.MinHeight = 485
  Constraints.MinWidth = 735
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object FolderPanel: TPanel
    Left = 0
    Top = 0
    Width = 748
    Height = 49
    Align = alTop
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 0
    ExplicitWidth = 720
    DesignSize = (
      748
      49)
    object FolderLabel: TLabel
      Left = 12
      Top = 8
      Width = 30
      Height = 13
      Caption = 'Folder'
    end
    object FolderEdit: TEdit
      Left = 12
      Top = 24
      Width = 705
      Height = 21
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 0
    end
    object FolderButton: TBitBtn
      Left = 719
      Top = 24
      Width = 21
      Height = 21
      Anchors = [akTop, akRight]
      Caption = '...'
      TabOrder = 1
      OnClick = SelectFolder
    end
  end
  object MainPanel: TPanel
    Left = 0
    Top = 49
    Width = 748
    Height = 365
    Align = alClient
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 1
    ExplicitWidth = 720
    ExplicitHeight = 346
    object TemplatePanel: TPanel
      Left = 0
      Top = 0
      Width = 748
      Height = 65
      Align = alTop
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 0
      ExplicitWidth = 720
      object CounterGroupBox: TGroupBox
        Left = 356
        Top = 0
        Width = 177
        Height = 65
        Caption = 'Counter [C]'
        TabOrder = 1
        object CounterStartLabel: TLabel
          Left = 8
          Top = 16
          Width = 37
          Height = 13
          Caption = 'Start at'
        end
        object CounterStepLabel: TLabel
          Left = 64
          Top = 16
          Width = 37
          Height = 13
          Caption = 'Step by'
        end
        object CounterDigitsLabel: TLabel
          Left = 120
          Top = 16
          Width = 26
          Height = 13
          Caption = 'Digits'
        end
        object CounterStartEdit: TSpinEdit
          Left = 8
          Top = 32
          Width = 49
          Height = 22
          EditorEnabled = False
          MaxValue = 1000000000
          MinValue = 0
          TabOrder = 0
          Value = 1
          OnChange = RefreshList
        end
        object CounterStepEdit: TSpinEdit
          Left = 64
          Top = 32
          Width = 49
          Height = 22
          EditorEnabled = False
          MaxValue = 100000000
          MinValue = 1
          TabOrder = 1
          Value = 1
          OnChange = RefreshList
        end
        object CounterDigitsComboBox: TComboBox
          Left = 120
          Top = 32
          Width = 49
          Height = 21
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 2
          Text = '1'
          OnChange = RefreshList
          Items.Strings = (
            '1'
            '2'
            '3'
            '4'
            '5'
            '6'
            '7'
            '8'
            '9'
            '10')
        end
      end
      object TemplateGroupBox: TGroupBox
        Left = 4
        Top = 0
        Width = 345
        Height = 65
        Caption = 'Templates'
        TabOrder = 0
        object NameTemplateLabel: TLabel
          Left = 8
          Top = 16
          Width = 87
          Height = 13
          Caption = 'Filename template'
        end
        object ExtTemplateLabel: TLabel
          Left = 176
          Top = 16
          Width = 92
          Height = 13
          Caption = 'Extension template'
        end
        object NameTemplateEdit: TEdit
          Left = 8
          Top = 32
          Width = 161
          Height = 21
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          Text = '[N]'
          OnChange = RefreshList
        end
        object ExtTemplateEdit: TEdit
          Left = 176
          Top = 32
          Width = 161
          Height = 21
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          Text = '[E]'
          OnChange = RefreshList
        end
      end
    end
    object FilesPanel: TPanel
      Left = 0
      Top = 65
      Width = 748
      Height = 300
      Align = alClient
      BevelOuter = bvNone
      BorderWidth = 4
      Caption = ' '
      TabOrder = 1
      ExplicitWidth = 720
      ExplicitHeight = 281
      object FilesListView: TListView
        Left = 4
        Top = 4
        Width = 740
        Height = 292
        Align = alClient
        Columns = <
          item
            Caption = 'Old name'
            Width = 250
          end
          item
            Caption = 'New name'
            Width = 250
          end
          item
            Caption = 'Full path'
            Width = 320
          end>
        RowSelect = True
        TabOrder = 0
        ViewStyle = vsReport
        ExplicitWidth = 712
        ExplicitHeight = 273
      end
    end
  end
  object ButtonsPanel: TPanel
    Left = 0
    Top = 414
    Width = 748
    Height = 33
    Align = alBottom
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 2
    ExplicitTop = 395
    ExplicitWidth = 720
    DesignSize = (
      748
      33)
    object GoButton: TBitBtn
      Left = 656
      Top = 4
      Width = 83
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Go!'
      TabOrder = 0
      OnClick = ProcessList
    end
  end
end
