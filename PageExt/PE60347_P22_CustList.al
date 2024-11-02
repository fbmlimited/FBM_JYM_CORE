



pageextension 60347 FBMCustomerListExt_JYMCO extends "Customer List"
{

    layout
    {
        addafter(Name)
        {
            field(FBM_GrCode; Rec.FBM_GrCode)
            {
                ApplicationArea = all;
            }

        }
        addafter("Phone No.")
        {
            field("Payment Bank Code_CO"; rec."FBM_Payment Bank Code")
            {
                ApplicationArea = all;
            }
            field("Payment Bank Code2"; rec."FBM_Payment Bank Code2")
            {
                ApplicationArea = all;
            }
        }
        addafter("Name")
        {
            field("No. 2_CO"; rec.FBM_GrCode)
            {
                ApplicationArea = all;
            }
            field("VAT Registration No."; rec."VAT Registration No.")
            {
                ApplicationArea = all;
            }
            field("Group Customer_CO"; rec.FBM_Group)
            {
                ApplicationArea = all;
            }
            field("SubGroup Customer_CO"; rec.FBM_SubGroup)
            {
                ApplicationArea = all;
            }
        }



    }
    actions
    {
        addlast(reporting)
        {
            group("Aged Account Monthly")
            {

                Caption = 'Aged Account Monthly';
                Image = "Report";
                action(AgedAccountMonthly)
                {
                    ApplicationArea = Advanced;
                    Caption = 'Aged Account Monthly';
                    Image = CustomerLedger;
                    RunObject = Page "FBM_Aged Acc by Months_JYM_CO";


                }
            }
        }
        addfirst(navigation)
        {
            group("Customer Sites_CO")
            {
                Image = Warehouse;
                caption = 'Sites';

                action(Sites)
                {
                    ApplicationArea = All;
                    Image = Warehouse;
                    Visible = ShowSites;
                    caption = 'Local Sites';

                    trigger OnAction()
                    begin
                        CustomerSiteP.passpar(rec."No.");
                        CustomerSiteP.RunModal();
                        clear(CustomerSiteP)
                    end;
                }
                action(SetActive)
                {
                    ApplicationArea = All;
                    Image = History;

                    caption = 'Set Active All';

                    trigger OnAction()
                    var

                        csite: record FBM_CustomerSite_C;
                    begin
                        csite.FindFirst();
                        repeat
                            csite.Rename(csite."Customer No.", csite."Site Code", csite.Version, true);
                            csite.Modify();
                        until csite.Next() = 0
                    end;
                }
            }
        }
    }
    var
        showsites: Boolean;
        companyinfo: record "Company Information";
        CustomerSiteP: Page FBM_CustomerSite_JMCO;
        CustomerSite: Record FBM_CustomerSite_C;

#if not JYM
    trigger
    OnOpenPage()
    var
        customer: record Customer;
        custlist2: page "FBM_Customer List_JYM_CO";

    begin
        if companyinfo.Get() then begin
            if companyinfo.FBM_CustIsOp then
                ShowSites := true
            else
                ShowSites := false;
        end;
        if GuiAllowed then begin
            customer.CopyFilters(rec);

            custlist2.SetTableView(customer);
            custlist2.Run();
            clear(custlist2);

        end;

    end;
#endif



}



