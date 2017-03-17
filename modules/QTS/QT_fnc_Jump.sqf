// Quentins Jump
/*
	Author: Quentin

	Description:
	plays jump move when player oversteps something

	Parameter(s):
		none

	Returns:
	true
*/

/* To Do

- check if V button in fact assigned to step over and not changed by user
- add switchMove command to CfgRemoteExecution

*/
/* Notes

- AovrPercMrunSrasWrflDf	// jump move

*/


// add EHs to unit
waituntil {!(isNull (findDisplay 46))};	// wait until main display is initialized
QT_Jump_Display_EH = (findDisplay 46) displayAddEventHandler
[
	"KeyDown",
	{
		// declare EH variables
		private _DIK = _this select 1;
			
		// code
		if (_DIK isEqualTo 47 && {!isWalking player} && {stance player isEqualTo "STAND"} && {speed player > 0}) then	// if player presses assigned button, isn´t walking and is standing (which means he must be running)...
		{
			[player,"AovrPercMrunSrasWrflDf"] remoteExec ["switchMove",0];	// ...let player play jump move for all machines...
			true	// ... and prevent default step-over-move
		};
	}
];


// create diary entry explanation
if !(player diarySubjectExists "QTS") then {player createDiarySubject ["QTS","QTS"];}; // create "QTS" diary entry with usage hints for player
player createDiaryRecord [
	"QTS",
	[
		"Springen",
			"<br/><font color='#107b1b'>V</font color> auf der Tastatur, um während des Laufens zu springen."
	]
];


// return
_return = true;
_return;