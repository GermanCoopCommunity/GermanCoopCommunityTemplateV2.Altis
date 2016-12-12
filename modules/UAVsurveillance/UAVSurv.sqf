// by Quentin
/*

	Description:
	Play a fake UAV observational sequence which serves as an establishing shot.

	Parameters:
		_this select 0: OBJECT or ARRAY - Target position/object
		_this select 1: STRING - Text to display
		_this select 2 (Optional): NUMBER - Altitude (in meters)
		_this select 3 (Optional): NUMBER - Radius of the circular movement (in meters)
		_this select 4 (Optional): NUMBER - Viewing angle (in degrees)
		_this select 5 (Optional): NUMBER - Direction of camera movement (0: anti-clockwise, 1: clockwise, default: random)
		_this select 6 (Optional): ARRAY -	Objects/positions/groups to display icons over
							Syntax: [[icon, color, target, size X, size Y, angle, text, shadow]]
		_this select 7 (Optional): NUMBER - Mode (0: normal (default), 1: world scenes)
*/
/* To Do



*/
/* Notes



*/


// declare local variables
private _groupLeader = _this select 3;


// play UAV sequence above specific group leader
[
	_groupLeader,((str(group _groupLeader) select [2]) + ", Position: " + str(position _groupLeader) + ", Aktuelle Mannstärke: " + str(count units group _groupLeader)),
	50/*,
	1,
	0,
	1,
	["Infantry",'#107b1b',_groupLeader,5,5,0,str(position _groupLeader),0],
	0*/
] call BIS_fnc_establishingShot;


// return
_return = true;
_return;