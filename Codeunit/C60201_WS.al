codeunit 60201 FBM_WS
{
    trigger
    OnRun()
    begin
        GetCMaster();

        GetSMaster();

        GetSLocal();

        getFA();

        postFANew();
    end;

    local procedure GetCMaster()
    var
        Client: HttpClient;
        ResponseMessage: HttpResponseMessage;

        Url: Text;
        No: code[20];
        version: integer;
        custmast: record FBM_Customer;
        AuthString: Text;
        B64: codeunit "Base64 Convert";

        ArrayJSONManagement: Codeunit "JSON Management";
        JSONManagement: Codeunit "JSON Management";
        ObjectJSONManagement: Codeunit "JSON Management";
        i: Integer;
        CodeText: Text;
        CustomerJsonObject: Text;

        singlecust: Text;
        cust: Text;
        jsonarray: JsonArray;
        jsontext: text;


    begin
        AuthString := STRSUBSTNO('%1:%2', 'API.ACE', 'DBCAno845.95');

        AuthString := B64.ToBase64(AuthString);
        AuthString := STRSUBSTNO('Basic %1', AuthString);
        Client.DefaultRequestHeaders().Add('Authorization', AuthString);
        Url := 'https://dynamics-bc.com:2214/BC220/ODataV4/GetCustMasterMXWS/';
        if not client.Get(Url, responseMessage) then
            Error('The call to the web service failed.');
        if not ResponseMessage.IsSuccessStatusCode then
            Error('The web service returned an error message:\\' +
                    'Status code: %1\' +
                    'Description: %2',
                    ResponseMessage.HttpStatusCode,
                    ResponseMessage.ReasonPhrase);
        ResponseMessage.Content.ReadAs(JsonText);

        JSONManagement.InitializeObject(JsonText);

        if JSONManagement.GetArrayPropertyValueAsStringByName('value', CustomerJsonObject) then begin

            ArrayJSONManagement.InitializeCollection(CustomerJsonObject);

            for i := 0 to ArrayJSONManagement.GetCollectionCount() - 1 do begin
                ArrayJSONManagement.GetObjectFromCollectionByIndex(singlecust, i);
                ObjectJSONManagement.InitializeObject(singlecust);

                ObjectJSONManagement.GetStringPropertyValueByName('No', CodeText);
                No := CopyStr(CodeText, 1, MaxStrLen(custmast."No."));
                if no <> '' then begin
                    custmast.Reset();
                    custmast.SetRange(ActiveRec, true);
                    custmast.SetRange("No.", No);
                    if custmast.FindFirst() then begin
                        custmast.LastPropagated := Today;
                        custmast.Modify();
                        ObjectJSONManagement.GetStringPropertyValueByName('Version', CodeText);
                        if evaluate(version, CopyStr(CodeText, 1, MaxStrLen(format(custmast.Version)))) then
                            if version > custmast.Version then begin
                                custmast.Rename(No, version, true);

                                ObjectJSONManagement.GetStringPropertyValueByName('Name', CodeText);
                                custmast.name := CopyStr(CodeText, 1, MaxStrLen(custmast.Name));
                                ObjectJSONManagement.GetStringPropertyValueByName('Name2', CodeText);
                                custmast."Name 2" := CopyStr(CodeText, 1, MaxStrLen(custmast."Name 2"));
                                ObjectJSONManagement.GetStringPropertyValueByName('Address', CodeText);
                                custmast.Address := CopyStr(CodeText, 1, MaxStrLen(custmast.Address));
                                ObjectJSONManagement.GetStringPropertyValueByName('Address2', CodeText);
                                custmast."Address 2" := CopyStr(CodeText, 1, MaxStrLen(custmast."Address 2"));
                                ObjectJSONManagement.GetStringPropertyValueByName('City', CodeText);
                                custmast.City := CopyStr(CodeText, 1, MaxStrLen(custmast.City));
                                ObjectJSONManagement.GetStringPropertyValueByName('PostCode', CodeText);
                                custmast."Post Code" := CopyStr(CodeText, 1, MaxStrLen(custmast."Post Code"));
                                ObjectJSONManagement.GetStringPropertyValueByName('County', CodeText);
                                custmast.County := CopyStr(CodeText, 1, MaxStrLen(custmast.County));
                                ObjectJSONManagement.GetStringPropertyValueByName('CountryRegion', CodeText);
                                custmast."Country/Region Code" := CopyStr(CodeText, 1, MaxStrLen(custmast."Country/Region Code"));
                                ObjectJSONManagement.GetStringPropertyValueByName('VATRegistrationNo', CodeText);
                                custmast."VAT Registration No." := CopyStr(CodeText, 1, MaxStrLen(custmast."VAT Registration No."));
                                ObjectJSONManagement.GetStringPropertyValueByName('Group', CodeText);
                                custmast.FBM_Group := CopyStr(CodeText, 1, MaxStrLen(custmast.FBM_Group));
                                ObjectJSONManagement.GetStringPropertyValueByName('SubGroup', CodeText);
                                custmast.FBM_SubGroup := CopyStr(CodeText, 1, MaxStrLen(custmast.FBM_SubGroup));
                                ObjectJSONManagement.GetStringPropertyValueByName('Valid_From', CodeText);
                                evaluate(custmast."Valid From", CopyStr(CodeText, 1, MaxStrLen(format(custmast."Valid From"))));
                                ObjectJSONManagement.GetStringPropertyValueByName('Valid_To', CodeText);
                                evaluate(custmast."Valid To", CopyStr(CodeText, 1, MaxStrLen(format(custmast."Valid To"))));
                                ObjectJSONManagement.GetStringPropertyValueByName('Record_Owner', CodeText);
                                custmast."Record Owner" := CopyStr(CodeText, 1, MaxStrLen(custmast."Record Owner"));
                                ObjectJSONManagement.GetStringPropertyValueByName('Change_Note', CodeText);
                                custmast."Change Note" := CopyStr(CodeText, 1, MaxStrLen(custmast."Change Note"));

                                custmast.Modify(true);
                            end;
                    end
                    else begin
                        custmast.Init();
                        custmast."No." := No;
                        custmast.ActiveRec := true;
                        custmast.Version := version;
                        custmast.Insert();
                        custmast.LastPropagated := Today;
                        ObjectJSONManagement.GetStringPropertyValueByName('Name', CodeText);
                        custmast.name := CopyStr(CodeText, 1, MaxStrLen(custmast.Name));
                        ObjectJSONManagement.GetStringPropertyValueByName('Name2', CodeText);
                        custmast."Name 2" := CopyStr(CodeText, 1, MaxStrLen(custmast."Name 2"));
                        ObjectJSONManagement.GetStringPropertyValueByName('Address', CodeText);
                        custmast.Address := CopyStr(CodeText, 1, MaxStrLen(custmast.Address));
                        ObjectJSONManagement.GetStringPropertyValueByName('Address2', CodeText);
                        custmast."Address 2" := CopyStr(CodeText, 1, MaxStrLen(custmast."Address 2"));
                        ObjectJSONManagement.GetStringPropertyValueByName('City', CodeText);
                        custmast.City := CopyStr(CodeText, 1, MaxStrLen(custmast.City));
                        ObjectJSONManagement.GetStringPropertyValueByName('PostCode', CodeText);
                        custmast."Post Code" := CopyStr(CodeText, 1, MaxStrLen(custmast."Post Code"));
                        ObjectJSONManagement.GetStringPropertyValueByName('County', CodeText);
                        custmast.County := CopyStr(CodeText, 1, MaxStrLen(custmast.County));
                        ObjectJSONManagement.GetStringPropertyValueByName('CountryRegion', CodeText);
                        custmast."Country/Region Code" := CopyStr(CodeText, 1, MaxStrLen(custmast."Country/Region Code"));
                        ObjectJSONManagement.GetStringPropertyValueByName('VATRegistrationNo', CodeText);
                        custmast."VAT Registration No." := CopyStr(CodeText, 1, MaxStrLen(custmast."VAT Registration No."));
                        ObjectJSONManagement.GetStringPropertyValueByName('Group', CodeText);
                        custmast.FBM_Group := CopyStr(CodeText, 1, MaxStrLen(custmast.FBM_Group));
                        ObjectJSONManagement.GetStringPropertyValueByName('SubGroup', CodeText);
                        custmast.FBM_SubGroup := CopyStr(CodeText, 1, MaxStrLen(custmast.FBM_SubGroup));
                        ObjectJSONManagement.GetStringPropertyValueByName('Valid_From', CodeText);
                        evaluate(custmast."Valid From", CopyStr(CodeText, 1, MaxStrLen(format(custmast."Valid From"))));
                        ObjectJSONManagement.GetStringPropertyValueByName('Valid_To', CodeText);
                        evaluate(custmast."Valid To", CopyStr(CodeText, 1, MaxStrLen(format(custmast."Valid To"))));
                        ObjectJSONManagement.GetStringPropertyValueByName('Record_Owner', CodeText);
                        custmast."Record Owner" := CopyStr(CodeText, 1, MaxStrLen(custmast."Record Owner"));
                        ObjectJSONManagement.GetStringPropertyValueByName('Change_Note', CodeText);
                        custmast."Change Note" := CopyStr(CodeText, 1, MaxStrLen(custmast."Change Note"));
                        custmast.Modify();
                    end;
                end;

            end;
            custmast.Reset();
            custmast.SetFilter(LastPropagated, '=%1', 0D);

            custmast.DeleteAll();
            custmast.reset;
            custmast.ModifyAll(LastPropagated, 0D);
        end;
    end;

    local procedure GetSMaster()
    var
        Client: HttpClient;
        ResponseMessage: HttpResponseMessage;

        Url: Text;
        No: code[20];
        version: integer;
        sitemast: record FBM_Site;
        AuthString: Text;
        B64: codeunit "Base64 Convert";

        ArrayJSONManagement: Codeunit "JSON Management";
        JSONManagement: Codeunit "JSON Management";
        ObjectJSONManagement: Codeunit "JSON Management";
        i: Integer;
        CodeText: Text;
        SiteJsonObject: Text;

        singlesite: Text;
        site: Text;
        jsonarray: JsonArray;
        jsontext: text;


    begin
        AuthString := STRSUBSTNO('%1:%2', 'API.ACE', 'DBCAno845.95');

        AuthString := B64.ToBase64(AuthString);
        AuthString := STRSUBSTNO('Basic %1', AuthString);
        Client.DefaultRequestHeaders().Add('Authorization', AuthString);
        Url := 'https://dynamics-bc.com:2214/BC220/ODataV4/GetSiteMasterMXWS/';
        if not client.Get(Url, responseMessage) then
            Error('The call to the web service failed.');
        if not ResponseMessage.IsSuccessStatusCode then
            Error('The web service returned an error message:\\' +
                    'Status code: %1\' +
                    'Description: %2',
                    ResponseMessage.HttpStatusCode,
                    ResponseMessage.ReasonPhrase);
        ResponseMessage.Content.ReadAs(JsonText);

        JSONManagement.InitializeObject(JsonText);

        if JSONManagement.GetArrayPropertyValueAsStringByName('value', SiteJsonObject) then begin

            ArrayJSONManagement.InitializeCollection(SiteJsonObject);

            for i := 0 to ArrayJSONManagement.GetCollectionCount() - 1 do begin
                ArrayJSONManagement.GetObjectFromCollectionByIndex(singlesite, i);
                ObjectJSONManagement.InitializeObject(singlesite);

                ObjectJSONManagement.GetStringPropertyValueByName('SiteCode', CodeText);
                No := CopyStr(CodeText, 1, MaxStrLen(sitemast."Site Code"));
                if no <> '' then begin
                    sitemast.Reset();
                    sitemast.SetRange(ActiveRec, true);
                    sitemast.SetRange("Site Code", No);
                    if sitemast.FindFirst() then begin
                        sitemast.LastPropagated := Today;
                        sitemast.Modify();
                        ObjectJSONManagement.GetStringPropertyValueByName('Version', CodeText);
                        if evaluate(version, CopyStr(CodeText, 1, MaxStrLen(format(sitemast.Version)))) then
                            if version > sitemast.Version then begin
                                sitemast.Rename(No, version, true);

                                ObjectJSONManagement.GetStringPropertyValueByName('Name', CodeText);
                                sitemast."Site Name" := CopyStr(CodeText, 1, MaxStrLen(sitemast."Site Name"));
                                ObjectJSONManagement.GetStringPropertyValueByName('Name2', CodeText);
                                sitemast."Site Name 2" := CopyStr(CodeText, 1, MaxStrLen(sitemast."Site Name 2"));
                                ObjectJSONManagement.GetStringPropertyValueByName('Address', CodeText);
                                sitemast.Address := CopyStr(CodeText, 1, MaxStrLen(sitemast.Address));
                                ObjectJSONManagement.GetStringPropertyValueByName('Address2', CodeText);
                                sitemast."Address 2" := CopyStr(CodeText, 1, MaxStrLen(sitemast."Address 2"));
                                ObjectJSONManagement.GetStringPropertyValueByName('City', CodeText);
                                sitemast.City := CopyStr(CodeText, 1, MaxStrLen(sitemast.City));
                                ObjectJSONManagement.GetStringPropertyValueByName('PostCode', CodeText);
                                sitemast."Post Code" := CopyStr(CodeText, 1, MaxStrLen(sitemast."Post Code"));
                                ObjectJSONManagement.GetStringPropertyValueByName('County', CodeText);
                                sitemast.County := CopyStr(CodeText, 1, MaxStrLen(sitemast.County));
                                ObjectJSONManagement.GetStringPropertyValueByName('CountryRegion', CodeText);
                                sitemast."Country/Region Code" := CopyStr(CodeText, 1, MaxStrLen(sitemast."Country/Region Code"));
                                ObjectJSONManagement.GetStringPropertyValueByName('VATNumber', CodeText);
                                sitemast."Vat Number" := CopyStr(CodeText, 1, MaxStrLen(sitemast."Vat Number"));
                                ObjectJSONManagement.GetStringPropertyValueByName('Valid_From', CodeText);
                                evaluate(sitemast."Valid From", CopyStr(CodeText, 1, MaxStrLen(format(sitemast."Valid From"))));
                                ObjectJSONManagement.GetStringPropertyValueByName('Valid_To', CodeText);
                                evaluate(sitemast."Valid To", CopyStr(CodeText, 1, MaxStrLen(format(sitemast."Valid To"))));
                                ObjectJSONManagement.GetStringPropertyValueByName('Record_Owner', CodeText);
                                sitemast."Record Owner" := CopyStr(CodeText, 1, MaxStrLen(sitemast."Record Owner"));
                                ObjectJSONManagement.GetStringPropertyValueByName('Change_Note', CodeText);
                                sitemast."Change Note" := CopyStr(CodeText, 1, MaxStrLen(sitemast."Change Note"));

                                sitemast.Modify(true);
                            end;
                    end
                    else begin
                        sitemast.Init();
                        sitemast."Site Code" := No;
                        sitemast.ActiveRec := true;
                        sitemast.Version := version;
                        sitemast.Insert();
                        sitemast.LastPropagated := Today;
                        ObjectJSONManagement.GetStringPropertyValueByName('Name', CodeText);
                        sitemast."Site Name" := CopyStr(CodeText, 1, MaxStrLen(sitemast."Site Name"));
                        ObjectJSONManagement.GetStringPropertyValueByName('Name2', CodeText);
                        sitemast."Site Name 2" := CopyStr(CodeText, 1, MaxStrLen(sitemast."Site Name 2"));
                        ObjectJSONManagement.GetStringPropertyValueByName('Address', CodeText);
                        sitemast.Address := CopyStr(CodeText, 1, MaxStrLen(sitemast.Address));
                        ObjectJSONManagement.GetStringPropertyValueByName('Address2', CodeText);
                        sitemast."Address 2" := CopyStr(CodeText, 1, MaxStrLen(sitemast."Address 2"));
                        ObjectJSONManagement.GetStringPropertyValueByName('City', CodeText);
                        sitemast.City := CopyStr(CodeText, 1, MaxStrLen(sitemast.City));
                        ObjectJSONManagement.GetStringPropertyValueByName('PostCode', CodeText);
                        sitemast."Post Code" := CopyStr(CodeText, 1, MaxStrLen(sitemast."Post Code"));
                        ObjectJSONManagement.GetStringPropertyValueByName('County', CodeText);
                        sitemast.County := CopyStr(CodeText, 1, MaxStrLen(sitemast.County));
                        ObjectJSONManagement.GetStringPropertyValueByName('CountryRegion', CodeText);
                        sitemast."Country/Region Code" := CopyStr(CodeText, 1, MaxStrLen(sitemast."Country/Region Code"));
                        ObjectJSONManagement.GetStringPropertyValueByName('VATNumber', CodeText);
                        sitemast."Vat Number" := CopyStr(CodeText, 1, MaxStrLen(sitemast."Vat Number"));

                        ObjectJSONManagement.GetStringPropertyValueByName('Valid_From', CodeText);
                        evaluate(sitemast."Valid From", CopyStr(CodeText, 1, MaxStrLen(format(sitemast."Valid From"))));
                        ObjectJSONManagement.GetStringPropertyValueByName('Valid_To', CodeText);
                        evaluate(sitemast."Valid To", CopyStr(CodeText, 1, MaxStrLen(format(sitemast."Valid To"))));
                        ObjectJSONManagement.GetStringPropertyValueByName('Record_Owner', CodeText);
                        sitemast."Record Owner" := CopyStr(CodeText, 1, MaxStrLen(sitemast."Record Owner"));
                        ObjectJSONManagement.GetStringPropertyValueByName('Change_Note', CodeText);
                        sitemast."Change Note" := CopyStr(CodeText, 1, MaxStrLen(sitemast."Change Note"));
                        sitemast.Modify();
                    end;
                end;

            end;
            sitemast.Reset();
            sitemast.SetFilter(LastPropagated, '=%1', 0D);

            sitemast.DeleteAll();
            sitemast.reset;
            sitemast.ModifyAll(LastPropagated, 0D);
        end;
    end;

    local procedure GetSLocal()
    var
        Client: HttpClient;
        ResponseMessage: HttpResponseMessage;

        Url: Text;
        No: code[20];
        gcust: code[20];
        version: integer;
        siteloc: record FBM_CustomerSite_C;
        customer: record Customer;
        AuthString: Text;
        B64: codeunit "Base64 Convert";
        csite: record FBM_CustomerSite_C;
        maxnum: Integer;

        ArrayJSONManagement: Codeunit "JSON Management";
        JSONManagement: Codeunit "JSON Management";
        ObjectJSONManagement: Codeunit "JSON Management";
        i: Integer;
        CodeText: Text;
        SiteJsonObject: Text;

        singlesite: Text;
        site: Text;
        jsonarray: JsonArray;
        jsontext: text;


    begin
        AuthString := STRSUBSTNO('%1:%2', 'API.ACE', 'DBCAno845.95');

        AuthString := B64.ToBase64(AuthString);
        AuthString := STRSUBSTNO('Basic %1', AuthString);
        Client.DefaultRequestHeaders().Add('Authorization', AuthString);
        Url := 'https://dynamics-bc.com:2214/BC220/ODataV4/GetSiteLocMXWS/';
        if not client.Get(Url, responseMessage) then
            Error('The call to the web service failed.');
        if not ResponseMessage.IsSuccessStatusCode then
            Error('The web service returned an error message:\\' +
                    'Status code: %1\' +
                    'Description: %2',
                    ResponseMessage.HttpStatusCode,
                    ResponseMessage.ReasonPhrase);
        ResponseMessage.Content.ReadAs(JsonText);

        JSONManagement.InitializeObject(JsonText);

        if JSONManagement.GetArrayPropertyValueAsStringByName('value', SiteJsonObject) then begin

            ArrayJSONManagement.InitializeCollection(SiteJsonObject);

            for i := 0 to ArrayJSONManagement.GetCollectionCount() - 1 do begin
                ArrayJSONManagement.GetObjectFromCollectionByIndex(singlesite, i);
                ObjectJSONManagement.InitializeObject(singlesite);

                ObjectJSONManagement.GetStringPropertyValueByName('SiteGrCode', CodeText);
                No := CopyStr(CodeText, 1, MaxStrLen(siteloc.SiteGrCode));
                ObjectJSONManagement.GetStringPropertyValueByName('gcust', CodeText);
                gcust := CopyStr(CodeText, 1, MaxStrLen(siteloc."Customer No."));
                if (no <> '') and (gcust <> '') then begin
                    siteloc.ChangeCompany('Juegos y Maquinaria');
                    siteloc.Reset();
                    siteloc.SetRange(ActiveRec, true);
                    siteloc.SetFilter(Status, '<>%1', siteloc.Status::"STOP OPERATION");
                    siteloc.SetRange(SiteGrCode, No);
                    customer.ChangeCompany('Juegos y Maquinaria');
                    customer.SetRange(FBM_GrCode, gcust);
                    if customer.FindFirst() then
                        siteloc.setrange("Customer No.", customer."No.");
                    if siteloc.FindFirst() then begin
                        siteloc.LastPropagated := Today;
                        siteloc.Modify();
                        ObjectJSONManagement.GetStringPropertyValueByName('Version', CodeText);
                        if evaluate(version, CopyStr(CodeText, 1, MaxStrLen(format(siteloc.Version)))) then
                            if version > siteloc.Version then begin
                                siteloc.Rename(customer."No.", siteloc."Site Code", version, true);

                                ObjectJSONManagement.GetStringPropertyValueByName('Status', CodeText);
                                evaluate(siteloc.Status, CopyStr(CodeText, 1, MaxStrLen(format(siteloc.Status.AsInteger()))));
                                ObjectJSONManagement.GetStringPropertyValueByName('Contract', CodeText);
                                siteloc."Contract Code" := CopyStr(CodeText, 1, MaxStrLen(siteloc."Contract Code"));
                                ObjectJSONManagement.GetStringPropertyValueByName('Contract2', CodeText);
                                siteloc."Contract Code2" := CopyStr(CodeText, 1, MaxStrLen(siteloc."Contract Code2"));
                                ObjectJSONManagement.GetStringPropertyValueByName('Contact', CodeText);
                                siteloc.Contact := CopyStr(CodeText, 1, MaxStrLen(siteloc.Contact));
                                ObjectJSONManagement.GetStringPropertyValueByName('vatnumber', CodeText);
                                siteloc."Vat Number" := CopyStr(CodeText, 1, MaxStrLen(siteloc."Vat Number"));

                                ObjectJSONManagement.GetStringPropertyValueByName('Valid_From', CodeText);
                                evaluate(siteloc."Valid From", CopyStr(CodeText, 1, MaxStrLen(format(siteloc."Valid From"))));
                                ObjectJSONManagement.GetStringPropertyValueByName('Valid_To', CodeText);
                                evaluate(siteloc."Valid To", CopyStr(CodeText, 1, MaxStrLen(format(siteloc."Valid To"))));
                                ObjectJSONManagement.GetStringPropertyValueByName('Record_Owner', CodeText);
                                siteloc."Record Owner" := CopyStr(CodeText, 1, MaxStrLen(siteloc."Record Owner"));
                                ObjectJSONManagement.GetStringPropertyValueByName('Change_Note', CodeText);
                                siteloc."Change Note" := CopyStr(CodeText, 1, MaxStrLen(siteloc."Change Note"));

                                siteloc.Modify(true);
                            end;
                    end
                    else begin

                        siteloc.SiteGrCode := No;
                        customer.SetRange(FBM_GrCode, gcust);
                        if customer.FindFirst() then begin
                            siteloc."Customer No." := customer."No.";
                            csite.ChangeCompany('Juegos y Maquinaria');
                            csite.Reset();
                            csite.setrange("Customer No.", customer."No.");
                            if csite.FindLast() then
                                if strpos(csite."Site Code", '-') > 0 then
                                    evaluate(maxnum, copystr(csite."Site Code", strpos(csite."Site Code", '-') + 1))
                                else
                                    maxnum := 0
                            else
                                maxnum := 0;
                            //rec.Rename(rec."Customer No.", rec."Customer No." + '-' + PADSTR('', 4 - strlen(FORMAT(MAXNUM + 1)), '0') + FORMAT(MAXNUM + 1));
                            siteloc."Site Code" := siteloc."Customer No." + '-' + PADSTR('', 4 - strlen(FORMAT(MAXNUM + 1)), '0') + FORMAT(MAXNUM + 1);

                        end;

                        siteloc.ActiveRec := true;
                        siteloc.Version := version;
                        siteloc.Insert();
                        siteloc.LastPropagated := Today;
                        ObjectJSONManagement.GetStringPropertyValueByName('Status', CodeText);
                        evaluate(siteloc.Status, CopyStr(CodeText, 1, MaxStrLen(format(siteloc.Status.AsInteger()))));
                        ObjectJSONManagement.GetStringPropertyValueByName('Contract', CodeText);
                        siteloc."Contract Code" := CopyStr(CodeText, 1, MaxStrLen(siteloc."Contract Code"));
                        ObjectJSONManagement.GetStringPropertyValueByName('Contract2', CodeText);
                        siteloc."Contract Code2" := CopyStr(CodeText, 1, MaxStrLen(siteloc."Contract Code2"));
                        ObjectJSONManagement.GetStringPropertyValueByName('Contact', CodeText);
                        siteloc.Contact := CopyStr(CodeText, 1, MaxStrLen(siteloc.Contact));
                        ObjectJSONManagement.GetStringPropertyValueByName('vatnumber', CodeText);
                        siteloc."Vat Number" := CopyStr(CodeText, 1, MaxStrLen(siteloc."Vat Number"));

                        ObjectJSONManagement.GetStringPropertyValueByName('Valid_From', CodeText);
                        evaluate(siteloc."Valid From", CopyStr(CodeText, 1, MaxStrLen(format(siteloc."Valid From"))));
                        ObjectJSONManagement.GetStringPropertyValueByName('Valid_To', CodeText);
                        evaluate(siteloc."Valid To", CopyStr(CodeText, 1, MaxStrLen(format(siteloc."Valid To"))));
                        ObjectJSONManagement.GetStringPropertyValueByName('Record_Owner', CodeText);
                        siteloc."Record Owner" := CopyStr(CodeText, 1, MaxStrLen(siteloc."Record Owner"));
                        ObjectJSONManagement.GetStringPropertyValueByName('Change_Note', CodeText);
                        siteloc."Change Note" := CopyStr(CodeText, 1, MaxStrLen(siteloc."Change Note"));

                        IF siteloc.Modify() THEN BEGIN END;
                    end;
                end;

            end;
            siteloc.Reset();
            siteloc.SetFilter(LastPropagated, '=%1', 0D);

            siteloc.DeleteAll();
            siteloc.reset;
            siteloc.ModifyAll(LastPropagated, 0D);
        end;
    end;

    local procedure GetFA()
    var
        Client: HttpClient;
        ResponseMessage: HttpResponseMessage;

        Url: Text;
        No: code[20];
        version: integer;
        fa: record "Fixed Asset";
        AuthString: Text;
        B64: codeunit "Base64 Convert";

        ArrayJSONManagement: Codeunit "JSON Management";
        JSONManagement: Codeunit "JSON Management";
        ObjectJSONManagement: Codeunit "JSON Management";
        i: Integer;
        CodeText: Text;
        CustomerJsonObject: Text;

        singlecust: Text;
        cust: Text;
        jsonarray: JsonArray;
        jsontext: text;
        cname: text;


    begin
        cname := CompanyName;
        if cname = 'FBM MEX' THEN BEGIN
            AuthString := STRSUBSTNO('%1:%2', 'API.ACE', 'DBCAno845.95');

            AuthString := B64.ToBase64(AuthString);
            AuthString := STRSUBSTNO('Basic %1', AuthString);
            Client.DefaultRequestHeaders().Add('Authorization', AuthString);
            Url := 'https://dynamics-bc.com:2214/BC220/ODataV4/GetFAMXWS/';
            if not client.Get(Url, responseMessage) then
                Error('The call to the web service failed.');
            if not ResponseMessage.IsSuccessStatusCode then
                Error('The web service returned an error message:\\' +
                        'Status code: %1\' +
                        'Description: %2',
                        ResponseMessage.HttpStatusCode,
                        ResponseMessage.ReasonPhrase);
            ResponseMessage.Content.ReadAs(JsonText);

            JSONManagement.InitializeObject(JsonText);

            if JSONManagement.GetArrayPropertyValueAsStringByName('value', CustomerJsonObject) then begin

                ArrayJSONManagement.InitializeCollection(CustomerJsonObject);

                for i := 0 to ArrayJSONManagement.GetCollectionCount() - 1 do begin
                    ArrayJSONManagement.GetObjectFromCollectionByIndex(singlecust, i);
                    ObjectJSONManagement.InitializeObject(singlecust);

                    ObjectJSONManagement.GetStringPropertyValueByName('No', CodeText);
                    No := CopyStr(CodeText, 1, MaxStrLen(fa."No."));
                    if no <> '' then begin
                        fa.Reset();

                        fa.SetRange("No.", No);
                        if fa.FindFirst() then begin
                            fa.LastPropagated := Today;
                            fa.Modify();
                            ObjectJSONManagement.GetStringPropertyValueByName('Version', CodeText);
                            if evaluate(version, CopyStr(CodeText, 1, MaxStrLen(format(fa.Version)))) then
                                if version > fa.Version then begin
                                    fa.version := version;

                                    ObjectJSONManagement.GetStringPropertyValueByName('SerialNo', CodeText);
                                    fa."Serial No." := CopyStr(CodeText, 1, MaxStrLen(fa."Serial No."));
                                    ObjectJSONManagement.GetStringPropertyValueByName('Description', CodeText);
                                    fa.Description := CopyStr(CodeText, 1, MaxStrLen(fa.Description));
                                    ObjectJSONManagement.GetStringPropertyValueByName('FAClassCode', CodeText);
                                    fa."FA Class Code" := CopyStr(CodeText, 1, MaxStrLen(fa."FA Class Code"));
                                    ObjectJSONManagement.GetStringPropertyValueByName('FASubclassCode', CodeText);
                                    fa."FA Subclass Code" := CopyStr(CodeText, 1, MaxStrLen(fa."FA Subclass Code"));
                                    ObjectJSONManagement.GetStringPropertyValueByName('FALocationcode', CodeText);
                                    fa."FA Location Code" := CopyStr(CodeText, 1, MaxStrLen(fa."FA Location Code"));
                                    ObjectJSONManagement.GetStringPropertyValueByName('Model', CodeText);
                                    fa.FBM_Model := CopyStr(CodeText, 1, MaxStrLen(fa.FBM_Model));
                                    ObjectJSONManagement.GetStringPropertyValueByName('Segment', CodeText);
                                    evaluate(fa.FBM_Segment2, CopyStr(CodeText, 1, MaxStrLen(format(fa.FBM_Segment2.AsInteger()))));
                                    ObjectJSONManagement.GetStringPropertyValueByName('Brand', CodeText);
                                    evaluate(fa.FBM_Brand, CopyStr(CodeText, 1, MaxStrLen(format(fa.FBM_Brand))));
                                    ObjectJSONManagement.GetStringPropertyValueByName('Lessee', CodeText);
                                    fa.FBM_Lessee := CopyStr(CodeText, 1, MaxStrLen(fa.FBM_Lessee));
                                    ObjectJSONManagement.GetStringPropertyValueByName('Site', CodeText);
                                    fa.FBM_Site := CopyStr(CodeText, 1, MaxStrLen(fa.FBM_Site));
                                    ObjectJSONManagement.GetStringPropertyValueByName('Status', CodeText);
                                    evaluate(fa.FBM_Status, CopyStr(CodeText, 1, MaxStrLen(format(fa.FBM_Status.AsInteger()))));
                                    ObjectJSONManagement.GetStringPropertyValueByName('DAtePrepared', CodeText);
                                    evaluate(fa.FBM_DatePrepared, CopyStr(CodeText, 1, MaxStrLen(format(fa.FBM_DatePrepared))));
                                    ObjectJSONManagement.GetStringPropertyValueByName('AcqCost', CodeText);
                                    evaluate(fa.FBM_AcquisitionCost, CopyStr(CodeText, 1, MaxStrLen(format(fa.FBM_AcquisitionCost))));
                                    ObjectJSONManagement.GetStringPropertyValueByName('Acqdate', CodeText);
                                    evaluate(fa.FBM_AcquisitionDate, CopyStr(CodeText, 1, MaxStrLen(format(fa.FBM_AcquisitionDate))));
                                    ObjectJSONManagement.GetStringPropertyValueByName('Deprdate', CodeText);
                                    evaluate(fa.FBM_DepreciationDate, CopyStr(CodeText, 1, MaxStrLen(format(fa.FBM_DepreciationDate))));
                                    fa.Modify(true);
                                end;
                        end
                        else begin
                            fa.Init();
                            fa."No." := No;
                            fa.ActiveRec := true;
                            fa.Version := version;
                            fa.Insert();
                            fa.LastPropagated := Today;
                            ObjectJSONManagement.GetStringPropertyValueByName('SerialNo', CodeText);
                            fa."Serial No." := CopyStr(CodeText, 1, MaxStrLen(fa."Serial No."));
                            ObjectJSONManagement.GetStringPropertyValueByName('Description', CodeText);
                            fa.Description := CopyStr(CodeText, 1, MaxStrLen(fa.Description));
                            ObjectJSONManagement.GetStringPropertyValueByName('FAClassCode', CodeText);
                            fa."FA Class Code" := CopyStr(CodeText, 1, MaxStrLen(fa."FA Class Code"));
                            ObjectJSONManagement.GetStringPropertyValueByName('FASubclassCode', CodeText);
                            fa."FA Subclass Code" := CopyStr(CodeText, 1, MaxStrLen(fa."FA Subclass Code"));
                            ObjectJSONManagement.GetStringPropertyValueByName('FALocationcode', CodeText);
                            fa."FA Location Code" := CopyStr(CodeText, 1, MaxStrLen(fa."FA Location Code"));
                            ObjectJSONManagement.GetStringPropertyValueByName('Model', CodeText);
                            fa.FBM_Model := CopyStr(CodeText, 1, MaxStrLen(fa.FBM_Model));
                            ObjectJSONManagement.GetStringPropertyValueByName('Segment', CodeText);
                            evaluate(fa.FBM_Segment2, CopyStr(CodeText, 1, MaxStrLen(format(fa.FBM_Segment2.AsInteger()))));
                            ObjectJSONManagement.GetStringPropertyValueByName('Brand', CodeText);
                            evaluate(fa.FBM_Brand, CopyStr(CodeText, 1, MaxStrLen(format(fa.FBM_Brand))));
                            ObjectJSONManagement.GetStringPropertyValueByName('Lessee', CodeText);
                            fa.FBM_Lessee := CopyStr(CodeText, 1, MaxStrLen(fa.FBM_Lessee));
                            ObjectJSONManagement.GetStringPropertyValueByName('Site', CodeText);
                            fa.FBM_Site := CopyStr(CodeText, 1, MaxStrLen(fa.FBM_Site));
                            ObjectJSONManagement.GetStringPropertyValueByName('Status', CodeText);
                            evaluate(fa.FBM_Status, CopyStr(CodeText, 1, MaxStrLen(format(fa.FBM_Status.AsInteger()))));
                            ObjectJSONManagement.GetStringPropertyValueByName('DAtePrepared', CodeText);
                            evaluate(fa.FBM_DatePrepared, CopyStr(CodeText, 1, MaxStrLen(format(fa.FBM_DatePrepared))));
                            ObjectJSONManagement.GetStringPropertyValueByName('AcqCost', CodeText);
                            evaluate(fa.FBM_AcquisitionCost, CopyStr(CodeText, 1, 20));
                            ObjectJSONManagement.GetStringPropertyValueByName('Acqdate', CodeText);
                            evaluate(fa.FBM_AcquisitionDate, CopyStr(CodeText, 1, MaxStrLen(format(fa.FBM_AcquisitionDate))));
                            ObjectJSONManagement.GetStringPropertyValueByName('Deprdate', CodeText);
                            evaluate(fa.FBM_DepreciationDate, CopyStr(CodeText, 1, MaxStrLen(format(fa.FBM_DepreciationDate))));
                            fa.Modify();
                        end;
                    end;

                end;
                fa.Reset();
                fa.SetFilter(LastPropagated, '=%1', 0D);
                fa.SetFilter(FBM_ReplicaStatus2, '<>%1', fa.FBM_ReplicaStatus2::Pending);

                fa.DeleteAll();
                fa.reset;
                fa.ModifyAll(LastPropagated, 0D);
            end;
        END;
    end;

    local procedure postFANew()
    var
        httpclient: HttpClient;
        requestmessage: HttpRequestMessage;
        httpresponemessage: HttpResponseMessage;
        url: label 'https://dynamics-bc.com:2214/BC220/ODataV4/PostFANewWS/';
        response: Text;
        content: HttpContent;
        HeaderJsonObject: JsonObject;
        JsonArray: JsonArray;
        fa: record "Fixed Asset";
        text: text[2048];
        NewJsonObject: JsonObject;
        AuthString: Text;
        B64: codeunit "Base64 Convert";
        HttpHeadersContent: HttpHeaders;



    begin
        fa.setrange(FBM_ReplicaStatus2, fa.FBM_ReplicaStatus2::Pending);
        fa.SetFilter("No.", '%1', 'AF*');
        fa.SetRange("FA Subclass Code", 'EGM_MX');
        fa.SetRange(FBM_IsLocalRec, false);
        if fa.findset(true) then
            repeat

                clear(HeaderJsonObject);
                HeaderJsonObject.add('No', fa."No.");
                HeaderJsonObject.add('SerialNo', fa."Serial No.");
                HeaderJsonObject.add('Description', fa.Description);
                HeaderJsonObject.add('FAClassCode', fa."FA Class Code");
                HeaderJsonObject.add('FASubclassCode', fa."FA Subclass Code");
                //HeaderJsonObject.add('ReplicaStatus', format(fa.FBM_ReplicaStatus::Sent));
                JsonArray.add(HeaderJsonObject);
                fa.FBM_ReplicaStatus2 := fa.FBM_ReplicaStatus2::Sent;
                fa.Modify();
            until fa.Next() = 0;
        NewJsonObject.add('', JsonArray);
        NewJsonObject.WriteTo(text);
        // Content.GetHeaders(HttpHeadersContent);

        // HttpHeadersContent.Remove('Content-Type');

        // HttpHeadersContent.Add('Content-Type', 'application/json');

        Content.GetHeaders(HttpHeadersContent);

        if HttpHeadersContent.Contains('Content-Type') then HttpHeadersContent.Remove('Content-Type');
        HttpHeadersContent.Add('Content-Type', 'application/json');

        if HttpHeadersContent.Contains('Content-Encoding') then HttpHeadersContent.Remove('Content-Encoding');
        HttpHeadersContent.Add('Content-Encoding', 'UTF8');

        //Content.GetHeaders(HttpHeadersContent);
        // Content.GetHeaders(HttpHeadersContent);
        // HttpHeadersContent.Clear();
        // HttpHeadersContent.Add('Content-Type', 'application/json');
        content.WriteFrom(text);
        requestmessage.Content(content);
        AuthString := STRSUBSTNO('%1:%2', 'API.ACE', 'DBCAno845.95');

        AuthString := B64.ToBase64(AuthString);
        AuthString := STRSUBSTNO('Basic %1', AuthString);
        httpClient.DefaultRequestHeaders().Add('Authorization', AuthString);
        //httpresponemessage.Content.GetHeaders(HttpHeadersContent);//added
        if httpclient.Post(url, content, httpresponemessage) then begin
            httpresponemessage.Content().ReadAs(response);
            if httpresponemessage.IsSuccessStatusCode then begin
                message(response);
            end;

        end;

    end;


}