pageextension 60304 FBM_ILEListext_JMCO extends "Item Ledger Entries"
{
    layout
    {
        addlast(Control1)
        {
            field(FBM_Pedimento; copystr(Rec.FBM_Pedimento_2, 5))
            {
                ApplicationArea = all;

                caption = 'Pedimento[15]';
            }
            field(FBM_Pedimento14; rec.FBM_Pedimento12 + ' ' + copystr(Rec.FBM_Pedimento_2, 11))
            {
                ApplicationArea = all;

                caption = 'Pedimento[14]';
            }

        }

    }
    actions
    {
        addlast(processing)
        {
            action(Pedimento)
            {
                Visible = isped;
                ApplicationArea = all;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                image = DataEntry;
                trigger
                OnAction()
                var
                    popup: page FBM_PedimentoPopup_JMCO;
                    ile: record "Item Ledger Entry";
                begin
                    ile.get(rec."Entry No.");
                    popup.SetRecord(ile);

                    popup.RunModal();
                end;

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