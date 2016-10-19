// by Fabi


// disable vehicles firing in base
{
    _x addEventHandler ["Fired",{
        if (((_this select 0) distance (getMarkerpos "GeCo_MissionProtection_BaseMarker")) < 500) then	// if someone shoots from a vehicle inside base...
		{
            deleteVehicle (_this select 6);	// ...delete the projectile
        };
    }];
    nil
} count vehicles;