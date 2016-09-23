// by Fabi


// disable copilot´s ability to take over control in any vehicle on mission start
{
    //_x enableCopilot false;	// disable copilot slot being able to take over control over helo
    _x addEventHandler ["Fired",{
        if (((_this select 0) distance (getmarkerpos "GeCo_MissionProtection_BaseMarker")) < ((((getMarkerSize "GeCo_MissionProtection_BaseMarker") select 0) + ((getMarkerSize "GeCo_MissionProtection_BaseMarker") select 1)) / 2)) then	// if someone shoots from a vehicle inside base...
		{
            deleteVehicle (_this select 6);	// ...delete the projectile
        };
    }];
    nil
} count vehicles;