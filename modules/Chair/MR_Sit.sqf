// MacRae Chair, edited by Quentin
/*
	Author: MacRae

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

1. place a chair on the map.
2. add this to the chair Init field: this addAction ["Hinsetzen","modules\Chair\MR_Sit.sqf"];

*/


// declare local variables
_chair = _this select 0; 
_unit = _this select 1; 


// code
[_unit,"Crew"] remoteExec ["switchMove",0];	// let player sit, also visible for other players
_unit setPosATL (getPosATL _chair);	// set player's position including height to the chair's
_unit setDir ((getDir _chair) - 180);	// rotate him according to chair direction
MR_StandUp = _unit addAction ["Aufstehen","player switchMove """"; player removeAction MR_StandUp;"];	// give player the option to stand up again


// return
true;