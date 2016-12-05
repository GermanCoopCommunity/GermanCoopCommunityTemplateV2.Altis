// by Fabi & Quentin


// log start of execution
if !(player diarySubjectExists "Modules") then {player createDiarySubject ["Modules","Modules"];};
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
			BOOLEAN - true for password correct
		1:
			STRING - name of dialog
		2:
			NUMBER - amount of attempts allowed
		3:
			BOOLEAN - true to kick player if he answered wrong, false to only set him back to slot screen
		4:
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
PW_correct = false;

MPS_fnc_PW = {
	// declare given arguments in local variables
	private _dialog = _this select 0;
	private _PW_att_all = _this select 1;
	private _kickIfWrong = _this select 2;
	private _furtherCode = _this select 3;


	// code
	createDialog _dialog;
	0 cutText ["Beantworten Sie die Frage, Soldat!","BLACK FADED",0,true];	// ...turn screen black as long as security question isn't answered
	waitUntil {!dialog};
	if (!PW_correct) then
	{
		if (PW_Attempts < _PW_att_all) then
		{
			hint format ["Falsch. Sie haben noch %1 Versuch(e).",PW_Attempts - _PW_att_all];
			PW_Attempts = PW_Attempts + 1;
			0 cutText ["Beantworten Sie die Frage, Soldat!","BLACK FADED",0,true];	// ...turn screen black as long as security question isn't answered
			[_dialog,PW_Attempts - _PW_att_all,_kickIfWrong,_furtherCode] call MPS_fnc_PW;
		}
		else
		{
			if (_kickIfWrong) then
			{
				[100] call MPS_fnc_AddFoul;
			}
			else
			{
				endMission "LOSER";
			};
		};
	}
	else
	{
		_furtherCode; closeDialog 0;
	};
};


/* Fouler Rejoin Protection */
PW_Attempts = 1;	// ...set this as his first password attempt
if ((getPlayerUID player) in Blacklist && {!((getPlayerUID player) in Whitelist)}) then	// if player has already been kicked and therefor is on blacklist and he is also not on the whitelist of trustworthy people...
{
	["FRP",1,false,{Blacklist = Blacklist - [getPlayerUID player]}] call MPS_fnc_PW;
};
/* Fouler Rejoin Protection section finished */


/* Idiotentest */
// check on join, if JIPer speaks German
PW_Attempts = 1;	// ...set this as his first password attempt
if (isMultiplayer && {didJIP}) then
{
	["CheckGerman",2,false,true] call MPS_fnc_PW;
	waitUntil {!dialog};	// ...wait until dialog is answered
	["CheckGerman2",2,false,true] call MPS_fnc_PW;
	waitUntil {!dialog};	// ...wait until dialog is answered
	["CheckGerman3",2,false,true] call MPS_fnc_PW;
	waitUntil {!dialog};	// ...wait until dialog is answered
	["CheckGerman4",2,false,true] call MPS_fnc_PW;
};
/* Idiotentest section finished */


/* Slot Protection dialogs */
PW_Attempts = 1;	// ...set this as his first password attempt
if (isMultiplayer) then	// only if it is multiplayer mode, for editor purposes
{
	// check on join, if...
	// ...player has pilot password
	if (typeOf player in Pilots) then	// if player is a pilot...	
	{
		["CheckPilot",3,false,true] call MPS_fnc_PW;
		
	};

	// ...player has curator password
	if (typeOf player in Curators) then
	{
		["CheckCurator",3,false,true] call MPS_fnc_PW;	// ...create according security dialog
	};

	// ...player has OPZ password
	if (typeOf player in Officers) then	// if player is a curator...
	{
		["CheckOfficer",3,false,true] call MPS_fnc_PW;
	};
};
/* Slot Protection section finished */


// log end of execution
player createDiaryRecord ["Modules",["MPS Sec Diags","<font color='#107b1b'>Ausführung beendet</font color> nach " + str(time) + " Sekunden."]];