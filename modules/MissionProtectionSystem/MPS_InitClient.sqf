// by Fabi & Quentin


// log start of execution
//if !(player diarySubjectExists "Modules") then {player createDiarySubject ["Modules","Modules"];}; // create "Modules" diary entry for player
player createDiaryRecord ["Modules",["MPS InitClient","<font color='#b40100'>Ausführung begonnen</font color> nach " + str(time) + " Sekunden."]];


// wait until all core variables are publicized
waitUntil {!isNil "Blacklist"};


/* Foul Monitoring Function */
MPS_FoulsCount = 0;	// set player's foul count and MPS's warnings to 0 initially
MPS_Warnings = 0;

MPS_fnc_AddFoul =
{
	params [["_foulWeight",1]];
	MPS_FoulsCount = MPS_FoulsCount + _foulWeight;	// increase player's foul limit by weight of the foul he committed
    
	if (MPS_FoulsCount >= 100 && {!(getPlayerUID player in Whitelist)}) then	// if player's fouls exceed limit, he isn't a trustworthy person on the whitelist and he doesn't play a Sepcial Slot...
	{
		[""] spawn BIS_fnc_dynamicText;	// ...remove currently displayed dynamic text
		endMission "LOSER";	// ...end mission for him
		0 cutText ["Ihr Einsatz wurde aufgrund Ihres Fehlverhaltens abgebrochen.","BLACK FADED",0];	// ...inform him about the reason for the kick
		Blacklist pushbackUnique (getPlayerUID player);	// ...add player's UID (equal to steamID64 of the player) to blacklist to prevent him from rejoining the mission (FRP)
		publicVariable "Blacklist";	// ...broadcast current blacklist to each connected computer
		["homojack",format ["#kick %1",name player]] remoteExec ["serverCommand",2];	// ...kick him
		((name player) + " wurde wegen seines Fehlverhaltens vom Einsatz abgezogen.") remoteExec ["systemChat",0];	// ...show system info message for the other players
    };
};
/* Fouls Monitoring Function finished */


/* Baserape Protection section */
if (isNil "MPS_BaseMrkr" && {!(getPlayerUID player in Whitelist)}) then	// if mission builder has placed a BaseMarker, player is not on Whitelist and doesn't play a Special Slot...
{
	FiredMan_EH = player addEventHandler ["FiredMan",
	{
		if (((_this select 0) distance (getMarkerPos "MPS_BaseMrkr")) < 400) then	// if player fires inside base...
		{
			deleteVehicle (_this select 6);	// ...delete the projectile / grenade / satchel / mine
			switch true do	// (by Drunken Officer, edited by Quentin) ...warn player according to what foul he committed
			{
				case ((_this select 1) isKindOf ["Put",configFile >> "CfgWeapons"]): {["<t color='#ff0000' size ='1.5'>Das Platzieren von Sprengstoff in der Basis ist strengstens verboten, Soldat!<br/>Sie wurden verwarnt.</t>",0,0,4,0] spawn BIS_fnc_dynamicText}; //--- Put sind die Bomben und Minen
				case ((_this select 1) isKindOf ["Throw",configFile >> "CfgWeapons"]): {["<t color='#ff0000' size ='1.5'>Das Werfen von Objekten in der Basis ist strengstens verboten, Soldat!<br/>Sie wurden verwarnt.</t>",0,0,4,0] spawn BIS_fnc_dynamicText}; //--- Throw sind Granaten
				case ((_this select 1) isKindOf ["Rifle",configFile >> "CfgWeapons"]): {["<t color='#ff0000' size ='1.5'>Der Waffeneinsatz in der Basis ist gegen die Dienstvorschriften, Soldat!<br/>Sie wurden verwarnt.</t>",0,0,4,0] spawn BIS_fnc_dynamicText}; //--- Rifle im allg
				case ((_this select 1) isKindOf ["Pistol",configFile >> "CfgWeapons"]): {["<t color='#ff0000' size ='1.5'>Der Waffeneinsatz in der Basis ist gegen die Dienstvorschriften, Soldat!<br/>Sie wurden verwarnt.</t>",0,0,4,0] spawn BIS_fnc_dynamicText}; //--- Pistolenim allg
				case ((_this select 1) isKindOf ["Launcher_Base_F", configFile >> "CfgWeapons"]): {["<t color='#ff0000' size ='1.5'>Der Waffeneinsatz in der Basis ist gegen die Dienstvorschriften, Soldat!<br/>Sie wurden verwarnt.</t>",0,0,4,0] spawn BIS_fnc_dynamicText}; //--- RPGim allg
				default {["<t color='#ff0000' size ='1.5'>Der Einsatz von Bordwaffen in der Basis ist gegen die Dienstvorschriften, Soldat!<br/>Sie wurden verwarnt.</t>",0,0,4,0] spawn BIS_fnc_dynamicText};	//--- Fahrzeugwaffen
			};
			[15] call MPS_fnc_AddFoul;	// ...increase his foul counter
		};
		//nil;	// prevent weapon firing anim & sound (doesn't work like this)
	}];
}
else	// ...otherwise
{
	if (!isNil "MPS_BaseMrkr") then	// ...if there is no object called "MPS_BaseMrkr"...
	{
		["<t color='#ff0000' size ='1.5'>Es gibt keinen BaseMarker!<br/>Erstelle einen Marker namens ""MPS_BaseMrkr"" und platziere ihn ins Zentrum der Spielerbasis, damit das Schutzsystem arbeiten kann.</t>",0,0,4,0] spawn BIS_fnc_dynamicText;	// ...tell him
	};
};
/* Baserape Protection section finished */


/* Teamkill Protection */
if (!(getPlayerUID player in Whitelist) && {!(getPlayerUID player in Pilots)}) then	// if player is not on Whitelist and doesn't play as a pilot (because they could accidentally teamkill dropping bombs etc.)...
{
	MPKilled_EH = player addMPEventHandler ["MPKilled",
	{
		private _victim = _this select 0;
		private _killer = _this select 1;
		private _instigator = _this select 2;
		if ((player isEqualTo _victim) && {!(player isEqualTo _killer)} && {!(player isEqualTo _instigator)} && {isPlayer _killer}) then
		{
			hint format ["Du wurdest von deinem Kameraden %1 %2 aus der Einheit %3 getötet. Er wurde verwarnt.",rank _killer,name _killer,str(group _killer) select [2]];
		}
		else
		{ 
			if (player isEqualTo _killer && {!(player isEqualTo _victim)} && {isPlayer _killer}) then
			{
				[50] call MPS_fnc_AddFoul;
				if (MPS_FoulsCount < 100) then
				{	
					["<t color='#ff0000' size = '1.5'>Verbündetenbeschuss wird nicht toleriert, Soldat!<br/>Beim nächsten Verbündetenbeschuss wird ihre Mission abgebrochen.</t>",0,0,4,0] spawn BIS_fnc_dynamicText;
				};
			};
		};
	}];
};
/* Teamkill Protection section finished */


// if player is a curator, initialize MPS on vehicles and units spawned by him
if (isNil "MPS_BaseMrkr") then	// if mission builder has placed a BaseMarker...
{
	if (typeOf player in Curators) then
	{
		// SilentSpike: getAssignedCuratorLogic command will return objNull if used immediately after the curator logic is assigned to the unit in question (this includes at mission time 0). To avoid problems use the following beforehand
		waitUntil {!isNull (getAssignedCuratorLogic player)};
		COPP_EH = (getAssignedCuratorLogic player) addEventHandler [
			"CuratorObjectPlaced",
			{
				private _entity = _this select 0;
				if (_entity isKindOf "AllVehicle") then
				{
					_entity addEventHandler ["Fired",
					{
						private _entity = _this select 0;
						private _projectile = _this select 6;
						if ((_entity distance (getMarkerPos "MPS_BaseMrkr")) < 400) then	// if curator placed unit shoots inside base...
						{
							deleteVehicle _projectile;	// ...delete the projectile
						};
					}];
				};
			}
		];
	};
}
else	// ...otherwise...
{
	if (!isNil "MPS_BaseMrkr") then	// ...if there is no object called "MPS_BaseMrkr"...
	{
		["<t color='#ff0000' size ='1.5'>Es gibt keinen BaseMarker!<br/>Erstelle ein Objekt namens ""MPS_BaseMrkr"" und platziere es ins Zentrum der Spielerbasis, damit das Schutzsystem arbeiten kann.</t>",0,0,4,0] spawn BIS_fnc_dynamicText;	// ...tell him
	};
};

// if player is trustworthy, tell him the passwords to all slots
if ((getPlayerUID player) in Whitelist) then
{
	player createDiarySubject ["Sicherheit","Sicherheit"];
	player createDiaryRecord [
		"Sicherheit",
		[
			"Passwörter",
			"Diesen Tagebucheintrag bekommst nur du als GeCo-Orga-Mitglied angezeigt. Alle Passwörter sind natürlich ohne Anführungszeichen einzugeben.<br/><br/>
			<font color='#1d49d1'>Slot Protection Passwords:</font color><br/>
				Offiziere:  <font color='#107b1b'>""OPZ""</font color><br/>
				Piloten:  <font color='#107b1b'>""Pilot""</font color><br/>
				Zeus:  <font color='#107b1b'>""Zeus""</font color><br/><br/>
				Zuschauer:  <font color='#107b1b'>""Spec""</font color><br/><br/>
				<font color='#1d49d1'>Idiotentest:</font color><br/>
				Serversprache:  <font color='#107b1b'>""deutsch""</font color><br/>
				Hauptstadt:  <font color='#107b1b'>""Berlin""</font color><br/>
				Bundesländer:  <font color='#107b1b'>""16""</font color><br/>
				Bundeskanzler:  <font color='#107b1b'>""Angela Merkel""</font color><br/><br/>
				<font color='#1d49d1'>Fouler Rejoin Protection:</font color><br/>
				<font color='#107b1b'>""rejoin""</font color>"
		]
	];
};


// initialize Security Dialogs
_null = execVM "modules\MissionProtectionSystem\MPS_Sec_Dialogs.sqf";


// log end of execution
player createDiaryRecord ["Modules",["MPS InitClient","<font color='#107b1b'>Ausführung beendet</font color> nach " + str(time) + " Sekunden."]];