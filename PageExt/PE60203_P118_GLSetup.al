pageextension 60203 FBM_GLSetupExt_JMCO extends "General Ledger Setup"
{
    actions
    {
        addlast(processing)
        {
            action("4 Fields")
            {
                ApplicationArea = all;
                trigger
                OnAction()
                var
                    fix: Codeunit FBM_Fixes_JMCO;
                begin
                    fix.move4fields();


                end;

            }
            action("Multicat")
            {
                ApplicationArea = all;
                trigger
                OnAction()
                var
                    fix: Codeunit FBM_Fixes_JMCO;
                begin
                    fix.multicat();


                end;

            }
            action("Pedimento")
            {
                ApplicationArea = all;
                trigger
                OnAction()
                var
                    fix: Codeunit FBM_Fixes_JMCO;
                begin
                    fix.importped();
                    message('done');


                end;

            }
        }
    }
}