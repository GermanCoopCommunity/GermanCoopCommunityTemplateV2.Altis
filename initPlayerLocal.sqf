// by Quentin


// log start of execution
diag_log format ["%1 --- Executing initPlayerLocal.sqf",diag_ticktime];

// custom setup params
//#define Woodland	// players wear woodland camouflage
#define NoNVG	// players don't have night vision goggles
#define NoAINVG	// AI don't have night vision goggles


// Psychobastard: reset EH to avoid unwanted impacts on mission flow (for example after player slot changed)
player removeAllMPEventHandlers "MPKilled";
player removeAllEventHandlers "Fired";
player removeAllEventHandlers "CuratorObjectPlaced";


/* briefing file */
#include "initBriefing.hpp"	// see initBriefing.hpp file for briefing sections
/* briefing complete */


/* initialize QTS */
if (isNil "QT_call_fncs") then	// if QTS hasn't been initialized yet...
{
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
	
	KK_fnc_StreamUAV = compile preprocessFileLineNumbers "modules\QTS\UAVStream\KK_fnc_StreamUAV.sqf";
	
	JK_fnc_NameTags = compile preprocessFileLineNumbers "modules\QTS\JK_fnc_NameTags.sqf";

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
					#ifdef NoAINVG	// if AI aren't to be equipped with NVGs...
					switch (side _entity) do	// ...depending on entity's side, remove the according NV goggles
					{
						case ("WEST"): {_entity unassignItem "NVGoggles"; _entity removeItem "NVGoggles";};
						case ("EAST"): {_entity unassignItem "NVGoggles_OPFOR"; _entity removeItem "NVGoggles_OPFOR";};
						case ("RESISTANCE"): {_entity unassignItem "NVGoggles_INDEP"; _entity removeItem "NVGoggles_INDEP";};
						default {_entity unassignItem "NVGoggles"; _entity removeItem "NVGoggles";};
					};
					#endif
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
};
/* QTS initialization complete */


/* Loadout */
// woodland hiddenTexture
#ifdef Woodland	// if players are to wear Woodland uniforms..
// ...apply woodland hiddenTexture to player
if ((uniform player == "U_B_CombatUniform_mcam") or {uniform player == "U_B_CombatUniform_mcam_tshirt"} or {uniform player == "U_B_CombatUniform_mcam_vest"}) then
{
	player setObjectTextureGlobal [0,"\a3\characters_f\BLUFOR\Data\clothing_wdl_co.paa"];
	_vestItems = vestItems player;
	_vestMagazines = vestMagazines player;
	player addVest "V_PlateCarrier2_rgr";
	{player addItemToVest _x} forEach _vestItems;
	{player addItemToVest _x} forEach _vestMagazines;
	player addHeadgear "H_HelmetB_light";
};
// ...add persistent EH to keep woodland hiddenTexture
#endif

// night vision
#ifdef NoNVG	// if players aren't to be equipped with NVGs...
switch (side player) do	// ...depending on caller's side, remove the according NV goggles
{
	case ("WEST"): {player unassignItem "NVGoggles"; player removeItem "NVGoggles";};
	case ("EAST"): {player unassignItem "NVGoggles_OPFOR"; player removeItem "NVGoggles_OPFOR";};
	case ("RESISTANCE"): {player unassignItem "NVGoggles_INDEP"; player removeItem "NVGoggles_INDEP";};
	default {player unassignItem "NVGoggles"; player removeItem "NVGoggles";};
};
#endif

// save default unit loadout to apply on respawn later
plyr_ldt = getUnitLoadout player;
/* Loadout complete */


// initialize UAV streaming to OPZ
if (!isNil "greyhawk" && !isNil "whiteboard" && !isNil "dronecontrol") then
{[greyhawk,whiteboard,dronecontrol] call KK_fnc_StreamUAV;};


/* initialize MissionProtectionSystem */
private _MPS_InitClient = compile preprocessFileLineNumbers "modules\MissionProtectionSystem\MPS_InitClient.sqf";
call _MPS_InitClient;	// maybe spawn to allow file to continue initializing without needing to wait for MPS?
/* MissionProtectionSystem initialization complete */


/* mission specific code comes here */



/* end of mission specific code */


/* Intro */
if (isMultiplayer) then
{
	_introShot = [player,"US-Basis Almyra, Altis, Mittelmeer"] call BIS_fnc_establishingShot;
	waitUntil {scriptDone _introShot};
	[[ 
	  ["Willkommen","<t align = 'center' shadow = '1' size = '1' font='PuristaBold'>%1</t>"], 
	  ["bei der GeCo!","<t align = 'center' shadow = '1' size = '1' font='PuristaBold'>%1</t>"],
	  [""],
	  [""]
	]] spawn BIS_fnc_typeText;
	["img\loadingpic.paa"] spawn BIS_fnc_textTiles;	// show img
	0 cutText ["","BLACK IN",5];
};
/* Intro complete */


// log end of execution
diag_log format ["%1 --- initPlayerLocal.sqf executed",diag_ticktime];