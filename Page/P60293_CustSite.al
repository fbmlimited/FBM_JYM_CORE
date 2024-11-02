page 60293 FBM_CustSite_JMCO
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = FBM_CustomerSite_C;
    caption = 'Customer/Site';
    SourceTableTemporary = false;


    layout
    {
        area(Content)
        {
            group(Selection)
            {

                field(selsite; selsite)
                {
                    caption = 'Select New Site';
                    ApplicationArea = all;
                    trigger
                    OnLookup(var Text: Text): Boolean
                    var
                        compinfo: record "Company Information";
                        csite: record FBM_CustomerSite_C;
                        maxnum: Integer;
                    begin
                        clear(site);
                        compinfo.get;
                        site.SetRange(Company1, compinfo."Custom System Indicator Text");
                        if site.findfirst then
                            repeat
                                csite.setrange(sitegrcode, site."Site Code");
                                if csite.IsEmpty then
                                    site.Mark(true)
                                else
                                    site.mark(false);
                            until site.Next() = 0;

                        site.setrange(Company1);
                        site.SetRange(Company2, compinfo."Custom System Indicator Text");
                        if site.findfirst then
                            repeat
                                csite.setrange(sitegrcode, site."Site Code");
                                if csite.IsEmpty then
                                    site.Mark(true)
                                else
                                    site.mark(false);
                            until site.Next() = 0;
                        site.SetRange(Company2);
                        site.SetRange(Company3, compinfo."Custom System Indicator Text");
                        if site.findfirst then
                            repeat
                                csite.setrange(sitegrcode, site."Site Code");
                                if csite.IsEmpty then
                                    site.Mark(true)
                                else
                                    site.mark(false);
                            until site.Next() = 0;
                        site.setrange(Company1);
                        site.SetRange(Company2);
                        site.SetRange(Company3);
                        site.MarkedOnly(true);

                        if page.RunModal(page::FBM_SiteLookup_JMCO, site) = action::LookupOK then begin
                            selsite := site."Site Code";
                            if rec.SiteGrCode = '' then begin
                                rec.SiteGrCode := site."Site Code";
                                csite.Reset();
                                csite.setrange("Customer No.", rec."Customer No.");
                                if csite.FindLast() then
                                    if strpos(csite."Site Code", '-') > 0 then
                                        evaluate(maxnum, copystr(csite."Site Code", strpos(csite."Site Code", '-') + 1))
                                    else
                                        maxnum := 0
                                else
                                    maxnum := 0;
                                //rec.Rename(rec."Customer No.", rec."Customer No." + '-' + PADSTR('', 4 - strlen(FORMAT(MAXNUM + 1)), '0') + FORMAT(MAXNUM + 1));
                                rec."Site Code" := rec."Customer No." + '-' + PADSTR('', 4 - strlen(FORMAT(MAXNUM + 1)), '0') + FORMAT(MAXNUM + 1);

                            end;
                        end;
                    end;
                }
            }
            repeater(GroupName)
            {
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

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Caption = 'Status';
                    Editable = issuper;
                }
                field("Site Name"; rec."Site Name_FF")
                {
                    ApplicationArea = All;
                    Caption = 'Site Name';
                }
                field(Address; rec.Address_FF)
                {
                    ApplicationArea = All;
                }
                field("Address 2"; rec."Address 2_FF")
                {
                    ApplicationArea = All;
                }
                field(City; rec.City_FF)
                {
                    ApplicationArea = All;
                }
                field("Post Code"; rec."Post Code_FF")
                {
                    ApplicationArea = All;
                }
                field("Country/Region Code"; rec."Country/Region Code_FF")
                {
                    ApplicationArea = All;
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
                field(FBM_CustomerType; Rec.FBM_CustomerType)
                {
                    ApplicationArea = all;
                    Editable = false;

                    trigger
                                        OnValidate()
                    begin
                        ufield();
                    end;
                }
                field(FBM_Permisionario; Rec.FBM_Permisionario)

                {
                    //enabled = showP;
                    ApplicationArea = all;

                }
                field(FBM_Operador; Rec.FBM_Operador)
                {
                    //enabled = showO;
                    ApplicationArea = all;

                }
                field(FBM_Administrador; Rec.FBM_Administrador)
                {
                    ApplicationArea = all;
                    //Enabled = showA;
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
            action(sol)
            {
                ApplicationArea = All;
                Image = SendApprovalRequest;

                caption = 'Change Request';

                trigger OnAction()
                var
                    req: record FBM_CustSiteReq;
                    reqpage: page FBM_SiteChangeReq_DD;
                begin
                    reqpage.passpar(rec.SiteGrCode, true);
                    req.Init();
                    req.ReqType := req.ReqType::Edit;
                    req.CustSiteCode := rec.SiteGrCode;
                    req.Rectype := 'SITE';
                    req.Insert();
                    commit;
                    reqpage.SetTableView(req);
                    reqpage.Runmodal();
                    clear(reqpage);
                end;
            }
            action(History)
            {
                ApplicationArea = All;
                Image = History;

                caption = 'History';

                trigger OnAction()
                var

                    hpage: page FBM_CustSiteHist_JMCO;
                begin
                    hpage.passpar(rec."Customer No.", rec."Site Code");


                    hpage.Run();
                    clear(hpage);
                end;
            }


        }
    }


    trigger
    OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        ufield();
    end;

    trigger
    OnAfterGetRecord()
    begin
        compinfo.get;
        EnableSpin := compinfo.FBM_EnSpin;
        cust.get(rec."Customer No.");
        existrec := rec."Site Code" <> '';
        //visfield();
    end;

    trigger
   OnModifyRecord(): Boolean
    var
        csite: record FBM_CustomerSite_C;
        pcsite: page FBM_CustomerSite_JMCO;




    begin
        commit;
        csite.SetRange("Customer No.", rec."Customer No.");
        csite.SetRange("Site Code", rec."Site Code");

        if csite.FindLast() then begin
            if rec.SiteGrCode <> xrec.SiteGrCode then
                csite.validate(SiteGrCode, rec.SiteGrCode);
            if rec.Status <> xrec.Status then
                csite.validate(Status, rec.Status);
            if rec.Contact <> xrec.Contact then
                csite.validate(Contact, rec.Contact);
            if rec."Contract Code" <> xrec."Contract Code" then
                csite.validate("Contract Code", rec."Contract Code");
            if rec."Contract Code2" <> xrec."Contract Code2" then
                csite.validate("Contract Code2", rec."Contract Code2");
            if rec."Vat Number" <> xrec."Vat Number" then
                csite.validate("Vat Number", rec."Vat Number");
            if rec.FBM_CustomerType <> xrec.FBM_CustomerType then
                csite.validate(FBM_CustomerType, rec.FBM_CustomerType);
            if rec.FBM_Administrador <> xrec.FBM_Administrador then
                csite.validate(FBM_Administrador, rec.FBM_Administrador);
            if rec.FBM_Operador <> xrec.FBM_Operador then
                csite.validate(FBM_Operador, rec.FBM_Operador);
            if rec.FBM_Permisionario <> xrec.FBM_Permisionario then
                csite.validate(FBM_Permisionario, rec.FBM_Permisionario);
            csite.SetRange("Customer No.", rec."Customer No.");
            csite.SetRange("Site Code", rec."Site Code");


            if csite.FindLast() then begin
                csite.SiteGrCode := rec.SiteGrCode;
                csite.Status := rec.Status;
                csite.Contact := rec.Contact;
                csite."Contract Code" := rec."Contract Code";
                csite."Contract Code2" := rec."Contract Code2";
                csite."Vat Number" := rec."Vat Number";
                csite.FBM_CustomerType := rec.FBM_CustomerType;
                csite.FBM_Administrador := rec.FBM_Administrador;
                csite.FBM_Operador := rec.FBM_Operador;
                csite.FBM_Permisionario := rec.FBM_Permisionario;
                csite.Modify(true);

            end;

        end;
    end;

    var
        DimensionValue: Record "Dimension Value";
        FASetup: Record "FA Setup";
        EnableSpin: Boolean;
        compinfo: record "Company Information";
        selsite: code[20];
        site: record FBM_Site;
        uper: codeunit "User Permissions";
        issuper: boolean;
        showP: Boolean;
        showO: Boolean;
        showA: Boolean;
        cust: record Customer;
        pcust: code[20];
        existrec: Boolean;

    procedure passpar(cust: code[20])
    begin
        pcust := cust;
    end;

    procedure visfield()
    begin
        Case rec.FBM_CustomerType of
            rec.FBM_CustomerType::Permisionario:
                begin
                    showP := true;
                    showO := false;
                    showA := false;

                end;
            rec.FBM_CustomerType::Operador:
                begin
                    showP := true;
                    showO := true;
                    showA := false;


                end;
            rec.FBM_CustomerType::Administrador:
                begin
                    showP := true;
                    showO := true;
                    showA := true;

                end;


        End;
    end;

    procedure ufield()
    begin
        cust.get(rec."Customer No.");
        Case rec.FBM_CustomerType of
            rec.FBM_CustomerType::Permisionario:
                begin
                    showP := true;
                    showO := false;
                    showA := false;
                    rec.FBM_Administrador := '';
                    rec.FBM_Operador := '';
                    rec.FBM_AdministradorC := '';
                    rec.FBM_OperadorC := '';
                    rec.FBM_Permisionario := cust.Name;
                    rec.FBM_PermisionarioC := rec."Customer No.";

                end;
            rec.FBM_CustomerType::Operador:
                begin
                    showP := true;
                    showO := true;
                    showA := false;
                    rec.FBM_Administrador := '';
                    rec.FBM_AdministradorC := '';
                    rec.FBM_Operador := cust.Name;
                    rec.FBM_OperadorC := rec."Customer No.";
                    rec.FBM_Permisionario := '';
                    rec.FBM_PermisionarioC := '';

                end;
            rec.FBM_CustomerType::Administrador:
                begin
                    showP := true;
                    showO := true;
                    showA := true;
                    rec.FBM_Administrador := cust.Name;
                    rec.FBM_AdministradorC := rec."Customer No.";
                    rec.FBM_Operador := '';
                    rec.FBM_Permisionario := '';
                    rec.FBM_OperadorC := '';
                    rec.FBM_PermisionarioC := '';
                end;


        End;
    end;
}
