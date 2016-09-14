// by Quentin


// Briefing
player createDiaryRecord [
	"Diary", [
		"Situation",""
	]
];
player createDiaryRecord [
	"Diary", [
		"Rules Of Engagement",""
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


// QTS entries (must be here, otherwise diary entries aren´t shown in map before mission start)
// QT Gestures
player createDiarySubject ["Gesten","Gesten"];
player createDiaryRecord [
	"Gesten",
	[
		"Info",
			"Folgende Zahlen auf der Tastatur unter den F-Tasten, um folgende Gesten auszuführen:<br/><br/>5 - ""<font color='#107b1b'>Los!</font color>""<br/>6 - ""<font color='#107b1b'>Stop!</font color>""<br/>7 - ""<font color='#107b1b'>Ja!</font color>""<br/>8 - ""<font color='#107b1b'>Nein!</font color>""<br/>9 - ""<font color='#107b1b'>Sichtung auf (Gradangabe)!</font color>"""""
	]
];


// QT Earplugs
player createDiarySubject ["Ohrstöpsel","Ohrstöpsel"];
player createDiaryRecord [
	"Ohrstöpsel",
	[
		"Info",
			"<br/><font color='#107b1b'>Linke Windows-Taste</font color> auf der Tastatur, um die Ohrstöpsel umzuschalten."
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


// QT Jump
player createDiarySubject ["Springen","Springen"];
player createDiaryRecord [
	"Springen",
	[
		"Info",
			"<br/><font color='#107b1b'>V</font color> auf der Tastatur, um während des Laufens zu springen."
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