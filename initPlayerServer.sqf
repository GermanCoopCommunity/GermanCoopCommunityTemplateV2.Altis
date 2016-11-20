// by Quentin


// log start of execution
diag_log format ["%1 --- Executing initPlayerServer.sqf",diag_ticktime];


// ZFW
private _ZFW_initPlayerServer = compile preprocessFileLineNumbers "Scripts\ZeusFramework\ZFW_initPlayerServer.sqf";
call _ZFW_initPlayerServer;


/* mission specific code comes here */



/* end of mission specific code */


// log end of execution
diag_log format ["%1 --- initPlayerServer.sqf executed",diag_ticktime];
