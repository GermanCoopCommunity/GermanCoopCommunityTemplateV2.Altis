// by Quentin


switch (side player) do	// depending on player's side, remove the according NV goggles
{
	case ("WEST"): {player unassignItem "NVGoggles"; player removeItem "NVGoggles";};
	case ("EAST"): {player unassignItem "NVGoggles_OPFOR"; player removeItem "NVGoggles_OPFOR";};
	case ("RESISTANCE"): {player unassignItem "NVGoggles_INDEP"; player removeItem "NVGoggles_INDEP";};
	default {player unassignItem "NVGoggles"; player removeItem "NVGoggles";};
};
plyr_ldt = getUnitLoadout player;	// save as default player loadout to apply on respawn later