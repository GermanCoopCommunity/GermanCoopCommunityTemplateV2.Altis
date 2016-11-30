// by Quentin


// log start of execution
if !(player diarySubjectExists "Modules") then {player createDiarySubject ["Modules","Modules"];};
player createDiaryRecord ["Modules",["Loadout InitClient","<font color='#b40100'>Ausführung begonnen</font color> nach " + str(time) + " Sekunden."]];


/* Player Loadout */
waitUntil {!isNil "Officers"};
// ...modify loadout as you like
if (side player isEqualTo "WEST") then
{
	if (typeOf player in Officers) then {player addHeadgear "H_Beret_02";};	// if player is a US Officers, assign him the Officers military cap
	if (rank player isEqualTo "COLONEL") then {player addHeadgear "H_Beret_Colonel";};	// if player is a US Officers with colonel rank, assign him the colonel military cap
};
plyr_ldt = getUnitLoadout player;	// save default player loadout to apply on respawn later
//if ((_this select 0) isEqualTo 1) then {_null = execVM "modules\MissionParams\setWoodland.sqf";};	// if US players are to wear woodland camouflage, execute according file
/* Player Loadout set */


// log end of execution
player createDiaryRecord ["Modules",["Loadout InitClient","<font color='#107b1b'>Ausführung beendet</font color> nach " + str(time) + " Sekunden."]];