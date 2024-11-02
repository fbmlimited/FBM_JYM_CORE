pageextension 60355 FBM_PurchInvSubExt_JMCO extends "Purch. Invoice Subform"
{
    layout
    {
        addafter("Location Code")
        {

            field(FBM_Pedimento1; Rec.FBM_Pedimento12)
            {
                ApplicationArea = all;
                Visible = isped;
            }

            field(FBM_Pedimento3; Rec.FBM_Pedimento3)
            {
                ApplicationArea = all;
                Visible = isped;
            }
            field(FBM_Pedimento4; Rec.FBM_Pedimento4)
            {
                ApplicationArea = all;
                Visible = isped;
            }
            field(FBM_Pedimento; Rec.FBM_Pedimento)
            {
                ApplicationArea = all;
                Visible = isped;
            }
        }
    }
    trigger
   OnOpenPage()
    begin
        purchsetup.get;
        isped := purchsetup.FBM_Use_Pedimento;

    end;

    var
        purchsetup: record "Purchases & Payables Setup";
        isped: Boolean;
}