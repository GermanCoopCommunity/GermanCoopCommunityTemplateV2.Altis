// by Quentin


// log start of execution
diag_log format ["%1 --- Executing onPlayerRespawn.sqf",diag_ticktime];


// ZFW
private _ZFW_onPlayerRespawn = compile preprocessFileLineNumbers "Scripts\ZeusFramework\ZWF_onPlayerRespawn.sqf";
call _ZFW_onPlayerRespawn;


// log end of execution
diag_log format ["%1 --- onPlayerRespawn.sqf executed",diag_ticktime];
