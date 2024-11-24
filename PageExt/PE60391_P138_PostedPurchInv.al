pageextension 60391 FBM_PostedPInvExt_JMCO extends "Posted Purchase Invoice"
{

    layout
    {
        addafter(General)
        {
            group(Pedimento)
            {
                visible = isped;
                field(FBM_Pedimento12; Rec.FBM_Pedimento12)
                {
                    ApplicationArea = all;
                }
                field(FBM_Pedimento1; Rec.FBM_Pedimento1)
                {
                    ApplicationArea = all;
                }
                field(FBM_Pedimento2; Rec.FBM_Pedimento2)
                {
                    ApplicationArea = all;
                }
                field(FBM_Pedimento3; Rec.FBM_Pedimento3)
                {
                    ApplicationArea = all;
                }
                field(FBM_Pedimento34; Rec.FBM_Pedimento34)
                {
                    ApplicationArea = all;
                }
                field(FBM_Pedimento4; Rec.FBM_Pedimento42)
                {
                    ApplicationArea = all;
                }
                field(FBM_Pedimento; copystr(Rec.FBM_Pedimento, 5))
                {
                    ApplicationArea = all;

                    caption = 'Pedimento[15]';
                }
                field(FBM_Pedimento14; rec.FBM_Pedimento12 + ' ' + copystr(Rec.FBM_Pedimento, 11))
                {
                    ApplicationArea = all;

                    caption = 'Pedimento[14]';
                }
            }
        }
    }
    trigger
    OnOpenPage()
    ;
    begin

        purchsetup.get;
        isped := purchsetup.FBM_Use_Pedimento;
    end;

    var
        purchsetup: record "Purchases & Payables Setup";
        isped: Boolean;
}