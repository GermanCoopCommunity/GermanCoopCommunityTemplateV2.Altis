// by Fabi, edited by Quentin


// log start of execution
if (isServer && {!(player diarySubjectExists "Modules")}) then {player createDiarySubject ["Modules","Modules"];};
player createDiaryRecord ["Modules",["BFT InitServer","<font color='#b40100'>Ausführung begonnen</font color> nach " + str(time) + " Sekunden."]];


// wait for mission to start, otherwise no markers are shown
waitUntil {time > 0};


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
		if (typeOf leader _x isEqualTo "B_Pilot_F" or {typeOf leader _x isEqualTo "O_Pilot_F"} or {typeOf leader _x isEqualTo "I_Pilot_F"}) then	// if group leader is fighter pilot
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
            if (typeOf (leader _x) in Officers) then
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
BFT_fnc_PFH =
{
	if (!isServer) exitWith{};
    {
        str _x + "_BFT" setMarkerPos (position (leader _x));
        nil
    } count BFT_Groups;
};
PFH pushback [BFT_fnc_PFH,5];


// log end of execution
player createDiaryRecord ["Modules",["BFT InitServer","<font color='#107b1b'>Ausführung beendet</font color> nach " + str(time) + " Sekunden."]];