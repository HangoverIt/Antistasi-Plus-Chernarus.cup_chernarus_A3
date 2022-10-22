///////////////////////////
//   Rebel Information   //
///////////////////////////

["name", "NAPA"] call _fnc_saveToTemplate; 						

["flag", "FlagCarrierGUE"] call _fnc_saveToTemplate; 						
["flagTexture", "ca\data\flag_napa_co.paa"] call _fnc_saveToTemplate;
["flagMarkerType", "Faction_GUE"] call _fnc_saveToTemplate; 

["vehicleBasic", "CUP_C_TT650_CIV"] call _fnc_saveToTemplate; 			
["vehicleLightUnarmed", "CUP_I_Datsun_4seat"] call _fnc_saveToTemplate; 		
["vehicleLightArmed", "CUP_I_Datsun_PK"] call _fnc_saveToTemplate;
["vehicleHeavyArmed", "CUP_I_Hilux_DSHKM_NAPA"] call _fnc_saveToTemplate;
["vehicleTruck", "CUP_V3S_Open_NAPA"] call _fnc_saveToTemplate; 			
["vehicleAT", "CUP_I_Hilux_SPG9_NAPA"] call _fnc_saveToTemplate; 		
["vehicleAA", "CUP_I_Ural_ZU23_NAPA"] call _fnc_saveToTemplate; 		

["vehicleBoat", "I_C_Boat_Transport_02_F"] call _fnc_saveToTemplate; 	
["vehicleRepair", "CUP_I_V3S_Repair_TKG"] call _fnc_saveToTemplate; 			
["vehicleFuel", "CUP_I_V3S_Refuel_TKG"] call _fnc_saveToTemplate; 			

["vehiclePlane", "CUP_C_AN2_CIV"] call _fnc_saveToTemplate; 		
["vehiclePayloadPlane", "CUP_C_CESSNA_CIV"] call _fnc_saveToTemplate;
["vehicleHeli", "not_supported"] call _fnc_saveToTemplate; 		

["vehicleCivBike", "CUP_C_TT650_CIV"] call _fnc_saveToTemplate;
["vehicleCivCar", "CUP_O_Hilux_unarmed_CR_CIV"] call _fnc_saveToTemplate;
["vehicleCivTruck", "CUP_C_Ural_Open_Civ_03"] call _fnc_saveToTemplate;
["vehicleCivHeli", "CUP_C_SA330_Puma_HC1_ChernAvia"] call _fnc_saveToTemplate;
["vehicleCivBoat", "CUP_C_PBX_CIV"] call _fnc_saveToTemplate;
["vehicleCivSupply", "C_Van_01_box_F"] call _fnc_saveToTemplate;

["staticMG", "CUP_I_DSHKM_NAPA"] call _fnc_saveToTemplate; 					
["staticAT", "CUP_I_SPG9_NAPA"] call _fnc_saveToTemplate; 					
["staticAA", "CUP_I_ZU23_NAPA"] call _fnc_saveToTemplate; 					
["staticMortar", "CUP_I_2b14_82mm_NAPA"] call _fnc_saveToTemplate; 				
["staticMortarMagHE", "8Rnd_82mm_Mo_shells"] call _fnc_saveToTemplate;
["staticMortarMagSmoke", "8Rnd_82mm_Mo_Smoke_white"] call _fnc_saveToTemplate;

//Static weapon definitions
["baggedMGs", [["CUP_B_DShkM_Gun_Bag","CUP_B_DShkM_TripodHigh_Bag"]]] call _fnc_saveToTemplate; 				
["baggedAT", [["CUP_B_SPG9_Gun_Bag","CUP_B_SPG9_Tripod_Bag"]]] call _fnc_saveToTemplate; 					
["baggedAA", []] call _fnc_saveToTemplate; 				
["baggedMortars", [["CUP_B_Podnos_Gun_Bag","CUP_B_Podnos_Bipod_Bag"]]] call _fnc_saveToTemplate; 			

["mineAT", ["CUP_Mine_M","CUP_MineE_M"]] call _fnc_saveToTemplate;
["mineAPERS", ["ClaymoreDirectionalMine_Remote_Mag","APERSMine_Range_Mag", "APERSBoundingMine_Range_Mag", "APERSTripMine_Wire_Mag"]] call _fnc_saveToTemplate;					

["breachingExplosivesAPC", [["DemoCharge_Remote_Mag", 1], ["IEDLandSmall_Remote_Mag", 1], ["IEDUrbanSmall_Remote_Mag", 1]]] call _fnc_saveToTemplate;
["breachingExplosivesTank", [
		["SatchelCharge_Remote_Mag", 1],
		["CUP_PipeBomb_M", 1],
		["CUP_TimeBomb_M", 1], 
		["CUP_IED_V4_M", 1],
		["CUP_IED_V2_M", 1],
		["CUP_IED_V3_M", 2],
		["CUP_IED_V1_M", 2],
		["DemoCharge_Remote_Mag", 2], 
		["IEDLandSmall_Remote_Mag", 2], 
		["IEDUrbanSmall_Remote_Mag", 2], 
		["IEDUrbanSmall_Remote_Mag", 2]
	]
] call _fnc_saveToTemplate;

///////////////////////////
//  Rebel Starting Gear  //
///////////////////////////
["uniforms", [
"U_IG_Guerilla1_1",
"U_IG_Guerilla2_1",
"U_IG_Guerilla2_2",
"U_IG_Guerilla2_3",
"U_IG_Guerilla3_1",
"U_IG_leader",
"U_IG_Guerrilla_6_1",
"CUP_U_I_GUE_Anorak_03",
"CUP_U_I_GUE_Anorak_02",
"CUP_U_I_GUE_WorkU_01",
"CUP_U_I_GUE_WorkU_02",
"CUP_U_I_GUE_Flecktarn2",
"CUP_U_I_GUE_Flecktarn",
"CUP_U_I_GUE_Flecktarn4",
"CUP_U_I_GUE_Woodland1"
]] call _fnc_saveToTemplate;

["headgear", [
    "CUP_H_Ger_Boonie2_Flecktarn",
	"CUP_H_C_Beret_01",
	"CUP_H_C_Beret_02",
	"CUP_H_C_Beret_03",
	"CUP_H_C_Beret_04",
	"CUP_H_US_BOONIE_Alpenflage",
	"CUP_H_US_patrol_cap_alpenflage",
	"H_Booniehat_khk_hs",
	"H_Booniehat_tan",
	"H_Cap_tan",
	"H_Cap_oli_hs",
	"H_Cap_blk",
	"H_Cap_headphones",
	"H_ShemagOpen_tan",
	"H_Shemag_olive_hs",
	"H_Bandanna_khk_hs",
	"H_Bandanna_sand",
	"H_Bandanna_cbr"
]] call _fnc_saveToTemplate;

private _initialRebelEquipment = ["Binocular"
];

if (A3A_hasTFAR) then {_initialRebelEquipment append ["tf_microdagr","tf_anprc154"]};
if (A3A_hasTFAR && startWithLongRangeRadio) then {_initialRebelEquipment pushBack "tf_anprc155_coyote"};
if (A3A_hasTFARBeta) then {_initialRebelEquipment append ["TFAR_microdagr","TFAR_anprc154"]};
if (A3A_hasTFARBeta && startWithLongRangeRadio) then {_initialRebelEquipment pushBack "TFAR_anprc155_coyote"};

["initialRebelEquipment", _initialRebelEquipment] call _fnc_saveToTemplate;

//////////////////////////////////////
//       Antistasi Plus Stuff       //
//////////////////////////////////////
["baseSoldiers", [ // Cases matter. Lower case here because allVariables on namespace returns lowercase
	["militia_unarmed", "I_E_Soldier_unarmed_F"],
	["militia_rifleman", "I_E_Soldier_F"],
	["militia_staticcrew", "I_E_Soldier_F"],
	["militia_medic", "I_E_Medic_F"],
	["militia_sniper", "I_E_soldier_M_F"],
	["militia_marksman", "I_E_soldier_M_F"],
	["militia_lat", "I_E_Soldier_LAT2_F"],
	["militia_machinegunner", "I_E_Soldier_AR_F"],
	["militia_explosivesexpert", "I_E_Soldier_Exp_F"],
	["militia_grenadier", "I_E_Soldier_GL_F"],
	["militia_squadleader", "I_E_Soldier_SL_F"],
	["militia_engineer", "I_E_Engineer_F"],
	["militia_at", "I_E_Soldier_LAT_F"],
	["militia_aa", "I_E_Soldier_AA_F"],
	["militia_petrovsky", "I_E_Officer_F"]
]] call _fnc_saveToTemplate;

lootCrate = "Box_Syndicate_Ammo_F";
rallyPoint = "B_RadioBag_01_wdl_F";

//black market stuff
shop_UAV = ["I_UAV_01_F"];
shop_AA = ["CUP_I_Datsun_AA", "CUP_O_ZSU23_Afghan_TK", "CUP_I_M163_Vulcan_AAF"];
shop_MRAP = ["CUP_I_BTR40_MG_TKG", "CUP_B_RG31_M2_OD_USA", "CUP_I_BRDM2_NAPA"];
shop_wheel_apc = ["CUP_O_BTR60_SLA", "CUP_O_BTR80_SLA", "CUP_B_LAV25M240_USMC"];
shop_track_apc = ["CUP_B_M113A3_olive_USA", "CUP_I_MTLB_pk_NAPA", "CUP_I_BMP2_NAPA"];
shop_heli = ["CUP_I_412_Military_Armed_PMC", "CUP_I_Wildcat_Green_AAF", "CUP_O_Ka50_DL_RU"];
shop_tank = ["CUP_I_T55_NAPA", "CUP_O_T72_SLA", "CUP_B_Leopard2A6_HIL"];
shop_plane = ["CUP_I_CESSNA_T41_ARMED_ION", "I_UAV_02_dynamicLoadout_F", "CUP_I_L39_AAF"];

additionalShopLight = ["CUP_B_Jackal2_L2A1_FIA", "CUP_B_M1165_GMV_USMC", "CUP_B_M1151_Mk19_WDL_USA"];
additionalShopAtgmVehicles = ["CUP_I_Hilux_metis_NAPA", "CUP_B_M1167_USMC", "CUP_I_BRDM2_ATGM_NAPA"];
additionalShopManpadsVehicles = ["CUP_O_LR_AA_TKM", "CUP_B_HMMWV_Avenger_USMC",  "CUP_O_2S6_RU"];
additionalShopArtillery = ["CUP_I_Hilux_podnos_NAPA", "CUP_I_D30_TK_GUE", "CUP_I_Hilux_MLRS_NAPA"];

//technical menu content, CUP exclusive
vehSDKLightUnarmedArmored = "CUP_I_Hilux_armored_unarmed_IND_G_F";
technicalArmoredBtr = "CUP_I_Hilux_armored_BTR60_IND_G_F";
technicalArmoredAa = "CUP_I_Hilux_armored_zu23_IND_G_F";
technicalArmoredSpg = "CUP_I_Hilux_armored_SPG9_IND_G_F";
technicalArmoredMg = "CUP_I_Hilux_armored_DSHKM_IND_G_F";

//military building models (common for all sides)
smallBunker = "Land_BagBunker_Small_F";
sandbag = "Land_BagFence_Long_F";

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

//     DO NOT GO PAST THIS LINE

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

//////////////////////////
//       Loadouts       //
//////////////////////////
private _loadoutData = call _fnc_createLoadoutData;
_loadoutData setVariable ["rifles", []]; 				
_loadoutData setVariable ["carbines", []]; 				
_loadoutData setVariable ["grenadeLaunchers", []]; 		
_loadoutData setVariable ["SMGs", []]; 					
_loadoutData setVariable ["machineGuns", []]; 			//this line determines machine guns -- Example: ["arifle_MX_SW_F","arifle_MX_SW_Hamr_pointer_F"] -- Array, can contain multiple assets
_loadoutData setVariable ["marksmanRifles", []]; 		
_loadoutData setVariable ["sniperRifles", []]; 			
_loadoutData setVariable ["lightATLaunchers", []]; 		
_loadoutData setVariable ["ATLaunchers", []]; 			
_loadoutData setVariable ["missileATLaunchers", []]; 	
_loadoutData setVariable ["AALaunchers", []]; 			
_loadoutData setVariable ["sidearms", []]; 				

_loadoutData setVariable ["ATMines", []]; 				
_loadoutData setVariable ["APMines", []]; 				
_loadoutData setVariable ["lightExplosives", []]; 		
_loadoutData setVariable ["heavyExplosives", []]; 		

_loadoutData setVariable ["antiInfantryGrenades", []]; 	
_loadoutData setVariable ["antiTankGrenades", []]; 		
_loadoutData setVariable ["smokeGrenades", []]; 		




_loadoutData setVariable ["maps", ["ItemMap"]];
_loadoutData setVariable ["watches", ["ItemWatch"]];
_loadoutData setVariable ["compasses", ["ItemCompass"]];
_loadoutData setVariable ["radios", []];
_loadoutData setVariable ["gpses", []];
_loadoutData setVariable ["NVGs", []]; 
_loadoutData setVariable ["binoculars", ["Binocular"]];

_loadoutData setVariable ["uniforms", ["U_IG_Guerilla1_1","U_IG_Guerilla2_1","U_IG_Guerilla2_2","U_IG_Guerilla2_3","U_IG_Guerilla3_1","U_IG_leader","U_IG_Guerrilla_6_1","CUP_U_I_GUE_Anorak_03","CUP_U_I_GUE_Anorak_02","CUP_U_I_GUE_WorkU_01","CUP_U_I_GUE_WorkU_02","CUP_U_I_GUE_Flecktarn2","CUP_U_I_GUE_Flecktarn","CUP_U_I_GUE_Flecktarn4","CUP_U_I_GUE_Woodland1"]];
_loadoutData setVariable ["vests", []];
_loadoutData setVariable ["backpacks", []];
_loadoutData setVariable ["longRangeRadios", []];
_loadoutData setVariable ["helmets", []];

//Item *set* definitions. These are added in their entirety to unit loadouts. No randomisation is applied.
_loadoutData setVariable ["items_medical_basic", ["BASIC"] call A3A_fnc_itemset_medicalSupplies];
_loadoutData setVariable ["items_medical_standard", ["STANDARD"] call A3A_fnc_itemset_medicalSupplies];
_loadoutData setVariable ["items_medical_medic", ["MEDIC"] call A3A_fnc_itemset_medicalSupplies];
_loadoutData setVariable ["items_miscEssentials", [] call A3A_fnc_itemset_miscEssentials];


_loadoutData setVariable ["items_squadleader_extras", []];
_loadoutData setVariable ["items_rifleman_extras", []];
_loadoutData setVariable ["items_medic_extras", []];
_loadoutData setVariable ["items_grenadier_extras", []];
_loadoutData setVariable ["items_explosivesExpert_extras", []];
_loadoutData setVariable ["items_engineer_extras", ["Toolkit", "MineDetector"]];
_loadoutData setVariable ["items_lat_extras", []];
_loadoutData setVariable ["items_at_extras", []];
_loadoutData setVariable ["items_aa_extras", []];
_loadoutData setVariable ["items_machineGunner_extras", []];
_loadoutData setVariable ["items_marksman_extras", []];
_loadoutData setVariable ["items_sniper_extras", []];
_loadoutData setVariable ["items_police_extras", []];
_loadoutData setVariable ["items_crew_extras", []];
_loadoutData setVariable ["items_unarmed_extras", []];

////////////////////////
//  Rebel Unit Types  //
///////////////////////.

private _squadLeaderTemplate = {
	["helmets"] call _fnc_setHelmet;
	["vests"] call _fnc_setVest;
	["uniforms"] call _fnc_setUniform;
	
	["backpacks"] call _fnc_setBackpack;

	[["grenadeLaunchers", "rifles"] call _fnc_fallback] call _fnc_setPrimary;
	["primary", 5] call _fnc_addMagazines;
	

	["sidearms"] call _fnc_setHandgun;
	["handgun", 2] call _fnc_addMagazines;

	["items_medical_standard"] call _fnc_addItemSet;
	["items_squadLeader_extras"] call _fnc_addItemSet;
	["items_miscEssentials"] call _fnc_addItemSet;
	["antiInfantryGrenades", 2] call _fnc_addItem;
	["antiTankGrenades", 1] call _fnc_addItem;
	["smokeGrenades", 2] call _fnc_addItem;
	["smokeGrenades", 2] call _fnc_addItem;

	["maps"] call _fnc_addMap;
	["watches"] call _fnc_addWatch;
	["compasses"] call _fnc_addCompass;
	["radios"] call _fnc_addRadio;
	["gpses"] call _fnc_addGPS;
	["binoculars"] call _fnc_addBinoculars;
	["NVGs"] call _fnc_addNVGs;
};

private _riflemanTemplate = {
	["helmets"] call _fnc_setHelmet;
	["vests"] call _fnc_setVest;
	["uniforms"] call _fnc_setUniform;
	["backpacks"] call _fnc_setBackpack;

	["rifles"] call _fnc_setPrimary;
	["primary", 8] call _fnc_addMagazines;

	["sidearms"] call _fnc_setHandgun;
	["handgun", 2] call _fnc_addMagazines;

	["items_medical_standard"] call _fnc_addItemSet;
	["items_rifleman_extras"] call _fnc_addItemSet;
	["items_miscEssentials"] call _fnc_addItemSet;
	["antiInfantryGrenades", 2] call _fnc_addItem;
	["antiTankGrenades", 1] call _fnc_addItem;
	["smokeGrenades", 2] call _fnc_addItem;

	["maps"] call _fnc_addMap;
	["watches"] call _fnc_addWatch;
	["compasses"] call _fnc_addCompass;
	["radios"] call _fnc_addRadio;
	["NVGs"] call _fnc_addNVGs;
};

private _medicTemplate = {
	["helmets"] call _fnc_setHelmet;
	["vests"] call _fnc_setVest;
	["uniforms"] call _fnc_setUniform;
	["backpacks"] call _fnc_setBackpack;

	["carbines"] call _fnc_setPrimary;
	["primary", 5] call _fnc_addMagazines;

	["sidearms"] call _fnc_setHandgun;
	["handgun", 2] call _fnc_addMagazines;

	["items_medical_medic"] call _fnc_addItemSet;
	["items_medic_extras"] call _fnc_addItemSet;
	["items_miscEssentials"] call _fnc_addItemSet;
	["antiInfantryGrenades", 1] call _fnc_addItem;
	["smokeGrenades", 2] call _fnc_addItem;

	["maps"] call _fnc_addMap;
	["watches"] call _fnc_addWatch;
	["compasses"] call _fnc_addCompass;
	["radios"] call _fnc_addRadio;
	["NVGs"] call _fnc_addNVGs;
};

private _grenadierTemplate = {
	["helmets"] call _fnc_setHelmet;
	["vests"] call _fnc_setVest;
	["uniforms"] call _fnc_setUniform;
	["backpacks"] call _fnc_setBackpack;

	["grenadeLaunchers"] call _fnc_setPrimary;
	["primary", 5] call _fnc_addMagazines;
	

	["sidearms"] call _fnc_setHandgun;
	["handgun", 2] call _fnc_addMagazines;

	["items_medical_standard"] call _fnc_addItemSet;
	["items_grenadier_extras"] call _fnc_addItemSet;
	["items_miscEssentials"] call _fnc_addItemSet;
	["antiInfantryGrenades", 4] call _fnc_addItem;
	["antiTankGrenades", 3] call _fnc_addItem;
	["smokeGrenades", 2] call _fnc_addItem;

	["maps"] call _fnc_addMap;
	["watches"] call _fnc_addWatch;
	["compasses"] call _fnc_addCompass;
	["radios"] call _fnc_addRadio;
	["NVGs"] call _fnc_addNVGs;
};

private _explosivesExpertTemplate = {
	["helmets"] call _fnc_setHelmet;
	["vests"] call _fnc_setVest;
	["uniforms"] call _fnc_setUniform;
	["backpacks"] call _fnc_setBackpack;

	["rifles"] call _fnc_setPrimary;
	["primary", 5] call _fnc_addMagazines;
	

	["sidearms"] call _fnc_setHandgun;
	["handgun", 2] call _fnc_addMagazines;

	["items_medical_standard"] call _fnc_addItemSet;
	["items_explosivesExpert_extras"] call _fnc_addItemSet;
	["items_miscEssentials"] call _fnc_addItemSet;

	["lightExplosives", 2] call _fnc_addItem;
	if (random 1 > 0.5) then {["heavyExplosives", 1] call _fnc_addItem;};
	if (random 1 > 0.5) then {["atMines", 1] call _fnc_addItem;};
	if (random 1 > 0.5) then {["apMines", 1] call _fnc_addItem;};

	["antiInfantryGrenades", 1] call _fnc_addItem;
	["smokeGrenades", 1] call _fnc_addItem;

	["maps"] call _fnc_addMap;
	["watches"] call _fnc_addWatch;
	["compasses"] call _fnc_addCompass;
	["radios"] call _fnc_addRadio;
	["NVGs"] call _fnc_addNVGs;
};

private _engineerTemplate = {
	["helmets"] call _fnc_setHelmet;
	["vests"] call _fnc_setVest;
	["uniforms"] call _fnc_setUniform;
	["backpacks"] call _fnc_setBackpack;

	["carbines"] call _fnc_setPrimary;
	["primary", 5] call _fnc_addMagazines;

	["sidearms"] call _fnc_setHandgun;
	["handgun", 2] call _fnc_addMagazines;

	["items_medical_standard"] call _fnc_addItemSet;
	["items_engineer_extras"] call _fnc_addItemSet;
	["items_miscEssentials"] call _fnc_addItemSet;

	if (random 1 > 0.5) then {["lightExplosives", 1] call _fnc_addItem;};

	["antiInfantryGrenades", 1] call _fnc_addItem;
	["smokeGrenades", 2] call _fnc_addItem;

	["maps"] call _fnc_addMap;
	["watches"] call _fnc_addWatch;
	["compasses"] call _fnc_addCompass;
	["radios"] call _fnc_addRadio;
	["NVGs"] call _fnc_addNVGs;
};

private _latTemplate = {
	["helmets"] call _fnc_setHelmet;
	["vests"] call _fnc_setVest;
	["uniforms"] call _fnc_setUniform;
	["backpacks"] call _fnc_setBackpack;

	["rifles"] call _fnc_setPrimary;
	["primary", 8] call _fnc_addMagazines;

	[["lightATLaunchers", "ATLaunchers"] call _fnc_fallback] call _fnc_setLauncher;
	//TODO - Add a check if it's disposable.
	["launcher", 1] call _fnc_addMagazines;

	["sidearms"] call _fnc_setHandgun;
	["handgun", 2] call _fnc_addMagazines;

	["items_medical_standard"] call _fnc_addItemSet;
	["items_lat_extras"] call _fnc_addItemSet;
	["items_miscEssentials"] call _fnc_addItemSet;
	["antiInfantryGrenades", 1] call _fnc_addItem;
	["antiTankGrenades", 2] call _fnc_addItem;
	["smokeGrenades", 1] call _fnc_addItem;

	["maps"] call _fnc_addMap;
	["watches"] call _fnc_addWatch;
	["compasses"] call _fnc_addCompass;
	["radios"] call _fnc_addRadio;
	["NVGs"] call _fnc_addNVGs;
};

private _atTemplate = {
	["helmets"] call _fnc_setHelmet;
	["vests"] call _fnc_setVest;
	["uniforms"] call _fnc_setUniform;
	["backpacks"] call _fnc_setBackpack;

	["rifles"] call _fnc_setPrimary;
	["primary", 5] call _fnc_addMagazines;

	[selectRandom ["ATLaunchers", "missileATLaunchers"]] call _fnc_setLauncher;
	//TODO - Add a check if it's disposable.
	["launcher", 2] call _fnc_addMagazines;

	["sidearms"] call _fnc_setHandgun;
	["handgun", 2] call _fnc_addMagazines;

	["items_medical_standard"] call _fnc_addItemSet;
	["items_at_extras"] call _fnc_addItemSet;
	["items_miscEssentials"] call _fnc_addItemSet;
	["antiInfantryGrenades", 1] call _fnc_addItem;
	["antiTankGrenades", 2] call _fnc_addItem;
	["smokeGrenades", 1] call _fnc_addItem;

	["maps"] call _fnc_addMap;
	["watches"] call _fnc_addWatch;
	["compasses"] call _fnc_addCompass;
	["radios"] call _fnc_addRadio;
	["NVGs"] call _fnc_addNVGs;
};

private _aaTemplate = {
	["helmets"] call _fnc_setHelmet;
	["vests"] call _fnc_setVest;
	["uniforms"] call _fnc_setUniform;
	["backpacks"] call _fnc_setBackpack;

	["rifles"] call _fnc_setPrimary;
	["primary", 5] call _fnc_addMagazines;

	["AALaunchers"] call _fnc_setLauncher;
	//TODO - Add a check if it's disposable.
	["launcher", 2] call _fnc_addMagazines;

	["sidearms"] call _fnc_setHandgun;
	["handgun", 2] call _fnc_addMagazines;

	["items_medical_standard"] call _fnc_addItemSet;
	["items_aa_extras"] call _fnc_addItemSet;
	["items_miscEssentials"] call _fnc_addItemSet;
	["antiInfantryGrenades", 2] call _fnc_addItem;
	["smokeGrenades", 2] call _fnc_addItem;

	["maps"] call _fnc_addMap;
	["watches"] call _fnc_addWatch;
	["compasses"] call _fnc_addCompass;
	["radios"] call _fnc_addRadio;
	["NVGs"] call _fnc_addNVGs;
};

private _machineGunnerTemplate = {
	["helmets"] call _fnc_setHelmet;
	["vests"] call _fnc_setVest;
	["uniforms"] call _fnc_setUniform;
	["backpacks"] call _fnc_setBackpack;

	["machineGuns"] call _fnc_setPrimary;
	["primary", 4] call _fnc_addMagazines;

	["sidearms"] call _fnc_setHandgun;
	["handgun", 2] call _fnc_addMagazines;

	["items_medical_standard"] call _fnc_addItemSet;
	["items_machineGunner_extras"] call _fnc_addItemSet;
	["items_miscEssentials"] call _fnc_addItemSet;
	["antiInfantryGrenades", 2] call _fnc_addItem;
	["smokeGrenades", 2] call _fnc_addItem;

	["maps"] call _fnc_addMap;
	["watches"] call _fnc_addWatch;
	["compasses"] call _fnc_addCompass;
	["radios"] call _fnc_addRadio;
	["NVGs"] call _fnc_addNVGs;
};

private _marksmanTemplate = {
	["helmets"] call _fnc_setHelmet;
	["vests"] call _fnc_setVest;
	["uniforms"] call _fnc_setUniform;
	["backpacks"] call _fnc_setBackpack;

	["marksmanRifles"] call _fnc_setPrimary;
	["primary", 8] call _fnc_addMagazines;

	["sidearms"] call _fnc_setHandgun;
	["handgun", 2] call _fnc_addMagazines;

	["items_medical_standard"] call _fnc_addItemSet;
	["items_marksman_extras"] call _fnc_addItemSet;
	["items_miscEssentials"] call _fnc_addItemSet;
	["antiInfantryGrenades", 2] call _fnc_addItem;
	["smokeGrenades", 2] call _fnc_addItem;

	["maps"] call _fnc_addMap;
	["watches"] call _fnc_addWatch;
	["compasses"] call _fnc_addCompass;
	["radios"] call _fnc_addRadio;
	["NVGs"] call _fnc_addNVGs;
};

private _sniperTemplate = {
	["helmets"] call _fnc_setHelmet;
	["vests"] call _fnc_setVest;
	["uniforms"] call _fnc_setUniform;
	["backpacks"] call _fnc_setBackpack;

	["sniperRifles"] call _fnc_setPrimary;
	["primary", 5] call _fnc_addMagazines;

	["sidearms"] call _fnc_setHandgun;
	["handgun", 2] call _fnc_addMagazines;

	["items_medical_standard"] call _fnc_addItemSet;
	["items_sniper_extras"] call _fnc_addItemSet;
	["items_miscEssentials"] call _fnc_addItemSet;
	["antiInfantryGrenades", 2] call _fnc_addItem;
	["smokeGrenades", 2] call _fnc_addItem;

	["maps"] call _fnc_addMap;
	["watches"] call _fnc_addWatch;
	["compasses"] call _fnc_addCompass;
	["radios"] call _fnc_addRadio;
	["NVGs"] call _fnc_addNVGs;
};

private _policeTemplate = {
	["vests"] call _fnc_setVest;
	["uniforms"] call _fnc_setUniform;
	["backpacks"] call _fnc_setBackpack;

	[selectRandom ["smgs", "carbines"]] call _fnc_setPrimary;
	["primary", 5] call _fnc_addMagazines;

	["sidearms"] call _fnc_setHandgun;
	["handgun", 2] call _fnc_addMagazines;

	["items_medical_standard"] call _fnc_addItemSet;
	["items_police_extras"] call _fnc_addItemSet;
	["items_miscEssentials"] call _fnc_addItemSet;
	["smokeGrenades", 1] call _fnc_addItem;

	["maps"] call _fnc_addMap;
	["watches"] call _fnc_addWatch;
	["compasses"] call _fnc_addCompass;
	["radios"] call _fnc_addRadio;
};

private _crewTemplate = {
	["helmets"] call _fnc_setHelmet;
	["vests"] call _fnc_setVest;
	["uniforms"] call _fnc_setUniform;

	["smgs"] call _fnc_setPrimary;
	["primary", 3] call _fnc_addMagazines;

	["sidearms"] call _fnc_setHandgun;
	["handgun", 2] call _fnc_addMagazines;

	["items_medical_basic"] call _fnc_addItemSet;
	["items_crew_extras"] call _fnc_addItemSet;
	["items_miscEssentials"] call _fnc_addItemSet;
	["smokeGrenades", 2] call _fnc_addItem;

	["maps"] call _fnc_addMap;
	["watches"] call _fnc_addWatch;
	["compasses"] call _fnc_addCompass;
	["radios"] call _fnc_addRadio;
	["gpses"] call _fnc_addGPS;
	["NVGs"] call _fnc_addNVGs;
};

private _unarmedTemplate = {
	["vests"] call _fnc_setVest;
	["uniforms"] call _fnc_setUniform;

	["items_medical_basic"] call _fnc_addItemSet;
	["items_unarmed_extras"] call _fnc_addItemSet;
	["items_miscEssentials"] call _fnc_addItemSet;

	["maps"] call _fnc_addMap;
	["watches"] call _fnc_addWatch;
	["compasses"] call _fnc_addCompass;
	["radios"] call _fnc_addRadio;
};

private _prefix = "militia";
private _unitTypes = [
	["Petrovsky", _squadLeaderTemplate],
	["SquadLeader", _squadLeaderTemplate],
	["Rifleman", _riflemanTemplate],
	["staticCrew", _riflemanTemplate],
	["Medic", _medicTemplate, [["medic", true]]],
	["Engineer", _engineerTemplate, [["engineer", true]]],
	["ExplosivesExpert", _explosivesExpertTemplate, [["explosiveSpecialist", true]]],
	["Grenadier", _grenadierTemplate],
	["LAT", _latTemplate],
	["AT", _atTemplate],
	["AA", _aaTemplate],
	["MachineGunner", _machineGunnerTemplate],
	["Marksman", _marksmanTemplate],
	["Sniper", _sniperTemplate],
	["Unarmed", _unarmedTemplate]
];

[_prefix, _unitTypes, _loadoutData] call _fnc_generateAndSaveUnitsToTemplate;
