// by Quentin


// log start of execution
diag_log format ["%1 --- Executing init.sqf",diag_ticktime];


////////////////////////////////////////////////// initialize QTS //////////////////////////////////////////////////
// precompile fncs
QT_fnc_Earplugs = compile preprocessFileLineNumbers "scripts\fnc\QT_fnc_Earplugs.sqf";
QT_fnc_Insignia = compile preprocessFileLineNumbers "scripts\fnc\QT_fnc_Insignia.sqf";
QT_fnc_Gestures = compile preprocessFileLineNumbers "scripts\fnc\QT_fnc_Gestures.sqf";
QT_fnc_Jump = compile preprocessFileLineNumbers "scripts\fnc\QT_fnc_Jump.sqf";


// define fnc arrays
QT_call_fncs = [QT_fnc_Earplugs,QT_fnc_Insignia,QT_fnc_Gestures,QT_fnc_Jump];
QT_spawn_fncs = [];
QT_AI_call_fncs = [QT_fnc_Insignia];
QT_AI_spawn_fncs = [];


// apply QTS to AI units
if (!isNil "QT_AI_call_fncs") then
{
	{[_x] call QT_fnc_Insignia} count (allUnits - (allPlayers - entities "HeadlessClient_F"));
};
/*if (!isNil "QT_AI_spawn_fncs") then
{
	
};*/
////////////////////////////////////////////////// QTS initialization complete //////////////////////////////////////////////////


// added by psycho, needed to reset EH, mission EH's can avoid unwanted impacts on mission flow (for example after player slot changed)
removeallMissionEventHandlers "Draw3D";
// editing purposes
if !(isMultiplayer) then {{_x disableAI "MOVE"} forEach allUnits};


////////////////////////////////////////////////// add Mission EHs //////////////////////////////////////////////////
// Nametags
JK_fnc_NameTags = compile preprocessFileLineNumbers "scripts\fnc\JK_fnc_NameTags.sqf";
if !((isClass (configFile >> "CfgPatches" >> "cba_ee")) && ((isClass (configFile >> "CfgPatches" >> "A3C_NameTag")) || (isClass (configFile >> "CfgPatches" >> "STNametags")))) then	// if player doesn´t run the nametag mods STNameTags and A3C_NameTag...
{
	addMissionEventHandler ["Draw3D", {_this call JK_fnc_NameTags}];	// ...initialize JK Nametags for player
};


// (disable radio callouts and -texts) can be set via difficulty settings
//0.1 fadeRadio 0;		// <-- out commented by psycho, this command stops working of some required game sounds (f.e. the *pieppiep* if a launcher has a target switched on)
enableRadio false;
enableSentences false;


// 3rd Person in vehicles only
addMissionEventHandler ["Draw3D", {
	if (
		(
			isNull objectParent player	// if player is on foot...
			&&
			{cameraView == "EXTERNAL"}	// ...and he switches his camera to 3rd Person...
			&&
			{(player distance (getmarkerpos "GeCo_MissionProtection_BaseMarker")) >= (getMarkerSize "GeCo_MissionProtection_BaseMarker") select 0}	// ...and he ist outside base...
		)
		or
		{
			!isNull objectParent player	// if player isn´t on foot...
			&&
			{cameraView == "EXTERNAL"}	// ...and he switches his camera to 3rd Person...
			&&
			{!((player isEqualTo commander objectParent player) or (player isEqualTo driver objectParent player) or /*(player isEqualTo gunner objectParent player) or */(player == vehicle player turretUnit [0]))}	// ...and he is only passenger in the vehicle...
			&&
			{(player distance (getmarkerpos "GeCo_MissionProtection_BaseMarker")) >= (getMarkerSize "GeCo_MissionProtection_BaseMarker") select 0}	// ...and he ist outside base...
		}
	)
	then
	{
		player switchCamera "INTERNAL";	// ...switch camera back to 1st Person
		["<t size='0.8'>3rd Person ist außerhalb der Basis nur für Crewmitglieder (Fahrer/(Co-)Piloten, Kommandanten, Bordschützen...) in ihren Fahrzeugen verfügbar.</t>",0,0,4,0] spawn bis_fnc_dynamicText;
	};
}];
////////////////////////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////// mission specific code comes here //////////////////////////////////////////////////



//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


// log end of execution
diag_log format ["%1 --- init.sqf executed",diag_ticktime];
