// by Quentin


/*// get vehicle starting position
{
	_x setVariable ["StartPos",position _x,true];
	nil;
} count vehicles;

// add Veh_KilledEH
{
	_x addEventHandler ["Killed",
	{
		[_x] execVM "modules\VehicleRespawn\Veh_Respawn.sqf";
	}];
	nil;
} count vehicles;*/

// set all vehicles as respawnable
{
	_x respawnVehicle [-1];
	nil;
} count vehicles;