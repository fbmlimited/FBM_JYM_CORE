pageextension 60317 FBM_FACardExt_CO extends "Fixed Asset Card"
{
    layout
    {
        addlast(General)
        {

            field(siteloccode; siteloccode)
            {
                Caption = 'Site Loc. Code';
                ApplicationArea = all;

                Editable = false;
                ;
            }
            field(LastMovementSite; sitename)
            {
                Caption = 'Site Name';
                ApplicationArea = all;

                Editable = false;
                ;
            }
            field(custloccode; custloccode)
            {
                Caption = 'Cust. Loc. Code';
                ApplicationArea = all;

                Editable = false;
            }
            field(custname; custname)
            {
                Caption = 'Customer Name';
                ApplicationArea = all;

                Editable = false;
            }


        }
    }


    trigger
    OnAfterGetRecord()
    var


        cust: record Customer;

        csite: record FBM_CustomerSite_C;
        site: record FBM_Site;
    begin
        siteloccode := '';
        sitename := '';
        custname := '';

        csite.SetRange(ActiveRec, true);
        csite.SetRange(SiteGrCode, rec.FBM_Site);

        if csite.FindFirst() then begin
            custloccode := csite."Customer No.";

            cust.setrange("No.", csite."Customer No.");

            if cust.FindFirst() then
                custname := cust.Name;

            siteloccode := csite."Site Code";
        end;
        site.setrange("Site Code", rec.FBM_Site);
        site.SetRange(ActiveRec, true);
        if site.FindFirst() then
            sitename := site."Site Name";
        // end;


    end;

    var
        custloccode: code[20];

        custname: text[100];
        siteloccode: code[20];
        sitename: text[100];


}
