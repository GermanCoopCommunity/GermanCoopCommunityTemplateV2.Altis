// by Quentin


// log start of execution
diag_log format ["%1 --- Executing init.sqf",diag_ticktime];


/* initialize QTS */
if (isNil "QT_call_fncs") then	// if QTS hasn't been initialized yet...
{
	// ...precompile fncs	
	QT_fnc_Earplugs = compile preprocessFileLineNumbers "modules\QTS\QT_fnc_Earplugs.sqf";
	QT_fnc_Insignia = compile preprocessFileLineNumbers "modules\QTS\QT_fnc_Insignia.sqf";
	QT_fnc_Gestures = compile preprocessFileLineNumbers "modules\QTS\QT_fnc_Gestures.sqf";
	QT_fnc_Jump = compile preprocessFileLineNumbers "modules\QTS\QT_fnc_Jump.sqf";
	KK_fnc_StreamUAV = compile preprocessFileLineNumbers "modules\QTS\UAVStream\KK_fnc_StreamUAV.sqf";
	JK_fnc_NameTags = compile preprocessFileLineNumbers "modules\QTS\JK_fnc_NameTags.sqf";

	// ...define fnc arrays
	QT_call_fncs = [QT_fnc_Earplugs,QT_fnc_Insignia,QT_fnc_Gestures,QT_fnc_Jump];
	QT_spawn_fncs = [];
	QT_AI_call_fncs = [QT_fnc_Insignia];
	QT_AI_spawn_fncs = [];

	// apply QTS to AI units
	{[_x] call QT_fnc_Insignia} count (allUnits - (allPlayers - entities "HeadlessClient_F"));

	// apply QTS on player
	{[player] call _x} count QT_call_fncs;
	{[player] spawn _x} forEach QT_spawn_fncs;
};
/* QTS initialization complete */


// added by psycho, needed to reset EH, mission EHs can avoid unwanted impacts on mission flow (for example after player slot changed)
removeAllMissionEventHandlers "Draw3D";


/* add Mission EHs */
// Nametags
if !((isClass (configFile >> "CfgPatches" >> "cba_ee")) && ((isClass (configFile >> "CfgPatches" >> "A3C_NameTag")) or (isClass (configFile >> "CfgPatches" >> "STNametags")))) then	// if player doesn´t run the nametag mods STNameTags and A3C_NameTag...
{addMissionEventHandler ["Draw3D",{_this call JK_fnc_NameTags}];};	// ...initialize JK Nametags for player

// 3rd Person in vehicles only
ThrdPrs_MEH = addMissionEventHandler ["Draw3D",{
	if
	(
		isNull objectParent player	// if player is on foot...
		&&
		{cameraView == "EXTERNAL"}	// ...and he switches his camera to 3rd Person...
		&&
		{(player distance (getMarkerPos "MPS_BaseMrkr")) > 400}	// ...and he is outside base...
	)
	then
	{
		["<t size='0.8'>3rd Person ist außerhalb der Basis nur in Fahrzeugen verfügbar, Soldat.</t>",0,0,4,0] spawn bis_fnc_dynamicText;	// ...inform him
		player switchCamera "INTERNAL";	// ...switch camera back to 1st Person
	};
}];

// Vehicle Restriction: forbid players to operate vehicles they aren't in class for
Veh_Restrct_MEH = addMissionEventHandler ["Draw3D",{
	if
	(
		!isNull objectParent player	// if player is in vehicle...
		&&
		!((getText (configfile >> "CfgVehicles" >> typeOf objectParent player >> "vehicleClass") == "Submarine") or (typeOf objectParent player == "Steerable_Parachute_F"))	// ...which is not an SDV (as only basic divers can maneuver them) or a parachute (for players mustn't be ejected out of them)...
		&&
		{(objectParent player isKindOf "Tank") or {objectParent player isKindOf "Air"}}	// ...but a tank or an aircraft... (to exclude crew requirements for cars and trucks)
		&&
		{((typeOf player) != (getText (configFile >> "CfgVehicles" >> typeOf objectParent player >> "crew")))}	// ...and he is not the same class as needed to crew that vehicle...
		&&
		{(player isEqualTo commander objectParent player) or (player isEqualTo driver objectParent player) or (player == objectParent player turretUnit [0])}	// ...and he is either commander, driver or copilot of the vehicle...
	)
	then
	{
		["<t size='0.8'>Überlassen Sie diesen Platz jemandem, der dafür auch ausgebildet ist, Soldat.</t>",0,0,4,0] spawn bis_fnc_dynamicText;	// ...warn him
		//hintSilent format ["Nur ein %1 ist für die Bedienung dieses Fahrzeuges ausgebildet.", getText (configFile >> "CfgVehicles" >> (getText (configFile >> "CfgVehicles" >> typeOf (objectParent player) >> "crew")) >> "DisplayName")];
		player action ["GetOut",objectParent player];	// ...eject him out of the vehicle
	};
}];
/* mission EHs added */


// increase view distance
setViewDistance 4000;


// (disable radio callouts and -texts) can be set via difficulty settings
//0.1 fadeRadio 0;		// <-- out commented by psycho, this command stops working of some required game sounds (f.e. the *pieppiep* if a launcher has a target switched on)
enableRadio false;
enableSentences false;


/* mission specific code comes here */



/* end of mission specific code */


// log end of execution
diag_log format ["%1 --- init.sqf executed",diag_ticktime];