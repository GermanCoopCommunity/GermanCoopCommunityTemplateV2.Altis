// by Quentin


// log start of execution
diag_log format ["%1 --- Executing initPlayerLocal.sqf",diag_ticktime];


// Psychobastard: reset EH to avoid unwanted impacts on mission flow (for example after player slot changed)
player removeAllEventHandlers "CuratorObjectPlaced";


/* initialize modules */
_null = execVM "modules\Briefing\Briefing.sqf";	// Briefing
_null = execVM "modules\Loadout\Player_Loadout.sqf";	// Player Loadout
_null = execVM "modules\QTS\QTS_Init.sqf";	// Quentin's Scripts
_null = execVM "modules\MissionProtectionSystem\MPS_InitClient.sqf";	// Mission Protection System
_null = execVM "modules\Intro\MissionIntro.sqf";	// Mission Intro
/* initialized modules */


/* mission specific code comes here */



/* end of mission specific code */


// log end of execution
diag_log format ["%1 --- initPlayerLocal.sqf executed",diag_ticktime];