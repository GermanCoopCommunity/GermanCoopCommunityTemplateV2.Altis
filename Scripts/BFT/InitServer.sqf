GeCo_BFT_Groups=[];
{
    GeCo_BFT_Groups pushBackUnique group _x;
    nil
} count allPlayers;
{
    private _marker =createMarker[str _x +"_Marker",[0,0,0]];
    _marker setMarkerText ((str _x) select [2]);
    _marker setMarkerType "b_unknown";
    nil
} count GeCo_BFT_Groups;

onEachFrame {
    if(!isServer)exitWith{};
    {
        str _x +"_Marker" setMarkerPos (position (leader _x));
        nil
    } count GeCo_BFT_Groups;
};