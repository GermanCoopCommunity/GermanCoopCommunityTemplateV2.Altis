// by Quentin


// log start of execution
//if !(player diarySubjectExists "Modules") then {player createDiarySubject ["Modules","Modules"];}; // create "Modules" diary entry for player
player createDiaryRecord ["Modules",["QTS InitClient","<font color='#b40100'>Ausführung begonnen</font color> nach " + str(time) + " Sekunden."]];


/* initialize QTS */
// define fnc arrays
QT_call_fncs = [];
QT_spawn_fncs = [];
QT_AI_call_fncs = [];
QT_AI_spawn_fncs = [];
	
	
// precompile fncs
QT_fnc_Earplugs = compile preprocessFileLineNumbers "modules\QTS\QT_fnc_Earplugs.sqf";
QT_call_fncs pushBackUnique QT_fnc_Earplugs;

QT_fnc_Insignia = compile preprocessFileLineNumbers "modules\QTS\QT_fnc_Insignia.sqf";
QT_call_fncs pushBackUnique QT_fnc_Insignia;
QT_AI_call_fncs pushBackUnique QT_fnc_Insignia;

QT_fnc_Gestures = compile preprocessFileLineNumbers "modules\QTS\QT_fnc_Gestures.sqf";
QT_call_fncs pushBackUnique QT_fnc_Gestures;

QT_fnc_Jump = compile preprocessFileLineNumbers "modules\QTS\QT_fnc_Jump.sqf";
QT_call_fncs pushBackUnique QT_fnc_Jump;

// apply QTS on AI units
{[_x] call QT_fnc_Insignia} count (allUnits - (allPlayers - entities "HeadlessClient_F"));

// apply QTS on player
{[] call _x} count QT_call_fncs;
{[] spawn _x; nil} count QT_spawn_fncs;
/* QTS initialization complete */


// log end of execution
player createDiaryRecord ["Modules",["QTS InitClient","<font color='#107b1b'>Ausführung beendet</font color> nach " + str(time) + " Sekunden."]];