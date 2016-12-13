// by Quentin


// declare given argument as local variable
_vehicle = _this select 0;

// create new vehicle at start position
(typeOf _vehicle) createVehicle (_vehicle getVariable "StartPos");

// add respawned vehicle to editable objects for all curators
{[_x,[[_vehicle],true]] remoteExec ["addCuratorEditableObjects",2]; nil;} count allCurators;

// BLUFOR Striders
if (side co isEqualTo WEST && {(typeOf _vehicle isEqualTo "I_MRAP_03_hmg_F") or {typeOf _vehicle isEqualTo "I_MRAP_03_gmg_F"}) then	// if players are BLUFOR...
{
	[_vehicle,["Blufor",1],true] call BIS_fnc_initVehicle;	// ...give respawned striders BLUFOR skin
};