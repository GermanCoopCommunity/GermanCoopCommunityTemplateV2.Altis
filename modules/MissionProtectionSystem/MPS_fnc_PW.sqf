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
[true,""CheckPilot"",3,false,true] call MPS_fnc_PW;

*/


// declare given arguments in local variables
private _PW_correct = _this select 0;
private _dialog = _this select 1;
private _PW_att_all = _this select 2;
private _kickIfWrong = _this select 3;
private _furtherCode = _this select 4;


// code
if (!_PW_correct) then
{
	if (PW_attempts < _PW_att_all) then
	{
		hint format ["Falsch. Sie haben noch %1 Versuch(e).",PW_Attempts - _PW_att_all];
		PW_Attempts = PW_Attempts + 1;
		0 cutText ["Beantworten Sie die Frage, Soldat!","BLACK FADED",0,true];	// ...turn screen black as long as security question isn't answered
		createDialog _dialog;
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


// return
true;