// MacRae Chair, edited by Quentin
/*
	Author: MacRae Kid

	Description:
	lets player sit down and stand up on and from a camping chair

	Parameter(s):
		0:
			OBJECT - chair object
		1:
			OBJECT - caller unit	

	Returns:
	true
*/

/* To Do


*/
/* Notes

1. Place a Camping Chair on the map.
2. Add this to the Camping chair Init: this addAction ["<t color='#0099FF'>Hinsetzen</t>","fnc\Chair\MR_SitDown.sqf"]

*/

// declare local variables
_chair = _this select 0; 
_unit = _this select 1; 

// code
[[_unit, "Crew"], "MAC_fnc_switchMove"] spawn BIS_fnc_MP; 
_unit setPos (getPos _chair); 
_unit setDir ((getDir _chair) - 180); 
standup = _unit addaction ["<t color='#0099FF'>Aufstehen</t>","player switchMove ""; player removeaction standup;"];
_unit setpos [getpos _unit select 0, getpos _unit select 1,((getpos _unit select 2) +1)];

// return
true;