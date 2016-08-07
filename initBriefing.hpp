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


// Revive explanation
player createDiarySubject ["How To","How To"];
player createDiaryRecord [
	"How To",
	[
		"Revive",
			"Das Revivesystem ist darauf ausgelegt, den Spieler bei Treffern durch großkalibrige Projektile oder bei Treffern auf ungeschützte Areale zu töten. Nur Sanitäter können wiederbeleben, wenn sie ein Medikit bei sich tragen."
	]
];


// QTS entries (must be here, otherwise diary entries aren´t shown in map before mission start)
player createDiarySubject ["QTS","QTS"];
player createDiaryRecord [
	"QTS",
	[
		"Ohrstöpsel",
			"<br/><font color='#107b1b'>Linke Windows-Taste</font color> auf der Tastatur, um die Ohrstöpsel umzuschalten."
	]
];
