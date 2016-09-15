// Quentins Jump
/*
	Author: Quentin

	Description:
	plays jump move when player oversteps something

	Parameter(s):
		0:
			OBJECT - player unit

	Returns:
	String
*/

/* To Do

- check if V button in fact assigned to step over and not changed by user

*/
/* Notes

// jump move
- AovrPercMrunSrasWrflDf

*/

// declare local variables
private _unit = _this select 0;


// add EHs to unit
waituntil {!(isNull (findDisplay 46))};	// wait until main display is initialized
(findDisplay 46) displayAddEventHandler
[
	"KeyDown",
	{
		// declare EH variables
		private _DIK = _this select 1;
			
		// code
		if (_DIK == 47 && {!isWalking player} && {stance player == "STAND"}) then	// if player presses assigned button, isn´t walking and is standing (which means he must be running)...
		{
			player switchMove "AovrPercMrunSrasWrflDf";	// ...let player play jump move...
			true	// ... and prevent default step-over-move
		};
	}
];


// return
_return = true;
_return;