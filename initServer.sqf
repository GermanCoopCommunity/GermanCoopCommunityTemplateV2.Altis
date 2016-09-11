// by Quentin


// log start of execution
diag_log format ["%1 --- Executing initServer.sqf",diag_ticktime];


/*// initialize variables and publicize them to everyone
a_variable = false;
publicVariable "a_variable";*/


// delete player body on disconnect
addMissionEventHandler ["HandleDisconnect",{deleteVehicle (_this select 0);}];


////////////////////////////////////////////////// initialize InitServers //////////////////////////////////////////////////
// Core
private _Core_InitServer = compile preprocessFileLineNumbers "Scripts\Core\InitServer.sqf";
call _Core_InitServer;

// BFT
private _BFT_InitServer = compile preprocessFileLineNumbers "Scripts\BFT\BFT_InitServer.sqf";
call _BFT_InitServer;

// MissionProtectionSystem
private _MPS_InitServer = compile preprocessFileLineNumbers "Scripts\MissionProtectionSystem\InitServer.sqf";
call _MPS_InitServer;

// ZFW
private _ZFW_InitServer = compile preprocessFileLineNumbers "Scripts\ZeusFramework\ZFW_InitServer.sqf";
call _ZFW_InitServer;
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


// log end of execution
diag_log format ["%1 --- initServer.sqf executed",diag_ticktime];
