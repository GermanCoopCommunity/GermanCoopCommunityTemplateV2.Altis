// by Quentin


// log start of execution
diag_log format ["%1 --- Executing initPlayerLocal.sqf",diag_ticktime];
if !(player diarySubjectExists "Modules") then {player createDiarySubject ["Modules","Modules"];};
player createDiaryRecord ["Modules",["InitPlayerLocal","<font color='#b40100'>Ausführung begonnen</font color> nach " + str(time) + " Sekunden."]];


// Psychobastard: reset EH to avoid unwanted impacts on mission flow (for example after player slot changed)
player removeAllEventHandlers "CuratorObjectPlaced";


/* initialize modules */
_null = execVM "modules\Briefing\Briefing_InitClient.sqf";	// Briefing
_null = execVM "modules\Loadout\Loadout_InitClient.sqf";	// Player Loadout
_null = execVM "modules\QTS\QTS_InitClient.sqf";	// Quentin's Scripts
_null = execVM "modules\MissionProtectionSystem\MPS_InitClient.sqf";	// Mission Protection System
_null = execVM "modules\Intro\MissionIntro_InitClient.sqf";	// Mission Intro
if (typeOf player in Officers) then {_null = execVM "modules\UAVsurveillance\UAVSurv_InitClient.sqf";};	// UAVSurveillance
/* initialized modules */


/* mission specific code comes here */



/* end of mission specific code */


// log end of execution
diag_log format ["%1 --- initPlayerLocal.sqf executed",diag_ticktime];
player createDiaryRecord ["Modules",["InitPlayerLocal","<font color='#107b1b'>Ausführung beendet</font color> nach " + str(time) + " Sekunden."]];