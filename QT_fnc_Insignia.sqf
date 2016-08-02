// Quentins Rank Insignia
/*
	Author: Quentin

	Description:
	Assigns unit an insignia according to their rank

	Parameter(s):
		0:
			OBJECT - unit

	Returns:
	String
*/

/* To Do



*/
/* Notes



*/

// declare local variables
private _unit = _this select 0;


if (!(side _unit == civilian) or {captive _unit}) then	// if unit is neither civilian nor a captive...
{
	// ...assign player an insignia according to his rank
	switch (rank _unit) do
	{	
		case "COLONEL": {[_unit,"ColonelInsignia"] call bis_fnc_setUnitInsignia;};
		case "MAJOR": {[_unit,"MajorInsignia"] call bis_fnc_setUnitInsignia;};
		case "CAPTAIN": {[_unit,"CaptainInsignia"] call bis_fnc_setUnitInsignia;};
		case "LIEUTENANT": {[_unit,"LieutenantInsignia"] call bis_fnc_setUnitInsignia;};
		case "SERGEANT": {[_unit,"SergeantInsignia"] call bis_fnc_setUnitInsignia;};
		case "CORPORAL": {[_unit,"CorporalInsignia"] call bis_fnc_setUnitInsignia;};
		case "PRIVATE": {[_unit,"PrivateInsignia"] call bis_fnc_setUnitInsignia;};
	};
	_unit addEventHandler [	// ...reassign unit an insignia according to their rank after death again
		"Respawn",
			{
				// declare EH variables
				private _unit = _this select 0;
				
				// code
				switch (rank _unit) do
				{	
					case "COLONEL": {[_unit,"ColonelInsignia"] call bis_fnc_setUnitInsignia;};
					case "MAJOR": {[_unit,"MajorInsignia"] call bis_fnc_setUnitInsignia;};
					case "CAPTAIN": {[_unit,"CaptainInsignia"] call bis_fnc_setUnitInsignia;};
					case "LIEUTENANT": {[_unit,"LieutenantInsignia"] call bis_fnc_setUnitInsignia;};
					case "SERGEANT": {[_unit,"SergeantInsignia"] call bis_fnc_setUnitInsignia;};
					case "CORPORAL": {[_unit,"CorporalInsignia"] call bis_fnc_setUnitInsignia;};
					case "PRIVATE": {[_unit,"PrivateInsignia"] call bis_fnc_setUnitInsignia;};
				};
			}
	];
};


// return
true;