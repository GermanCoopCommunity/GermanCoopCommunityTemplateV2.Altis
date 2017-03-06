// Quentins Rank Insignia
/*
	Author: Quentin

	Description:
	Assigns unit an insignia according to their rank

	Parameter(s):
		0:
			OBJECT - unit

	Returns:
	true
*/
/* To Do



*/
/* Notes



*/
// declare local variables
private _unit = _this select 0;


if (!(side _unit isEqualTo civilian)/* && {!(captive _unit)}*/) then	// if unit is no civilian...
{
	// ...assign unit an insignia according to his rank
	switch (rank _unit) do
	{	
		case "COLONEL": {[_unit,"ColonelInsignia"] call BIS_fnc_setUnitInsignia};
		case "MAJOR": {[_unit,"MajorInsignia"] call BIS_fnc_setUnitInsignia};
		case "CAPTAIN": {[_unit,"CaptainInsignia"] call BIS_fnc_setUnitInsignia};
		case "LIEUTENANT": {[_unit,"LieutenantInsignia"] call BIS_fnc_setUnitInsignia};
		case "SERGEANT": {[_unit,"SergeantInsignia"] call BIS_fnc_setUnitInsignia};
		case "CORPORAL": {[_unit,"CorporalInsignia"] call BIS_fnc_setUnitInsignia};
		case "PRIVATE": {[_unit,"PrivateInsignia"] call BIS_fnc_setUnitInsignia};
	};
	addMissionEventHandler ["EachFrame",	// add persistent MEH to maintain insignia after respawn / opening virtual arsenal / taking off clothes and back on again
	{
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
	}];
};


// return
true;