// Quentins Rank Insignia
/*
	Author: Quentin

	Description:
	Assigns unit an insignia according to their rank

	Parameter(s):
		none

	Returns:
	true
*/
/* To Do



*/
/* Notes



*/


if (!(side player isEqualTo civilian)/* && {!(captive player)}*/) then	// if unit is no civilian...
{
	// ...assign unit an insignia according to his rank
	switch (rank player) do
	{	
		case "COLONEL": {[player,"ColonelInsignia"] call BIS_fnc_setUnitInsignia};
		case "MAJOR": {[player,"MajorInsignia"] call BIS_fnc_setUnitInsignia};
		case "CAPTAIN": {[player,"CaptainInsignia"] call BIS_fnc_setUnitInsignia};
		case "LIEUTENANT": {[player,"LieutenantInsignia"] call BIS_fnc_setUnitInsignia};
		case "SERGEANT": {[player,"SergeantInsignia"] call BIS_fnc_setUnitInsignia};
		case "CORPORAL": {[player,"CorporalInsignia"] call BIS_fnc_setUnitInsignia};
		case "PRIVATE": {[player,"PrivateInsignia"] call BIS_fnc_setUnitInsignia};
	};
	// ...assign unit an insignia according to his rank after respawn
	player addEventHandler ["Respawn",{[] execVM "modules\QTS\QT_Insignia_Respawn.sqf";}];
};


// return
true;