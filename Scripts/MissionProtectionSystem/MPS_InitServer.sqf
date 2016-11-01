// by Fabi, edited by Quentin


// disable vehicles firing in base
{
    _x addEventHandler ["Fired",{
        if (((_this select 0) distance (getMarkerpos "GeCo_MissionProtection_BaseMarker")) < 400) then	// if someone shoots from a vehicle inside base...
		{
            deleteVehicle (_this select 6);	// ...delete the projectile
			["<t color='#ff0000' size ='1.5'>Der Einsatz von Bordwaffen in der Basis ist gegen die Dienstvorschriften, Soldat!<br/>Sie wurden verwarnt.</t>",0,0,4,0] spawn BIS_fnc_dynamicText;	// ...warn him
			[15] call GeCo_MissionProtection_AddFoul;	// ...increase his foul counter
        };
    }];
    nil
} count vehicles;