// by Quentin


// wait until security dialogs are answered
waitUntil {!isNil "PW_correct"};
waitUntil {!dialog && (PW_correct isEqualTo true)};

/* Intro */
if (isMultiplayer) then
{
	if !((typeOf player in Curators) or {typeOf player isEqualTo "VirtualSpectator_F"}) then
	{
		[player,"Standort: " + worldName + ", Ziel: " + rank player + " " + name player + ", Gruppe: " + (str(group player) select [2]),50] call BIS_fnc_establishingShot;
	};
	[[ 
	  ["Willkommen","<t align = 'center' shadow = '1' size = '1' font='PuristaBold'>%1</t>"], 
	  ["bei der GeCo!","<t align = 'center' shadow = '1' size = '1' font='PuristaBold'>%1</t>"],
	  [""],
	  [""]
	]] spawn BIS_fnc_typeText;
	["img\loadingpic.paa"] spawn BIS_fnc_textTiles;	// show img
	0 cutText ["","BLACK IN",5];
};
/* Intro complete */