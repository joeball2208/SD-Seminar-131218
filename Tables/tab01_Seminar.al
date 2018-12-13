table 50101 "CSD Seminar"
// CSD1.00 - 2018-01-01 - D. E. Veloper
// Chapter 5 - Lab 2-2
{
    DataClassification = ToBeClassified;
    Caption = 'Seminar';

    fields
    {
        field(10; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'No.';

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SeminarSetup.get;
                    NoSeriesMgt.TestManual(SeminarSetup."Seminar Nos.");
                    "No. Series" := '';
                end;
            end;
        }

        field(20; "Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Name';

            trigger OnValidate()
            begin
                if ("Search Name" = UpperCase(xrec."Search Name")) or
                ("Search Name" = '')
                then
                    "Search Name" := Name;
            end;
        }

        field(30; "Seminar Duration"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Seminar Duration';
            DecimalPlaces = 0 : 1;
        }

        field(40; "Minimum Participants"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Minimum Participants';
        }

        field(50; "Maximum Participants"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Maximum Participants';
        }

        field(60; "Search Name"; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Search Name';
        }

        field(70; "Blocked"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Blocked';
        }

        field(80; "Last Date Modified"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Last Date Modified';
            Editable = false;
        }

        field(90; "Comment"; Boolean)
        {
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
            //CalcFormula=exist("CSD Seminar Comment Line" where("Table
            // Name"= const("Seminar"),"No."=Field("No.")));                       
        }

        field(100; "Seminar Price"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Seminar Price';
            AutoFormatType = 1;
        }

        field(110; "Gen. Prod. Posting Group"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";

            trigger OnValidate()
            begin
                if (xrec."Gen. Prod. Posting Group" <> "Gen. Prod. Posting Group") then begin
                    if GenProdPostingsGroup.ValidateVatProdPostingGroup(GenProdPostingsGroup, "Gen. Prod. Posting Group") then
                        Validate("VAT Prod. Posting Group", GenProdPostingsGroup."Def. VAT Prod. Posting Group");
                end;
            end;
        }

        field(120; "VAT Prod. Posting Group"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
        }

        field(130; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'No. Series';
            TableRelation = "No. Series";
            Editable = false;
        }

    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }

        key(Key1; "Search Name")
        {

        }
    }

    var
        SeminarSetup: Record "CSD Seminar Setup";
        //CommentLine : record "CSD Seminar Comment Line";
        Seminar: Record "CSD Seminar";
        GenProdPostingsGroup: Record "Gen. Product Posting Group";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            SeminarSetup.get;
            SeminarSetup.TestField("Seminar Nos.");
            NoSeriesMgt.InitSeries(SeminarSetup."Seminar Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
    end;

    trigger OnModify()
    begin
        "Last Date Modified" := Today();
    end;

    trigger OnRename()
    begin
        "Last Date Modified" := Today();
    end;

    trigger OnDelete()
    begin
        //CommentLine.Reset;
        //CommentLine.SetRange("Table Name",
        //CommentLine."Table Name"::Seminar);
        //CommentLine.SetRange("No.","No.");
        // CommentLine.DeleteAll;
    end;

    procedure AssistEdit(): Boolean
    begin
        with Seminar do begin
            Seminar := rec;
            SeminarSetup.get;
            SeminarSetup.TestField("Seminar Nos.");
            if NoSeriesMgt.SelectSeries(SeminarSetup."Seminar Nos.", xrec."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("No.");
                Rec := Seminar;
                exit(true);
            end;
        end;
    end;
}