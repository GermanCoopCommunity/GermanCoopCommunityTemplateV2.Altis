// by Fabi, edited by Quentin


// check every player's group and add it to array of groups to be tracked
BFT_Groups = [];
{
    BFT_Groups pushBackUnique group _x;
    nil
} count (allPlayers - entities "VirtualCurator_F");	// exclude curators


// assign each group in BFT_Groups-Array a marker with its name
{
    private _marker = createMarker [str _x + "_BFT",[0,0,0]];
    _marker setMarkerText ((str _x) select [2]);
    if (typeOf (leader _x) in Pilots) then
	{
		if (typeOf leader _x == "B_Pilot_F" or {typeOf leader _x == "O_Pilot_F"} or {typeOf leader _x == "I_Pilot_F"}) then
		{
			_marker setMarkerType "b_plane";
		}
		else
		{
			_marker setMarkerType "b_air";
		};
    }
	else
	{
        if (typeOf (leader _x) in Crews) then
		{ 
            _marker setMarkerType "b_mech_inf";
        }
		else
		{
            if (typeOf (leader _x) in OPZ) then
			{
                _marker setMarkerType "b_hq";
            }
			else
			{
                _marker setMarkerType "b_inf";
            };
        };
    };
    nil
} count BFT_Groups;


// refresh each group's marker position on each frame depending on group leader's position
BFT_fn_PFH =
{
	if (!isServer) exitWith{};
    {
        str _x + "_BFT" setMarkerPos (position (leader _x));
        nil
    } count BFT_Groups;
};
PFH pushback [BFT_fn_PFH, 5];