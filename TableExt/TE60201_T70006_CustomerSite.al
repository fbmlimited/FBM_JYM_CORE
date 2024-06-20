tableextension 60201 FBM_CustomerSiteExt_JCM_CO extends FBM_CustomerSite_C
{
    fields
    {
        field(60200; FBM_CustomerType; enum FBM_CustType_JYM_CO)
        {
            Caption = 'Tipo Cliente';

        }
        field(60201; FBM_Permisionario; text[100])
        {
            Caption = 'Permisionario';
            TableRelation = FBM_Partner_JYM_CO.Name where(Type = const(FBM_CustType_JYM_CO::Permisionario));
            ValidateTableRelation = false;
        }
        field(60202; FBM_Operador; text[100])
        {
            Caption = 'Operador';
            TableRelation = FBM_Partner_JYM_CO.Name where(type = const(FBM_CustType_JYM_CO::Operador));
            ValidateTableRelation = false;
        }
        field(60203; FBM_Administrador; text[100])
        {
            Caption = 'Administrador';
            TableRelation = FBM_Partner_JYM_CO.Name where(Type = const(FBM_CustType_JYM_CO::Administrador));
            ValidateTableRelation = false;
        }
        field(60204; FBM_PermisionarioC; code[20])
        {
            Caption = 'Permisionario';

        }
        field(60205; FBM_OperadorC; code[20])
        {
            Caption = 'Operador';

        }
        field(60206; FBM_AdministradorC; code[20])
        {
            Caption = 'Administrador';

        }
    }
    trigger
    OnInsert()
    var
        cust: record Customer;
    begin
        cust.get(rec."Customer No.");
        rec.FBM_CustomerType := cust.FBM_CustomerType;
        //rec.Modify();
    end;

}