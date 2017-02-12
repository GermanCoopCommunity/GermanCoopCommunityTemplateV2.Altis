// by Fabi, edited by Quentin


// log start of execution
//if !(player diarySubjectExists "Modules") then {player createDiarySubject ["Modules","Modules"];}; // create "Modules" diary entry for player
player createDiaryRecord ["Modules",["BFT InitServer","<font color='#b40100'>Ausführung begonnen</font color> nach " + str(time) + " Sekunden."]];


// wait for mission to start, otherwise no markers are shown
waitUntil {time > 0};


// check every player's group and add it to array of groups to be tracked
BFT_Groups = [];
{
    BFT_Groups pushBackUnique group _x;
    nil
} count (allPlayers - entities "VirtualCurator_F");	// exclude curators


// assign each player group a marker with its name
{
    private _marker = createMarker [str _x + "_BFT",[0,0,0]];
    _marker setMarkerText ((str _x) select [2]);
    if (typeOf (leader _x) in Pilots) then
	{
		if (typeOf leader _x isEqualTo "B_Pilot_F" or {typeOf leader _x isEqualTo "O_Pilot_F"} or {typeOf leader _x isEqualTo "I_Pilot_F"}) then	// if group leader is fighter pilot
		{
			switch (side leader _x) do
			{
				case WEST: {_marker setMarkerType "b_plane";};
				case EAST: {_marker setMarkerType "o_plane";};
				case RESISTANCE: {_marker setMarkerType "n_plane";};
				default {_marker setMarkerType "n_plane";};
			};
		}
		else
		{
			switch (side leader _x) do
			{
				case WEST: {_marker setMarkerType "b_air";};
				case EAST: {_marker setMarkerType "o_air";};
				case RESISTANCE: {_marker setMarkerType "n_air";};
				default {_marker setMarkerType "n_air";};
			};
		};
	}
	else
	{
        if (typeOf (leader _x) in Crews) then
		{ 
            switch (side leader _x) do
			{
				case WEST: {_marker setMarkerType "b_mech_inf";};
				case EAST: {_marker setMarkerType "o_mech_inf";};
				case RESISTANCE: {_marker setMarkerType "n_mech_inf";};
				default {_marker setMarkerType "n_mech_inf";};
			};
        }
		else
		{
            if (typeOf (leader _x) in Officers) then
			{
                switch (side leader _x) do
				{
				case WEST: {_marker setMarkerType "b_hq";};
				case EAST: {_marker setMarkerType "o_hq";};
				case RESISTANCE: {_marker setMarkerType "n_hq";};
				default {_marker setMarkerType "n_hq";};
				};
            }
			else
			{
                switch (side leader _x) do
				{
				case WEST: {_marker setMarkerType "b_inf";};
				case EAST: {_marker setMarkerType "o_inf";};
				case RESISTANCE: {_marker setMarkerType "n_inf";};
				default {_marker setMarkerType "n_inf";};
				};
            };
        };
    };
    nil
} count BFT_Groups;


// refresh each group's marker position on each frame depending on group leader's position
BFT_fnc_PFH =
{
	if (!isServer) exitWith{};
    {
        str _x + "_BFT" setMarkerPos (position (leader _x));
        nil
    } count BFT_Groups;
};
PFH pushback [BFT_fnc_PFH,5];	// number is refreshing rate, modify as you wish


// log end of execution
player createDiaryRecord ["Modules",["BFT InitServer","<font color='#107b1b'>Ausführung beendet</font color> nach " + str(time) + " Sekunden."]];