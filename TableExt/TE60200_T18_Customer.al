tableextension 60200 FBM_CustomerExt_JCM_CO extends Customer
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
            TableRelation = Customer.Name where(FBM_CustomerType = const(FBM_CustType_JYM_CO::Administrador));
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

}