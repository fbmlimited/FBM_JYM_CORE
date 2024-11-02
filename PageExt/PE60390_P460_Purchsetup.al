pageextension 60390 FBM_PurchSetupExt_JMCO extends "Purchases & Payables Setup"
{
    layout
    {
        addlast(General)
        {

            field(FBM_Use_Pedimento; Rec.FBM_Use_Pedimento)
            {
                ApplicationArea = all;

            }

        }

    }
}