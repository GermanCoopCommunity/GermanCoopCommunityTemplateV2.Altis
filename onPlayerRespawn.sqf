// by Quentin


// log start of execution
_newUnit = _this select 0;
//if !(_newUnit diarySubjectExists "Modules") then {_newUnit createDiarySubject ["Modules","Modules"];}; // create "Modules" diary entry for player
_newUnit createDiaryRecord ["Modules",["onPlayerRespawn","<font color='#b40100'>Ausführung begonnen</font color> nach " + str(time) + " Sekunden."]];




// ZFW
private _ZFW_onPlayerRespawn = compile preprocessFileLineNumbers "modules\ZeusFramework\ZFW_onPlayerRespawn.sqf";
call _ZFW_onPlayerRespawn;

// Aufwachanimation
if !(secondaryWeapon _newUnit isEqualTo "") then
{
	waitUntil {!isNull _newUnit};
	_newUnit switchMove "Acts_UnconsciousStandUp_part1";
	_newUnit playMove "Acts_UnconsciousStandUp_part2";
};


// apply default unit loadout on respawn
_newUnit setUnitLoadout plyr_ldt;


/* mission specific code comes here */



/* end of mission specific code */


// log end of execution
_newUnit createDiaryRecord ["Modules",["onPlayerRespawn","<font color='#107b1b'>Ausführung beendet</font color> nach " + str(time) + " Sekunden."]];