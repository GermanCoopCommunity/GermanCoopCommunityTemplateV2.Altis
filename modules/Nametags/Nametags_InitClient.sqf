// by Quentin


// log start of execution
if !(player diarySubjectExists "Modules") then {player createDiarySubject ["Modules","Modules"];};
player createDiaryRecord ["Modules",["Nametags InitClient","<font color='#b40100'>Ausführung begonnen</font color> nach " + str(time) + " Sekunden."]];


if !((isClass (configFile >> "CfgPatches" >> "cba_ee")) && ((isClass (configFile >> "CfgPatches" >> "A3C_NameTag")) or (isClass (configFile >> "CfgPatches" >> "STNametags")))) then	// if player doesn´t run the nametag mods STNameTags and A3C_NameTag...
{addMissionEventHandler ["Draw3D",{_this call JK_fnc_NameTags}];};	// ...initialize JK Nametags for player


// log end of execution
player createDiaryRecord ["Modules",["Nametags InitClient","<font color='#107b1b'>Ausführung beendet</font color> nach " + str(time) + " Sekunden."]];