// by Quentin


// log start of execution
if !(player diarySubjectExists "Modules") then {player createDiarySubject ["Modules","Modules"];};
player createDiaryRecord ["Modules",["Briefing InitClient","<font color='#b40100'>Ausführung begonnen</font color> nach " + str(time) + " Sekunden."]];


// Briefing
// benutze <br/>, um einen Enter-artigen Zeilensprung einzufügen
player createDiaryRecord [
	"Diary", [
		"Situation",
		"Die Ausgangssituation der Mission steht hier."
	]
];
player createDiaryRecord [
	"Diary", [
		"Einsatzregeln",
		"Die Einsatzregeln der Mission stehen hier."
	]
];
player createDiaryRecord [
	"Diary", [
		"Mission",
		"Die Mission selbst steht hier."
	]
];
player createDiaryRecord [
	"Diary", [
		"Durchführung","Wird von der Führung bestimmt."	// bleibt bestehen
	]
];


// Credits
player createDiarySubject ["Credits","Credits"];
player createDiaryRecord [
	"Credits",
	[
		"Wolf13898 & wildw1ng",
			"Bundeswehr Texturen"
	]
];
player createDiaryRecord [
	"Credits",
	[
		"Sabre",
			"UN 2030 Texturen"
	]
];
player createDiaryRecord [
	"Credits",
	[
		"MacRae",
			"Sitzscript"
	]
];
player createDiaryRecord [
	"Credits",
	[
		"GeCo Team",
			"Hauptfunktionen"
	]
];
player createDiaryRecord [
	"Credits",
	[
		"Blackburn / Zombeck",
			"Unbedingte Hilfsbereitschaft"
	]
];


// Revive explanation
player createDiarySubject ["Revive","Revive"];
player createDiaryRecord [
	"Revive",
	[
		"Info",
			"Das Revivesystem ist darauf ausgelegt, den Spieler bei Treffern durch großkalibrige Projektile oder bei Treffern auf ungeschützte Areale zu töten. <font color='#107b1b'>Nur Sanitäter können wiederbeleben</font color>, wenn sie ein Medikit bei sich tragen."
	]
];


// Teamspeak IP
player createDiarySubject ["Teamspeak","Teamspeak"];
player createDiaryRecord [
	"Teamspeak",
	[
		"IP",
			"Dies ist ein deutsches Coop-Event der German Coop Community. Bitte schließ' dich deinen Kameraden auf dem TS an:<br/><font color='#107b1b'>148.251.184.100:9983</font color>"
	]
];


// Company Roster
player createDiarySubject ["Kommandostruktur","Kommandostruktur"];
{
	if (isPlayer leader _x) then
	{
		player createDiaryRecord
		[
			"Kommandostruktur",
			[
				str(_x) select [2],
				"<br/><font color='#107b1b'>Befehlshaber:</font color> " + rank leader _x + " " + name leader _x +
				"<br/><font color='#107b1b'>Anfängliche Mannstärke gesamt:</font color> " + str(count (units  _x))
			]
		];
	};
	nil;
} count allGroups;


// log end of execution
player createDiaryRecord ["Modules",["Briefing InitClient","<font color='#107b1b'>Ausführung beendet</font color> nach " + str(time) + " Sekunden."]];