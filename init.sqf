// by Quentin


// log start of execution
diag_log format ["%1 --- Executing init.sqf",diag_ticktime];


// Psychobastard: needed to reset EH/ mission EHs can avoid unwanted impacts on mission flow (for example after player slot changed)
removeAllMissionEventHandlers "Draw3D";


/* define functions */
KK_fnc_StreamUAV = compile preprocessFileLineNumbers "modules\UAVStream\KK_fnc_StreamUAV.sqf";
JK_fnc_NameTags = compile preprocessFileLineNumbers "modules\Nametags\JK_fnc_NameTags.sqf";
/* functions defined */
 

// initialize UAV streaming to OPZ
_null = execVM "modules\UAVStream\UAVStream_Init.sqf";


/* add Mission EHs */
_null = execVM "modules\Nametags\Nametags_Init.sqf";	// Nametags
_null = execVM "modules\MissionProtectionSystem\MPS_Init.sqf";	// 3rd Person Restriction & Vehicle Restriction
/* Mission EHs added */


// (disable radio callouts and -texts) can be set via difficulty settings
//0.1 fadeRadio 0;		// <-- out commented by psycho, this command stops working of some required game sounds (f.e. the *pieppiep* if a launcher has a target switched on)
enableRadio false;
enableSentences false;


/* mission specific code comes here */



/* end of mission specific code */


// log end of execution
diag_log format ["%1 --- init.sqf executed",diag_ticktime];