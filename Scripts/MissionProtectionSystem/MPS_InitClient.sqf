// by Fabi & Quentin


if ((getPlayerUID player) in GeCo_Blacklist && {!(getPlayerUID player in GeCo_Whitelist)}) then	// if player has already been kicked and therefore is on blacklist and not on the whitelist of trustworthy people...
{
	// create dialog asking for password in case player was kicked accidentally and wants to rejoin (if password true, erase his name from the blacklist), otherwise...
	endMission "LOSER";	// ...kick him again
};


// set player´s foul count to 0 initially
GeCo_MissionProtection_CountFouls = 0;


// fnc foul control
GeCo_MissionProtection_AddFoul =
{
    params [["_foulWeight", 1]];
    GeCo_MissionProtection_CountFouls = GeCo_MissionProtection_CountFouls + _foulWeight;
    
    if (GeCo_MissionProtection_CountFouls >= 100 && {!(getPlayerUID player in GeCo_Whitelist)}) then	// if player´s fouls exceed limit and he isn´t a trustworthy person on the whitelist...
	{
		endMission "LOSER";	// ...kick him
		//["LOSER",false,0,false,false] call BIS_fnc_endMission;	// does the same as command above, but not as pretty and with "restart" option, which is not wanted
		//("#exec kick" + (name player)) remoteExec ["serverCommand", 2];	// kick player from game server (doesn´t work atm)
		//serverCommand ("#kick" + (name player));
		GeCo_Blacklist pushbackUnique (getPlayerUID player);	// ...add player´s UID (equal to steamID64 of the player) to blacklist to prevent him from rejoining the mission
    };
};


// prevent base shooting
player addEventHandler ["Fired",
{
    if (((_this select 0) distance (getmarkerpos "GeCo_MissionProtection_BaseMarker")) < (getMarkerSize "GeCo_MissionProtection_BaseMarker") select 0) then	// if player fires inside base...
	{
        deleteVehicle (_this select 6);	// ...delete the projectile
		["<t color='#ff0000' size = '1.5'>Das Schießen in der Basis ist strengstens verboten!<br/>Du wurdest verwarnt.</t>",0,0,4,0] spawn BIS_fnc_dynamicText;
        [15] call GeCo_MissionProtection_AddFoul;	// ...warn him
    };
	//nil	// prevent weapon firing anim & sound (doesn´t work like this)
}];


// forbid players to operate vehicles they aren´t in class for
player addEventHandler ["GetInMan",
{		
		// declare EH variables
		private _unit = _this select 0;
		private _pos = _this select 1;
		private _veh = _this select 2;
		
	if (
		!((getText (configfile >> "CfgVehicles" >> typeOf _veh >> "vehicleClass") == "Submarine") or (typeOf _veh == "Steerable_Parachute_F"))	// ...which is not an SDV or a parachute...
		&&
		{(_veh isKindOf "Tank") or {_veh isKindOf "Air"}}	// ...but a tank or an aircraft... (to exclude crew requirements for cars and trucks)
		&&
		{((typeOf _unit) != (getText (configFile >> "CfgVehicles" >> typeOf _veh >> "crew")))}	// ...and he is not the same class as needed to crew that vehicle...
		&&
		{((_pos == "driver") or /*(_pos == "gunner") or */(_unit == _veh turretUnit [0]))}	// ...and he is either commander, driver, gunner or copilot of the vehicle...
	)
	then
	{
		["<t size='0.8'>Du bist für die Bedienung dieses Fahrzeuges nicht ausgebildet. Du wurdest verwarnt.</t>",0,0,4,0] spawn bis_fnc_dynamicText;
		//hintSilent format ["Nur ein %1 ist für die Bedienung dieses Fahrzeuges ausgebildet.", getText (configFile >> "CfgVehicles" >> (getText (configFile >> "CfgVehicles" >> typeOf(vehicle player) >> "crew")) >> "DisplayName")];
		_unit action ["GetOut", _veh];	// ...eject him out of the vehicle
	};
}];


// teamkill punisher
player addMPEventHandler ["MPKilled",
{
	// declare EH variables
	private _victim = _this select 0;	// = local player
	private _killer = _this select 1;	// contains unit itself in case of collisions
	private _instigator = _this select 2;	// person who pulled the trigger
	
    if ((isPlayer _victim) && {_victim != objNull} && {_victim != _killer} && {side _victim == side player}) then	// if player killed another player of his own side, didn´t die from a collision and didn´t manually respawn...
	{
		["<t color='#ff0000' size = '1.5'>Teambeschuss wird nicht toleriert!<br/>Du wurdest verwarnt.</t>",0,0,4,0] spawn BIS_fnc_dynamicText;
        [50] call GeCo_MissionProtection_AddFoul;	// ...warn him
		hint format ["Opfer: %1, Killer: %2",_victim,_killer];
    };
}];


// if player is a curator, initialize MPS on vehicles and units spawned by him
if (typeOf player == "VirtualCurator_F" or typeOf player == "B_VirtualCurator_F" or typeOf player == "C_VirtualCurator_F" or typeOf player == "I_VirtualCurator_F" or typeOf player == "O_VirtualCurator_F") then
{
    player addEventHandler [
        "CuratorObjectPlaced",
        {
            /*if ((_this select 1) isKindOf "Air") then    // disable copilot being able to take over controls in Zeus placed air vehicles
            {
                (_this select 1) enableCopilot false;
            };*/
            if ((_this select 1) isKindOf "AllVehicle") then    // disable copilot being able to take over controls in Zeus placed air vehicles
            {
                (_this select 1) addEventHandler ["Fired",
				{
                    if (((_this select 0) distance (getmarkerpos "GeCo_MissionProtection_BaseMarker")) < ((((getMarkerSize "GeCo_MissionProtection_BaseMarker") select 0) + ((getMarkerSize "GeCo_MissionProtection_BaseMarker") select 1)) / 2)) then	// if curator placed unit shoots inside base...
					{
                        deleteVehicle (_this select 6);	// ...delete the projectile
                    };
                }];
            };
        }
    ];
};


// check on join, if...
GeCo_PasswordCorrect = false;

// ...player has pilot password
if (typeOf player in GeCo_Pilots && isMultiplayer) then	// if player is a pilot...	(and only if it is multiplayer mode, for editor purposes)
{
    GeCo_Try = 1;	// ...set this as his first password attempt
    GeCo_fn_Passwort =
	{
        _ok = createDialog "GeCo_CheckPilot";	// ...open the dialog for entering password
        waitUntil {!dialog};	// ...wait until dialog is created
        if(!GeCo_PasswordCorrect) then	// ...if entered password is wrong...
		{
            if (GeCo_Try < 3) then	// ...if that wasn´t his third attempt...
			{
                GeCo_Try = GeCo_Try + 1;	// ...increase attempt counter
				hintC format ["Falsch. Du hast noch %1 Versuche.", 4 - GeCo_Try];	// ...show him an error
				hint "";	// remove hint remainings
                [] call GeCo_fn_Passwort;	// ...and reopen dialog
            }
			else	// ...if it was his third attempt...
			{ 
                [100] call GeCo_MissionProtection_AddFoul;	// ...kick him
            };
        };
    };
    [] call GeCo_fn_Passwort;
};

// ...player has curator password
if (typeOf player in GeCo_Curators && isMultiplayer) then	// if player is a curator...	(and only if it is multiplayer mode, for editor purposes)
{
    GeCo_Try = 1;	// ...set this as his first password attempt
    GeCo_fn_Passwort =
	{
        _ok = createDialog "GeCo_CheckCurator";	// ...open the dialog for entering password
        waitUntil {!dialog};	// ...wait until dialog is created
        if (!GeCo_PasswordCorrect) then	// ...if entered password is wrong...
		{
            if (GeCo_Try < 3) then	// ...if that wasn´t his third attempt...
			{
                GeCo_Try = GeCo_Try + 1;	// ...increase attempt counter
				//hintC format ["Falsch. Du hast noch %1 Versuche.", 4 - GeCo_Try];	// ...show him an error (doesn´t seem to work in Zeus interface)
				//hint "";	// remove hint remainings
                [] call GeCo_fn_Passwort;	// ...and reopen dialog
            }
			else	// ...if it was his third attempt...
			{ 
                [100] call GeCo_MissionProtection_AddFoul;	// ...kick him
            };
        };
    };
    [] call GeCo_fn_Passwort;
};

// ...player has OPZ password
if (typeOf player in GeCo_OPZ && isMultiplayer) then	// if player is a curator...
{
    GeCo_Try = 1;	// ...set this as his first password attempt
    GeCo_fn_Passwort =
	{
        _ok = createDialog "GeCo_CheckOPZ";	// ...open the dialog for entering password
        waitUntil {!dialog};	// ...wait until dialog is created
        if (!GeCo_PasswordCorrect) then	// ...if entered password is wrong...
		{
            if (GeCo_Try < 3) then	// ...if that wasn´t his third attempt...
			{
                GeCo_Try = GeCo_Try + 1;	// ...increase attempt counter
				hintC format ["Falsch. Du hast noch %1 Versuche.", 4 - GeCo_Try];	// ...show him an error
				hint "";	// remove hint remainings
                [] call GeCo_fn_Passwort;	// ...and reopen dialog
            }
			else	// ...if it was his third attempt...
			{ 
                [100] call GeCo_MissionProtection_AddFoul;	// ...kick him
            };
        };
    };
    [] call GeCo_fn_Passwort;
};


// ...player speaks German
if (!GeCo_PasswordCorrect && isMultiplayer) then	// if entered password is wrong...	(and only if it is multiplayer mode, for editor purposes)
{
    GeCo_Try = 1;	// ...set this as his first password attempt
    GeCo_fn_Passwort =
	{
        _ok = createDialog "GeCo_CheckGerman";	// ...open the dialog for answering a question
        waitUntil {!dialog};	// ...wait until dialog is created
        if (!GeCo_PasswordCorrect) then	// ...if entered password is wrong...
		{
            if (GeCo_Try < 3) then	// ...if that wasn´t his third attempt...
			{
                GeCo_Try = GeCo_Try + 1;	// ...increase attempt counter
				hintC format ["Falsch. Du hast noch %1 Versuche.", 4 - GeCo_Try];	// ...show him an error
				hint "";	// remove hint remainings
                [] call GeCo_fn_Passwort;	// ...and reopen dialog
            }
			else	// ...if it was his third attempt...
			{ 
                [100] call GeCo_MissionProtection_AddFoul;	// ...kick him
            };
        };
    };
    [] call GeCo_fn_Passwort;
};