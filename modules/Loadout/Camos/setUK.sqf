// by Quentin


possCamoUnif = ["U_B_CombatUniform_mcam","U_B_CombatUniform_mcam_tshirt","U_B_CombatUniform_mcam_vest"];

if (uniform player in possCamoUnif) then
{
	private _unifItems = uniformItems player;
	private _unifMagazines = uniformMagazines player;
	
	if (_this select 0 isEqualTo "NonTanoa") then
	{
		if (uniform player isEqualTo "U_B_CombatUniform_mcam") then {player addUniform "U_B_CTRG_1"};
		if (uniform player isEqualTo "U_B_CombatUniform_mcam_tshirt") then {player addUniform "U_B_CTRG_1"};
		if (uniform player isEqualTo "U_B_CombatUniform_mcam_vest") then {player addUniform "U_B_CTRG_1"};
	}
	else
	{
		if (uniform player isEqualTo "U_B_CombatUniform_mcam") then {player addUniform "U_B_CTRG_Soldier_urb_1_F"};
		if (uniform player isEqualTo "U_B_CombatUniform_mcam_tshirt") then {player addUniform "U_B_CTRG_Soldier_urb_2_F"};
		if (uniform player isEqualTo "U_B_CombatUniform_mcam_vest") then {player addUniform "U_B_CTRG_Soldier_urb_3_F"};
	};
		
	{player addItemToUniform _x; nil;} count _unifItems;
	{player addItemToUniform _x; nil;} count _unifMagazines;
	
	private _vestItems = vestItems player;
	private _vestMagazines = vestMagazines player;
	switch (vest player) do
	{
		// if player wears Carrier GL Rig
		case "V_PlateCarrierGL_blk": {player addVest "V_PlateCarrierH_CTRG"};
		case "V_PlateCarrierGL_mtp": {player addVest "V_PlateCarrierH_CTRG"};
		case "V_PlateCarrierGL_tna_F": {player addVest "V_PlateCarrierH_CTRG"};
		// if player wears Carrier Lite
		case "V_PlateCarrier1_blk": {player addVest "V_PlateCarrierL_CTRG"};
		case "V_PlateCarrier1_rgr_noflag_F": {player addVest "V_PlateCarrierL_CTRG"};
		case "V_PlateCarrier1_tna_F": {player addVest "V_PlateCarrierL_CTRG"};
		// if player wears Carrier Rig
		case "V_PlateCarrier2_blk": {player addVest "V_PlateCarrierH_CTRG"};
		case "V_PlateCarrier2_rgr_noflag_F": {player addVest "V_PlateCarrierH_CTRG"};
		case "V_PlateCarrier2_tna_F": {player addVest "V_PlateCarrierH_CTRG"};
		// if player wears Carrier Special Rig
		case "V_PlateCarrierSpec_blk": {player addVest "V_PlateCarrierH_CTRG"};
		case "V_PlateCarrierSpec_mtp": {player addVest "V_PlateCarrierH_CTRG"};
		case "V_PlateCarrierSpec_tna_F": {player addVest "V_PlateCarrierH_CTRG"};
		// if player wears Chest Rig
		case "V_Chestrig_blk": {player addVest "V_PlateCarrierL_CTRG"};
		case "V_Chestrig_khk": {player addVest "V_PlateCarrierL_CTRG"};
		case "V_Chestrig_oli": {player addVest "V_PlateCarrierL_CTRG"};
		// if player wears Slash Bandolier
		case "V_BandollierB_blk": {player addVest "V_PlateCarrierL_CTRG"};
		case "V_BandollierB_cbr": {player addVest "V_PlateCarrierL_CTRG"};
		case "V_BandollierB_ghex_F": {player addVest "V_PlateCarrierL_CTRG"};
		case "V_BandollierB_khk": {player addVest "V_PlateCarrierL_CTRG"};
		case "V_BandollierB_oli": {player addVest "V_PlateCarrierL_CTRG"};
		// more to come
		//case "": {player addVest "V_TacVest_camo"};
		
		default {nil};
	};
	{player addItemToVest _x; nil;} count _vestItems;
	{player addItemToVest _x; nil;} count _vestMagazines;
	plyr_ldt = getUnitLoadout player;	// save default player loadout to apply on respawn later
};