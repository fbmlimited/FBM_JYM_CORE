page 60210 FBM_SiteLookup_JMCO
{
    Caption = 'Site Lookup';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = FBM_Site;


    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Site Code"; rec."Site Code")
                {
                    ApplicationArea = All;
                }
                field("Site Name"; Rec."Site Name")
                {
                    ApplicationArea = All;
                }

            }
        }

    }


}