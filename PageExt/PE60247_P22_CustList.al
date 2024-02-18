



pageextension 60247 FBMCustomerListExt_JYMCO extends "Customer List"
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
    }
#if not JYM
    trigger
    OnOpenPage()
    var
        customer: record Customer;
        custlist2: page "FBM_Customer List_JYM_CO";

    begin
        if GuiAllowed then begin
            customer.CopyFilters(rec);

            custlist2.SetTableView(customer);
            custlist2.Run();
            Error('');

        end;

    end;
#endif



}



