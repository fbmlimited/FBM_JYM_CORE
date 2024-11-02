page 60265 FBM_CustSiteHist_JMCO
{
    Caption = 'CustSite History';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = FBM_CustomerSite_C;
    ModifyAllowed = false;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Version; Rec.Version)
                {
                    ApplicationArea = All;
                    Caption = 'Version';
                }
                field(ActiveRec; Rec.ActiveRec)
                {
                    ApplicationArea = All;
                    Caption = 'Active';
                }

                field(SiteGrCode; Rec.SiteGrCode)
                {
                    ApplicationArea = All;
                    Caption = 'Site Gr. Code';
                }
                field("Site Code"; rec."Site Code")
                {
                    ApplicationArea = All;
                    Caption = 'Site Code';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Caption = 'Status';

                }


                field(Contact; rec.Contact)
                {
                    ApplicationArea = all;
                }
                field("Contract Code"; rec."Contract Code")
                {
                    ApplicationArea = all;
                }

                field("Contract Code2"; rec."Contract Code2")
                {
                    ApplicationArea = all;
                    visible = EnableSpin;
                }
                field("Vat Number"; Rec."Vat Number")
                {
                    ApplicationArea = all;
                }
                field("Valid From"; Rec."Valid From")
                {
                    ApplicationArea = all;
                }
                field("Valid To"; Rec."Valid To")
                {
                    ApplicationArea = all;
                }
                field("Record Owner"; Rec."Record Owner")
                {
                    ApplicationArea = all;
                }
                field("Change Note"; Rec."Change Note")
                {
                    ApplicationArea = all;
                }

            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
    trigger
    OnOpenPage()
    begin
        rec.SetRange("Customer No.", pcust);
        rec.SetRange("Site Code", psite);
    end;

    trigger
     OnAfterGetRecord()
    begin
        compinfo.get;
        EnableSpin := compinfo.FBM_EnSpin;
    end;

    var
        enablespin: Boolean;
        compinfo: record "Company Information";
        pcust: code[20];
        psite: code[20];

    procedure passpar(cust: code[20]; site: code[20])
    begin
        pcust := cust;
        psite := site;
    end;
}