// by Quentin


// declare given argument in local variable
private _setPlayerNONVG = _this select 0;


// set NVG for player according to value set in Mission Params in description.ext
if (_setPlayerNONVG isEqualTo 0) then
{
	waitUntil {time > 0};	// wait for mission start, so default loadout is assigned first to be overwritten by the NVG one
	switch (side player) do	// depending on player's side, remove the according NV goggles
	{
		case ("WEST"): {player unassignItem "NVGoggles"; player removeItem "NVGoggles";};
		case ("EAST"): {player unassignItem "NVGoggles_OPFOR"; player removeItem "NVGoggles_OPFOR";};
		case ("RESISTANCE"): {player unassignItem "NVGoggles_INDEP"; player removeItem "NVGoggles_INDEP";};
		default {player unassignItem "NVGoggles"; player removeItem "NVGoggles";};
	};
	plyr_ldt = getUnitLoadout player;	// save as default player loadout to apply on respawn later
};