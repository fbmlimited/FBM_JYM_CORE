page 60201 FBM_CustomerSite_JMCO
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = FBM_CustomerSite_C;
    caption = 'Customer/Site';


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
    }
    trigger
    OnOpenPage()
    begin
        issuper := uper.IsSuper(UserSecurityId());

    end;

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
        //visfield();
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
