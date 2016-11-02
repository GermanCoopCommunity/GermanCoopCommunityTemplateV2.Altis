// by Quentin


// log start of execution
diag_log format ["%1 --- Executing ZFW_initPlayerServer.sqf",diag_ticktime];


// declare local variables
_player = _this select 0;
_didJIP = _this select 1;


// make JIP player visible for curators
if (_didJIP) then {{_x addCuratorEditableObjects [[_player],true]} count allCurators;};


/*// trusted players can access Zeus interface
if (getPlayerUID in Whitelist) then {player assignCurator (getPlayerUID player);};*/


// log end of execution
diag_log format ["%1 --- ZFW_initPlayerServer.sqf executed",diag_ticktime];