// by Fabi & Quentin


// define Pilots
GeCo_Pilots = ["B_Helipilot_F","B_Pilot_F","O_Helipilot_F","O_Pilot_F","I_helipilot_F","I_Pilot_F","C_man_pilot_F"];

// define Crew
GeCo_Crew = ["B_crew_F","O_crew_F","I_crew_F"];

// define OPZ
GeCo_OPZ = ["B_officer_F","O_officer_F","I_officer_F"];

// define Curators
GeCo_Curators = ["VirtualCurator_F","B_VirtualCurator_F","O_VirtualCurator_F","I_VirtualCurator_F","C_VirtualCurator_F"];

// GeCo whitelist of trustworthy people (@Fabi, deinen und Yoshis Ingame-Namen habe ich nicht)
GeCo_Whitelist = ["Grey Wolf","Deathbite","Quentin"];

// GeCo blacklist containing players which exceeded the fouls limit and were kicked
GeCo_Blacklist = [];

// define PFH
GeCo_PFH = [];
addMissionEventHandler ["EachFrame",
{
  {
    _x params [["_function",{}], ["_delay",0], ["_delta", diag_tickTime]];
    if (diag_tickTime > _delta) then
	{
		_x set [2, _delta + _delay];
		true call _function;
    };
    nil
  } count GeCo_PFH;
}];