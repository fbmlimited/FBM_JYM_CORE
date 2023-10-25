pageextension 60200 FBM_CustCardExt_JYM_CO extends "Customer Card"
{
    layout
    {
        addlast(General)
        {
            group(Clasificación)
            {


                field(FBM_CustomerType; Rec.FBM_CustomerType)
                {
                    ApplicationArea = all;
                    trigger
                    OnValidate()
                    begin
                        ufield();
                    end;





                }


                field(FBM_Permisionario; Rec.FBM_Permisionario)

                {
                    enabled = showP;
                    ApplicationArea = all;

                }
                field(FBM_Operador; Rec.FBM_Operador)
                {
                    enabled = showO;
                    ApplicationArea = all;

                }
                field(FBM_Administrador; Rec.FBM_Administrador)
                {
                    ApplicationArea = all;
                    Enabled = showA;
                }

            }
        }
    }
    trigger
    OnOpenPage()
    begin
        ufield();

    end;

    var
        showP: Boolean;
        showO: Boolean;
        showA: Boolean;

    procedure ufield()
    begin
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
                    rec.FBM_Permisionario := rec.Name;
                    rec.FBM_PermisionarioC := rec."No.";

                end;
            rec.FBM_CustomerType::Operador:
                begin
                    showP := true;
                    showO := true;
                    showA := false;
                    rec.FBM_Administrador := '';
                    rec.FBM_AdministradorC := '';
                    rec.FBM_Operador := rec.Name;
                    rec.FBM_OperadorC := rec."No.";
                    rec.FBM_Permisionario := '';
                    rec.FBM_PermisionarioC := '';

                end;
            rec.FBM_CustomerType::Administrador:
                begin
                    showP := true;
                    showO := true;
                    showA := true;
                    rec.FBM_Administrador := rec.Name;
                    rec.FBM_AdministradorC := rec."No.";
                    rec.FBM_Operador := '';
                    rec.FBM_Permisionario := '';
                    rec.FBM_OperadorC := '';
                    rec.FBM_PermisionarioC := '';
                end;


        End;
    end;
}