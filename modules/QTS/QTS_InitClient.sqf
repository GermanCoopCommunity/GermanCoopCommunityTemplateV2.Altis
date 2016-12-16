// by Quentin


// log start of execution
if !(player diarySubjectExists "Modules") then {player createDiarySubject ["Modules","Modules"];};
player createDiaryRecord ["Modules",["QTS InitClient","<font color='#b40100'>Ausführung begonnen</font color> nach " + str(time) + " Sekunden."]];


/* initialize QTS */
// define fnc arrays
QT_call_fncs = [];
QT_spawn_fncs = [];
QT_AI_call_fncs = [];
QT_AI_spawn_fncs = [];
	
	
// precompile fncs
QT_fnc_Earplugs = compile preprocessFileLineNumbers "modules\QTS\QT_fnc_Earplugs.sqf";
QT_call_fncs pushBackUnique QT_fnc_Earplugs;

QT_fnc_Insignia = compile preprocessFileLineNumbers "modules\QTS\QT_fnc_Insignia.sqf";
QT_call_fncs pushBackUnique QT_fnc_Insignia;
QT_AI_call_fncs pushBackUnique QT_fnc_Insignia;

QT_fnc_Gestures = compile preprocessFileLineNumbers "modules\QTS\QT_fnc_Gestures.sqf";
QT_call_fncs pushBackUnique QT_fnc_Gestures;

QT_fnc_Jump = compile preprocessFileLineNumbers "modules\QTS\QT_fnc_Jump.sqf";
QT_call_fncs pushBackUnique QT_fnc_Jump;

// apply QTS on AI units
{[_x] call QT_fnc_Insignia} count (allUnits - (allPlayers - entities "HeadlessClient_F"));

// apply QTS on player
{[player] call _x} count QT_call_fncs;
{[player] spawn _x} forEach QT_spawn_fncs;

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
				if (!isNil "QT_AI_spawn_fncs") then {{[_entity] spawn _x} forEach QT_AI_spawn_fncs};	// ...initialize QT_AI_spawn_fncs for it
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
				if (!isNil "QT_AI_spawn_fncs") then {{[_entity] spawn _x} forEach QT_AI_spawn_fncs};	// ...initialize QT_AI_spawn_fncs for it
			};
			{_x addCuratorEditableObjects [[_entity],true]} count (allCurators - [_curator]);	// ...add placed entity to editable objects for the other curators
		}
	];*/
};
/* QTS initialization complete */


// log end of execution
player createDiaryRecord ["Modules",["QTS InitClient","<font color='#107b1b'>Ausführung beendet</font color> nach " + str(time) + " Sekunden."]];