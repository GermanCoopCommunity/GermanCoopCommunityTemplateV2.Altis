// by Quentin


// Briefing
player createDiaryRecord [
	"Diary", [
		"Situation",""
	]
];
player createDiaryRecord [
	"Diary", [
		"Einsatzregeln",""
	]
];
player createDiaryRecord [
	"Diary", [
		"Mission",""
	]
];
player createDiaryRecord [
	"Diary", [
		"Durchführung","Wird von der Führung bestimmt."
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
			"Dies ist ein deutsches Coop-Event der German Coop Community. Bitte schließ dich deinen Kameraden auf dem TS an:<br/><font color='#107b1b'>148.251.184.100:9983</font color>"
	]
];


// Credits
player createDiarySubject ["Credits","Credits"];
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
		"MacRae",
			"Sitzscript"
	]
];
player createDiaryRecord [
	"Credits",
	[
		"Killzone Kid",
			"UAV Streaming"
	]
];