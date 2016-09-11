// by Quentin


// log start of execution
diag_log format ["%1 --- Executing ZFW_onPlayerRespawn.sqf",diag_ticktime];


// make player visible to curators on respawn
_newUnit = _this select 0;
{_x addCuratorEditableObjects [[_newUnit],true]} count allCurators;


// log end of execution
diag_log format ["%1 --- ZFW_onPlayerRespawn.sqf executed",diag_ticktime];
