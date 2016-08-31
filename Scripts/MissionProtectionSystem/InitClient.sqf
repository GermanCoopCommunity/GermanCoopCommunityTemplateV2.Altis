// by Fabi & Quentin


// set player´s foul count to 0 initially
GeCo_MissionProtection_CountFouls = 0;


// fnc foul control
GeCo_MissionProtection_AddFoul =
{
    params [["_foulWeight", 1]];
    GeCo_MissionProtection_CountFouls = GeCo_MissionProtection_CountFouls + _foulWeight;
    
    if (GeCo_MissionProtection_CountFouls >= 100) then
	{
        endMission "LOSER";
    };
};


// prevent base shooting
player addEventHandler["Fired",
{
    if (((_this select 0) distance (getmarkerpos "GeCo_MissionProtection_BaseMarker")) < (getMarkerSize "GeCo_MissionProtection_BaseMarker") select 0) then
	{
        deleteVehicle (_this select 6);
		["<t color='#ff0000' size = '1.5'>Das Schießen in der Basis ist strengstens verboten!<br />Du wurdest verwarnt.</t>",0,0,4,0] spawn BIS_fnc_dynamicText;
        [15] call GeCo_MissionProtection_AddFoul;
    };
}];


// forbid players to operate vehicles they aren´t in class for
player addEventHandler ["GetInMan", {
		
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
player addMPEventHandler ["MPKilled",{

	// declare EH variables
	private _victim = _this select 0;
	private _killer = _this select 1;
	private _triggerer = _this select 2;
	
	
    if ((_victim != _triggerer) && {(_victim in allPlayers) && (side _victim == side player)}) then	// if player killed another player of his own side and he didn´t manually respawn...
	{
		["<t color='#ff0000' size = '1.5'>Teambeschuss wird nicht toleriert!<br/>Du wurdest verwarnt.</t>",0,0,4,0] spawn BIS_fnc_dynamicText;
        [50] call GeCo_MissionProtection_AddFoul;	// ...warn him
    };
}];


// if player is a curator, initialize MPS on vehicles and units spawned by him
if (typeOf player == "VirtualCurator_F" or typeOf player == "B_VirtualCurator_F" or typeOf player == "C_VirtualCurator_F" or typeOf player == "I_VirtualCurator_F" or typeOf player == "O_VirtualCurator_F") then
{
    player addEventHandler [
        "CuratorObjectPlaced",
        {
            if ((_this select 1) isKindOf "Air") then    // disable copilot being able to take over controls in Zeus placed air vehicles
            {
                (_this select 1) enableCopilot false;
            };
            if ((_this select 1) isKindOf "AllVehicle") then    // disable copilot being able to take over controls in Zeus placed air vehicles
            {
                (_this select 1) addEventHandler ["Fired",
				{
                    if (((_this select 0) distance (getmarkerpos "GeCo_MissionProtection_BaseMarker")) < (getMarkerSize "GeCo_MissionProtection_BaseMarker") select 0) then	// if curator placed unit shoots inside base...
					{
                        deleteVehicle (_this select 6);	// ...delete the projectile
                    };
                }];
            };
        }
    ];
};