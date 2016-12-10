// by Quentin


if (isServer) then
{
	{switch (side _x) do	// depending on AI's side, remove the according NV goggles
	{
		case ("WEST"): {_x unassignItem "NVGoggles"; _x removeItem "NVGoggles";};
		case ("EAST"): {_x unassignItem "NVGoggles_OPFOR"; _x removeItem "NVGoggles_OPFOR";};
		case ("RESISTANCE"): {_x unassignItem "NVGoggles_INDEP"; _x removeItem "NVGoggles_INDEP";};
		default {_x unassignItem "NVGoggles"; _x removeItem "NVGoggles";};
	};} forEach allUnits - playableUnits;
};
if (typeOf player in Curators) then	// if player is a curator, remove NVG from units spawned by him
{
	// single units
	// SilentSpike: getAssignedCuratorLogic command will return objNull if used immediately after the curator logic is assigned to the unit in question (this includes at mission time 0). To avoid problems use the following beforehand
	waitUntil {!isNull (getAssignedCuratorLogic player)};
	NOAINVG_EH = (getAssignedCuratorLogic player) addEventHandler
	[
		"CuratorObjectPlaced",
		{
			private _entity = _this select 1;			
			if (_entity in (allUnits - playableUnits - entities "HeadlessClient_F")) then	// if entity spawned is an AI unit...
			{
				switch (side _entity) do	// ...depending on entity's side, remove the according NV goggles
				{
					case ("WEST"): {_entity unassignItem "NVGoggles"; _entity removeItem "NVGoggles";};
					case ("EAST"): {_entity unassignItem "NVGoggles_OPFOR"; _entity removeItem "NVGoggles_OPFOR";};
					case ("RESISTANCE"): {_entity unassignItem "NVGoggles_INDEP"; _entity removeItem "NVGoggles_INDEP";};
					default {_entity unassignItem "NVGoggles"; _entity removeItem "NVGoggles";};
				};
			};
		}
	];
};