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
		{
		};
	}
];


// return
_return = true;
_return;
