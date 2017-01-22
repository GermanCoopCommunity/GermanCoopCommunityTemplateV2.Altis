// by Fabi & Quentin


// log start of execution
//if !(player diarySubjectExists "Modules") then {player createDiarySubject ["Modules","Modules"];}; // create "Modules" diary entry for player
player createDiaryRecord ["Modules",["Core InitServer","Ausführung begonnen um " + str(time)]];


/* let server define all arrays and publicize them to the clients, so JIPers don't reset the arrays each time they JIP */
// define Pilots
Pilots = ["B_Helipilot_F","B_Pilot_F","O_Helipilot_F","O_Pilot_F","I_helipilot_F","I_Pilot_F","C_man_pilot_F","B_T_Helipilot_F","B_T_Pilot_F","O_T_Helipilot_F","O_T_Pilot_F","I_C_Pilot_F"];
publicVariable "Pilots";

// define Crew
Crews = ["B_crew_F","O_crew_F","I_crew_F","B_T_crew_F","O_T_crew_F"];
publicVariable "Crew";

// define Officers
Officers = ["B_officer_F","O_officer_F","I_officer_F","B_T_officer_F","O_T_officer_F","B_GEN_Commander_F"];
publicVariable "Officers";

// define Curators
Curators = ["VirtualCurator_F","B_VirtualCurator_F","O_VirtualCurator_F","I_VirtualCurator_F","C_VirtualCurator_F"];
publicVariable "Curators";

// define Special Slots
SpecSlots = Pilots + Officers + Curators;
publicVariable "SpecSlots";

// whitelist of trustworthy people
Whitelist = ["76561198024503777","76561198029924112","76561198063094413","76561198035982662","76561198006766136"];
publicVariable "Whitelist";

// blacklist containing players which exceeded the fouls limit and were kicked
Blacklist = [];
publicVariable "Blacklist";

// array containing names of players which exceeded the fouls limit and were kicked
AllKicked = [];
publicVariable "AllKicked";

// array containing names of players which fouled, but weren't kicked yet
AllWarned = [];
publicVariable "AllWarned";

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


// log end of execution
player createDiaryRecord ["Modules",["Core InitServer","Ausführung beendet um " + str(time)]];