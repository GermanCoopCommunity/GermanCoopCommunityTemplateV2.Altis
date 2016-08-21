// by Fabi, edited by Quentin


// set player´s foul count to 0 initially
GeCo_MissionProtection_CountFouls = 0;


// fnc foul control
GeCo_MissionProtection_AddFoul = {
    params [["_foulWeight", 1]];
    GeCo_MissionProtection_CountFouls = GeCo_MissionProtection_CountFouls + _foulWeight;
    
    if (GeCo_MissionProtection_CountFouls >= 100) then {
        endMission "LOSER";
    };
};


// prevent base shooting
player addEventHandler["Fired", {
    if (((_this select 0) distance (getmarkerpos "GeCo_MissionProtection_BaseMarker")) < (getMarkerSize "GeCo_MissionProtection_BaseMarker") select 0) then {
        deleteVehicle (_this select 6);
	["<t color='#ff0000' size = '1.5'>Das Schießen in der Basis ist strengstens verboten!<br />Du wurdest verwarnt.</t>",0,0,4,0] spawn BIS_fnc_dynamicText;
        [15] call GeCo_MissionProtection_AddFoul;
    };
}];


// only pilots are allowed to fly
player addEventHandler["GetInMan",{
    if (!((typeOf(_this select 0)) in GeCo_Pilots) && (_this select 1) == "driver" && ((_this select 2) isKindof "Air") && !((_this select 2) isKindof "Steerable_Parachute_F" )) then {
        (_this select 0) action ["GetOut", vehicle (_this select 0)];
        ["<t size='0.8'>Nur die Piloten sind dazu ausgebildet, zu fliegen. Du wurdest verwarnt.</t>",0,0,4,0] spawn bis_fnc_dynamicText;
        [5] call GeCo_MissionProtection_AddFoul;
    };
}];

/*// forbid players to operate vehicles they aren´t in class for
addMissionEventHandler ["Draw3D", {
	if (
		(!isNull objectParent player)	// if player is in a vehicle...
		&&
		{!((getText (configfile >> "CfgVehicles" >> typeOf objectParent player >> "vehicleClass") == "Submarine") or (typeOf objectParent player == "Steerable_Parachute_F"))}	// ...which is not an SDV or a parachute...
		&&
		{(objectParent player isKindOf "Tank") or {objectParent player isKindOf "Air"}}	// ...but a tank or an aircraft... (to exclude crew requirements for cars and trucks)
		&&
		{((typeOf player) != (getText (configFile >> "CfgVehicles" >> typeOf(vehicle player) >> "crew")))}	// ...and he is not the same class as needed to crew that vehicle...
		&&
		{((player isEqualTo commander objectParent player) or (player isEqualTo driver objectParent player) or 
		//(player isEqualTo gunner objectParent player) or
		(player == vehicle player turretUnit [0]))}	// ...and he is either commander, driver, gunner or copilot of the vehicle...
	)
	then
	{
		hintSilent format ["Nur ein %1 ist für die Bedienung dieses Fahrzeuges ausgebildet.", getText (configFile >> "CfgVehicles" >> (getText (configFile >> "CfgVehicles" >> typeOf(vehicle player) >> "crew")) >> "DisplayName")];
		player action ["GetOut", vehicle player];	// ...eject him out of the vehicle
		//moveOut player;
	};
}];*/


// Teamkill punisher
player addMPEventHandler ["MPKilled",{
    if (_this select 1 == player) then {
	["<t color='#ff0000' size = '1.5'>Teambeschuss wird nicht toleriert!<br />Du wurdest verwarnt.</t>",0,0,4,0] spawn BIS_fnc_dynamicText;
        [50] call GeCo_MissionProtection_AddFoul;
    };
}];


// if player is a curator, initialize BFT on units spawned by him
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
                    (_this select 1) addEventHandler ["Fired",{
                        if (((_this select 0) distance (getmarkerpos "GeCo_MissionProtection_BaseMarker")) < (getMarkerSize "GeCo_MissionProtection_BaseMarker") select 0) then {
                            deleteVehicle (_this select 6);
                        };
                    }];
                };
            }
        ];
    };
