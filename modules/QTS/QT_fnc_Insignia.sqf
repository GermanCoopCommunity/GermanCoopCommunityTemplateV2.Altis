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


if (!(side _unit isEqualTo civilian)/* && {!(captive _unit)}*/) then	// if unit is neither civilian (nor a captive)...
{
	// ...assign player an insignia according to his rank
	switch (rank _unit) do
	{	
		case "COLONEL": {[_unit,"ColonelInsignia"] call BIS_fnc_setUnitInsignia; insignia = "ColonelInsignia";};
		case "MAJOR": {[_unit,"MajorInsignia"] call BIS_fnc_setUnitInsignia; insignia = "MajorInsignia";};
		case "CAPTAIN": {[_unit,"CaptainInsignia"] call BIS_fnc_setUnitInsignia; insignia = "CaptainInsignia";};
		case "LIEUTENANT": {[_unit,"LieutenantInsignia"] call BIS_fnc_setUnitInsignia; insignia = "LieutenantInsignia";};
		case "SERGEANT": {[_unit,"SergeantInsignia"] call BIS_fnc_setUnitInsignia; insignia = "SergeantInsignia";};
		case "CORPORAL": {[_unit,"CorporalInsignia"] call BIS_fnc_setUnitInsignia; insignia = "CorporalInsignia";};
		case "PRIVATE": {[_unit,"PrivateInsignia"] call BIS_fnc_setUnitInsignia; insignia = "PrivateInsignia";};
	};
	_unit addEventHandler [	// ...reassign unit an insignia according to their rank after death again
		"Respawn",
			{
				// declare EH variables
				private _unit = _this select 0;
				
				// code
				switch (rank _unit) do
				{	
					case "COLONEL": {[_unit,"ColonelInsignia"] call BIS_fnc_setUnitInsignia;};
					case "MAJOR": {[_unit,"MajorInsignia"] call BIS_fnc_setUnitInsignia;};
					case "CAPTAIN": {[_unit,"CaptainInsignia"] call BIS_fnc_setUnitInsignia;};
					case "LIEUTENANT": {[_unit,"LieutenantInsignia"] call BIS_fnc_setUnitInsignia;};
					case "SERGEANT": {[_unit,"SergeantInsignia"] call BIS_fnc_setUnitInsignia;};
					case "CORPORAL": {[_unit,"CorporalInsignia"] call BIS_fnc_setUnitInsignia;};
					case "PRIVATE": {[_unit,"PrivateInsignia"] call BIS_fnc_setUnitInsignia;};
				};
			}
	];
	addMissionEventHandler ["EachFrame",	// add persistent MEH to maintain insignia
	{
		if !(([player] call BIS_fnc_getUnitInsignia) isEqualTo insignia) then {[player,insignia] call BIS_fnc_setUnitInsignia;};
	}];
};


// return
true;