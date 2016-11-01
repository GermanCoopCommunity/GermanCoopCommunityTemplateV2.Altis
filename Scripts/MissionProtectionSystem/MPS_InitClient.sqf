// by Fabi & Quentin


// set player's foul count to 0 initially
GeCo_MissionProtection_CountFouls = 0;


// fnc foul control
GeCo_MissionProtection_AddFoul =
{
    params [["_foulWeight", 1]];
    GeCo_MissionProtection_CountFouls = GeCo_MissionProtection_CountFouls + _foulWeight;	// increase player's foul limit by weight of the foul he committed
    
    if (GeCo_MissionProtection_CountFouls >= 100 && {!(getPlayerUID player in GeCo_Whitelist)}) then	// if player's fouls exceed limit and he isn't a trustworthy person on the whitelist...
	{
		[""] spawn BIS_fnc_dynamicText;	// ...remove currently displayed dynamic text
		endMission "LOSER";	// ...end mission for him
		titleCut ["Ihr Einsatz wurde aufgrund Ihres Fehlverhaltens abgebrochen.","BLACK FADED",0];	// ...inform him about the reason for the kick
		//["LOSER",false,0,false,false] call BIS_fnc_endMission;	// does the same as command above, but not as pretty and with "restart" option, which is not wanted
		GeCo_Blacklist pushbackUnique (getPlayerUID player);	// ...add player´s UID (equal to steamID64 of the player) to blacklist to prevent him from rejoining the mission
		publicVariable "GeCo_Blacklist";	// ...broadcast current blacklist to each connected computer
		((name player) + " wurde wegen seines Fehlverhaltens vom Einsatz abgezogen.") remoteExec ["systemChat",-2];	// ...show system info message for the other players
		["",format ["#kick %1",name player]] remoteExec ["serverCommand",2];	// ...kick him
    };
};


// prevent base shooting
Fired_EH = player addEventHandler ["Fired",
{
    if (((_this select 0) distance (getMarkerPos "GeCo_MissionProtection_BaseMarker")) < 400) then	// if player fires inside base...
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
		[15] call GeCo_MissionProtection_AddFoul;	// ...increase his foul counter
    };
	//nil;	// prevent weapon firing anim & sound (doesn't work like this)
}];


// teamkill punisher
MPKilled_EH = player addMPEventHandler ["MPKilled",
{
	private _victim = _this select 0;
	private _killer = _this select 1;
	private _instigator = _this select 2;
	if (player == _victim) then 
	{
		hint format ["Du wurdest von deinem Kameraden %1 %2 aus der %3-Einheit getötet. Er wurde verwarnt.",toLower (rank _killer),name _killer,str(group _killer) select [2]];
	}
	else
	{ 
		if (player == _killer) then
		{
			[50] call GeCo_MissionProtection_AddFoul;
			if (GeCo_MissionProtection_CountFouls < 100) then
			{	
				["<t color='#ff0000' size = '1.5'>Verbündetenbeschuss wird nicht toleriert, Soldat!<br/>Beim nächsten Verbündetenbeschuss wird ihre Mission abgebrochen.</t>",0,0,4,0] spawn BIS_fnc_dynamicText;
			}
		};
	};
}];


// if player is a curator, initialize MPS on vehicles and units spawned by him
if (typeOf player in ["VirtualCurator_F","B_VirtualCurator_F","O_VirtualCurator_F","I_VirtualCurator_F","C_VirtualCurator_F"]) then
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
					if ((_entity distance (getmarkerpos "GeCo_MissionProtection_BaseMarker")) < 400) then	// if curator placed unit shoots inside base...
					{
                        deleteVehicle _projectile;	// ...delete the projectile
                    };
                }];
            };
        }
    ];
};


// check on join, if...
GeCo_PasswordCorrect = false;

// ...player has pilot password
if (typeOf player in ["B_Helipilot_F","B_Pilot_F","O_Helipilot_F","O_Pilot_F","I_helipilot_F","I_Pilot_F","C_man_pilot_F"] && {isMultiplayer}) then	// if player is a pilot...	(and only if it is multiplayer mode, for editor purposes)
{
    GeCo_Try = 1;	// ...set this as his first password attempt
    GeCo_fn_Passwort =
	{
		private _ok = createDialog "GeCo_CheckPilot";	// ...open the dialog for entering password
        waitUntil {!dialog};	// ...wait until dialog is created
        if(!GeCo_PasswordCorrect) then	// ...if entered password is wrong...
		{
            if (GeCo_Try < 3) then	// ...if that wasn´t his third attempt...
			{
				GeCo_Try = GeCo_Try + 1;	// ...increase attempt counter
				//hintC format ["Falsch. Du hast noch %1 Versuche.", 4 - GeCo_Try];	// ...show him an error
				//hint "";	// remove hint remains
                [] call GeCo_fn_Passwort;	// ...and reopen dialog
            }
			else	// ...if it was his third attempt...
			{ 
                [100] call GeCo_MissionProtection_AddFoul;	// ...kick him
            };
        };
    };
    [] call GeCo_fn_Passwort;
};

// ...player has curator password
if (typeOf player in ["VirtualCurator_F","B_VirtualCurator_F","O_VirtualCurator_F","I_VirtualCurator_F","C_VirtualCurator_F"] && {isMultiplayer}) then	// if player is a curator...	(and only if it is multiplayer mode, for editor purposes)
{
    GeCo_Try = 1;	// ...set this as his first password attempt
    GeCo_fn_Passwort =
	{
        private _ok = createDialog "GeCo_CheckCurator";	// ...open the dialog for entering password
        waitUntil {!dialog};	// ...wait until dialog is created
        if (!GeCo_PasswordCorrect) then	// ...if entered password is wrong...
		{
            if (GeCo_Try < 3) then	// ...if that wasn´t his third attempt...
			{
				GeCo_Try = GeCo_Try + 1;	// ...increase attempt counter
				//hintC format ["Falsch. Du hast noch %1 Versuche.", 4 - GeCo_Try];	// ...show him an error (doesn´t seem to work in Zeus interface)
				//hint "";	// remove hint remains
                [] call GeCo_fn_Passwort;	// ...and reopen dialog
            }
			else	// ...if it was his third attempt...
			{ 
                [100] call GeCo_MissionProtection_AddFoul;	// ...kick him
            };
        };
    };
    [] call GeCo_fn_Passwort;
};

// ...player has OPZ password
if (typeOf player in ["B_officer_F","O_officer_F","I_officer_F"] && {isMultiplayer}) then	// if player is a curator...
{
    GeCo_Try = 1;	// ...set this as his first password attempt
    GeCo_fn_Passwort =
	{
        private _ok = createDialog "GeCo_CheckOPZ";	// ...open the dialog for entering password
        waitUntil {!dialog};	// ...wait until dialog is created
        if (!GeCo_PasswordCorrect) then	// ...if entered password is wrong...
		{
            if (GeCo_Try < 3) then	// ...if that wasn´t his third attempt...
			{
				GeCo_Try = GeCo_Try + 1;	// ...increase attempt counter
				//hintC format ["Falsch. Du hast noch %1 Versuche.", 4 - GeCo_Try];	// ...show him an error
				//hint "";	// remove hint remains
                [] call GeCo_fn_Passwort;	// ...and reopen dialog
            }
			else	// ...if it was his third attempt...
			{ 
                [100] call GeCo_MissionProtection_AddFoul;	// ...kick him
            };
        };
    };
    [] call GeCo_fn_Passwort;
};


// ...JIPer speaks German
if (didJIP) then
{
	if (!GeCo_PasswordCorrect && {isMultiplayer}) then	// if entered password is wrong...	(and only if it is multiplayer mode, for editor purposes)
	{
		GeCo_Try = 1;	// ...set this as his first password attempt
		GeCo_fn_Passwort =
		{
			private _ok = createDialog "GeCo_CheckGerman";	// ...open the dialog for answering a question
			waitUntil {!dialog};	// ...wait until dialog is created
			if (!GeCo_PasswordCorrect) then	// ...if entered password is wrong...
			{
				if (GeCo_Try < 3) then	// ...if that wasn´t his third attempt...
				{
					GeCo_Try = GeCo_Try + 1;	// ...increase attempt counter
					//hintC format ["Falsch. Du hast noch %1 Versuche.", 4 - GeCo_Try];	// ...show him an error
					//hint "";	// remove hint remains
					[] call GeCo_fn_Passwort;	// ...and reopen dialog
				}
				else	// ...if it was his third attempt...
				{ 
					[100] call GeCo_MissionProtection_AddFoul;	// ...kick him
				};
			};
		};
		[] call GeCo_fn_Passwort;
	};
	if (!GeCo_PasswordCorrect && {isMultiplayer}) then	// if entered password is wrong...	(and only if it is multiplayer mode, for editor purposes)
	{
		GeCo_Try = 1;	// ...set this as his first password attempt
		GeCo_fn_Passwort =
		{
			private _ok = createDialog "GeCo_CheckGerman2";	// ...open the dialog for answering a question
			waitUntil {!dialog};	// ...wait until dialog is created
			if (!GeCo_PasswordCorrect) then	// ...if entered password is wrong...
			{
				if (GeCo_Try < 3) then	// ...if that wasn´t his third attempt...
				{
					GeCo_Try = GeCo_Try + 1;	// ...increase attempt counter
					//hintC format ["Falsch. Du hast noch %1 Versuche.", 4 - GeCo_Try];	// ...show him an error
					//hint "";	// remove hint remains
					[] call GeCo_fn_Passwort;	// ...and reopen dialog
				}
				else	// ...if it was his third attempt...
				{ 
					[100] call GeCo_MissionProtection_AddFoul;	// ...kick him
				};
			};
		};
		[] call GeCo_fn_Passwort;
	};
	if (!GeCo_PasswordCorrect && {isMultiplayer}) then	// if entered password is wrong...	(and only if it is multiplayer mode, for editor purposes)
	{
		GeCo_Try = 1;	// ...set this as his first password attempt
		GeCo_fn_Passwort =
		{
			private _ok = createDialog "GeCo_CheckGerman3";	// ...open the dialog for answering a question
			waitUntil {!dialog};	// ...wait until dialog is created
			if (!GeCo_PasswordCorrect) then	// ...if entered password is wrong...
			{
				if (GeCo_Try < 3) then	// ...if that wasn´t his third attempt...
				{
					GeCo_Try = GeCo_Try + 1;	// ...increase attempt counter
					//hintC format ["Falsch. Du hast noch %1 Versuche.", 4 - GeCo_Try];	// ...show him an error
					//hint "";	// remove hint remains
					[] call GeCo_fn_Passwort;	// ...and reopen dialog
				}
				else	// ...if it was his third attempt...
				{ 
					[100] call GeCo_MissionProtection_AddFoul;	// ...kick him
				};
			};
		};
		[] call GeCo_fn_Passwort;
	};
	if (!GeCo_PasswordCorrect && {isMultiplayer}) then	// if entered password is wrong...	(and only if it is multiplayer mode, for editor purposes)
	{
		GeCo_Try = 1;	// ...set this as his first password attempt
		GeCo_fn_Passwort =
		{
			private _ok = createDialog "GeCo_CheckGerman4";	// ...open the dialog for answering a question
			waitUntil {!dialog};	// ...wait until dialog is created
			if (!GeCo_PasswordCorrect) then	// ...if entered password is wrong...
			{
				if (GeCo_Try < 3) then	// ...if that wasn´t his third attempt...
				{
					GeCo_Try = GeCo_Try + 1;	// ...increase attempt counter
					//hintC format ["Falsch. Du hast noch %1 Versuche.", 4 - GeCo_Try];	// ...show him an error
					//hint "";	// remove hint remains
					[] call GeCo_fn_Passwort;	// ...and reopen dialog
				}
				else	// ...if it was his third attempt...
				{ 
					[100] call GeCo_MissionProtection_AddFoul;	// ...kick him
				};
			};
		};
		[] call GeCo_fn_Passwort;
	};
	if ((getPlayerUID player) in GeCo_Blacklist && {!(getPlayerUID player) in GeCo_Whitelist}) then	// if player has already been kicked and therefor is on blacklist and not on the whitelist of trustworthy people...
	{
		GeCo_Try = 1;	// ...set this as his first password attempt
		GeCo_fn_Passwort =
		{
			private _ok = createDialog "GeCo_FRP";	// ...open the dialog for answering a question
			waitUntil {!dialog};	// ...wait until dialog is created
			if (!GeCo_PasswordCorrect) then	// ...if entered password is wrong...
			{
				if (GeCo_Try < 3) then	// ...if that wasn´t his third attempt...
				{
					GeCo_Try = GeCo_Try + 1;	// ...increase attempt counter
					//hintC format ["Falsch. Du hast noch %1 Versuche.", 4 - GeCo_Try];	// ...show him an error
					//hint "";	// remove hint remains
					[] call GeCo_fn_Passwort;	// ...and reopen dialog
				}
				else	// ...if it was his third attempt...
				{ 
					[100] call GeCo_MissionProtection_AddFoul;	// ...kick him
				};
			};
		};
		[] call GeCo_fn_Passwort;
	};
};


// if player is judged trustworthy by MPS, tell him the passwords to all slots
if ((getPlayerUID player) in GeCo_Whitelist) then
{
	player createDiarySubject ["Sicherheit","Sicherheit"];
	player createDiaryRecord [
		"Sicherheit",
		[
			"Passwörter",
				"Diesen Tagebucheintrag bekommst nur du als Mitglied des GeCo-Teams angezeigt.<br/><br/>Folgende Passwörter schützen die Slots:<br/>OPZ:  <font color='#107b1b'>""OPZ""</font color><br/>Piloten:  <font color='#107b1b'>""Pilot""</font color><br/>Zeus:  <font color='#107b1b'>""Zeus""</font color><br/>allgemein:  <font color='#107b1b'>""deutsch""</font color>"
		]
	];
};