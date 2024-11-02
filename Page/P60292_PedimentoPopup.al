page 60292 FBM_PedimentoPopup_JMCO
{
    Caption = 'Pedimento';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Item Ledger Entry";
    Editable = true;
    ModifyAllowed = true;

    layout
    {
        area(Content)
        {
            group(Ped)
            {
                caption = 'Pedimento';
                field(Ped12; Ped12)
                {
                    ApplicationArea = All;
                    caption = 'Ped Alpha [3]';
                    trigger
                    OnValidate()
                    begin
                        cu.updateped(rec."Entry No.", ped12, ped1, ped2, ped3, ped4);
                        CurrPage.Update();
                    end;
                }
                field(Ped1; Ped1)
                {
                    ApplicationArea = All;
                    caption = 'Ped 1 [2]';
                    trigger
                   OnValidate()
                    begin
                        cu.updateped(rec."Entry No.", ped12, ped1, ped2, ped3, ped4);

                    end;
                }
                field(Ped2; Ped2)
                {
                    ApplicationArea = All;
                    caption = 'Ped 2 [2]';
                    trigger
                   OnValidate()
                    begin
                        cu.updateped(rec."Entry No.", ped12, ped1, ped2, ped3, ped4);

                    end;
                }
                field(Ped3; Ped3)
                {
                    ApplicationArea = All;
                    caption = 'Ped 3 [4]';
                    trigger
                   OnValidate()
                    begin
                        cu.updateped(rec."Entry No.", ped12, ped1, ped2, ped3, ped4);

                    end;
                }
                field(Ped4; Ped4)
                {
                    ApplicationArea = All;
                    caption = 'Ped 4 [7]';
                    trigger
                   OnValidate()
                    begin
                        cu.updateped(rec."Entry No.", ped12, ped1, ped2, ped3, ped4);
                    end;
                }
                field(FBM_Pedimento; Rec.FBM_Pedimento)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    trigger
    OnAfterGetRecord()
    begin
        ped12 := copystr(rec.FBM_Pedimento, 1, 3);
        ped1 := copystr(rec.FBM_Pedimento, 5, 2);
        ped2 := copystr(rec.FBM_Pedimento, 8, 2);
        ped3 := copystr(rec.FBM_Pedimento, 11, 4);
        ped4 := copystr(rec.FBM_Pedimento, 17, 7);




    end;

    var
        ped12: text[3];
        ped1: text[2];
        ped2: text[2];
        ped3: text[4];
        ped4: text[7];
        cu: codeunit FBM_Fixes_JMCO;
}