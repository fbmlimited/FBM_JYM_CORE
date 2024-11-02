page 60246 "FBM_Customer List_JYM_CO"
{
    ApplicationArea = Basic, Suite, Service;
    Caption = 'Customers';
    CardPageID = "Customer Card";
    InsertAllowed = false;
    PageType = List;
    QueryCategory = 'Customer List';
    SourceTable = Customer;
    UsageCategory = Lists;

    AboutTitle = 'About customers';
    AboutText = 'Here you overview all registered customers, their balances, and the sales statistics. With [Customer Templates](?page=1381 "Opens the Customer Templates") you can quickly create new customers having common details defined by the template.';

    layout
    {
        area(content)
        {
            group(Selection)
            {

                field(selcust; selcust)
                {
                    caption = 'Select New Customer';

                    ApplicationArea = all;
                    trigger
                    OnLookup(var Text: Text): Boolean
                    var
                        compinfo: record "Company Information";
                        customer: record Customer;
                        newno: code[20];

                    begin
                        clear(cust);
                        compinfo.get;
                        cust.SetRange(FBM_Company1, compinfo."Custom System Indicator Text");
                        if cust.findfirst then
                            repeat
                                customer.setrange("FBM_GrCode", cust."No.");
                                if customer.IsEmpty then
                                    cust.Mark(true)
                                else
                                    cust.mark(false);
                            until cust.Next() = 0;
                        cust.setrange(FBM_Company1);
                        cust.SetRange(FBM_Company2, compinfo."Custom System Indicator Text");
                        if cust.findfirst then
                            repeat
                                customer.setrange("FBM_GrCode", cust."No.");
                                if customer.IsEmpty then
                                    cust.Mark(true)
                                else
                                    cust.mark(false);
                            until cust.Next() = 0;
                        cust.SetRange(FBM_Company2);
                        cust.SetRange(FBM_Company3, compinfo."Custom System Indicator Text");
                        if cust.findfirst then
                            repeat
                                customer.setrange("FBM_GrCode", cust."No.");
                                if customer.IsEmpty then
                                    cust.Mark(true)
                                else
                                    cust.mark(false);
                            until cust.Next() = 0;
                        cust.setrange(FBM_Company1);
                        cust.SetRange(FBM_Company2);
                        cust.SetRange(FBM_Company3);
                        cust.MarkedOnly(true);

                        if page.RunModal(page::FBM_CustLookup_JYM_CO, cust) = action::LookupOK then begin
                            selcust := cust."No.";
                            CUSTOMER."No." := customer.CreateNewCustomer(cust.name, FALSE);
                            newno := customer."No.";
                            customer.FBM_GrCode := cust."No.";
                            customer.name := cust.Name;
                            customer."Name 2" := cust."Name 2";
                            customer.Address := cust.Address;
                            customer."Address 2" := cust."Address 2";
                            customer.City := cust.City;
                            customer."Post Code" := cust."Post Code";
                            customer.County := cust.County;
                            customer."Country/Region Code" := cust."Country/Region Code";
                            customer."Customer Posting Group" := cust."Customer Posting Group";
                            customer."VAT Bus. Posting Group" := cust."VAT Bus. Posting Group";
                            customer."VAT Registration No." := cust."VAT Registration No.";
                            customer.Modify();
                            commit;

                            rec.Setrange(FBM_GrCode, cust."No.");

                            CurrPage.Update();
                            PAGE.RunModal(PAGE::"Customer Card", rec);

                            exit(true);
                        end
                    end;
                }
            }
            repeater(Control1)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies a unique number that identifies the customer. The number can be generated automatically from a number series, or you can number each of them manually.';
                }
                field(Name; Rec.Name)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the customer''s name that appears on all related documents. For companies, specify the company''s name here, and then add the relevant people as contacts that you link to this customer.';
                }
                field("Name 2"; Rec."Name 2")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies an additional part of the name.';
                    Visible = false;
                }
                field(FBM_GrCode; Rec.FBM_GrCode)
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }

                field("Post Code"; Rec."Post Code")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the postal code.';
                    Visible = false;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the country/region of the address.';
                    Visible = false;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the customer''s telephone number.';
                }

                field(Contact; rec.Contact)
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the name of the person you regularly contact when you do business with this customer.';
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    Editable = false;
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies a code for the salesperson who normally handles this customer''s account.';
                    Visible = false;
                }
                field("Customer Posting Group"; Rec."Customer Posting Group")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the customer''s market type to link business transactions to.';
                    Visible = IsAllowMultiplePostingGroupsVisible;
                }
                field("Allow Multiple Posting Groups"; Rec."Allow Multiple Posting Groups")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies if multiple posting groups can be used for posting business transactions for this customer.';
                    Visible = false;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the customer''s trade type to link transactions made for this customer with the appropriate general ledger account according to the general posting setup.';
                    Visible = false;
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the VAT specification of the involved customer or vendor to link transactions made for this record with the appropriate general ledger account according to the VAT posting setup.';
                    Visible = false;
                }
                field("Customer Price Group"; Rec."Customer Price Group")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the customer price group code, which you can use to set up special sales prices in the Sales Prices window.';
                    Visible = false;
                }
                field("Customer Disc. Group"; Rec."Customer Disc. Group")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the customer discount group code, which you can use as a criterion to set up special discounts in the Sales Line Discounts window.';
                    Visible = false;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies a formula that calculates the payment due date, payment discount date, and payment discount amount.';
                    Visible = false;
                }
                field("Reminder Terms Code"; Rec."Reminder Terms Code")
                {
                    Editable = false;
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies how reminders about late payments are handled for this customer.';
                    Visible = false;
                }
                field("Fin. Charge Terms Code"; Rec."Fin. Charge Terms Code")
                {
                    Editable = false;
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the code for the involved finance charges in case of late payment.';
                    Visible = false;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    Editable = false;
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the default currency for the customer.';
                    Visible = false;
                }
                field("Language Code"; Rec."Language Code")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the language that is used when translating specified text on documents to foreign business partner, such as an item description on an order confirmation.';
                    Visible = false;
                }
                field("Search Name"; Rec."Search Name")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies an alternate name that you can use to search for the record in question when you cannot remember the value in the Name field.';
                    Visible = false;
                }
                field("Credit Limit (LCY)"; Rec."Credit Limit (LCY)")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the maximum amount you allow the customer to exceed the payment balance before warnings are issued.';
                    Visible = false;
                }
                field(Blocked; rec.Blocked)
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies that the related record is blocked from being posted in transactions, for example a customer that is declared insolvent or an item that is placed in quarantine.';
                    Visible = false;
                }
                field("Privacy Blocked"; Rec."Privacy Blocked")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies whether to limit access to data for the data subject during daily operations. This is useful, for example, when protecting data from changes while it is under privacy review.';
                    Visible = false;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies when the customer card was last modified.';
                    Visible = false;
                }
                field("Application Method"; Rec."Application Method")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies how to apply payments to entries for this customer.';
                    Visible = false;
                }

                field("Balance (LCY)"; Rec."Balance (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the payment amount that the customer owes for completed sales. This value is also known as the customer''s balance.';

                    trigger OnDrillDown()
                    begin
                        rec.OpenCustomerLedgerEntries(false);
                    end;
                }
                field("Balance Due (LCY)"; Rec."Balance Due (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies payments from the customer that are overdue per today''s date.';

                    trigger OnDrillDown()
                    begin
                        rec.OpenCustomerLedgerEntries(true);
                    end;
                }
                field("Sales (LCY)"; Rec."Sales (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the total net amount of sales to the customer in LCY.';
                }
                field("Payments (LCY)"; Rec."Payments (LCY)")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the sum of payments received from the customer.';
                }

            }
        }
        area(factboxes)
        {
            part(PowerBIEmbeddedReportPart; "Power BI Embedded Report Part")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part(Control99; "CRM Statistics FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No.");
                Visible = CRMIsCoupledToRecord and CRMIntegrationEnabled;
            }
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(Database::Customer),
                              "No." = FIELD("No.");
                Visible = NOT IsOfficeAddin;
            }
            part(SalesHistSelltoFactBox; "Sales Hist. Sell-to FactBox")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = FIELD("No."),
                              "Currency Filter" = FIELD("Currency Filter"),
                              "Date Filter" = FIELD("Date Filter"),
                              "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
            }
            part(SalesHistBilltoFactBox; "Sales Hist. Bill-to FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No."),
                              "Currency Filter" = FIELD("Currency Filter"),
                              "Date Filter" = FIELD("Date Filter"),
                              "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                Visible = false;
            }
            part(CustomerStatisticsFactBox; "Customer Statistics FactBox")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = FIELD("No."),
                              "Currency Filter" = FIELD("Currency Filter"),
                              "Date Filter" = FIELD("Date Filter"),
                              "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
            }
            part(CustomerDetailsFactBox; "Customer Details FactBox")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = FIELD("No."),
                              "Currency Filter" = FIELD("Currency Filter"),
                              "Date Filter" = FIELD("Date Filter"),
                              "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                Visible = false;
            }
            part(Control1907829707; "Service Hist. Sell-to FactBox")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = FIELD("No."),
                              "Currency Filter" = FIELD("Currency Filter"),
                              "Date Filter" = FIELD("Date Filter"),
                              "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                Visible = false;
            }
            part(Control1902613707; "Service Hist. Bill-to FactBox")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = FIELD("No."),
                              "Currency Filter" = FIELD("Currency Filter"),
                              "Date Filter" = FIELD("Date Filter"),
                              "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                Visible = false;
            }

            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }

    actions
    {
        area(navigation)
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
                        clear(CustomerSiteP);
                    end;
                }
                // action(SetActive)
                // {
                //     ApplicationArea = All;
                //     Image = History;

                //     caption = 'Set Active All';

                //     trigger OnAction()
                //     var

                //         csite: record FBM_CustomerSite_C;
                //     begin
                //         csite.FindFirst();
                //         repeat
                //             csite.Rename(csite."Customer No.", csite."Site Code", csite.Version, true);
                //             csite.Modify();
                //         until csite.Next() = 0
                //     end;
                // }
            }
            group("&Customer")
            {
                Caption = '&Customer';
                Image = Customer;
                action("Co&mments")
                {
                    ApplicationArea = Comments;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name" = CONST(Customer),
                                  "No." = FIELD("No.");
                    ToolTip = 'View or add comments for the record.';
                }
                group(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    action(DimensionsSingle)
                    {
                        ApplicationArea = Dimensions;
                        Caption = 'Dimensions-Single';
                        Image = Dimensions;
                        RunObject = Page "Default Dimensions";
                        RunPageLink = "Table ID" = CONST(18),
                                      "No." = FIELD("No.");
                        ShortCutKey = 'Alt+D';
                        ToolTip = 'View or edit the single set of dimensions that are set up for the selected record.';
                    }
                    action(DimensionsMultiple)
                    {
                        AccessByPermission = TableData Dimension = R;
                        ApplicationArea = Dimensions;
                        Caption = 'Dimensions-&Multiple';
                        Image = DimensionSets;
                        ToolTip = 'View or edit dimensions for a group of records. You can assign dimension codes to transactions to distribute costs and analyze historical information.';

                        trigger OnAction()
                        var
                            Cust: Record Customer;
                            DefaultDimMultiple: Page "Default Dimensions-Multiple";
                        begin
                            CurrPage.SetSelectionFilter(Cust);
                            DefaultDimMultiple.SetMultiRecord(Cust, rec.FieldNo("No."));
                            DefaultDimMultiple.RunModal();
                        end;
                    }
                }
                action("Bank Accounts")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Accounts';
                    Image = BankAccount;
                    RunObject = Page "Customer Bank Account List";
                    RunPageLink = "Customer No." = FIELD("No.");
                    ToolTip = 'View or set up the customer''s bank accounts. You can set up any number of bank accounts for each customer.';
                }
                action("Direct Debit Mandates")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Direct Debit Mandates';
                    Image = MakeAgreement;
                    RunObject = Page "SEPA Direct Debit Mandates";
                    RunPageLink = "Customer No." = FIELD("No.");
                    ToolTip = 'View the direct-debit mandates that reflect agreements with customers to collect invoice payments from their bank account.';
                }
                action(ShipToAddresses)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Ship-&to Addresses';
                    Image = ShipAddress;
                    RunObject = Page "Ship-to Address List";
                    RunPageLink = "Customer No." = FIELD("No.");
                    ToolTip = 'View or edit alternate shipping addresses where the customer wants items delivered if different from the regular address.';
                }
                action("C&ontact")
                {
                    AccessByPermission = TableData Contact = R;
                    ApplicationArea = Basic, Suite;
                    Caption = 'C&ontact';
                    Image = ContactPerson;
                    ToolTip = 'View or edit detailed information about the contact person at the customer.';

                    trigger OnAction()
                    begin
                        rec.ShowContact();
                    end;
                }
                action("Item References")
                {
                    AccessByPermission = TableData "Item Reference" = R;
                    ApplicationArea = Suite, ItemReferences;
                    Caption = 'Item Refe&rences';
                    Image = Change;
                    RunObject = Page "Item References";
                    RunPageLink = "Reference Type" = CONST(Customer),
                                  "Reference Type No." = FIELD("No.");
                    RunPageView = SORTING("Reference Type", "Reference Type No.");
                    ToolTip = 'Set up the customer''s own identification of items that you sell to the customer. Item references to the customer''s item number means that the item number is automatically shown on sales documents instead of the number that you use.';
                }
                action(OnlineMap)
                {
                    ApplicationArea = All;
                    Caption = 'Online Map';
                    Image = Map;
                    Scope = Repeater;
                    ToolTip = 'View the address on an online map.';
                    Visible = false;

                    trigger OnAction()
                    begin
                        rec.DisplayMap();
                    end;
                }
                action(ApprovalEntries)
                {
                    AccessByPermission = TableData "Approval Entry" = R;
                    ApplicationArea = Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                    trigger OnAction()
                    begin
                        ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                    end;
                }
            }
            group(ActionGroupCRM)
            {
                Caption = 'Dataverse';
                Visible = CRMIntegrationEnabled or CDSIntegrationEnabled;
                Enabled = (BlockedFilterApplied and (rec.Blocked = rec.Blocked::" ")) or not BlockedFilterApplied;
                action(CRMGotoAccount)
                {
                    ApplicationArea = Suite;
                    Caption = 'Account';
                    Image = CoupledCustomer;
                    ToolTip = 'Open the coupled Dataverse account.';

                    trigger OnAction()
                    var
                        CRMIntegrationManagement: Codeunit "CRM Integration Management";
                    begin
                        CRMIntegrationManagement.ShowCRMEntityFromRecordID(rec.RecordId);
                    end;
                }
                action(CRMSynchronizeNow)
                {
                    AccessByPermission = TableData "CRM Integration Record" = IM;
                    ApplicationArea = Suite;
                    Caption = 'Synchronize';
                    Image = Refresh;
                    ToolTip = 'Send or get updated data to or from Dataverse.';

                    trigger OnAction()
                    var
                        Customer: Record Customer;
                        CRMIntegrationManagement: Codeunit "CRM Integration Management";
                        CustomerRecordRef: RecordRef;
                    begin
                        CurrPage.SetSelectionFilter(Customer);
                        Customer.Next();

                        if Customer.Count = 1 then
                            CRMIntegrationManagement.UpdateOneNow(Customer.RecordId)
                        else begin
                            CustomerRecordRef.GetTable(Customer);
                            CRMIntegrationManagement.UpdateMultipleNow(CustomerRecordRef);
                        end
                    end;
                }
                action(UpdateStatisticsInCRM)
                {
                    ApplicationArea = Suite;
                    Caption = 'Update Account Statistics';
                    Enabled = CRMIsCoupledToRecord;
                    Image = UpdateXML;
                    ToolTip = 'Send customer statistics data to Dataverse to update the Account Statistics FactBox.';
                    Visible = CRMIntegrationEnabled;

                    trigger OnAction()
                    var
                        CRMIntegrationManagement: Codeunit "CRM Integration Management";
                    begin
                        CRMIntegrationManagement.CreateOrUpdateCRMAccountStatistics(Rec);
                    end;
                }
                group(Coupling)
                {
                    Caption = 'Coupling', Comment = 'Coupling is a noun';
                    Image = LinkAccount;
                    ToolTip = 'Create, change, or delete a coupling between the Business Central record and a Dataverse record.';
                    action(ManageCRMCoupling)
                    {
                        AccessByPermission = TableData "CRM Integration Record" = IM;
                        ApplicationArea = Suite;
                        Caption = 'Set Up Coupling';
                        Image = LinkAccount;
                        ToolTip = 'Create or modify the coupling to a Dataverse account.';

                        trigger OnAction()
                        var
                            CRMIntegrationManagement: Codeunit "CRM Integration Management";
                        begin
                            CRMIntegrationManagement.DefineCoupling(rec.RecordId);
                        end;
                    }
                    action(MatchBasedCoupling)
                    {
                        AccessByPermission = TableData "CRM Integration Record" = IM;
                        ApplicationArea = Suite;
                        Caption = 'Match-Based Coupling';
                        Image = CoupledCustomer;
                        ToolTip = 'Couple customers to accounts in Dataverse based on criteria.';

                        trigger OnAction()
                        var
                            Customer: Record Customer;
                            CRMIntegrationManagement: Codeunit "CRM Integration Management";
                            RecRef: RecordRef;
                        begin
                            CurrPage.SetSelectionFilter(Customer);
                            RecRef.GetTable(Customer);
                            //CRMIntegrationManagement.MatchBasedCoupling(RecRef);
                        end;
                    }
                    action(DeleteCRMCoupling)
                    {
                        AccessByPermission = TableData "CRM Integration Record" = D;
                        ApplicationArea = Suite;
                        Caption = 'Delete Coupling';
                        Enabled = CRMIsCoupledToRecord;
                        Image = UnLinkAccount;
                        ToolTip = 'Delete the coupling to a Dataverse account.';

                        trigger OnAction()
                        var
                            Customer: Record Customer;
                            CRMCouplingManagement: Codeunit "CRM Coupling Management";
                            RecRef: RecordRef;
                        begin
                            CurrPage.SetSelectionFilter(Customer);
                            RecRef.GetTable(Customer);
                            //CRMCouplingManagement.RemoveCoupling(RecRef);
                        end;
                    }
                }
                group(Create)
                {
                    Caption = 'Create';
                    Image = NewCustomer;
                    action(CreateInCRM)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Create Account in Dataverse';
                        Image = NewCustomer;
                        ToolTip = 'Generate the account in the coupled Dataverse account.';

                        trigger OnAction()
                        var
                            Customer: Record Customer;
                            CRMIntegrationManagement: Codeunit "CRM Integration Management";
                        begin
                            CurrPage.SetSelectionFilter(Customer);
                            CRMIntegrationManagement.CreateNewRecordsInCRM(Customer);
                        end;
                    }
                    action(CreateFromCRM)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Create Customer in Business Central';
                        Image = NewCustomer;
                        ToolTip = 'Generate the customer in the coupled Dataverse account.';

                        trigger OnAction()
                        var
                            CRMIntegrationManagement: Codeunit "CRM Integration Management";
                        begin
                            CRMIntegrationManagement.CreateNewCustomerFromCRM();
                        end;
                    }
                }
                action(ShowLog)
                {
                    ApplicationArea = Suite;
                    Caption = 'Synchronization Log';
                    Image = Log;
                    ToolTip = 'View integration synchronization jobs for the customer table.';

                    trigger OnAction()
                    var
                        CRMIntegrationManagement: Codeunit "CRM Integration Management";
                    begin
                        CRMIntegrationManagement.ShowLog(rec.RecordId);
                    end;
                }
            }
            group(History)
            {
                Caption = 'History';
                Image = History;
                action(CustomerLedgerEntries)
                {
                    ApplicationArea = Suite;
                    Caption = 'Ledger E&ntries';
                    Image = CustomerLedger;
                    RunObject = Page "Customer Ledger Entries";
                    RunPageLink = "Customer No." = FIELD("No.");
                    RunPageView = SORTING("Customer No.")
                                  ORDER(Descending);
                    ShortCutKey = 'Ctrl+F7';
                    ToolTip = 'View the history of transactions that have been posted for the selected record.';
                }
                action(Statistics)
                {
                    ApplicationArea = Suite;
                    Caption = 'Statistics';
                    Image = Statistics;
                    RunObject = Page "Customer Statistics";
                    RunPageLink = "No." = FIELD("No."),
                                  "Date Filter" = FIELD("Date Filter"),
                                  "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                    ShortCutKey = 'F7';
                    ToolTip = 'View statistical information, such as the value of posted entries, for the record.';
                }
                action("S&ales")
                {
                    ApplicationArea = Advanced;
                    Caption = 'S&ales';
                    Image = Sales;
                    RunObject = Page "Customer Sales";
                    RunPageLink = "No." = FIELD("No."),
                                  "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                    ToolTip = 'Shows a summary of customer ledger entries. You select the time interval in the View by field. The Period column on the left contains a series of dates that are determined by the time interval you have selected.';
                }
                action("Entry Statistics")
                {
                    ApplicationArea = Suite;
                    Caption = 'Entry Statistics';
                    Image = EntryStatistics;
                    RunObject = Page "Customer Entry Statistics";
                    RunPageLink = "No." = FIELD("No."),
                                  "Date Filter" = FIELD("Date Filter"),
                                  "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                    ToolTip = 'View entry statistics for the record.';
                }
                action("Statistics by C&urrencies")
                {
                    ApplicationArea = Suite;
                    Caption = 'Statistics by C&urrencies';
                    Image = Currencies;
                    RunObject = Page "Cust. Stats. by Curr. Lines";
                    RunPageLink = "Customer Filter" = FIELD("No."),
                                  "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"),
                                  "Date Filter" = FIELD("Date Filter");
                    ToolTip = 'View statistics for customers that use multiple currencies.';
                }
                action("Item &Tracking Entries")
                {
                    ApplicationArea = ItemTracking;
                    Caption = 'Item &Tracking Entries';
                    Image = ItemTrackingLedger;
                    ToolTip = 'View serial or lot numbers that are assigned to items.';

                    trigger OnAction()
                    var
                        ItemTrackingDocMgt: Codeunit "Item Tracking Doc. Management";
                    begin
                        ItemTrackingDocMgt.ShowItemTrackingForEntity(1, rec."No.", '', '', '');
                    end;
                }
                action("Sent Emails")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sent Emails';
                    Image = ShowList;
                    ToolTip = 'View a list of emails that you have sent to this customer.';

                    trigger OnAction()
                    var
                        Email: Codeunit Email;
                    begin
                        Email.OpenSentEmails(Database::Customer, Rec.SystemId);
                    end;
                }
            }
            group(Action24)
            {
                Caption = 'S&ales';
                Image = Sales;
                action(Sales_InvoiceDiscounts)
                {
                    ApplicationArea = Advanced;
                    Caption = 'Invoice &Discounts';
                    Image = CalculateInvoiceDiscount;
                    RunObject = Page "Cust. Invoice Discounts";
                    RunPageLink = Code = FIELD("Invoice Disc. Code");
                    ToolTip = 'Set up different discounts that are applied to invoices for the customer. An invoice discount is automatically granted to the customer when the total on a sales invoice exceeds a certain amount.';
                }

                action("Prepa&yment Percentages")
                {
                    ApplicationArea = Prepayments;
                    Caption = 'Prepa&yment Percentages';
                    Image = PrepaymentPercentages;
                    RunObject = Page "Sales Prepayment Percentages";
                    RunPageLink = "Sales Type" = CONST(Customer),
                                  "Sales Code" = FIELD("No.");
                    RunPageView = SORTING("Sales Type", "Sales Code");
                    ToolTip = 'View or edit the percentages of the price that can be paid as a prepayment. ';
                }
                action("Recurring Sales Lines")
                {
                    ApplicationArea = Suite;
                    Caption = 'Recurring Sales Lines';
                    Image = CodesList;
                    RunObject = Page "Standard Customer Sales Codes";
                    RunPageLink = "Customer No." = FIELD("No.");
                    ToolTip = 'Set up recurring sales lines for the customer, such as a monthly replenishment order, that can quickly be inserted on a sales document for the customer.';
                }
            }
            group(Documents)
            {
                Caption = 'Documents';
                Image = Documents;
                action(Quotes)
                {
                    ApplicationArea = Advanced;
                    Caption = 'Quotes';
                    Image = Quote;
                    RunObject = Page "Sales Quotes";
                    RunPageLink = "Sell-to Customer No." = FIELD("No.");
                    RunPageView = SORTING("Sell-to Customer No.");
                    ToolTip = 'View a list of ongoing sales quotes.';
                }
                action(Orders)
                {
                    ApplicationArea = Advanced;
                    Caption = 'Orders';
                    Image = Document;
                    RunObject = Page "Sales Order List";
                    RunPageLink = "Sell-to Customer No." = FIELD("No.");
                    RunPageView = SORTING("Sell-to Customer No.");
                    ToolTip = 'View a list of ongoing sales orders for the customer.';
                }
                action("Return Orders")
                {
                    ApplicationArea = SalesReturnOrder;
                    Caption = 'Return Orders';
                    Image = ReturnOrder;
                    RunObject = Page "Sales Return Order List";
                    RunPageLink = "Sell-to Customer No." = FIELD("No.");
                    RunPageView = SORTING("Sell-to Customer No.");
                    ToolTip = 'Open the list of ongoing return orders.';
                }
                group("Issued Documents")
                {
                    Caption = 'Issued Documents';
                    Image = Documents;
                    action("Issued &Reminders")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Issued &Reminders';
                        Image = OrderReminder;
                        RunObject = Page "Issued Reminder List";
                        RunPageLink = "Customer No." = FIELD("No.");
                        RunPageView = SORTING("Customer No.", "Posting Date");
                        ToolTip = 'View the reminders that you have sent to the customer.';
                    }
                    action("Issued &Finance Charge Memos")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Issued &Finance Charge Memos';
                        Image = FinChargeMemo;
                        RunObject = Page "Issued Fin. Charge Memo List";
                        RunPageLink = "Customer No." = FIELD("No.");
                        RunPageView = SORTING("Customer No.", "Posting Date");
                        ToolTip = 'View the finance charge memos that you have sent to the customer.';
                    }
                }
                action("Blanket Orders")
                {
                    ApplicationArea = Suite;
                    Caption = 'Blanket Orders';
                    Image = BlanketOrder;
                    RunObject = Page "Blanket Sales Orders";
                    RunPageLink = "Sell-to Customer No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", "Sell-to Customer No.");
                    ToolTip = 'Open the list of ongoing blanket orders.';
                }
            }
            group(Service)
            {
                Caption = 'Service';
                Image = ServiceItem;
                action("Service Orders")
                {
                    ApplicationArea = Service;
                    Caption = 'Service Orders';
                    Image = Document;
                    RunObject = Page "Service Orders";
                    RunPageLink = "Customer No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", "Customer No.");
                    ToolTip = 'Open the list of ongoing service orders.';
                }
                action("Ser&vice Contracts")
                {
                    ApplicationArea = Service;
                    Caption = 'Ser&vice Contracts';
                    Image = ServiceAgreement;
                    RunObject = Page "Customer Service Contracts";
                    RunPageLink = "Customer No." = FIELD("No.");
                    RunPageView = SORTING("Customer No.", "Ship-to Code");
                    ToolTip = 'Open the list of ongoing service contracts.';
                }
                action("Service &Items")
                {
                    ApplicationArea = Service;
                    Caption = 'Service &Items';
                    Image = ServiceItem;
                    RunObject = Page "Service Items";
                    RunPageLink = "Customer No." = FIELD("No.");
                    RunPageView = SORTING("Customer No.", "Ship-to Code", "Item No.", "Serial No.");
                    ToolTip = 'View or edit the service items that are registered for the customer.';
                }
            }
        }
        area(creation)
        {
            action(NewSalesBlanketOrder)
            {
                ApplicationArea = Suite;
                Caption = 'Blanket Sales Order';
                Image = BlanketOrder;
                RunObject = Page "Blanket Sales Order";
                RunPageLink = "Sell-to Customer No." = FIELD("No.");
                RunPageMode = Create;
                ToolTip = 'Create a blanket sales order for the customer.';
            }
            action(NewSalesQuote)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Quote';
                Image = NewSalesQuote;
                RunObject = Page "Sales Quote";
                RunPageLink = "Sell-to Customer No." = FIELD("No.");
                RunPageMode = Create;
                ToolTip = 'Offer items or services to a customer.';
            }
            action(NewSalesInvoice)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Invoice';
                Image = NewSalesInvoice;
                RunObject = Page "Sales Invoice";
                RunPageLink = "Sell-to Customer No." = FIELD("No.");
                RunPageMode = Create;
                ToolTip = 'Create a sales invoice for the customer.';
            }
            action(NewSalesOrder)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Order';
                Image = Document;
                RunObject = Page "Sales Order";
                RunPageLink = "Sell-to Customer No." = FIELD("No.");
                RunPageMode = Create;
                ToolTip = 'Create a sales order for the customer.';
            }
            action(NewSalesCrMemo)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Credit Memo';
                Image = CreditMemo;
                RunObject = Page "Sales Credit Memo";
                RunPageLink = "Sell-to Customer No." = FIELD("No.");
                RunPageMode = Create;
                ToolTip = 'Create a new sales credit memo to revert a posted sales invoice.';
            }
            action(NewSalesReturnOrder)
            {
                ApplicationArea = SalesReturnOrder;
                Caption = 'Sales Return Order';
                Image = ReturnOrder;
                RunObject = Page "Sales Return Order";
                RunPageLink = "Sell-to Customer No." = FIELD("No.");
                RunPageMode = Create;
                ToolTip = 'Create a new sales return order for items or services.';
            }
            action(NewServiceQuote)
            {
                ApplicationArea = Service;
                Caption = 'Service Quote';
                Image = Quote;
                RunObject = Page "Service Quote";
                RunPageLink = "Customer No." = FIELD("No.");
                RunPageMode = Create;
                ToolTip = 'Create a new service quote for the customer.';
            }
            action(NewServiceInvoice)
            {
                ApplicationArea = Service;
                Caption = 'Service Invoice';
                Image = Invoice;
                RunObject = Page "Service Invoice";
                RunPageLink = "Customer No." = FIELD("No.");
                RunPageMode = Create;
                ToolTip = 'Create a new service invoice for the customer.';
            }
            action(NewServiceOrder)
            {
                ApplicationArea = Service;
                Caption = 'Service Order';
                Image = Document;
                RunObject = Page "Service Order";
                RunPageLink = "Customer No." = FIELD("No.");
                RunPageMode = Create;
                ToolTip = 'Create a new service order for the customer.';
            }
            action(NewServiceCrMemo)
            {
                ApplicationArea = Service;
                Caption = 'Service Credit Memo';
                Image = CreditMemo;
                RunObject = Page "Service Credit Memo";
                RunPageLink = "Customer No." = FIELD("No.");
                RunPageMode = Create;
                ToolTip = 'Create a new service credit memo for the customer.';
            }
            action(NewReminder)
            {
                ApplicationArea = Suite;
                Caption = 'Reminder';
                Image = Reminder;
                RunObject = Page Reminder;
                RunPageLink = "Customer No." = FIELD("No.");
                RunPageMode = Create;
                ToolTip = 'Create a new reminder for the customer.';
                AboutTitle = 'Create a new document';
                AboutText = 'Get started on a new reminder, order, or other document for the customer selected in the list.';
            }
            action(NewFinChargeMemo)
            {
                ApplicationArea = Suite;
                Caption = 'Finance Charge Memo';
                Image = FinChargeMemo;
                RunObject = Page "Finance Charge Memo";
                RunPageLink = "Customer No." = FIELD("No.");
                RunPageMode = Create;
                ToolTip = 'Create a new finance charge memo.';
            }
        }
        area(processing)
        {
#if not CLEAN20
            group(Action104)
            {
                Caption = 'History';
                Image = History;
                ObsoleteState = Pending;
                ObsoleteReason = 'Duplicated action of CustomerLedgerEntries';
                ObsoleteTag = '20.0';
            }
#endif
            group(PricesAndDiscounts)
            {
                Caption = 'Prices & Discounts';
                action(Prices_InvoiceDiscounts)
                {
                    ApplicationArea = Advanced;
                    Caption = 'Invoice &Discounts';
                    Image = CalculateInvoiceDiscount;
                    RunObject = Page "Cust. Invoice Discounts";
                    RunPageLink = Code = FIELD("Invoice Disc. Code");
                    Scope = Repeater;
                    ToolTip = 'Set up different discounts applied to invoices for the selected customer. An invoice discount is automatically granted to the customer when the total on a sales invoice exceeds a certain amount.';
                }
                action(PriceLists)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Price Lists';
                    Image = Price;
                    Scope = Repeater;
                    Visible = ExtendedPriceEnabled;
                    ToolTip = 'View or set up sales price lists for products that you sell to the customer. A product price is automatically granted on invoice lines when the specified criteria are met, such as customer, quantity, or ending date.';

                    trigger OnAction()
                    var
                        PriceUXManagement: Codeunit "Price UX Management";
                    begin
                        PriceUXManagement.ShowPriceLists(Rec, "Price Amount Type"::Any);
                    end;
                }
                action(PriceLines)
                {
                    AccessByPermission = TableData "Sales Price Access" = R;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Prices';
                    Image = Price;
                    Scope = Repeater;
                    Visible = ExtendedPriceEnabled;
                    ToolTip = 'View or set up sales price lines for products that you sell to the customer. A product price is automatically granted on invoice lines when the specified criteria are met, such as customer, quantity, or ending date.';

                    trigger OnAction()
                    var
                        PriceSource: Record "Price Source";
                        PriceUXManagement: Codeunit "Price UX Management";
                    begin
                        Rec.ToPriceSource(PriceSource);
                        PriceUXManagement.ShowPriceListLines(PriceSource, "Price Amount Type"::Price);
                    end;
                }
                action(DiscountLines)
                {
                    AccessByPermission = TableData "Sales Discount Access" = R;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Discounts';
                    Image = LineDiscount;
                    Scope = Repeater;
                    Visible = ExtendedPriceEnabled;
                    ToolTip = 'View or set up different discounts for products that you sell to the customer. A product line discount is automatically granted on invoice lines when the specified criteria are met, such as customer, quantity, or ending date.';

                    trigger OnAction()
                    var
                        PriceSource: Record "Price Source";
                        PriceUXManagement: Codeunit "Price UX Management";
                    begin
                        Rec.ToPriceSource(PriceSource);
                        PriceUXManagement.ShowPriceListLines(PriceSource, "Price Amount Type"::Discount);
                    end;
                }

            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                Image = SendApprovalRequest;
                action(SendApprovalRequest)
                {
                    ApplicationArea = Suite;
                    Caption = 'Send A&pproval Request';
                    Enabled = (NOT OpenApprovalEntriesExist) AND EnabledApprovalWorkflowsExist AND CanRequestApprovalForFlow;
                    Image = SendApprovalRequest;
                    ToolTip = 'Request approval to change the record.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if ApprovalsMgmt.CheckCustomerApprovalsWorkflowEnabled(Rec) then
                            ApprovalsMgmt.OnSendCustomerForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = CanCancelApprovalForRecord OR CanCancelApprovalForFlow;
                    Image = CancelApprovalRequest;
                    ToolTip = 'Cancel the approval request.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        WorkflowWebhookManagement: Codeunit "Workflow Webhook Management";
                    begin
                        ApprovalsMgmt.OnCancelCustomerApprovalRequest(Rec);
                        WorkflowWebhookManagement.FindAndCancel(rec.RecordId);
                    end;
                }
            }
            group(Workflow)
            {
                Caption = 'Workflow';
                action(CreateApprovalWorkflow)
                {
                    ApplicationArea = Suite;
                    Caption = 'Create Approval Workflow';
                    Enabled = NOT EnabledApprovalWorkflowsExist;
                    Image = CreateWorkflow;
                    ToolTip = 'Set up an approval workflow for creating or changing customers, by going through a few pages that will guide you.';

                    trigger OnAction()
                    begin
                        PAGE.RunModal(PAGE::"Cust. Approval WF Setup Wizard");
                        SetWorkflowManagementEnabledState();
                    end;
                }
                action(ManageApprovalWorkflows)
                {
                    ApplicationArea = Suite;
                    Caption = 'Manage Approval Workflows';
                    Enabled = EnabledApprovalWorkflowsExist;
                    Image = WorkflowSetup;
                    ToolTip = 'View or edit existing approval workflows for creating or changing customers.';

                    trigger OnAction()
                    var
                        WorkflowManagement: Codeunit "Workflow Management";
                    begin
                        WorkflowManagement.NavigateToWorkflows(DATABASE::Customer, EventFilter);
                        SetWorkflowManagementEnabledState();
                    end;
                }
            }
            action("Cash Receipt Journal")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Cash Receipt Journal';
                Image = CashReceiptJournal;
                RunObject = Page "Cash Receipt Journal";
                ToolTip = 'Open the cash receipt journal to post incoming payments.';
            }
            action("Sales Journal")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Journal';
                Image = Journals;
                RunObject = Page "Sales Journal";
                ToolTip = 'Post any sales transaction for the customer.';
            }
            action(ApplyTemplate)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Apply Template';
                Image = ApplyTemplate;
                ToolTip = 'Apply a template to update one or more entities with your standard settings for a certain type of entity.';

                trigger OnAction()
                var
                    Customer: Record Customer;
                    CustomerTemplMgt: Codeunit "Customer Templ. Mgt.";
                begin
                    CurrPage.SetSelectionFilter(Customer);
                    CustomerTemplMgt.UpdateCustomersFromTemplate(Customer);
                end;
            }
            action(WordTemplate)
            {
                ApplicationArea = All;
                Caption = 'Apply Word Template';
                ToolTip = 'Apply a Word template on the selected records.';
                Image = Word;

                trigger OnAction()
                var
                    Customer: Record Customer;
                    WordTemplateSelectionWizard: Page "Word Template Selection Wizard";
                begin
                    CurrPage.SetSelectionFilter(Customer);
                    WordTemplateSelectionWizard.SetData(Customer);
                    WordTemplateSelectionWizard.RunModal();
                end;
            }
            action(Email)
            {
                ApplicationArea = All;
                Caption = 'Send Email';
                Image = Email;
                ToolTip = 'Send an email to this customer.';
                Enabled = CanSendEmail;

                trigger OnAction()
                var
                    TempEmailItem: Record "Email Item" temporary;
                    EmailScenario: Enum "Email Scenario";
                begin
                    TempEmailItem.AddSourceDocument(Database::Customer, Rec.SystemId);
                    TempEmailitem."Send to" := Rec."E-Mail";
                    TempEmailItem.Send(false, EmailScenario::Default);
                end;
            }
            action(PaymentRegistration)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Register Customer Payments';
                Image = Payment;
                RunObject = Page "Payment Registration";
                RunPageLink = "Source No." = FIELD("No.");
                ToolTip = 'Process your customer payments by matching amounts received on your bank account with the related unpaid sales invoices, and then post the payments.';
            }

        }
        area(reporting)
        {
            group(Reports)
            {
                Caption = 'Reports';
                group(SalesReports)
                {
                    Caption = 'Sales Reports';
                    Image = "Report";
                    action(ReportCustomerTop10List)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer - Top 10 List';
                        Image = "Report";
                        RunObject = Report "Customer - Top 10 List";
                        ToolTip = 'View which customers purchase the most or owe the most in a selected period. Only customers that have either purchases during the period or a balance at the end of the period will be included.';
                    }
                    action(ReportCustomerSalesList)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer - Sales List';
                        Image = "Report";
                        RunObject = Report "Customer - Sales List";
                        ToolTip = 'View customer sales for a period, for example, to report sales activity to customs and tax authorities. You can choose to include only customers with total sales that exceed a minimum amount. You can also specify whether you want the report to show address details for each customer.';
                    }
                    action(ReportSalesStatistics)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Sales Statistics';
                        Image = "Report";
                        RunObject = Report "Customer Sales Statistics";
                        ToolTip = 'View customers'' total costs, sales, and profits over time, for example, to analyze earnings trends. The report shows amounts for original and adjusted costs, sales, profits, invoice discounts, payment discounts, and profit percentage in three adjustable periods.';
                    }
                }
                group(FinanceReports)
                {
                    Caption = 'Finance Reports';
                    Image = "Report";
                    action(Statement)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Statement';
                        Image = "Report";
                        RunObject = Report "Customer Statement";
                        ToolTip = 'View a list of a customer''s transactions for a selected period, for example, to send to the customer at the close of an accounting period. You can choose to have all overdue balances displayed regardless of the period specified, or you can choose to include an aging band.';
                    }
                    action(BackgroundStatement)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Scheduled Statements';
                        Image = "Report";
                        ToolTip = 'Schedule Customer Statements in the Job Queue.';

                        trigger OnAction()
                        var
                            CustomerLayoutStatement: Codeunit "Customer Layout - Statement";
                        begin
                            //CustomerLayoutStatement.EnqueueReport();
                        end;
                    }
                    action(ReportCustomerBalanceToDate)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer - Balance to Date';
                        Image = "Report";
                        RunObject = Report "Customer - Balance to Date";
                        ToolTip = 'View a list with customers'' payment history up until a certain date. You can use the report to extract your total sales income at the close of an accounting period or fiscal year.';
                    }
                    action(ReportCustomerTrialBalance)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Customer - Trial Balance';
                        Image = "Report";
                        RunObject = Report "Customer - Trial Balance";
                        ToolTip = 'View the beginning and ending balance for customers with entries within a specified period. The report can be used to verify that the balance for a customer posting group is equal to the balance on the corresponding general ledger account on a certain date.';
                    }
                    action(ReportCustomerDetailTrial)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer - Detail Trial Bal.';
                        Image = "Report";
                        RunObject = Report "Customer - Detail Trial Bal.";
                        ToolTip = 'View the balance for customers with balances on a specified date. The report can be used at the close of an accounting period, for example, or for an audit.';
                    }
                    action(ReportCustomerSummaryAging)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Customer - Summary Aging';
                        Image = "Report";
                        RunObject = Report "Customer - Summary Aging Simp.";
                        ToolTip = 'View, print, or save a summary of each customer''s total payments due, divided into three time periods. The report can be used to decide when to issue reminders, to evaluate a customer''s creditworthiness, or to prepare liquidity analyses.';
                    }

                    action(ReportAgedAccountsReceivable)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Aged Accounts Receivable';
                        Image = "Report";
                        RunObject = Report "Aged Accounts Receivable";
                        ToolTip = 'View an overview of when customer payments are due or overdue, divided into four periods. You must specify the date you want aging calculated from and the length of the period that each column will contain data for.';
                    }
                    action(ReportCustomerPaymentReceipt)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Customer - Payment Receipt';
                        Image = "Report";
                        RunObject = Report "Customer - Payment Receipt";
                        ToolTip = 'View a document showing which customer ledger entries that a payment has been applied to. This report can be used as a payment receipt that you send to the customer.';
                    }
                }
                action(Reminder)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Reminder';
                    Image = Reminder;
                    RunObject = Report Reminder;
                    ToolTip = 'Create a new reminder for the customer.';
                }
            }
            group(General)
            {
                Caption = 'General';

                action("Customer Register")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customer Register';
                    Image = "Report";
                    RunObject = Report "Customer Register";
                    ToolTip = 'View posted customer ledger entries divided into, and sorted according to, registers. By using a filter, you can select exactly the entries in the registers that you need to see. If you have created many entries and you do not set a filter, the report will print a large amount of information.';
                }
                action("Customer - Top 10 List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customer - Top 10 List';
                    Image = "Report";
                    RunObject = Report "Customer - Top 10 List";
                    ToolTip = 'View which customers purchase the most or owe the most in a selected period. Only customers that have either purchases during the period or a balance at the end of the period will be included.';
                }
            }
            group(Sales)
            {
                Caption = 'Sales';
                Image = Sales;
                action("Customer - Order Summary")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customer - Order Summary';
                    Image = "Report";
                    RunObject = Report "Customer - Order Summary";
                    ToolTip = 'View the order detail (the quantity not yet shipped) for each customer in three periods of 30 days each, starting from a selected date. There are also columns with orders to be shipped before and after the three periods and a column with the total order detail for each customer. The report can be used to analyze a company''s expected sales volume.';
                }
                action("Customer - Order Detail")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customer - Order Detail';
                    Image = "Report";
                    RunObject = Report "Customer - Order Detail";
                    ToolTip = 'View a list of orders divided by customer. The order amounts are totaled for each customer and for the entire list. The report can be used, for example, to obtain an overview of sales over the short term or to analyze possible shipment problems.';
                }
                action("Customer - Sales List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customer - Sales List';
                    Image = "Report";
                    RunObject = Report "Customer - Sales List";
                    ToolTip = 'View customer sales for a period, for example, to report sales activity to customs and tax authorities. You can choose to include only customers with total sales that exceed a minimum amount. You can also specify whether you want the report to show address details for each customer.';
                }
                action("Sales Statistics")
                {
                    ApplicationArea = Suite;
                    Caption = 'Sales Statistics';
                    Image = "Report";
                    RunObject = Report "Customer Sales Statistics";
                    ToolTip = 'View customers'' total costs, sales, and profits over time, for example, to analyze earnings trends. The report shows amounts for original and adjusted costs, sales, profits, invoice discounts, payment discounts, and profit percentage in three adjustable periods.';
                }

            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process', Comment = 'Generated from the PromotedActionCategories property index 1.';

                actionref(PaymentRegistration_Promoted; PaymentRegistration)
                {
                }
                actionref(Email_Promoted; Email)
                {
                }
                actionref(ApplyTemplate_Promoted; ApplyTemplate)
                {
                }
            }
            group(Category_Category4)
            {
                Caption = 'Approve', Comment = 'Generated from the PromotedActionCategories property index 3.';
            }
            group(Category_Category6)
            {
                Caption = 'Request Approval', Comment = 'Generated from the PromotedActionCategories property index 5.';
            }
            group(Category_Category5)
            {
                Caption = 'New Document', Comment = 'Generated from the PromotedActionCategories property index 4.';

                actionref(NewSalesQuote_Promoted; NewSalesQuote)
                {
                }
                actionref(NewSalesOrder_Promoted; NewSalesOrder)
                {
                }
                actionref(NewSalesInvoice_Promoted; NewSalesInvoice)
                {
                }
                actionref(NewSalesCrMemo_Promoted; NewSalesCrMemo)
                {
                }
                actionref(NewReminder_Promoted; NewReminder)
                {
                }
            }
            group(Category_Category7)
            {
                Caption = 'Customer', Comment = 'Generated from the PromotedActionCategories property index 6.';

                actionref(CustomerLedgerEntries_Promoted; CustomerLedgerEntries)
                {
                }
                actionref(Statistics_Promoted; Statistics)
                {
                }
                group(Category_Dimensions)
                {
                    Caption = 'Dimensions';
                    ShowAs = SplitButton;

                    actionref(DimensionsMultiple_Promoted; DimensionsMultiple)
                    {
                    }
                    actionref(DimensionsSingle_Promoted; DimensionsSingle)
                    {
                    }
                }
                actionref(ApprovalEntries_Promoted; ApprovalEntries)
                {
                }
                actionref("Co&mments_Promoted"; "Co&mments")
                {
                }
                actionref(OnlineMap_Promoted; OnlineMap)
                {
                }

                separator(Navigate_Separator)
                {
                }

                actionref("C&ontact_Promoted"; "C&ontact")
                {
                }
                actionref("Sent Emails_Promoted"; "Sent Emails")
                {
                }
                actionref("Item &Tracking Entries_Promoted"; "Item &Tracking Entries")
                {
                }
                actionref("Item References_Promoted"; "Item References")
                {
                }
                actionref(Quotes_Promoted; Quotes)
                {
                }
                actionref(Orders_Promoted; Orders)
                {
                }
                actionref("Return Orders_Promoted"; "Return Orders")
                {
                }


            }
            group(Category_Category9)
            {
                Caption = 'Prices & Discounts', Comment = 'Generated from the PromotedActionCategories property index 8.';


                actionref(PriceLists_Promoted; PriceLists)
                {
                }
                actionref(PriceLines_Promoted; PriceLines)
                {
                }
                actionref(DiscountLines_Promoted; DiscountLines)
                {
                }
            }
            group(Category_Category8)
            {
                Caption = 'Navigate', Comment = 'Generated from the PromotedActionCategories property index 7.';
            }
            group(Category_Report)
            {
                Caption = 'Report', Comment = 'Generated from the PromotedActionCategories property index 2.';

                actionref(BackgroundStatement_Promoted; BackgroundStatement)
                {
                }
                actionref(Statement_Promoted; Statement)
                {
                }
                actionref("Customer - Order Summary_Promoted"; "Customer - Order Summary")
                {
                }
#if not CLEAN21
                actionref("Customer - Sales List_Promoted"; "Customer - Sales List")
                {
                    Visible = false;
                    ObsoleteState = Pending;
                    ObsoleteReason = 'Action is being demoted based on overall low usage.';
                    ObsoleteTag = '21.0';
                }
#endif
            }
            group(Category_Synchronize)
            {
                Caption = 'Synchronize';
                Visible = CRMIntegrationEnabled or CDSIntegrationEnabled;

                group(Category_Coupling)
                {
                    Caption = 'Coupling';
                    ShowAs = SplitButton;

                    actionref(ManageCRMCoupling_Promoted; ManageCRMCoupling)
                    {
                    }
                    actionref(DeleteCRMCoupling_Promoted; DeleteCRMCoupling)
                    {
                    }
                    actionref(MatchBasedCoupling_Promoted; MatchBasedCoupling)
                    {
                    }
                }
                actionref(CRMSynchronizeNow_Promoted; CRMSynchronizeNow)
                {
                }
                actionref(UpdateStatisticsInCRM_Promoted; UpdateStatisticsInCRM)
                {
                }
                actionref(CRMGotoAccount_Promoted; CRMGotoAccount)
                {
                }
                actionref(ShowLog_Promoted; ShowLog)
                {
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        Customer: Record Customer;
        CRMCouplingManagement: Codeunit "CRM Coupling Management";
        WorkflowWebhookManagement: Codeunit "Workflow Webhook Management";
    begin
        if CRMIntegrationEnabled or CDSIntegrationEnabled then
            CRMIsCoupledToRecord := CRMCouplingManagement.IsRecordCoupledToCRM(rec.RecordId);

        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(rec.RecordId);

        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(rec.RecordId);

        WorkflowWebhookManagement.GetCanRequestAndCanCancel(rec.RecordId, CanRequestApprovalForFlow, CanCancelApprovalForFlow);


        CurrPage.PowerBIEmbeddedReportPart.PAGE.SetCurrentListSelection(rec."No.");

        CurrPage.SetSelectionFilter(Customer);
        CanSendEmail := Customer.Count() = 1;
    end;

    trigger OnInit()
    begin
        CaptionTxt := CurrPage.Caption;
        //SetCaption(CaptionTxt);
        CurrPage.Caption(CaptionTxt);


        CurrPage.PowerBIEmbeddedReportPart.PAGE.InitPageRatio(PowerBIServiceMgt.GetFactboxRatio());
        CurrPage.PowerBIEmbeddedReportPart.PAGE.SetPageContext(CurrPage.ObjectId(false));

        SetWorkflowManagementEnabledState();
    end;

    trigger OnOpenPage()
    var
        IntegrationTableMapping: Record "Integration Table Mapping";
        CRMIntegrationManagement: Codeunit "CRM Integration Management";
        PriceCalculationMgt: Codeunit "Price Calculation Mgt.";
        OfficeManagement: Codeunit "Office Management";
    begin
        if companyinfo.Get() then begin
            if companyinfo.FBM_CustIsOp then
                ShowSites := true
            else
                ShowSites := false;
        end;
        CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled();
        CDSIntegrationEnabled := CRMIntegrationManagement.IsCDSIntegrationEnabled();
        if CRMIntegrationEnabled or CDSIntegrationEnabled then
            if IntegrationTableMapping.Get('CUSTOMER') then
                BlockedFilterApplied := IntegrationTableMapping.GetTableFilter().Contains('Field39=1(0)');

        ExtendedPriceEnabled := PriceCalculationMgt.IsExtendedPriceCalculationEnabled();
        Rec.SetRange("Date Filter", 0D, WorkDate());
        IsOfficeAddin := OfficeManagement.IsAvailable();

        SalesReceivablesSetup.GetRecordOnce();
        IsAllowMultiplePostingGroupsVisible := SalesReceivablesSetup."Allow Multiple Posting Groups";
    end;

    var
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        PowerBIServiceMgt: Codeunit "Power BI Service Mgt.";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";

        CanSendEmail: Boolean;
        ExtendedPriceEnabled: Boolean;
        CRMIntegrationEnabled: Boolean;
        CDSIntegrationEnabled: Boolean;
        CRMIsCoupledToRecord: Boolean;
        BlockedFilterApplied: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        showsites: Boolean;
        companyinfo: record "Company Information";
        CustomerSiteP: Page FBM_CustomerSite_JMCO;
        CustomerSite: Record FBM_CustomerSite_C;

#if not CLEAN21
        PowerBIVisible: Boolean;
#endif
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForFlow: Boolean;
        IsAllowMultiplePostingGroupsVisible: Boolean;
        IsOfficeAddin: Boolean;
        EventFilter: Text;
        CaptionTxt: Text;

        selcust: code[20];
        cust: record FBM_Customer;


    procedure GetSelectionFilter(): Text
    var
        Cust: Record Customer;
        SelectionFilterManagement: Codeunit SelectionFilterManagement;
    begin
        CurrPage.SetSelectionFilter(Cust);
        exit(SelectionFilterManagement.GetSelectionFilterForCustomer(Cust));
    end;

    procedure SetSelection(var Cust: Record Customer)
    begin
        CurrPage.SetSelectionFilter(Cust);
    end;

    local procedure SetWorkflowManagementEnabledState()
    var
        WorkflowManagement: Codeunit "Workflow Management";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        EventFilter := WorkflowEventHandling.RunWorkflowOnSendCustomerForApprovalCode() + '|' +
          WorkflowEventHandling.RunWorkflowOnCustomerChangedCode();

        EnabledApprovalWorkflowsExist := WorkflowManagement.EnabledWorkflowExist(DATABASE::Customer, EventFilter);
    end;

#if not CLEAN21
    [Obsolete('Replaced by the new implementation (V16) of price calculation.', '17.0')]
    local procedure ShowLineDiscounts()
    var
        SalesLineDiscount: Record "Sales Line Discount";
    begin
        SalesLineDiscount.SetCurrentKey("Sales Type", "Sales Code");
        SalesLineDiscount.SetRange("Sales Type", SalesLineDiscount."Sales Type"::Customer);
        SalesLineDiscount.SetRange("Sales Code", rec."No.");
        Page.Run(Page::"Sales Line Discounts", SalesLineDiscount);
    end;

    [Obsolete('Replaced by the new implementation (V16) of price calculation.', '17.0')]
    local procedure ShowPrices()
    var
        SalesPrice: Record "Sales Price";
    begin
        SalesPrice.SetCurrentKey("Sales Type", "Sales Code");
        SalesPrice.SetRange("Sales Type", SalesPrice."Sales Type"::Customer);
        SalesPrice.SetRange("Sales Code", rec."No.");
        Page.Run(Page::"Sales Prices", SalesPrice);
    end;
#endif

    [IntegrationEvent(false, false)]
    [Scope('OnPrem')]
    procedure SetCaption(var InText: Text)
    begin
    end;
}
