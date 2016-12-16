// by Quentin


// log start of execution
diag_log format ["%1 --- Executing init.sqf",diag_ticktime];
if !(player diarySubjectExists "Modules") then {player createDiarySubject ["Modules","Modules"];};
player createDiaryRecord ["Modules",["Init","<font color='#b40100'>Ausführung begonnen</font color> nach " + str(time) + " Sekunden."]];


// Psychobastard: needed to reset EH/ mission EHs can avoid unwanted impacts on mission flow (for example after player slot changed)
removeAllMissionEventHandlers "Draw3D";


/* define functions */
JK_fnc_NameTags = compile preprocessFileLineNumbers "modules\Nametags\JK_fnc_NameTags.sqf";
/* functions defined */


/* add Mission EHs */
_null = execVM "modules\Nametags\Nametags_InitClient.sqf";	// Nametags
_null = execVM "modules\MissionProtectionSystem\MPS_addMEH.sqf";	// 3rd Person Restriction & Vehicle Restriction
/* Mission EHs added */


// (disable radio callouts and -texts) can be set via difficulty settings
//0.1 fadeRadio 0;		// <-- out commented by psycho, this command stops working of some required game sounds (f.e. the *pieppiep* if a launcher has a target switched on)
enableRadio false;
enableSentences false;


// set view distance
setViewDistance 5000;


/* mission specific code comes here */



/* end of mission specific code */


// log end of execution
diag_log format ["%1 --- init.sqf executed",diag_ticktime];
player createDiaryRecord ["Modules",["Init","<font color='#107b1b'>Ausführung beendet</font color> nach " + str(time) + " Sekunden."]];