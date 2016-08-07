// by Fabi


// array of unit types allowed to fly
GeCo_MissionProtection_Pilots= ["B_Helipilot_F","B_Pilot_F","O_Helipilot_F","O_Pilot_F","I_helipilot_F","I_Pilot_F","C_man_pilot_F"];


// set player´s foul count to 0 initially
GeCo_MissionProtection_CountFouls = 0;


// fnc foul control
GeCo_MissionProtection_AddFoul = {
    params [["_foulWeight", 1]];
    GeCo_MissionProtection_CountFouls= GeCo_MissionProtection_CountFouls+ _foulWeight;
    
    if(GeCo_MissionProtection_CountFouls>= 100) then {
        endMission "Looser";
    };
};


// prevent base shooting
player addEventHandler["Fired", {
    if (((_this select 0) distance (getmarkerpos "GeCo_MissionProtection_BaseMarker")) < (getMarkerSize "GeCo_MissionProtection_BaseMarker") select 0) then {
        deleteVehicle (_this select 6);
        ["<t size='0.6'>Das Schießen in der Basis ist strengstens verboten! Du wurdest verwarnt.</t>"] spawn bis_fnc_dynamicText;
        [5] call GeCo_MissionProtection_AddFoul;
    };
}];


// only pilots are allowed to fly
player addEventHandler["GetInMan",{
    if (!((typeOf(_this select 0)) in GeCo_MissionProtection_Pilots )&&(_this select 1) == "driver" && ((_this select 2) isKindof "Air") && !((_this select 2) isKindof "Steerable_Parachute_F" )) then {
        (_this select 0) action ["GetOut", vehicle (_this select 0)];
        ["<t size='0.6'>Nur die Piloten sind dazu ausgebildet, zu fliegen. Du wurdest verwarnt.</t>"] spawn bis_fnc_dynamicText;
        [2] call GeCo_MissionProtection_AddFoul;
    };
}];


// Teamkill punisher
player addMPEventHandler ["MPKilled",{
    if (_this select 1 == player) then {
        ["<t size='0.6'>Du, %1, hast %2 getötet. Teambeschuss wird nicht toleriert! Du wurdest verwarnt.</t>", name _this select 0, name _this select 1] spawn bis_fnc_dynamicText;
        [20] call GeCo_MissionProtection_AddFoul;
    };
}];
