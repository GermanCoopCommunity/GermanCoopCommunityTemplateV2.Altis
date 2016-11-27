// by Quentin


if !((isClass (configFile >> "CfgPatches" >> "cba_ee")) && ((isClass (configFile >> "CfgPatches" >> "A3C_NameTag")) or (isClass (configFile >> "CfgPatches" >> "STNametags")))) then	// if player doesn´t run the nametag mods STNameTags and A3C_NameTag...
{addMissionEventHandler ["Draw3D",{_this call JK_fnc_NameTags}];};	// ...initialize JK Nametags for player