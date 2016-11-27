// by Quentin


// set AI skill according to value set in Mission Params in description.ext
if (_this select 0 == 1) then
{
	if ((uniform player == "U_B_CombatUniform_mcam") or {uniform player == "U_B_CombatUniform_mcam_tshirt"} or {uniform player == "U_B_CombatUniform_mcam_vest"}) then
	{
		player setObjectTextureGlobal [0,"\a3\characters_f\BLUFOR\Data\clothing_wdl_co.paa"];
		_vestItems = vestItems player;
		_vestMagazines = vestMagazines player;
		player addVest "V_PlateCarrier2_rgr";
		{player addItemToVest _x} forEach _vestItems;
		{player addItemToVest _x} forEach _vestMagazines;
		player addHeadgear "H_HelmetB_light";
		//player addEventHandler ["InventoryOpened",{player setObjectTextureGlobal [0,"\a3\characters_f\BLUFOR\Data\clothing_wdl_co.paa"];}];	// ...add persistent EH to keep woodland hiddenTexture
		addMissionEventHandler ["EachFrame",	// ...add persistent EH to keep woodland hiddenTexture
		{
			if !("a3\characters_f\blufor\data\clothing_wdl_co.paa" in getObjectTextures player) then
			{
				player setObjectTextureGlobal [0,"\a3\characters_f\BLUFOR\Data\clothing_wdl_co.paa"];
				if !(isNil QT_fnc_Insignia) then {[player] call QT_fnc_Insignia;};
			};
		}];
	};
};