// by Quentin


// log start of execution
diag_log format ["%1 --- Executing initServer.sqf",diag_ticktime];
if !(player diarySubjectExists "Modules") then {player createDiarySubject ["Modules","Modules"];};
player createDiaryRecord ["Modules",["InitServer","<font color='#b40100'>Ausführung begonnen</font color> nach " + str(time) + " Sekunden."]];


/* Missing Content Warnings */
// check for Curators
if (count entities "VirtualCurator_F" isEqualTo 0) then	// if there are no VirtualCurator_F...
{["<t color='#ff0000' size ='1.5'>Es gibt keinen neutralen Zeus!<br/>Erstelle mindestens einen ""VirtualCurator_F"".</t>",0,0,10,0] spawn BIS_fnc_dynamicText;	// ...tell mission builder
};
// check for Vehicle Respawn Module
if (count entities "ModuleRespawnVehicle_F" isEqualTo 0) then	// if there is no Vehicle Respawn Module...
{["<t color='#ff0000' size ='1.5'>Es gibt kein Fahrzeug-Respawn-Modul!<br/>Erstelle ein ""ModuleRespawnVehicle_F"" und synchronisiere alle Fahrzeuge, die respawnen sollen, damit.</t>",0,0,10,0] spawn BIS_fnc_dynamicText;	// ...tell mission builder
};
// check for Player Respawn (Module)
if (!isNil "respawn_west" && {!isNil "respawn_east"} && {!isNil "respawn_guerrila"} && {!isNil "respawn_civilian"} && {count entities "ModuleRespawnPosition_F" isEqualTo 0}) then	// if there is no Player Respawn (Module)...
{["<t color='#ff0000' size ='1.5'>Es gibt keinen Spieler-Respawn-Marker bzw. -modul!<br/>Erstelle einen Marker namens ""respawn_west"" oder setze ein Respawn-Modul ""ModuleRespawnPosition_F"" und setze ihn an eine Position, wo die Spieler respawnen sollen.</t>",0,0,10,0] spawn BIS_fnc_dynamicText;	// ...tell mission builder
};
// check for UAV Streaming components
if (isNil "streaming_drone") then	// if there is no streaming drone...
{["<t color='#ff0000' size ='1.5'>Es gibt keine Streaming-Drohne!<br/>Erstelle eine besetzte Greyhawk-Drohne namens ""streaming_drone"", damit das UAV Streaming arbeiten kann!</t>",0,0,10,0] spawn BIS_fnc_dynamicText;	// ...tell mission builder
};
if (isNil "drone_control") then	// if there is no streaming control station...
{["<t color='#ff0000' size ='1.5'>Es gibt keine Streaming-Station!<br/>Erstelle einen Monitor o.ä. namens ""drone_control"", damit das UAV Streaming arbeiten kann!</t>",0,0,10,0] spawn BIS_fnc_dynamicText;	// ...tell mission builder
};
if (isNil "whiteboard") then	// if there is no whiteboard streaming surface...
{["<t color='#ff0000' size ='1.5'>Es gibt keine Weißwandtafel!<br/>Erstelle eine Weißwandtafel namens ""whiteboard"", damit das UAV Streaming arbeiten kann!</t>",0,0,10,0] spawn BIS_fnc_dynamicText;	// ...tell mission builder
};
/* Missing Content Warnings ended */


/* public variables */
a_variable = true;
publicVariable "a_variable";
/* public variables initialized and puclicized */


// delete player body on disconnect
DC_EH = addMissionEventHandler ["HandleDisconnect",{deleteVehicle (_this select 0);}];


/* initialize InitServers */
// Core
private _Core_InitServer = compile preprocessFileLineNumbers "modules\Core\CR_InitServer.sqf";
call _Core_InitServer;

// Zeus Framework
private _ZFW_InitServer = compile preprocessFileLineNumbers "modules\ZeusFramework\ZFW_InitServer.sqf";
call _ZFW_InitServer;

// BLUFORCE Tracking
private _BFT_InitServer = compile preprocessFileLineNumbers "modules\BLUFORCE_Tracking\BFT_InitServer.sqf";
call _BFT_InitServer;

// Mission Protection System
private _MPS_InitServer = compile preprocessFileLineNumbers "modules\MissionProtectionSystem\MPS_InitServer.sqf";
call _MPS_InitServer;
/* initServers initialized */


/* mission specific code comes here */



/* end of mission specific code */


// log end of execution
diag_log format ["%1 --- initServer.sqf executed",diag_ticktime];
player createDiaryRecord ["Modules",["InitServer","<font color='#107b1b'>Ausführung beendet</font color> nach " + str(time) + " Sekunden."]];