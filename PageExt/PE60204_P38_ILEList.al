pageextension 60204 FBM_ILEListext_JMCO extends "Item Ledger Entries"
{
    layout
    {
        addlast(Control1)
        {
            field(FBM_Pedimento; Rec.FBM_Pedimento)
            {
                ApplicationArea = all;

            }

        }

    }
}