codeunit 60200 FBM_Fixes_JMCO
{
    Permissions = tabledata "Item Ledger Entry" = rimd;

    var
        Tempexcelbuffer: record "Excel Buffer" temporary;
        FileManagement: Codeunit "File Management";
        TempBlob: Codeunit "Temp Blob";

        SheetName, ErrorMessage : Text;
        FileInStream: InStream;
        ImportFileLbl: Label 'Import file';
        ile: record "Item Ledger Entry";
        rn: Integer;

    procedure move4fields()
    var
        cust: record Customer;
        csite: record FBM_CustomerSite_C;
    begin
        cust.FindFirst();
        repeat
            csite.Reset();
            csite.SetRange("Customer No.", cust."No.");
            csite.ModifyAll(FBM_CustomerType, cust.FBM_CustomerType);
            csite.ModifyAll(FBM_Operador, cust.FBM_Operador);
            csite.ModifyAll(FBM_OperadorC, cust.FBM_OperadorC);
            csite.ModifyAll(FBM_Administrador, cust.FBM_Administrador);
            csite.ModifyAll(FBM_AdministradorC, cust.FBM_AdministradorC);
            csite.ModifyAll(FBM_Permisionario, cust.FBM_Permisionario);
            csite.ModifyAll(FBM_PermisionarioC, cust.FBM_PermisionarioC);
        until cust.next = 0;
        message('done');

    end;

    procedure multicat()
    var
        item: record Item;
    begin
        if item.FindFirst() then
            repeat
                item.FBM_MultiCat := item."Item Category Code";
                item.Modify();
            until item.next = 0;
        message('done');
    end;

    procedure importped()

    begin
        FileManagement.BLOBImportWithFilter(TempBlob, ImportFileLbl, '', FileManagement.GetToFilterText('', '.xlsx'), 'xlsx');

        // Select sheet from the excel file
        TempBlob.CreateInStream(FileInStream);
        SheetName := TempExcelBuffer.SelectSheetsNameStream(FileInStream);

        // Open selected sheet
        TempBlob.CreateInStream(FileInStream);
        ErrorMessage := TempExcelBuffer.OpenBookStream(FileInStream, SheetName);
        if ErrorMessage <> '' then
            Error(ErrorMessage);

        TempExcelBuffer.ReadSheet();
        if TempExcelBuffer.FindSet() then
            repeat
                rn += 1;
                insertdata(rn);
            until TempExcelBuffer.Next() < 1;
    end;

    procedure GetValueAtCell(RowNo: Integer; ColNo: Integer): Text

    begin

        if Tempexcelbuffer.get(RowNo, ColNo) then
            exit(Tempexcelbuffer."Cell Value as Text");
    end;

    procedure insertdata(rowNo: Integer)
    var
        eno: integer;
    begin
        evaluate(eno, GetValueAtCell(rowNo, 1));
        ile.SetRange("Entry No.", eno);
        if ile.FindFirst() then begin
            ile.validate(FBM_Pedimento, GetValueAtCell(rowNo, 2));
            ile.validate(FBM_Pedimentobis, GetValueAtCell(rowNo, 3));
            ile.Modify();
        end;

    end;

    procedure refrcust()
    var
        cust: record FBM_Customer;
    begin
        cust.FindFirst();
        repeat
            cust.Validate(name, cust.Name + ';');
            cust.Modify();
            commit;
            cust.Validate(name, copystr(cust.name, 1, strlen(cust.name) - 1));
            cust.Modify(true);
            commit;
        until cust.Next() = 0;
        message('done');

    end;
}