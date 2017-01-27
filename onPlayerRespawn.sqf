// by Quentin


// log start of execution
//if !(player diarySubjectExists "Modules") then {player createDiarySubject ["Modules","Modules"];}; // create "Modules" diary entry for player
player createDiaryRecord ["Modules",["onPlayerRespawn","<font color='#b40100'>Ausführung begonnen</font color> nach " + str(time) + " Sekunden."]];


// ZFW
private _ZFW_onPlayerRespawn = compile preprocessFileLineNumbers "modules\ZeusFramework\ZFW_onPlayerRespawn.sqf";
call _ZFW_onPlayerRespawn;


// apply default unit loadout on respawn
player setUnitLoadout plyr_ldt;


/* mission specific code comes here */



/* end of mission specific code */


// log end of execution
player createDiaryRecord ["Modules",["onPlayerRespawn","<font color='#107b1b'>Ausführung beendet</font color> nach " + str(time) + " Sekunden."]];