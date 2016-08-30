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
- fade speech and music too (not radio because important for ingame sound)

*/
/* Notes

- Left Windows Key to toggle earplugs

*/


// set soundVolume to full initially
0.1 fadeSound 1;
//0.1 fadeSpeech 1;
//0.1 fadeMusic 1;


// set earplugs to "out" initially
player setVariable ["EarplugsIn",false];


// add EHs to unit
waituntil {!(isNull (findDisplay 46))};	// wait until main display is initialized
(findDisplay 46) displayAddEventHandler [
	"KeyDown",
	{
		// declare EH variables
		private _DIK = _this select 1;
		
		
		if (_DIK == 219) then
		{
			if !(player getVariable "EarplugsIn") then
			{
				0.1 fadeSound (soundVolume / 2);
				//0.1 fadeSpeech 0.25;
				//0.1 fadeMusic 0.25;
				["Ohrstöpsel eingesetzt.",1,0,3,0] spawn bis_fnc_dynamicText;
				player setVariable ["EarplugsIn",true];
			}
			else
			{
				0.1 fadeSound (soundVolume * 2);
				//0.1 fadeSpeech 1;
				//0.1 fadeMusic 1;
				["Ohrstöpsel entfernt.",1,0.1,3,0] spawn bis_fnc_dynamicText;
				player setVariable ["EarplugsIn",false];
			};
		};
	}
];


player addEventHandler [	// reset volume on players death
	"Respawn",
	{
		1 fadeSound 1;
		//1 fadeSpeech 1;
		//1 fadeMusic 1;
	}
];


// return
true;