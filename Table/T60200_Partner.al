table 60200 FBM_Partner_JYM_CO
{
    Caption = 'Partner';
    LookupPageId = FBM_PartnerList_JYM_CO;
    DrillDownPageId = FBM_PartnerList_JYM_CO;
    fields
    {
        field(1; Type; enum FBM_CustType_JYM_CO)
        {
            Caption = 'Tipo Partner';

        }
        field(2; Name; text[100])
        {
            Caption = 'Nombre partner';

        }

    }

    keys
    {
        key(PK; type, Name)
        {
            Clustered = true;
        }
    }

}