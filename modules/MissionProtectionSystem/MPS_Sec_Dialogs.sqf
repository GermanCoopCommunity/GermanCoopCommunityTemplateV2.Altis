// by Fabi & Quentin


// log start of execution
//if !(player diarySubjectExists "Modules") then {player createDiarySubject ["Modules","Modules"];}; // create "Modules" diary entry for player
player createDiaryRecord ["Modules",["MPS Sec Diags","<font color='#b40100'>Ausführung begonnen</font color> nach " + str(time) + " Sekunden."]];


// wait for mission start
waitUntil {time > 0};


// define Password Control Function
// Quentins MPS Password Control
/*
	Author: Quentin

	Description:
	checks passwords on joining player

	Parameter(s):
		0:
			STRING - name of dialog
		1:
			NUMBER - amount of attempts allowed
		2:
			BOOLEAN - true to kick player if he answered wrong, false to only set him back to slot screen
		3:
			CODE - code to be executed if test was passed

	Returns:
	true
*/
/* To Do



*/
/* Notes

example:
["CheckPilot",3,false,true] call MPS_fnc_PW;

*/


MPS_fnc_PW = {

	// declare given arguments in local variables
	private _dialog = _this select 0;
	private _PW_att_all = _this select 1;
	private _kickIfWrong = _this select 2;
	private _furtherCode = _this select 3;


	// code
	player enableSimulation false;	// ...make player immobile
	//while {PW_correct isEqualTo false} do {0 cutText ["Beantworten Sie die Frage, Soldat!","BLACK FADED",0,true];};	// ...turn screen black as long as security question isn't answered
	0 cutText ["Beantworten Sie die Frage, Soldat!","BLACK FADED",0,true];	// ...turn screen black as long as security question isn't answered
	createDialog _dialog;
	waitUntil {!dialog};
	if (!PW_correct) then
	{
		if (PW_Attempts < _PW_att_all) then
		{
			hint format ["Falsch. Sie haben noch %1 Versuch(e).",_PW_att_all - PW_Attempts];
			PW_Attempts = PW_Attempts + 1;
			[_dialog,PW_Attempts - _PW_att_all,_kickIfWrong,_furtherCode] call MPS_fnc_PW;	// ...recall fnc for another attempt
		}
		else
		{
			if (_kickIfWrong) then
			{
				if !(getPlayerUID player in Whitelist) then {[100] call MPS_fnc_AddFoul;};	// ...kick player
			}
			else
			{
				if !(getPlayerUID player in Whitelist) then {endMission "LOSER";};	// ...take player back to lobby
			};
		};
	}
	else
	{
		hint "";	// ...remove possible hint remains
		_furtherCode;	// ...execute given code		
		player enableSimulation true;	// ...make player mobile
		//closeDialog 0;	// already done by the dialogs themselves
	};
};


/* Fouler Rejoin Protection */
if ((getPlayerUID player) in Blacklist && {!((getPlayerUID player) in Whitelist)}) then	// if player has already been kicked and therefor is on blacklist and he is also not on the whitelist of trustworthy people...
{
	PW_Attempts = 0;	// ...set this as players first password attempt
	PW_correct = false;
	["FRP",1,true,{Blacklist = Blacklist - [getPlayerUID player]; publicVariable "Blacklist"}] call MPS_fnc_PW;
};
/* Fouler Rejoin Protection section finished */


/* Idiotentest */
// check on join, if JIPer speaks German
if !((getPlayerUID player) in Whitelist) then
{
	PW_Attempts = 0;	// ...set this as players first password attempt
	PW_correct = false;
	if (isMultiplayer && {didJIP}) then
	{
		["CheckGerman",2,false,true] call MPS_fnc_PW;
		waitUntil {!dialog};	// ...wait until dialog is answered
		PW_correct = false;
		["CheckGerman2",2,false,true] call MPS_fnc_PW;
		waitUntil {!dialog};	// ...wait until dialog is answered
		PW_correct = false;
		["CheckGerman3",2,false,true] call MPS_fnc_PW;
		waitUntil {!dialog};	// ...wait until dialog is answered
		PW_correct = false;
		["CheckGerman4",2,false,true] call MPS_fnc_PW;
		Whitelist pushBackUnique (getPlayerUID player);
		publicVariable "Whitelist";
	};
};
/* Idiotentest section finished */


/* Slot Protection dialogs */
if (isMultiplayer && {!((getPlayerUID player) in Whitelist)}) then	// only if it is multiplayer mode, for editor purposes, and player isn't whitelisted
{
	PW_Attempts = 0;	// ...set this as players first password attempt
	PW_correct = false;
	// check on join, if...
	// ...player has pilot password
	if (typeOf player in Pilots) then	// if player is a pilot...	
	{
		["CheckPilot",3,false,true] call MPS_fnc_PW;	// ...create according security dialog
		
	};

	// ...player has curator password
	if (typeOf player in Curators) then	// if player is an Curator...
	{
		PW_correct = false;
		["CheckCurator",3,false,true] call MPS_fnc_PW;	// ...create according security dialog
	};

	// ...player has OPZ password
	if (typeOf player in Officers) then	// if player is an Officer...
	{
		PW_correct = false;
		["CheckOfficer",3,false,true] call MPS_fnc_PW;	// ...create according security dialog
	};
	
	// ...player has Spectator password
	if (typeOf player isEqualTo "VirtualSpectator_F") then	// if player is a Spectator...
	{
		PW_correct = false;
		["CheckSpec",3,false,true] call MPS_fnc_PW;	// ...create according security dialog
	};
};
/* Slot Protection section finished */


// log end of execution
player createDiaryRecord ["Modules",["MPS Sec Diags","<font color='#107b1b'>Ausführung beendet</font color> nach " + str(time) + " Sekunden."]];