page 60200 FBM_PartnerList_JYM_CO
{
    Caption = 'Partner';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = FBM_Partner_JYM_CO;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
            }
        }

    }


}