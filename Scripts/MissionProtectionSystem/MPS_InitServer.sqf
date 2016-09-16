// by Fabi


// disable copilot´s ability to take over control in any vehicle on mission start
{
    _x enableCopilot false;
    _x addEventHandler ["Fired",{
        if (((_this select 0) distance (getmarkerpos "GeCo_MissionProtection_BaseMarker")) < ((((getMarkerSize "GeCo_MissionProtection_BaseMarker") select 0) + ((getMarkerSize "GeCo_MissionProtection_BaseMarker") select 1)) / 2)) then
		{
            deleteVehicle (_this select 6);
        };
    }];
    nil
} count vehicles;