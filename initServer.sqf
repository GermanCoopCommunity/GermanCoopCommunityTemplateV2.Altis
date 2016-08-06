// by Quentin


// log start of execution
diag_log format ["%1 --- Executing initServer.sqf",diag_ticktime];


/*// initialize variables and publicize them to everyone
a_variable = false;
publicVariable "a_variable";*/


// make allUnits (including players) visible for curators
{_x addCuratorEditableObjects [allUnits,true]} count allCurators;


// delete player body on disconnect
addMissionEventHandler ["HandleDisconnect",{deleteVehicle (_this select 0);}];

// initialize BFT
private _BFT_InitServer = compile preprocessFileLineNumbers "Scripts\BFT\InitServer.sqf";
call _BFT_InitServer;

// log end of execution
diag_log format ["%1 --- initServer.sqf executed",diag_ticktime];