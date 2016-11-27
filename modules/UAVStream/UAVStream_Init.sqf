// by Quentin


// initialize drone stream
if (!isNil "streaming_drone" && !isNil "whiteboard" && !isNil "drone_control") then
{
	[streaming_drone,whiteboard,drone_control] remoteExecCall ["KK_fnc_StreamUAV",group co];
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