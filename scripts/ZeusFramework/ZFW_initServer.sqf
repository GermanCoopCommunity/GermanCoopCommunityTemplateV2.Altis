// by Quentin


// log start of execution
diag_log format ["%1 --- Executing ZFW_initServer.sqf",diag_ticktime];


// make all units including players and also vehicles visible for curators
{_x addCuratorEditableObjects [allUnits,true]} count allCurators;
{_x addCuratorEditableObjects [vehicles,true]} count allCurators;


// log end of execution
diag_log format ["%1 --- ZFW_initServer.sqf executed",diag_ticktime];
