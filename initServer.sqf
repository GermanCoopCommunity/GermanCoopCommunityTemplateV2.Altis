// by Quentin


// log start of execution
diag_log format ["%1 --- Executing initServer.sqf",diag_ticktime];
if !(player diarySubjectExists "Modules") then {player createDiarySubject ["Modules","Modules"];};
player createDiaryRecord ["Modules",["InitServer","<font color='#b40100'>Ausführung begonnen</font color> nach " + str(time) + " Sekunden."]];


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