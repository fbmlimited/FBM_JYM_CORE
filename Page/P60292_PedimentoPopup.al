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
                    caption = 'Referencia JYM [3]';
                    trigger
                    OnValidate()
                    begin
                        cu.updateped(rec."Entry No.", ped12, ped1, ped2, ped3, ped34, ped4);
                        CurrPage.Update();
                    end;
                }
                field(Ped1; Ped1)
                {
                    ApplicationArea = All;
                    caption = 'Año Validaciòn [2]';
                    trigger
                   OnValidate()
                    begin
                        cu.updateped(rec."Entry No.", ped12, ped1, ped2, ped3, ped34, ped4);

                    end;
                }
                field(Ped2; Ped2)
                {
                    ApplicationArea = All;
                    caption = 'Aduana Despacho [2]';
                    trigger
                   OnValidate()
                    begin
                        cu.updateped(rec."Entry No.", ped12, ped1, ped2, ped3, ped34, ped4);

                    end;
                }
                field(Ped3; Ped3)
                {
                    ApplicationArea = All;
                    caption = 'Nro Patente [4]';
                    trigger
                   OnValidate()
                    begin
                        cu.updateped(rec."Entry No.", ped12, ped1, ped2, ped3, ped34, ped4);

                    end;
                }
                field(Ped34; Ped34)
                {
                    ApplicationArea = All;
                    caption = 'Ultimo digito año en curso [1]';
                    trigger
                   OnValidate()
                    begin
                        cu.updateped(rec."Entry No.", ped12, ped1, ped2, ped3, ped34, ped4);
                    end;
                }
                field(Ped4; Ped4)
                {
                    ApplicationArea = All;
                    caption = 'Nro Progr. de Despacho [6]';
                    trigger
                   OnValidate()
                    begin
                        cu.updateped(rec."Entry No.", ped12, ped1, ped2, ped3, ped34, ped4);
                    end;
                }
                field(FBM_Pedimento; copystr(Rec.FBM_Pedimento_2, 5))
                {
                    ApplicationArea = all;
                    Editable = false;

                    caption = 'Pedimento[15]';
                }
                field(FBM_Pedimento14; rec.FBM_Pedimento12 + ' ' + copystr(Rec.FBM_Pedimento_2, 11))
                {
                    ApplicationArea = all;
                    Editable = false;

                    caption = 'Pedimento[14]';
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
                field(FBM_Pedimento_2; Rec.FBM_Pedimento_2)
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
        if StrLen(rec.FBM_Pedimento_2) > 16 then begin
            ped12 := copystr(rec.FBM_Pedimento_2, 1, 3);
            ped1 := copystr(rec.FBM_Pedimento_2, 5, 2);
            ped2 := copystr(rec.FBM_Pedimento_2, 8, 2);
            ped3 := copystr(rec.FBM_Pedimento_2, 11, 4);
            ped34 := copystr(rec.FBM_Pedimento_2, 16, 1);
            ped4 := copystr(rec.FBM_Pedimento_2, 17, 6);
        end
        else begin
            ped12 := copystr(rec.FBM_Pedimento_2, 1, 3);
            ped1 := '';
            ped2 := '';
            ped3 := copystr(rec.FBM_Pedimento_2, 5, 4);
            ped34 := copystr(rec.FBM_Pedimento_2, 10, 1);
            ped4 := copystr(rec.FBM_Pedimento_2, 11, 6);
        end;



    end;

    var
        ped12: text[3];
        ped1: text[2];
        ped2: text[2];
        ped3: text[4];
        ped34: text[1];
        ped4: text[6];
        cu: codeunit FBM_Fixes_JMCO;
}