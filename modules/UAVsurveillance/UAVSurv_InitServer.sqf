// by Quentin


// log start of execution
if (isServer && {!(player diarySubjectExists "Modules")}) then {player createDiarySubject ["Modules","Modules"];};
player createDiaryRecord ["Modules",["UAVSurv InitClient","<font color='#b40100'>Ausführung begonnen</font color> nach " + str(time) + " Sekunden."]];


// set up Drone Control Station
{
	if (isPlayer leader _x) then
	{
		drone_control addAction [(str(_x) select [2]) + " verfolgen","modules\UAVsurveillance\UAVSurv.sqf",leader _x];
	};
	nil;
} count allGroups;



// log end of execution
player createDiaryRecord ["Modules",["UAVSurv InitClient","<font color='#107b1b'>Ausführung beendet</font color> nach " + str(time) + " Sekunden."]];