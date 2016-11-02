// by Fabi & Quentin


// define Pilots
Pilots = ["B_Helipilot_F","B_Pilot_F","O_Helipilot_F","O_Pilot_F","I_helipilot_F","I_Pilot_F","C_man_pilot_F"];
publicVariable "Pilots";

// define Crew
Crews = ["B_crew_F","O_crew_F","I_crew_F"];
publicVariable "Crew";

// define OPZ
OPZ = ["B_officer_F","O_officer_F","I_officer_F"];
publicVariable "OPZ";

// define Curators
Curators = ["VirtualCurator_F","B_VirtualCurator_F","O_VirtualCurator_F","I_VirtualCurator_F","C_VirtualCurator_F"];
publicVariable "Curators";

// whitelist of trustworthy people
Whitelist = ["76561198024503777","76561198029924112"];
publicVariable "Whitelist";

// blacklist containing players which exceeded the fouls limit and were kicked
Blacklist = [];
publicVariable "Blacklist";

// array containing names of players which exceeded the fouls limit and were kicked
AllFoulers = [];
publicVariable "AllFoulers";

// define PFH
PFH = [];
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
  } count PFH;
}];