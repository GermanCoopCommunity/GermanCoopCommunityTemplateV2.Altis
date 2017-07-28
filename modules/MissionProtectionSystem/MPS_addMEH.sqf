// by Quentin


// log start of execution
//if !(player diarySubjectExists "Modules") then {player createDiarySubject ["Modules","Modules"];}; // create "Modules" diary entry for player
player createDiaryRecord ["Modules",["MPS MEH","<font color='#b40100'>Ausführung begonnen</font color> nach " + str(time) + " Sekunden."]];


// add Mission EHs
if (isNil "MPS_BaseMrkr") then	// if mission builder has placed a BaseMarker...
{
	ThrdPrs_MEH = addMissionEventHandler ["Draw3D",	// ...add 3rd-Person-MEH
	{
		if
		(
			isNull objectParent player	// if player is on foot...
			&&
			{cameraView isEqualTo "EXTERNAL"}	// ...and he switches his camera to 3rd Person...
			&&
			{(player distance (getMarkerPos "MPS_BaseMrkr")) > 400}	// ...and he is outside base...
		)
		then
		{
			["<t size='0.8'>3rd Person ist außerhalb der Basis nur in Fahrzeugen verfügbar, Soldat.</t>",0,0,4,0] spawn BIS_fnc_dynamicText;	// ...inform him
			player switchCamera "INTERNAL";	// ...switch camera back to 1st Person
		};
	}];
}
else	// ...otherwise...
{
	if (!isNil "MPS_BaseMrkr") then	// ...if there is no object called "MPS_BaseMrkr"...
	{
		["<t color='#ff0000' size ='1.5'>Es gibt keinen BaseMarker!<br/>Erstelle ein Objekt namens ""MPS_BaseMrkr"" und platziere es ins Zentrum der Spielerbasis, damit das Schutzsystem arbeiten kann.</t>",0,0,10,0] spawn BIS_fnc_dynamicText;	// ...tell him
	};
};


Veh_Restrct_MEH = addMissionEventHandler ["Draw3D",
{
	if
	(
		!isNull objectParent player	// if player is in a vehicle...
		&&
		!((getText (configfile >> "CfgVehicles" >> typeOf objectParent player >> "vehicleClass") isEqualTo "Submarine") or (typeOf objectParent player isEqualTo "Steerable_Parachute_F"))	// ...which is not an SDV (as only basic divers can maneuver them) or a parachute (for players mustn't be ejected out of them)...
		&&
		{(objectParent player isKindOf "Tank") or {objectParent player isKindOf "Air"}}	// ...but is a tank or an aircraft... (to exclude crew requirements for cars and trucks)
		&&
		{((typeOf player) != (getText (configFile >> "CfgVehicles" >> typeOf objectParent player >> "crew")))}	// ...and he is not the same class as needed to crew that vehicle...
		&&
		{(player isEqualTo commander objectParent player) or (player isEqualTo driver objectParent player) or (player isEqualTo (objectParent player turretUnit [0]))}	// ...and he is either commander, driver or copilot of the vehicle...
	)
	then
	{
		_veh = objectParent player;
		["Sie sind kein " + (getText (configFile >> "CfgVehicles" >> (getText (configFile >> "CfgVehicles" >> typeOf _veh >> "crew")) >> "DisplayName"))+ ".<br/>" + "Überlassen Sie diesen Platz jemandem, der dafür auch ausgebildet ist, Soldat.",0,0,4,0] spawn BIS_fnc_dynamicText;	// ...warn him
		player action ["GetOut",_veh];	// ...eject him out of the vehicle
		if (isNull driver _veh) then {_veh engineOn false;};
	};
}];


// log end of execution
player createDiaryRecord ["Modules",["MPS MEH","<font color='#107b1b'>Ausführung beendet</font color> nach " + str(time) + " Sekunden."]];