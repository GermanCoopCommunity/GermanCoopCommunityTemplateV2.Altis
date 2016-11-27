// Quentins Gestures
/*
	Author: Quentin

	Description:
	assigns hotkeys (4-8) for quick gestures

	Parameter(s):
		0:
			OBJECT - player unit

	Returns:
	true
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
QT_Gestures_Display_EH = (findDisplay 46) displayAddEventHandler [
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


// create diary entry explanation
player createDiarySubject ["Gesten","Gesten"];
player createDiaryRecord [
	"Gesten",
	[
		"Info",
			"Folgende Zahlen auf der Tastatur unter den F-Tasten, um folgende Gesten auszuführen:<br/><br/><font color='#107b1b'>5</font color> - ""Los!""<br/><font color='#107b1b'>6</font color> - ""Stop!""<br/><font color='#107b1b'>7</font color> - ""Ja!""<br/><font color='#107b1b'>8</font color> - ""Nein!""<br/><font color='#107b1b'>9</font color> - ""Sichtung auf (Gradangabe)!"""""
	]
];


// return
true;