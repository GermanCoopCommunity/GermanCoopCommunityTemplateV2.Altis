// Quentins Gestures
/*
	Author: Quentin

	Description:
	assigns hotkeys (4-8) for quick gestures

	Parameter(s):
		0:
			OBJECT - player unit

	Returns:
	String
*/

/* To Do

- check if buttons already assigned to another important action
- playAction or playActionNow?

*/
/* Notes

// militarily important
gestureAdvance / gesturePoint // Same
gestureGo
gestureGoB	// not so pretty
gestureCeaseFire
// not militarily important
gestureCover	// not so pretty
gestureFollow	// not so pretty
gestureFreeze
gestureHi
gestureHiB
gestureHiC
gestureNo
gestureNod / gestureYes	// second is a bit slower but same
gestureUp	// not so pretty

*/


// add EHs to unit
waituntil {!(isNull (findDisplay 46))};	// wait until main display is initialized
(findDisplay 46) displayAddEventHandler [
	"KeyDown",
	{
		private _DIK = _this select 1;
		if (_DIK == 5) then
		{
			player playAction "gestureAdvance";
			if (shownChat) then
			{
				player groupChat "Go!";
			};
		};
		if (_DIK == 6) then
		{
			player playAction "gestureFreeze";
			if (shownChat) then
			{
				player groupChat "Stop!";
			};
		};
		if (_DIK == 7) then
		{
			player playAction "gestureYes";
			if (shownChat) then
			{
				player groupChat "Affirmative!";
			};
		};
		if (_DIK == 8) then
		{
			player playAction "gestureNo";
			if (shownChat) then
			{
				player groupChat "Negative!";
			};
		};
		if (_DIK == 9) then
		{
			private _dir = "";
			
			if (getDir player > 315 or getDir player <= 45) then
			{
				_dir = "north";
			};
			if (getDir player > 45 && getDir player <= 135) then
			{
				_dir = "west";
			};
			if (getDir player > 135 && getDir player <= 225) then
			{
				_dir = "south";
			};
			if (getDir player > 225 && getDir player <= 315) then
			{
				_dir = "east";
			};
			
			player playAction "gestureGo";
			if (shownChat) then
			{
				player groupChat format ["Sighting at %1, %2!", round (getDir player), _dir];
			};
		};
	}
];


// return
true;