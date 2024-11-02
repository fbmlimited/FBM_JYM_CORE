pageextension 60300 FBM_CustCardExt_JYM_CO extends "Customer Card"
{
    layout
    {
        addlast(General)
        {
            group(Clasificación)
            {


                field(FBM_CustomerType; Rec.FBM_CustomerType)
                {
                    ApplicationArea = all;






                }




            }
        }
    }
    actions
    {
        addlast(navigation)
        {
            group("Customer Sites_CO")
            {
                Image = Warehouse;
                caption = 'Sites';


                // action(Sites)
                // {
                //     ApplicationArea = All;
                //     Image = Warehouse;
                //     Visible = ShowSites;
                //     caption = 'Local Sites';

                //     trigger OnAction()
                //     begin
                //         Clear(CustomerSite);
                //         Clear(CustomerSiteP);
                //         CustomerSite.SetFilter("Customer No.", Rec."No.");
                //         CustomerSite.SetRange(ActiveRec, true);
                //         CustomerSiteP.SetTableView(CustomerSite);
                //         Commit();
                //         CustomerSiteP.RunModal();
                //     end;
                // }
            }
        }

    }



    var




        CustomerSiteP: Page FBM_CustomerSite_JMCO;
        CustomerSite: Record FBM_CustomerSite_C;


        companyinfo: Record "Company Information";
        ShowSites: boolean;
        issup: boolean;
        hascode: Boolean;

    trigger OnOpenPage()
    var
        uper: Codeunit "User Permissions";
    begin
        if companyinfo.Get() then begin
            if companyinfo.FBM_CustIsOp then
                ShowSites := true
            else
                ShowSites := false;

        end;
        issup := uper.IsSuper(UserSecurityId())

    end;
}