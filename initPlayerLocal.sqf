// by Quentin


// log start of execution
diag_log format ["%1 --- Executing initPlayerLocal.sqf",diag_ticktime];


////////////////////////////////////////// initialize QTS (also for JIPers) //////////////////////////////////////////
// initialize QTS on player
if (!isNil "QT_call_fncs") then {{[player] call _x} count QT_call_fncs};
if (!isNil "QT_spawn_fncs") then {{[player] spawn _x} forEach QT_spawn_fncs};

// if player is a curator, initialize QTS on units spawned by him
if (typeOf player == "VirtualCurator_F" or typeOf player == "B_VirtualCurator_F" or typeOf player == "C_VirtualCurator_F" or typeOf player == "I_VirtualCurator_F" or typeOf player == "O_VirtualCurator_F") then
{
	// single units
	player addEventHandler [
		"CuratorObjectPlaced",
		{
			_entity = _this select 1;			
			if (_entity in (allUnits - allPlayers - playableUnits - entities "HeadlessClient_F")) then	// if entity spawned is an AI unit...
			{
				if (!isNil "QT_AI_call_fncs") then {{[_entity] call _x} count QT_AI_call_fncs};	// ...initialize QT_AI_call_fncs for it
				if (!isNil "QT_AI_spawn_fncs") then {{[_entity] spawn _x} forEach QT_AI_spawn_fncs};	// ...initialize QT_AI_spawn_fncs for it
			};
			{_x addCuratorEditableObjects [[_this select 1],true]} count allCurators;	// ...add placed entity to editable objects for the other curators
		}
	];
/*	// AI groups
	player addEventHandler [
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
////////////////////////////////////////// QTS initialization for JIPers complete //////////////////////////////////////////


////////////////////////////////////////// briefing file //////////////////////////////////////////
// see initBriefing.hpp file for briefing sections
#include "initBriefing.hpp"
////////////////////////////////////////// briefing complete //////////////////////////////////////////


////////////////////////////////////////// GeCo Intro //////////////////////////////////////////
0 cutText ["","BLACK IN",7];	// fade in from black
[[ 
  ["US-Basis Almyra,","<t align = 'center' shadow = '1' size = '1' font='PuristaBold'>%1</t>"], 
  ["Altis","<t align = 'center' shadow = '1' size = '1' font='PuristaBold'>%1</t>"],
  [""],
  [""]
 ]] spawn BIS_fnc_typeText;
["img\loadingpic.paa"] spawn BIS_fnc_textTiles;	// show GeCo logo
////////////////////////////////////////// Intro complete //////////////////////////////////////////


// initialize MissionProtectionSystem
private _BFT_InitClient = compile preprocessFileLineNumbers "scripts\MissionProtectionSystem\InitClient.sqf";
call _BFT_InitClient;


// log end of execution
diag_log format ["%1 --- initPlayerLocal.sqf executed",diag_ticktime];