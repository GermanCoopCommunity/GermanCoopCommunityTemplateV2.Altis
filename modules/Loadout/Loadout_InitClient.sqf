// by Quentin


// log start of execution
//if !(player diarySubjectExists "Modules") then {player createDiarySubject ["Modules","Modules"];}; // create "Modules" diary entry for player
player createDiaryRecord ["Modules",["Loadout InitClient","<font color='#b40100'>Ausführung begonnen</font color> nach " + str(time) + " Sekunden."]];


/* Player Loadout */
waitUntil {!isNil "Officers"};

if (side player isEqualTo WEST) then
{
	if (typeOf player in Officers) then {player addHeadgear "H_Beret_02";};	// if player is a US Officer, assign him the Officers military cap
	if (rank player isEqualTo "COLONEL") then {player addHeadgear "H_Beret_Colonel";};	// if player is a US Officer with colonel rank, assign him the colonel military cap
};

/*

...modify loadout as you like here

*/

plyr_ldt = getUnitLoadout player;	// save default player loadout to apply on respawn later

// set camos
#define UK	// replace "Camo" with any of the below to apply this camo to players
#ifdef Woodland	// works fully
_null = [] execVM "modules\Loadout\Camos\setWoodland.sqf";
#endif
#ifdef Tropentarn	// doesn't work fully
_null = [] execVM "modules\Loadout\Camos\setTropentarn.sqf";
#endif
#ifdef Flecktarn	// doesn't work fully
_null = [] execVM "modules\Loadout\Camos\setFlecktarn.sqf";
#endif
#ifdef Sage	// doesn't work fully
_null = [] execVM "modules\Loadout\Camos\setSage.sqf";
#endif
#ifdef UN	// doesn't work fully
_null = [] execVM "modules\Loadout\Camos\setUN.sqf";
#endif
#ifdef UK	// doesn't work fully
_null = ["NonTanoa"] execVM "modules\Loadout\Camos\setUK.sqf";
//_null = ["Tanoa"] execVM "modules\Loadout\Camos\setUK.sqf";	// use this, if you want to equip the players with Tanoan UK-Camo (APEX-DLC NEEDED!)
#endif

// set player night vision preferences (comment out with // at the start of the next line to deactivate taking NVGs from player)
_null = [] execVM "modules\Loadout\NVG\setPlayerNVG.sqf";
// set AI night vision preferences (comment out with // at the start of the next line to deactivate taking NVGs from AI)
_null = [] execVM "modules\Loadout\NVG\setAINVG.sqf";
// set player weapon flashlight preferences (comment out with // at the start of the next line to deactivate replacing player's laser attachment with flashlight)
_null = [] execVM "modules\Loadout\setPlayerFlashlight.sqf";
/* Player Loadout set */


// log end of execution
player createDiaryRecord ["Modules",["Loadout InitClient","<font color='#107b1b'>Ausführung beendet</font color> nach " + str(time) + " Sekunden."]];