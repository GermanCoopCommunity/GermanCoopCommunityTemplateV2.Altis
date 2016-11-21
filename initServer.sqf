// by Quentin


// log start of execution
diag_log format ["%1 --- Executing initServer.sqf",diag_ticktime];


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

// MissionProtectionSystem
private _MPS_InitServer = compile preprocessFileLineNumbers "modules\MissionProtectionSystem\MPS_InitServer.sqf";
call _MPS_InitServer;

// ZFW
private _ZFW_InitServer = compile preprocessFileLineNumbers "modules\ZeusFramework\ZFW_InitServer.sqf";
call _ZFW_InitServer;

// BFT
waitUntil {time > 0};
private _BFT_InitServer = compile preprocessFileLineNumbers "modules\BLUFORCE_Tracking\BFT_InitServer.sqf";
call _BFT_InitServer;
/* initServers initialized */


/* mission specific code comes here */



/* end of mission specific code */


// log end of execution
diag_log format ["%1 --- initServer.sqf executed",diag_ticktime];