pageextension 60202 FBM_ItemTraxkingLinesExt_JYMCO extends "Item Tracking Lines"
{
    layout
    {
        modify(STF_Pedimento)
        {
            Visible = false;


        }
        modify(STF_NombreAduana)
        {
            Visible = false;


        }
        modify(STF_PedDate)
        {
            Visible = false;


        }


    }
}