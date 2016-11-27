// by Fabi & Quentin



// define Password Control Function
MPS_fnc_PW = compile preprocessFileLineNumbers "modules\MissionProtectionSystem\MPS_fnc_PW.sqf";


// wait until all core variables are publicized
waitUntil {!isNil "AllWarned"};


/* Fouls section */
// set player's foul count and MPS's warnings to 0 initially
MPS_FoulsCount = 0;
MPS_Warnings = 0;

// fnc foul control
//player createDiarySubject ["Auffällige Spieler","Auffällige Spieler"];	// create diary subject containing all foulers registered by MPS	DEACTIVATED UNTIL WORKING
MPS_fnc_AddFoul =
{
    params [["_foulWeight",1]];
    MPS_FoulsCount = MPS_FoulsCount + _foulWeight;	// increase player's foul limit by weight of the foul he committed
    
    if (MPS_FoulsCount >= 100 && {!(getPlayerUID player in Whitelist)}) then	// if player's fouls exceed limit and he isn't a trustworthy person on the whitelist...
	{
		[""] spawn BIS_fnc_dynamicText;	// ...remove currently displayed dynamic text
		endMission "LOSER";	// ...end mission for him
		titleCut ["Ihr Einsatz wurde aufgrund Ihres Fehlverhaltens abgebrochen.","BLACK FADED",0];	// ...inform him about the reason for the kick
		//["LOSER",false,0,false,false] call BIS_fnc_endMission;	// does the same as command above, but not as pretty and with "restart" option, which is not wanted
		Blacklist pushbackUnique (getPlayerUID player);	// ...add player's UID (equal to steamID64 of the player) to blacklist to prevent him from rejoining the mission (FRP)
		publicVariable "Blacklist";	// ...broadcast current blacklist to each connected computer
		AllKicked pushbackUnique (name player);	// ...add player's name to array of all kicked foulers to display it
		publicVariable "AllKicked";	// ...broadcast current kicked foulers to each connected computer
		[player,["Auffällige Spieler",[name player,"wurde gekickt."]]] remoteExec ["createDiaryRecord",0];	// ...update foulers diary entry
		["eevlkneevl",format ["#kick %1",name player]] remoteExec ["serverCommand",2];	// ...kick him
		((name player) + " wurde wegen seines Fehlverhaltens vom Einsatz abgezogen.") remoteExec ["systemChat",0];	// ...show system info message for the other players
    };
	if ((MPS_FoulsCount < 100) && (MPS_FoulsCount > 4) && {!(getPlayerUID player in Whitelist)}) then	// if player's fouls haven't exceeded limit yet and he isn't a trustworthy person on the whitelist...
	{
		MPS_Warnings = MPS_Warnings + 1;
		AllWarned pushbackUnique (name player);	// ...add player's name to array of all warned foulers to display it
		publicVariable "AllWarned";	// ...broadcast current warned foulers to each connected computer
		[player,["Auffällige Spieler",[name player,"wurde " + str(MPS_Warnings) + " mal verwarnt."]]] remoteExec ["createDiaryRecord",0];	// ...update foulers diary entry
	};
};
/* Fouls section finished */


/* Baserape Protection section */
if (isNil "MPS_BaseMrkr") then	// if mission builder has placed a BaseMarker...
{
	Fired_EH = player addEventHandler ["Fired",
	{
		if (((_this select 0) distance (getMarkerPos "MPS_BaseMrkr")) < 400) then	// if player fires inside base...
		{
			deleteVehicle (_this select 6);	// ...delete the projectile / grenade / satchel / mine
			switch true do	// (by Drunken Officer, edited by Quentin) ...warn player according to what foul he committed
			{
				case ((_this select 1) isKindOf ["Put", configFile >> "CfgWeapons"]): {["<t color='#ff0000' size ='1.5'>Das Platzieren von Sprengstoff in der Basis ist strengstens verboten, Soldat!<br/>Sie wurden verwarnt.</t>",0,0,4,0] spawn BIS_fnc_dynamicText}; //--- Put sind die Bomben und Minen
				case ((_this select 1) isKindOf ["Throw", configFile >> "CfgWeapons"]): {["<t color='#ff0000' size ='1.5'>Das Werfen von Objekten in der Basis ist strengstens verboten, Soldat!<br/>Sie wurden verwarnt.</t>",0,0,4,0] spawn BIS_fnc_dynamicText}; //--- Throw sind Granaten
				case ((_this select 1) isKindOf ["Rifle", configFile >> "CfgWeapons"]): {["<t color='#ff0000' size ='1.5'>Der Waffeneinsatz in der Basis ist gegen die Dienstvorschriften, Soldat!<br/>Sie wurden verwarnt.</t>",0,0,4,0] spawn BIS_fnc_dynamicText}; //--- Rifle im allg
				case ((_this select 1) isKindOf ["Pistol", configFile >> "CfgWeapons"]): {["<t color='#ff0000' size ='1.5'>Der Waffeneinsatz in der Basis ist gegen die Dienstvorschriften, Soldat!<br/>Sie wurden verwarnt.</t>",0,0,4,0] spawn BIS_fnc_dynamicText}; //--- Pistolenim allg
				case ((_this select 1) isKindOf ["Launcher_Base_F", configFile >> "CfgWeapons"]): {["<t color='#ff0000' size ='1.5'>Der Waffeneinsatz in der Basis ist gegen die Dienstvorschriften, Soldat!<br/>Sie wurden verwarnt.</t>",0,0,4,0] spawn BIS_fnc_dynamicText}; //--- RPGim allg
				default {["<t color='#ff0000' size ='1.5'>Zuwiderhandlung gegen die Dienstvorschriften in der Basis ist strengstens verboten, Soldat!<br/>Sie wurden verwarnt.</t>",0,0,4,0] spawn BIS_fnc_dynamicText};
			};
			[15] call MPS_fnc_AddFoul;	// ...increase his foul counter
		};
		//nil;	// prevent weapon firing anim & sound (doesn't work like this)
	}];
}
else	// ...otherwise...
{
	if (!isNil "MPS_BaseMrkr") then	// ...if there is no object called "MPS_BaseMrkr"...
	{
		["<t color='#ff0000' size ='1.5'>Es gibt keinen BaseMarker!<br/>Erstelle ein Objekt namens ""MPS_BaseMrkr"" und platziere es ins Zentrum der Spielerbasis, damit das Schutzsystem arbeiten kann.</t>",0,0,4,0] spawn BIS_fnc_dynamicText;	// ...tell him
	};
};
/* Baserape Protection section finished */


/* Teamkill Protection */
MPKilled_EH = player addMPEventHandler ["MPKilled",
{
	private _victim = _this select 0;
	private _killer = _this select 1;
	private _instigator = _this select 2;
	if ((player == _victim) && {!(player == _killer)}) then
	{
		hint format ["Du wurdest von deinem Kameraden %1 %2 aus der %3-Einheit getötet. Er wurde verwarnt.",toLower (rank _killer),name _killer,str(group _killer) select [2]];
	}
	else
	{ 
		if (player == _killer) then
		{
			[50] call MPS_fnc_AddFoul;
			if (MPS_FoulsCount < 100) then
			{	
				["<t color='#ff0000' size = '1.5'>Verbündetenbeschuss wird nicht toleriert, Soldat!<br/>Beim nächsten Verbündetenbeschuss wird ihre Mission abgebrochen.</t>",0,0,4,0] spawn BIS_fnc_dynamicText;
			};
		};
	};
}];
/* Teamkill Protection section finished */


/* Fouler Rejoin Protection */
if ((getPlayerUID player) in Blacklist && {!((getPlayerUID player) in Whitelist)}) then	// if player has already been kicked and therefor is on blacklist and he is also not on the whitelist of trustworthy people...
{
	PW_Attempts = 1;	// ...set this as his first password attempt
	waitUntil {time > 0};	// ...wait for mission start
	0 cutText ["Beantworten Sie die Frage, Soldat!","BLACK FADED",0,true];	// ...turn screen black as long as security question isn't answered
	createDialog "FRP";	// ...create according security dialog
};
/* Fouler Rejoin Protection section finished */


/* Slot Protection dialogs */
// check on join, if...
if (isMultiplayer) then	// only if it is multiplayer mode, for editor purposes
{
	// ...player has pilot password
	if (typeOf player in Pilots) then	// if player is a pilot...	
	{
		PW_Attempts = 1;	// ...set this as his first password attempt
		waitUntil {time > 0};	// ...wait for mission start
		0 cutText ["Beantworten Sie die Frage, Soldat!","BLACK FADED",0,true];	// ...turn screen black as long as security question isn't answered
		createDialog "CheckPilot";	// ...create according security dialog
	};

	// ...player has curator password
	if (typeOf player in Curators) then
	{
		PW_Attempts = 1;	// ...set this as his first password attempt
		waitUntil {time > 0};	// ...wait for mission start
		0 cutText ["Beantworten Sie die Frage, Soldat!","BLACK FADED",0,true];	// ...turn screen black as long as security question isn't answered
		createDialog "CheckCurator";	// ...create according security dialog
	};

	// ...player has OPZ password
	if (typeOf player in OPZ) then	// if player is a curator...
	{
		PW_Attempts = 1;	// ...set this as his first password attempt
		waitUntil {time > 0};	// ...wait for mission start
		0 cutText ["Beantworten Sie die Frage, Soldat!","BLACK FADED",0,true];	// ...turn screen black as long as security question isn't answered
		createDialog "CheckOPZ";	// ...create according security dialog
	};
};
/* Slot Protection section finished */


/* Idiotentest */
// ...JIPer speaks German
if (isMultiplayer && {didJIP}) then
{
	PW_Attempts = 1;	// ...set this as his first password attempt
	waitUntil {time > 0};	// ...wait for mission start
	0 cutText ["Beantworten Sie die Frage, Soldat!","BLACK FADED",0,true];	// ...turn screen black as long as security question isn't answered
	createDialog "CheckGerman";	// ...create according security dialog
	waitUntil {!dialog};	// ...wait until dialog is answered
	PW_Attempts = 1;	// ...set this as his first password attempt
	createDialog "CheckGerman2";	// ...create according security dialog
	waitUntil {!dialog};	// ...wait until dialog is answered
	PW_Attempts = 1;	// ...set this as his first password attempt
	createDialog "CheckGerman3";	// ...create according security dialog
	waitUntil {!dialog};	// ...wait until dialog is answered
	PW_Attempts = 1;	// ...set this as his first password attempt
	createDialog "CheckGerman4";	// ...create according security dialog
};
/* Idiotentest section finished */


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
			"Diesen Tagebucheintrag bekommst nur du als vertrauenswürdiger Spieler angezeigt. Alle Passwörter sind natürlich ohne Anführungszeichen einzugeben.<br/><br/>
			<font color='#1d49d1'>Slot Protection Passwords:</font color><br/>
				OPZ:  <font color='#107b1b'>""OPZ""</font color><br/>
				Piloten:  <font color='#107b1b'>""Pilot""</font color><br/>
				Zeus:  <font color='#107b1b'>""Zeus""</font color><br/><br/>
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