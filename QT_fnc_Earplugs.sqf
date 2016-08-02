// Quentins Earplugs
/*
	Author: Quentin

	Description:
	add earplugs to player

	Parameter(s):
		0:
			OBJECT - player unit

	Returns:
	String
*/

/* To Do

- check if buttons already assigned to another important action

*/
/* Notes

- Key 9

*/

// set soundVolume to full initially
0.1 fadeSound 1;
0.1 fadeSpeech 1;
0.1 fadeRadio 1;
0.1 fadeMusic 1;


// add EHs to unit
waituntil {!(isNull (findDisplay 46))};	// wait until main display is initialized
(findDisplay 46) displayAddEventHandler [
	"KeyDown",
	{
		private _DIK = _this select 1;
		if (_DIK == 10) then
		{
			if (soundVolume >= 0.5) then
			{
				0.1 fadeSound 0.25;
				0.1 fadeSpeech 0.25;
				0.1 fadeRadio 0.25;
				0.1 fadeMusic 0.25;
				hint "Ohrstöpsel eingesteckt";
			}
			else
			{
				0.1 fadeSound 1;
				0.1 fadeSpeech 1;
				0.1 fadeRadio 1;
				0.1 fadeMusic 1;
				hint "Ohrstöpsel entfernt";
			};
		};
	}
];
player addEventHandler [	// reset volume on players death
	"Respawn",
	{
		1 fadeSound 1;
		1 fadeSpeech 1;
		1 fadeRadio 1;
		1 fadeMusic 1;
	}
];


// return
true;