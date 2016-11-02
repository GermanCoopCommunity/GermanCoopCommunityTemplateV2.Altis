// by Quentin


// log start of execution
diag_log format ["%1 --- Executing ZFW_onPlayerRespawn.sqf",diag_ticktime];


// make player visible to curators on respawn
_newUnit = _this select 0;
{[_x,[[_newUnit],true]] remoteExec ["addCuratorEditableObjects",2]; nil;} count allCurators;	// add respawned player to editable objects for the other curators


// log end of execution
diag_log format ["%1 --- ZFW_onPlayerRespawn.sqf executed",diag_ticktime];