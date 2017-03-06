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
		case "COLONEL": {[_unit,"ColonelInsignia"] remoteExec [BIS_fnc_setUnitInsignia,0,true]};
		case "MAJOR": {[_unit,"MajorInsignia"] remoteExec [BIS_fnc_setUnitInsignia,0,true]};
		case "CAPTAIN": {[_unit,"CaptainInsignia"] remoteExec [BIS_fnc_setUnitInsignia,0,true]};
		case "LIEUTENANT": {[_unit,"LieutenantInsignia"] remoteExec [BIS_fnc_setUnitInsignia,0,true]};
		case "SERGEANT": {[_unit,"SergeantInsignia"] remoteExec [BIS_fnc_setUnitInsignia,0,true]};
		case "CORPORAL": {[_unit,"CorporalInsignia"] remoteExec [BIS_fnc_setUnitInsignia,0,true]};
		case "PRIVATE": {[_unit,"PrivateInsignia"] remoteExec [BIS_fnc_setUnitInsignia,0,true]};
	};
	addMissionEventHandler ["EachFrame",	// add persistent MEH to maintain insignia after respawn / opening virtual arsenal / taking off clothes and back on again
	{
		switch (rank player) do
		{	
			case "COLONEL": {[player,"ColonelInsignia"] remoteExec [BIS_fnc_setUnitInsignia,0,true]};
			case "MAJOR": {[player,"MajorInsignia"] remoteExec [BIS_fnc_setUnitInsignia,0,true]};
			case "CAPTAIN": {[player,"CaptainInsignia"] remoteExec [BIS_fnc_setUnitInsignia,0,true]};
			case "LIEUTENANT": {[player,"LieutenantInsignia"] remoteExec [BIS_fnc_setUnitInsignia,0,true]};
			case "SERGEANT": {[player,"SergeantInsignia"] remoteExec [BIS_fnc_setUnitInsignia,0,true]};
			case "CORPORAL": {[player,"CorporalInsignia"] remoteExec [BIS_fnc_setUnitInsignia,0,true]};
			case "PRIVATE": {[player,"PrivateInsignia"] remoteExec [BIS_fnc_setUnitInsignia,0,true]};
		};
	}];
};


// return
true;