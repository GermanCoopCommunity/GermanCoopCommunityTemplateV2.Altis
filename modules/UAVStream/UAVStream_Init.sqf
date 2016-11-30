// by Quentin


// log start of execution
if !(player diarySubjectExists "Modules") then {player createDiarySubject ["Modules","Modules"];};
player createDiaryRecord ["Modules",["UAV InitClient","<font color='#b40100'>Ausführung begonnen</font color> nach " + str(time) + " Sekunden."]];


// initialize drone stream
if (!isNil "streaming_drone" && {(typeOf streaming_drone isEqualTo "B_UAV_02_CAS_F") or (typeOf streaming_drone isEqualTo "I_UAV_02_CAS_F") or (typeOf streaming_drone isEqualTo "O_UAV_02_CAS_F")} && {!isNil "whiteboard"} && {!isNil "drone_control"}) then
{
	[streaming_drone,whiteboard,drone_control] remoteExecCall ["KK_fnc_StreamUAV",0];
};


// create diary record
waitUntil {player diarySubjectExists "Credits"};
player createDiaryRecord [
	"Credits",
	[
		"Killzone Kid",
			"UAV Streaming"
	]
];


// log end of execution
player createDiaryRecord ["Modules",["UAV InitClient","<font color='#107b1b'>Ausführung beendet</font color> nach " + str(time) + " Sekunden."]];