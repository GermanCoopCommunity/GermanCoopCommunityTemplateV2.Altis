// by Quentin


// log start of execution
diag_log format ["%1 --- Executing init.sqf",diag_ticktime];


////////////////////////////////////////////////// initialize QTS //////////////////////////////////////////////////
// precompile fncs
QT_fnc_Earplugs = compile preprocessFileLineNumbers "scripts\fnc\QT_fnc_Earplugs.sqf";
QT_fnc_Insignia = compile preprocessFileLineNumbers "scripts\fnc\QT_fnc_Insignia.sqf";

// define fnc arrays
QT_call_fncs = [QT_fnc_Earplugs,QT_fnc_Insignia];
QT_spawn_fncs = [];
QT_AI_call_fncs = [QT_fnc_Insignia];
QT_AI_spawn_fncs = [];

// initialize fncs on player
if (!isNil "QT_call_fncs") then {{[player] call _x} count QT_call_fncs;};
if (!isNil "QT_spawn_fncs") then {{[player] spawn _x} forEach QT_spawn_fncs;};

// apply to AI units as well
if (!isNil "QT_AI_call_fncs") then
{
	{[_x] call QT_fnc_Insignia} count (allUnits - (allPlayers - entities "HeadlessClient_F"));
};
if (!isNil "QT_AI_spawn_fncs") then
{
	//{[_x] call QT_fnc_BFT} count (allUnits - (allPlayers - entities "HeadlessClient_F"));
};

// apply to AI newly spawned by curators as well
{_x addEventHandler [
	"CuratorObjectPlaced",
		{
			//_curator = _this select 0;
			//_entity = _this select 1;			
			if ((_this select 1) in (allUnits - allPlayers - playableUnits - entities "HeadlessClient_F")) then	// if entity spawned is an AI unit...
			{
				if (!isNil "QT_AI_call_fncs") then {{[_this select 1] call _x} count QT_AI_call_fncs};	// ...initialize QT_AI_call_fncs for it
				if (!isNil "QT_AI_spawn_fncs") then {{[_this select 1] spawn _x} forEach QT_AI_spawn_fncs};	// ...initialize QT_AI_spawn_fncs for it
			};
			{_x addCuratorEditableObjects [[_this select 1],true]} count (allCurators - [_this select 0]);	// ...add placed entity to editable objects for the other curators
		}
];} foreach allCurators;
///////////////////////// ///////////////////////// QTS initialization complete //////////////////////////////////////////////////


//removeallMissionEventHandlers "Draw3D";	//<-- added by psycho, needed to reset EH, mission EH's can avoid unwanted impacts on mission flow (for example after player slot changed)


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


// Joko: make player visible to curators on respawn
fn_addPlayerToCurator = {
    params ["_unit"];
    {
        _x addCuratorEditableObjects [[_unit],true];
        nil
    } count allCurators;
};


////////////////////////////////////////////////// mission specific code comes here //////////////////////////////////////////////////



//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


// log end of execution
diag_log format ["%1 --- init.sqf executed",diag_ticktime];
