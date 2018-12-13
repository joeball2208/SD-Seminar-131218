pageextension 50101 "CSD ResourceListExt" extends "Resource List"
// CSD1.00 - 2018-01-01 - D. E. Veloper
// Chapter 5 - Lab 1-3
// Changed property on the Type field
// Added new fields:
// - Internal/External
// - Maximum Participants
// Added code to OnOpenPage trigger
{
    layout
    {
        modify(Type)
        {
            Visible = ShowType;
        }

        addafter(Type)
        {
            field("CSD Resource Type"; "CSD Resource Type")
            {
                Visible = ShowMaxField;
            }
        }
    }

    trigger OnOpenPage()
    begin
        ShowType := (GetFilter(Type) = '');
        ShowMaxField := (GetFilter(Type) = format(type::Machine));
    end;


    var
        [InDataSet]
        ShowMaxField: Boolean;
        [InDataSet]
        ShowType: Boolean;
}