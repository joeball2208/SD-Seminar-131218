pageextension 50100 "CSD ResourceCardExt" extends "Resource Card"
// CSD1.00 - 2018-02-01 - D. E. Veloper
// Chapter 5 - Lab 1-2
// Added new fields:
// - Internal/External
// - Maximum Participants
// Added new FastTab
// Added code to OnOpenPage trigger
{
    layout
    {
        addlast(General)
        {
            field("CSD Resource Type"; "CSD Resource Type")
            {

            }
            field("CSD Quantity Per Day"; "CSD Quantity Per Day")
            {

            }
        }
        addafter("Personal Data")
        {
            group("CSD Room")
            {
                Caption = 'Room';
                Visible = showmaxfield;
                field("CSD Maximum Participants"; "CSD Maximum Participants")
                {

                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        ShowMaxField := (Type = type::Machine);
        CurrPage.Update(false);
    end;

    var

        [InDataSet]
        ShowMaxField: Boolean;

}