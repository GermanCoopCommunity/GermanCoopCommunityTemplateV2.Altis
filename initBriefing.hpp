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


// Company Roster
player createDiarySubject ["Kommandostruktur","Kommandostruktur"];
if (!isNil "co") then	// if given player unit does exist...
{
	player createDiaryRecord [	// ...create diary entry to it commanding its unit
		"Kommandostruktur",
		[
			"OPZ",
			"Kommandeur: " + rank co + " " + name co
		]
	];
};
if (!isNil "alpha_lead") then
{
	player createDiaryRecord [
		"Kommandostruktur",
		[
			"Alpha",
			"Truppführer: " + rank alpha_lead + " " + name alpha_lead
		]
	];
};
if (!isNil "bravo_lead") then
{
	player createDiaryRecord [
		"Kommandostruktur",
		[
			"Bravo",
			"Truppführer: " + rank bravo_lead + " " + name bravo_lead
		]
	];
};
if (!isNil "charlie_lead") then
{
	player createDiaryRecord [
		"Kommandostruktur",
		[
			"Charlie",
			"Truppführer: " + rank charlie_lead + " " + name charlie_lead
		]
	];
};
if (!isNil "delta_lead") then
{
	player createDiaryRecord [
		"Kommandostruktur",
		[
			"Delta",
			"Truppführer: " + rank delta_lead + " " + name delta_lead
		]
	];
};
if (!isNil "echo_lead") then
{
	player createDiaryRecord [
		"Kommandostruktur",
		[
			"Echo",
			"Truppführer: " + rank echo_lead + " " + name echo_lead
		]
	];
};
if (!isNil "foxtrot_lead") then
{
	player createDiaryRecord [
		"Kommandostruktur",
		[
			"Foxtrot",
			"Truppführer: " + rank foxtrot_lead + " " + name foxtrot_lead
		]
	];
};
if (!isNil "golf_lead") then
{
	player createDiaryRecord [
		"Kommandostruktur",
		[
			"Golf",
			"Truppführer: " + rank golf_lead + " " + name golf_lead
		]
	];
};
if (!isNil "pilot_1") then
{
	player createDiaryRecord [
		"Kommandostruktur",
		[
			"Piloten",
			"Staffelführer: " + rank pilot_1 + " " + name pilot_1
		]
	];
};
if (!isNil "crew_1") then
{
		player createDiaryRecord [
		"Kommandostruktur",
		[
			"Panzer",
			"Kommandant: " + rank crew_1 + " " + name crew_1
		]
	];
};


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