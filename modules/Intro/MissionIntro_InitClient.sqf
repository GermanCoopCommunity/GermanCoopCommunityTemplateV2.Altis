// by Quentin


/* Intro */
if (isMultiplayer) then
{
	if !((typeOf player in Curators) or {typeOf player isEqualTo "VirtualSpectator_F"}) then {[player,"US-Basis Almyra, Altis, Mittelmeer"] call BIS_fnc_establishingShot;};
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