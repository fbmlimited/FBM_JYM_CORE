page 60291 FBM_CustComp
{
    Caption = 'CustComp';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = Customer;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(mastname; mastname)
                {
                    ApplicationArea = All;
                }
                field(FBM_GrCode; Rec.FBM_GrCode)
                {
                    ApplicationArea = All;
                }
            }
        }

    }
    trigger
    OnAfterGetRecord()
    begin
        custmast.setrange("No.", rec.FBM_GrCode);
        mastname := '';
        if custmast.FindFirst() then begin
            mastname := custmast.Name;
            custmast.Modify(true);
        end;


    end;

    var
        custmast: record FBM_Customer;
        mastname: text[100];

}