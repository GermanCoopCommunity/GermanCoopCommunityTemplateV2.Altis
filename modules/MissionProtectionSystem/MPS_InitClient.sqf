// by Fabi & Quentin


// wait until all core variables are publicized
waitUntil {!isNil "AllFoulers"};


/* Fouls section */
// set player's foul count to 0 initially
MPS_FoulsCount = 0;

// fnc foul control
MPS_fn_AddFoul =
{
    params [["_foulWeight", 1]];
    MPS_FoulsCount = MPS_FoulsCount + _foulWeight;	// increase player's foul limit by weight of the foul he committed
    
    if (MPS_FoulsCount >= 100 && {!(getPlayerUID player in Whitelist)}) then	// if player's fouls exceed limit and he isn't a trustworthy person on the whitelist...
	{
		[""] spawn BIS_fnc_dynamicText;	// ...remove currently displayed dynamic text
		endMission "LOSER";	// ...end mission for him
		titleCut ["Ihr Einsatz wurde aufgrund Ihres Fehlverhaltens abgebrochen.","BLACK FADED",0];	// ...inform him about the reason for the kick
		//["LOSER",false,0,false,false] call BIS_fnc_endMission;	// does the same as command above, but not as pretty and with "restart" option, which is not wanted
		Blacklist pushbackUnique (getPlayerUID player);	// ...add player's UID (equal to steamID64 of the player) to blacklist to prevent him from rejoining the mission (FRP)
		publicVariable "Blacklist";	// ...broadcast current blacklist to each connected computer
		AllFoulers pushbackUnique (name player);	// ...add player´s name to array of all players to display it
		publicVariable "AllFoulers";	// ...broadcast current foulers to each connected computer
		["eevlkneevl",format ["#kick %1",name player]] remoteExec ["serverCommand",2];	// ...kick him
		((name player) + " wurde wegen seines Fehlverhaltens vom Einsatz abgezogen.") remoteExec ["systemChat",-2];	// ...show system info message for the other players
    };
};
/* Fouls section finished */


/* Baserape Protection section */
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
		[15] call MPS_fn_AddFoul;	// ...increase his foul counter
    };
	//nil;	// prevent weapon firing anim & sound (doesn't work like this)
}];
/* Baserape Protection section finished */


/* Teamkill Protection */
// teamkill punisher
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
			[50] call MPS_fn_AddFoul;
			if (MPS_FoulsCount < 100) then
			{	
				["<t color='#ff0000' size = '1.5'>Verbündetenbeschuss wird nicht toleriert, Soldat!<br/>Beim nächsten Verbündetenbeschuss wird ihre Mission abgebrochen.</t>",0,0,4,0] spawn BIS_fnc_dynamicText;
			};
		};
	};
}];
/* Teamkill Protection section finished */


/* Fouler Rejoin Protection */
if ((getPlayerUID player) in Blacklist && {!((getPlayerUID player) in Whitelist)}) then	// if player has already been kicked and therefor is on blacklist and not on the whitelist of trustworthy people...
{
	Attempts = 1;	// ...set this as his first password attempt
	SP_fn_PW =
	{
		private _ok = createDialog "FRP";	// ...open the dialog for answering a question
		0 cutText ["Beantworten Sie die Frage, Soldat!","BLACK FADED",0,true];	// ...turn screen black as long as security question isn't answered
		waitUntil {!dialog};	// ...wait until dialog is created
		if (!PW_correct) then	// ...if entered password is wrong...
		{
			if (Attempts < 3) then	// ...if that wasn´t his third attempt...
			{
				Attempts = Attempts + 1;	// ...increase attempt counter
				//hintC format ["Falsch. Du hast noch %1 Versuche.", 4 - Attempts];	// ...show him an error
				//hint "";	// remove hint remains
				[] call SP_fn_PW;	// ...and reopen dialog
			}
			else	// ...if it was his third attempt...
			{ 
				[100] call MPS_fn_AddFoul;	// ...kick him
			};
		};
	};
	[] call SP_fn_PW;
};
/* Fouler Rejoin Protection section finished */


/* Slot Protection dialogs */
PW_correct = false;

// check on join, if...
if (isMultiplayer) then
{
	// ...player has pilot password
	if (typeOf player in Pilots) then	// if player is a pilot...	(and only if it is multiplayer mode, for editor purposes)
	{
		Attempts = 1;	// ...set this as his first password attempt
		SP_fn_PW =
		{
			private _ok = createDialog "CheckPilot";	// ...open the dialog for entering password
			0 cutText ["Beantworten Sie die Frage, Soldat!","BLACK FADED",0,true];	// ...turn screen black as long as security question isn't answered
			waitUntil {!dialog};	// ...wait until dialog is created
			if(!PW_correct) then	// ...if entered password is wrong...
			{
				if (Attempts < 3) then	// ...if that wasn´t his third attempt...
				{
					Attempts = Attempts + 1;	// ...increase attempt counter
					//hintC format ["Falsch. Du hast noch %1 Versuche.", 4 - Attempts];	// ...show him an error
					//hint "";	// remove hint remains
					[] call SP_fn_PW;	// ...and reopen dialog
				}
				else	// ...if it was his third attempt...
				{ 
					[100] call MPS_fn_AddFoul;	// ...kick him
				};
			};
		};
		[] call SP_fn_PW;
	};

	// ...player has curator password
	if (typeOf player in Curators) then	// if player is a curator...	(and only if it is multiplayer mode, for editor purposes)
	{
		Attempts = 1;	// ...set this as his first password attempt
		SP_fn_PW =
		{
			private _ok = createDialog "CheckCurator";	// ...open the dialog for entering password
			0 cutText ["Beantworten Sie die Frage, Soldat!","BLACK FADED",0,true];	// ...turn screen black as long as security question isn't answered
			waitUntil {!dialog};	// ...wait until dialog is created
			if (!PW_correct) then	// ...if entered password is wrong...
			{
				if (Attempts < 3) then	// ...if that wasn´t his third attempt...
				{
					Attempts = Attempts + 1;	// ...increase attempt counter
					//hintC format ["Falsch. Du hast noch %1 Versuche.", 4 - Attempts];	// ...show him an error (doesn´t seem to work in Zeus interface)
					//hint "";	// remove hint remains
					[] call SP_fn_PW;	// ...and reopen dialog
				}
				else	// ...if it was his third attempt...
				{ 
					[100] call MPS_fn_AddFoul;	// ...kick him
				};
			};
		};
		[] call SP_fn_PW;
	};

	// ...player has OPZ password
	if (typeOf player in OPZ) then	// if player is a curator...
	{
		Attempts = 1;	// ...set this as his first password attempt
		SP_fn_PW =
		{
			private _ok = createDialog "CheckOPZ";	// ...open the dialog for entering password
			0 cutText ["Beantworten Sie die Frage, Soldat!","BLACK FADED",0,true];	// ...turn screen black as long as security question isn't answered
			waitUntil {!dialog};	// ...wait until dialog is created
			if (!PW_correct) then	// ...if entered password is wrong...
			{
				if (Attempts < 3) then	// ...if that wasn´t his third attempt...
				{
					Attempts = Attempts + 1;	// ...increase attempt counter
					//hintC format ["Falsch. Du hast noch %1 Versuche.", 4 - Attempts];	// ...show him an error
					//hint "";	// remove hint remains
					[] call SP_fn_PW;	// ...and reopen dialog
				}
				else	// ...if it was his third attempt...
				{ 
					[100] call MPS_fn_AddFoul;	// ...kick him
				};
			};
		};
		[] call SP_fn_PW;
	};
};
/* Slot Protection section finished */


/* Idiotentest */
// ...JIPer speaks German
if (isMultiplayer && {didJIP}) then
{
	if (!PW_correct) then	// if entered password is wrong...	(and only if it is multiplayer mode, for editor purposes)
	{
		Attempts = 1;	// ...set this as his first password attempt
		SP_fn_PW =
		{
			private _ok = createDialog "CheckGerman";	// ...open the dialog for answering a question
			0 cutText ["Beantworten Sie die Frage, Soldat!","BLACK FADED",0,true];	// ...turn screen black as long as security question isn't answered
			waitUntil {!dialog};	// ...wait until dialog is created
			if (!PW_correct) then	// ...if entered password is wrong...
			{
				if (Attempts < 3) then	// ...if that wasn´t his third attempt...
				{
					Attempts = Attempts + 1;	// ...increase attempt counter
					//hintC format ["Falsch. Du hast noch %1 Versuche.", 4 - Attempts];	// ...show him an error
					//hint "";	// remove hint remains
					[] call SP_fn_PW;	// ...and reopen dialog
				}
				else	// ...if it was his third attempt...
				{ 
					[100] call MPS_fn_AddFoul;	// ...kick him
				};
			};
		};
		[] call SP_fn_PW;
	};
	if (!PW_correct) then	// if entered password is wrong...	(and only if it is multiplayer mode, for editor purposes)
	{
		Attempts = 1;	// ...set this as his first password attempt
		SP_fn_PW =
		{
			private _ok = createDialog "CheckGerman2";	// ...open the dialog for answering a question
			0 cutText ["Beantworten Sie die Frage, Soldat!","BLACK FADED",0,true];	// ...turn screen black as long as security question isn't answered
			waitUntil {!dialog};	// ...wait until dialog is created
			if (!PW_correct) then	// ...if entered password is wrong...
			{
				if (Attempts < 3) then	// ...if that wasn´t his third attempt...
				{
					Attempts = Attempts + 1;	// ...increase attempt counter
					//hintC format ["Falsch. Du hast noch %1 Versuche.", 4 - Attempts];	// ...show him an error
					//hint "";	// remove hint remains
					[] call SP_fn_PW;	// ...and reopen dialog
				}
				else	// ...if it was his third attempt...
				{ 
					[100] call MPS_fn_AddFoul;	// ...kick him
				};
			};
		};
		[] call SP_fn_PW;
	};
	if (!PW_correct) then	// if entered password is wrong...	(and only if it is multiplayer mode, for editor purposes)
	{
		Attempts = 1;	// ...set this as his first password attempt
		SP_fn_PW =
		{
			private _ok = createDialog "CheckGerman3";	// ...open the dialog for answering a question
			0 cutText ["Beantworten Sie die Frage, Soldat!","BLACK FADED",0,true];	// ...turn screen black as long as security question isn't answered
			waitUntil {!dialog};	// ...wait until dialog is created
			if (!PW_correct) then	// ...if entered password is wrong...
			{
				if (Attempts < 3) then	// ...if that wasn´t his third attempt...
				{
					Attempts = Attempts + 1;	// ...increase attempt counter
					//hintC format ["Falsch. Du hast noch %1 Versuche.", 4 - Attempts];	// ...show him an error
					//hint "";	// remove hint remains
					[] call SP_fn_PW;	// ...and reopen dialog
				}
				else	// ...if it was his third attempt...
				{ 
					[100] call MPS_fn_AddFoul;	// ...kick him
				};
			};
		};
		[] call SP_fn_PW;
	};
	if (!PW_correct) then	// if entered password is wrong...	(and only if it is multiplayer mode, for editor purposes)
	{
		Attempts = 1;	// ...set this as his first password attempt
		SP_fn_PW =
		{
			private _ok = createDialog "CheckGerman4";	// ...open the dialog for answering a question
			0 cutText ["Beantworten Sie die Frage, Soldat!","BLACK FADED",0,true];	// ...turn screen black as long as security question isn't answered
			waitUntil {!dialog};	// ...wait until dialog is created
			if (!PW_correct) then	// ...if entered password is wrong...
			{
				if (Attempts < 3) then	// ...if that wasn´t his third attempt...
				{
					Attempts = Attempts + 1;	// ...increase attempt counter
					//hintC format ["Falsch. Du hast noch %1 Versuche.", 4 - Attempts];	// ...show him an error
					//hint "";	// remove hint remains
					[] call SP_fn_PW;	// ...and reopen dialog
				}
				else	// ...if it was his third attempt...
				{ 
					[100] call MPS_fn_AddFoul;	// ...kick him
				};
			};
		};
		[] call SP_fn_PW;
	};
};
/* Idiotentest section finished */


// if player is a curator, initialize MPS on vehicles and units spawned by him
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