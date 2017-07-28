// by Quentin


// log start of execution
diag_log format ["%1 --- Executing ZFW_initPlayerLocal.sqf",diag_ticktime];


// if player is a curator, apply QTS on units spawned by him
if (typeOf player in Curators) then
{
	// single units
	// SilentSpike: getAssignedCuratorLogic command will return objNull if used immediately after the curator logic is assigned to the unit in question (this includes at mission time 0). To avoid problems use the following beforehand
	waitUntil {!isNull (getAssignedCuratorLogic player)};
	COP_EH = (getAssignedCuratorLogic player) addEventHandler [
		"CuratorObjectPlaced",
		{
			private _entity = _this select 1;			
			if (_entity in (allUnits - playableUnits - entities "HeadlessClient_F")) then	// if entity spawned is an AI unit...
			{
				if (!isNil "QT_AI_call_fncs") then {{[_entity] call _x} count QT_AI_call_fncs};	// ...initialize QT_AI_call_fncs for it
				if (!isNil "QT_AI_spawn_fncs") then {{[_entity] spawn _x;nil} count QT_AI_spawn_fncs};	// ...initialize QT_AI_spawn_fncs for it
				/*#ifdef NoAINVG	// if AI aren't to be equipped with NVGs...
				switch (side _entity) do	// ...depending on entity's side, remove the according NV goggles
				{
					case (WEST): {_entity unassignItem "NVGoggles"; _entity removeItem "NVGoggles";};
					case (EAST): {_entity unassignItem "NVGoggles_OPFOR"; _entity removeItem "NVGoggles_OPFOR";};
					case (RESISTANCE): {_entity unassignItem "NVGoggles_INDEP"; _entity removeItem "NVGoggles_INDEP";};
					default {_entity unassignItem "NVGoggles"; _entity removeItem "NVGoggles";};
				};
				#endif*/
			};
			{[_x,[[_entity],true]] remoteExec ["addCuratorEditableObjects",2]; nil;} count (allCurators - [getAssignedCuratorLogic player]);	// add placed entity to editable objects for the other curators
		}
	];
/*	// AI groups
	(getAssignedCuratorLogic player) addEventHandler [
		"CuratorGroupPlaced",
		{
			// declare EH variables
			_curator = _this select 0;
			_group = _this select 1;
			
			if (_group in allGroups) then	// if group spawned is an AI group...
			{
				if (!isNil "QT_AI_call_fncs") then {{[_entity] call _x} count QT_AI_call_fncs};	// ...initialize QT_AI_call_fncs for it
				if (!isNil "QT_AI_spawn_fncs") then {{[_entity] spawn _x;nil} count QT_AI_spawn_fncs};	// ...initialize QT_AI_spawn_fncs for it
			};
			{_x addCuratorEditableObjects [[_entity],true]} count (allCurators - [_curator]);	// ...add placed entity to editable objects for the other curators
		}
	];*/
};


// log end of execution
diag_log format ["%1 --- ZFW_initPlayerLocal.sqf executed",diag_ticktime];