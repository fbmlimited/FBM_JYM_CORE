page 60290 FBM_PermOpAsm_JYM_CO
{
    Caption = 'PermOpAdm';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = FBM_CustomerSite_C;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; cust.Name)
                {
                    ApplicationArea = All;
                }
                field("Site Code"; Rec."Site Code")
                {
                    ApplicationArea = All;
                }
                field(SiteGrCode; Rec.SiteGrCode)
                {
                    ApplicationArea = All;
                }
                field("Site Name_FF"; Rec."Site Name_FF")
                {
                    ApplicationArea = All;
                }
                field(FBM_CustomerType; Rec.FBM_CustomerType)
                {
                    ApplicationArea = All;
                }
                field(FBM_Permisionario; Rec.FBM_Permisionario)
                {
                    ApplicationArea = All;
                }
                field(FBM_Operador; Rec.FBM_Operador)
                {
                    ApplicationArea = All;
                }
                field(FBM_Administrador; Rec.FBM_Administrador)
                {
                    ApplicationArea = All;
                }

            }
        }
        area(Factboxes)
        {

        }
    }
    trigger

    OnAfterGetRecord()
    begin

        cust.get(rec."Customer No.");
    end;

    var
        cust: record Customer;
}