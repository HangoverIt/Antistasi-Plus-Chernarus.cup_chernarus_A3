//////////////////////////
//   Side Information   //
//////////////////////////

["name", "CDF"] call _fnc_saveToTemplate; 						
["spawnMarkerName", "CDF Support Corridor"] call _fnc_saveToTemplate; 			

["flag", "FlagCarrierCDF"] call _fnc_saveToTemplate; 						
["flagTexture", "\ca\data\flag_chernarus_co.paa"] call _fnc_saveToTemplate; 			
["flagMarkerType", "Faction_CDF"] call _fnc_saveToTemplate; 			

//////////////////////////////////////
//       Antistasi Plus Stuff       //
//////////////////////////////////////
["baseSoldiers", [ // Cases matter. Lower case here because allVariables on namespace returns lowercase
	["militia_squadleader", "CUP_B_CDF_Soldier_TL_FST"],
	["militia_rifleman", "CUP_B_CDF_Soldier_FST"],
	["militia_radioman", "CUP_B_CDF_Soldier_FST"],
	["militia_medic", "CUP_B_CDF_Medic_FST"],
	["militia_engineer", "CUP_B_CDF_Engineer_FST"],
	["militia_explosivesexpert", "CUP_B_CDF_Soldier_FST"],
	["militia_grenadier", "CUP_B_CDF_Soldier_GL_FST"],
	["militia_lat", "CUP_B_CDF_Soldier_LAT_FST"],
	["militia_at", "CUP_B_CDF_Soldier_LAT_FST"],
	["militia_aa", "CUP_B_CDF_Soldier_AA_FST"],
	["militia_machinegunner", "CUP_B_CDF_Soldier_MG_FST"],
	["militia_marksman", "CUP_B_CDF_Soldier_Marksman_FST"],
	["militia_sniper", "CUP_B_CDF_Sniper_FST"],

	["military_squadleader", "CUP_B_CDF_Soldier_TL_FST"],
	["military_rifleman", "CUP_B_CDF_Soldier_FST"],
	["military_radioman", "CUP_B_CDF_Soldier_FST"],
	["military_medic", "CUP_B_CDF_Medic_FST"],
	["military_engineer", "CUP_B_CDF_Engineer_FST"],
	["military_explosivesexpert", "CUP_B_CDF_Soldier_FST"],
	["military_grenadier", "CUP_B_CDF_Soldier_GL_FST"],
	["military_lat", "CUP_B_CDF_Soldier_LAT_FST"],
	["military_at", "CUP_B_CDF_Soldier_LAT_FST"],
	["military_aa", "CUP_B_CDF_Soldier_AA_FST"],
	["military_machinegunner", "CUP_B_CDF_Soldier_MG_FST"],
	["military_marksman", "CUP_B_CDF_Soldier_Marksman_FST"],
	["military_sniper", "CUP_B_CDF_Sniper_FST"],

	["elite_squadleader", "CUP_B_CDF_Soldier_TL_FST"],
	["elite_rifleman", "CUP_B_CDF_Soldier_FST"],
	["elite_radioman", "CUP_B_CDF_Soldier_FST"],
	["elite_medic", "CUP_B_CDF_Medic_FST"],
	["elite_engineer", "CUP_B_CDF_Engineer_FST"],
	["elite_explosivesexpert", "CUP_B_CDF_Soldier_FST"],
	["elite_grenadier", "CUP_B_CDF_Soldier_GL_FST"],
	["elite_lat", "CUP_B_CDF_Soldier_LAT_FST"],
	["elite_at", "CUP_B_CDF_Soldier_LAT_FST"],
	["elite_aa", "CUP_B_CDF_Soldier_AA_FST"],
	["elite_machinegunner", "CUP_B_CDF_Soldier_MG_FST"],
	["elite_marksman", "CUP_B_CDF_Soldier_Marksman_FST"],
	["elite_sniper", "CUP_B_CDF_Sniper_FST"],

	["sf_squadleader", "CUP_B_CDF_Soldier_TL_FST"],
	["sf_rifleman", "CUP_B_CDF_Soldier_FST"],
	["sf_radioman", "CUP_B_CDF_Soldier_FST"],
	["sf_medic", "CUP_B_CDF_Medic_FST"],
	["sf_engineer", "CUP_B_CDF_Engineer_FST"],
	["sf_explosivesexpert", "CUP_B_CDF_Soldier_FST"],
	["sf_grenadier", "CUP_B_CDF_Soldier_GL_FST"],
	["sf_lat", "CUP_B_CDF_Soldier_LAT_FST"],
	["sf_at", "CUP_B_CDF_Soldier_LAT_FST"],
	["sf_aa", "CUP_B_CDF_Soldier_AA_FST"],
	["sf_machinegunner", "CUP_B_CDF_Soldier_MG_FST"],
	["sf_marksman", "CUP_B_CDF_Soldier_Marksman_FST"],
	["sf_sniper", "CUP_B_CDF_Sniper_FST"],

	["other_crew", "CUP_B_CDF_Crew_FST"],
	["other_unarmed", "CUP_B_CDF_Soldier_Light_FST"],
	["other_official", "CUP_B_CDF_Officer_FST"],
	["other_traitor", "B_G_officer_F"],
	["other_pilot", "CUP_B_CDF_Pilot_FST"],
	["police_squadleader", "CUP_B_CDF_Soldier_FST"],
	["police_standard", "CUP_B_CDF_Soldier_FST"]
]] call _fnc_saveToTemplate;

//////////////////////////
//       Vehicles       //
//////////////////////////

["ammobox", "B_supplyCrate_F"] call _fnc_saveToTemplate; 	//Don't touch or you die a sad and lonely death!
["surrenderCrate", "Box_IND_Wps_F"] call _fnc_saveToTemplate; 
["equipmentBox", "Box_NATO_Equip_F"] call _fnc_saveToTemplate; 

["vehiclesBasic", ["B_Quadbike_01_F"]] call _fnc_saveToTemplate; 			
["vehiclesLightUnarmed", ["CUP_B_HMMWV_Unarmed_USMC","CUP_B_UAZ_Open_CDF", "CUP_B_UAZ_Unarmed_CDF"]] call _fnc_saveToTemplate; 		
["vehiclesLightArmed",["CUP_B_HMMWV_TOW_USMC", "CUP_B_HMMWV_MK19_USMC", "CUP_B_HMMWV_M1114_USMC", "CUP_B_HMMWV_M2_USMC", "CUP_B_BRDM2_HQ_CDF"]] call _fnc_saveToTemplate; 		//this line determines light and armed vehicles -- Example: ["vehiclesLightArmed",["B_MRAP_01_hmg_F", "B_MRAP_01_gmg_F"]] -- Array, can contain multiple assets
["vehiclesTrucks", ["CUP_B_Kamaz_Open_CDF", "CUP_B_Kamaz_CDF"]] call _fnc_saveToTemplate; 			
["vehiclesCargoTrucks", ["CUP_B_Ural_Open_CDF", "CUP_B_Kamaz_Open_CDF"]] call _fnc_saveToTemplate; 		
["vehiclesAmmoTrucks", ["CUP_B_Ural_Reammo_CDF"]] call _fnc_saveToTemplate; 		
["vehiclesRepairTrucks", ["CUP_B_Ural_Repair_CDF"]] call _fnc_saveToTemplate; 		
["vehiclesFuelTrucks", ["CUP_B_Kamaz_Refuel_CDF"]] call _fnc_saveToTemplate;		
["vehiclesMedical", ["CUP_B_S1203_Ambulance_CDF","CUP_B_BMP2_AMB_CDF"]] call _fnc_saveToTemplate;			
["vehiclesAPCs", ["CUP_B_M113_USA","CUP_B_BMP2_CDF", "CUP_B_BTR80_CDF", "CUP_B_BTR80A_CDF", "CUP_B_BRDM2_ATGM_CDF"]] call _fnc_saveToTemplate; 				
["vehiclesTanks", ["CUP_B_T72_CDF","CUP_B_M60A3_USMC"]] call _fnc_saveToTemplate; 			
["vehiclesAA", ["CUP_B_ZSU23_CDF", "CUP_B_UAZ_AA_CDF"]] call _fnc_saveToTemplate; 				
["vehiclesLightAPCs", ["CUP_B_MTLB_pk_CDF"]] call _fnc_saveToTemplate;			
["vehiclesIFVs", []] call _fnc_saveToTemplate;				

["vehiclesSam", ["",""]] call _fnc_saveToTemplate; 	//this line determines SAM systems, order: radar, SAM

["vehiclesTransportBoats", ["B_Boat_Transport_01_F"]] call _fnc_saveToTemplate; 	
["vehiclesGunBoats", ["CUP_B_RHIB2Turret_USMC", "CUP_B_RHIB_USMC"]] call _fnc_saveToTemplate; 			
["vehiclesAmphibious", ["CUP_B_M113_USA"]] call _fnc_saveToTemplate; 		

["vehiclesPlanesCAS", ["CUP_B_Su25_Dyn_CDF"]] call _fnc_saveToTemplate; 		
["vehiclesPlanesAA", ["CUP_B_SU34_CDF"]] call _fnc_saveToTemplate; 			
["vehiclesPlanesTransport", ["CUP_B_C130J_USMC"]] call _fnc_saveToTemplate; 	

["vehiclesHelisLight", ["CUP_B_MH6J_OBS_USA"]] call _fnc_saveToTemplate; 		
["vehiclesHelisTransport", ["CUP_B_Mi17_CDF", "CUP_B_UH60M_US"]] call _fnc_saveToTemplate; 	
["vehiclesHelisAttack", ["CUP_B_Mi24_D_Dynamic_CDF", "CUP_O_Ka50_DL_SLA"]] call _fnc_saveToTemplate; 		

["vehiclesArtillery", [
["CUP_B_BM21_CDF",["CUP_40Rnd_GRAD_HE"]]
]] call _fnc_saveToTemplate; 		

["uavsAttack", ["not_supported"]] call _fnc_saveToTemplate; 				
["uavsPortable", ["B_UAV_01_F"]] call _fnc_saveToTemplate; 				

["vehiclesMilitiaLightArmed", ["CUP_B_UAZ_MG_CDF"]] call _fnc_saveToTemplate; 
["vehiclesMilitiaTrucks", ["CUP_B_Ural_Open_CDF", "CUP_B_Ural_CDF"]] call _fnc_saveToTemplate;
["vehiclesMilitiaCars", ["CUP_B_UAZ_Unarmed_CDF", "CUP_B_UAZ_Open_CDF"]] call _fnc_saveToTemplate;
["vehiclesMilitiaApcs", ["CUP_B_BTR60_CDF","CUP_B_MTLB_pk_CDF"]] call _fnc_saveToTemplate;
["vehiclesMilitiaTanks", ["CUP_I_T55_TK_GUE"]] call _fnc_saveToTemplate;

["vehiclesPolice", ["CUP_LADA_LM_CIV", "CUP_C_S1203_Militia_CIV"]] call _fnc_saveToTemplate;

["staticMGs", ["CUP_B_DSHKM_CDF"]] call _fnc_saveToTemplate; 					
["staticAT", ["CUP_B_SPG9_CDF"]] call _fnc_saveToTemplate; 					
["staticAA", ["CUP_B_Igla_AA_pod_CDF", "CUP_B_ZU23_CDF"]] call _fnc_saveToTemplate; 					
["staticMortars", ["CUP_B_2b14_82mm_CDF"]] call _fnc_saveToTemplate;
["staticHowitzers", ["CUP_B_D30_CDF"]] call _fnc_saveToTemplate;

["mortarMagazineHE", "8Rnd_82mm_Mo_shells"] call _fnc_saveToTemplate;
["mortarMagazineSmoke", "8Rnd_82mm_Mo_Smoke_white"] call _fnc_saveToTemplate;

["howitzerMagazineHE", "CUP_30Rnd_122mmHE_D30_M"] call _fnc_saveToTemplate;

["baggedMGs", [["CUP_B_DShkM_Gun_Bag","CUP_B_DShkM_TripodHigh_Bag"]]] call _fnc_saveToTemplate; 				
["baggedAT", [["CUP_B_SPG9_Gun_Bag","CUP_B_SPG9_Tripod_Bag"]]] call _fnc_saveToTemplate; 					
["baggedAA", []] call _fnc_saveToTemplate; 					
["baggedMortars", [["CUP_B_Podnos_Gun_Bag","CUP_B_Podnos_Bipod_Bag"]]] call _fnc_saveToTemplate; 			//this line determines bagged static mortars -- Example: ["baggedMortars", [["B_Mortar_01_weapon_F", "B_Mortar_01_support_F"]]] -- Array, can contain multiple assets


["minefieldAT", ["CUP_MineE"]] call _fnc_saveToTemplate;
["minefieldAPERS", ["APERSMine", "APERSBoundingMine"]] call _fnc_saveToTemplate;


["playerDefaultLoadout", []] call _fnc_saveToTemplate;
["pvpLoadouts", [
	//Team Leader
	["cup_blufor_EUROFOR_teamLeader_temp"] call A3A_fnc_getLoadout,
	//Medic
	["cup_blufor_EUROFOR_medic_temp"] call A3A_fnc_getLoadout,
	//Autorifleman
	["cup_blufor_EUROFOR_machineGunner_temp"] call A3A_fnc_getLoadout,
	//Marksman
	["cup_blufor_EUROFOR_marksman_temp"] call A3A_fnc_getLoadout,
	//Anti-tank Scout
	["cup_blufor_EUROFOR_AT_temp"] call A3A_fnc_getLoadout,
	//AT2
	["cup_blufor_EUROFOR_AT2_temp"] call A3A_fnc_getLoadout
]] call _fnc_saveToTemplate;

["pvpVehicles", ["CUP_B_UAZ_MG_CDF", "CUP_B_UAZ_Open_CDF"]] call _fnc_saveToTemplate;


//////////////////////////
//       Loadouts       //
//////////////////////////
private _loadoutData = call _fnc_createLoadoutData;
_loadoutData setVariable ["rifles", []]; 					
_loadoutData setVariable ["carbines", []]; 					
_loadoutData setVariable ["grenadeLaunchers", []]; 			
_loadoutData setVariable ["SMGs", []]; 	
_loadoutData setVariable ["shotguns", []];					
_loadoutData setVariable ["machineGuns", []]; 				
_loadoutData setVariable ["marksmanRifles", []]; 			
_loadoutData setVariable ["sniperRifles", []]; 				
_loadoutData setVariable ["lightATLaunchers", []]; 
_loadoutData setVariable ["ATLaunchers", []];  				
_loadoutData setVariable ["missileATLaunchers", []]; 		
_loadoutData setVariable ["AALaunchers", []];
_loadoutData setVariable ["sidearms", []]; 					

_loadoutData setVariable ["ATMines", ["CUP_MineE_M"]]; 					
_loadoutData setVariable ["APMines", ["APERSMine_Range_Mag", "APERSBoundingMine_Range_Mag"]]; 					
_loadoutData setVariable ["lightExplosives", ["DemoCharge_Remote_Mag"]]; 			
_loadoutData setVariable ["heavyExplosives", ["SatchelCharge_Remote_Mag"]]; 			

_loadoutData setVariable ["antiInfantryGrenades", ["CUP_HandGrenade_RGD5"]]; 		
_loadoutData setVariable ["antiTankGrenades", []]; 			
_loadoutData setVariable ["smokeGrenades", ["SmokeShell"]];
_loadoutData setVariable ["signalsmokeGrenades", ["SmokeShellYellow", "SmokeShellRed", "SmokeShellPurple", "SmokeShellOrange", "SmokeShellGreen", "SmokeShellBlue"]];

_loadoutData setVariable ["maps", ["ItemMap"]];
_loadoutData setVariable ["watches", ["ItemWatch"]];
_loadoutData setVariable ["compasses", ["ItemCompass"]];
_loadoutData setVariable ["radios", ["ItemRadio"]];
_loadoutData setVariable ["gpses", ["ItemGPS"]];
_loadoutData setVariable ["NVGs", ["CUP_NVG_PVS7"]];
_loadoutData setVariable ["binoculars", ["Binocular"]];		
_loadoutData setVariable ["Rangefinder", ["CUP_LRTV"]];

_loadoutData setVariable ["uniforms", []];
_loadoutData setVariable ["sniperuniforms", []];
_loadoutData setVariable ["vests", []];
_loadoutData setVariable ["Hvests", []];
_loadoutData setVariable ["GLvests", []];
_loadoutData setVariable ["backpacks", []];
_loadoutData setVariable ["longRangeRadios", ["B_RadioBag_01_wdl_F", "CUP_B_Kombat_Radio_Olive"]];
_loadoutData setVariable ["helmets", []];
_loadoutData setVariable ["facewear", []];

//Item *set* definitions. These are added in their entirety to unit loadouts. No randomisation is applied.
_loadoutData setVariable ["items_medical_basic", ["BASIC"] call A3A_fnc_itemset_medicalSupplies]; //this line defines the basic medical loadout for vanilla
_loadoutData setVariable ["items_medical_standard", ["STANDARD"] call A3A_fnc_itemset_medicalSupplies]; //this line defines the standard medical loadout for vanilla
_loadoutData setVariable ["items_medical_medic", ["MEDIC"] call A3A_fnc_itemset_medicalSupplies]; //this line defines the medic medical loadout for vanilla
_loadoutData setVariable ["items_miscEssentials", [] call A3A_fnc_itemset_miscEssentials];


_loadoutData setVariable ["items_squadleader_extras", ["ACE_microDAGR", "ACE_DAGR", "Laserbatteries", "Laserbatteries", "Laserbatteries"]];
_loadoutData setVariable ["items_rifleman_extras", []];
_loadoutData setVariable ["items_medic_extras", []];
_loadoutData setVariable ["items_grenadier_extras", []];
_loadoutData setVariable ["items_explosivesExpert_extras", ["Toolkit", "MineDetector", "ACE_Clacker","ACE_DefusalKit"]];
_loadoutData setVariable ["items_engineer_extras", ["Toolkit", "MineDetector"]];
_loadoutData setVariable ["items_lat_extras", []];
_loadoutData setVariable ["items_at_extras", []];
_loadoutData setVariable ["items_aa_extras", []];
_loadoutData setVariable ["items_machineGunner_extras", []];
_loadoutData setVariable ["items_marksman_extras", ["ACE_RangeCard", "ACE_ATragMX", "ACE_Kestrel4500"]];
_loadoutData setVariable ["items_sniper_extras", ["ACE_RangeCard", "ACE_ATragMX", "ACE_Kestrel4500"]];
_loadoutData setVariable ["items_police_extras", []];
_loadoutData setVariable ["items_crew_extras", []];
_loadoutData setVariable ["items_unarmed_extras", []];

//TODO - ACE overrides for misc essentials, medical and engineer gear

///////////////////////////////////////
//    Special Forces Loadout Data    //
///////////////////////////////////////


private _sfLoadoutData = _loadoutData call _fnc_copyLoadoutData; 
_sfLoadoutData setVariable ["uniforms", ["CUP_U_B_BDUv2_roll_gloves_Tigerstripe", "CUP_U_B_BDUv2_roll2_gloves_Tigerstripe", "CUP_U_B_BDUv2_roll_gloves_CEU", "CUP_U_B_BDUv2_roll2_gloves_CEU"]];		
_sfLoadoutData setVariable ["sniperuniforms", ["CUP_U_O_RUS_Ghillie"]];
_sfLoadoutData setVariable ["vests", ["CUP_V_CPC_Fastbelt_rngr", "CUP_V_CPC_communicationsbelt_rngr"]];			
_sfLoadoutData setVariable ["Hvests", ["CUP_V_CPC_weaponsbelt_rngr"]];
_sfLoadoutData setVariable ["GLvests", ["CUP_V_CPC_weaponsbelt_rngr"]];
_sfLoadoutData setVariable ["backpacks", ["CUP_B_RUS_Backpack"]];		
_sfLoadoutData setVariable ["helmets", ["CUP_H_CZ_Hat03", "CUP_H_FR_Cap_Headset_Green", "CUP_H_OpsCore_Covered_Tigerstripe", "CUP_H_OpsCore_Covered_Tigerstripe_SF"]];
_sfLoadoutData setVariable ["facewear", ["G_Bandanna_oli", "G_Bandanna_shades", "G_Bandanna_beast"]];
_sfLoadoutData setVariable ["binoculars", ["CUP_LRTV"]];
_sfLoadoutData setVariable ["lightATLaunchers", ["CUP_launch_RPG26","CUP_launch_RShG2"]]; 
_sfLoadoutData setVariable ["ATLaunchers", [
	["CUP_launch_MAAWS", "", "", "CUP_optic_MAAWS_Scope", ["CUP_MAAWS_HEAT_M", "CUP_MAAWS_HEDP_M"], [], ""]
]];
_sfLoadoutData setVariable ["missileATLaunchers", [
	["CUP_launch_Metis", "", "", "", ["CUP_AT13_M"], [], ""]
]];
_sfLoadoutData setVariable ["AALaunchers", [
	["CUP_launch_FIM92Stinger", "", "", "", ["CUP_Stinger_M"], [], ""]
]];
_sfLoadoutData setVariable ["NVGs", ["CUP_NVG_1PN138"]];

_sfLoadoutData setVariable ["rifles", [
["CUP_arifle_M4A1_MOE_wdl", "CUP_muzzle_snds_M16", "", "CUP_optic_ACOG", ["CUP_30Rnd_556x45_Stanag", "CUP_30Rnd_556x45_Stanag", "CUP_30Rnd_556x45_Stanag_Tracer_Red"], [], ""],
["CUP_arifle_M4A1_camo", "CUP_muzzle_snds_M16_camo", "", "CUP_optic_ACOG", ["CUP_30Rnd_556x45_Stanag", "CUP_30Rnd_556x45_Stanag", "CUP_30Rnd_556x45_Stanag_Tracer_Red"], [], ""],
["CUP_arifle_AK103", "CUP_muzzle_snds_KZRZP_AK762", "", "CUP_optic_1p63", ["CUP_30Rnd_762x39_AK103_bakelite_M", "CUP_30Rnd_762x39_AK103_bakelite_M", "CUP_30Rnd_TE1_Red_Tracer_762x39_AK103_bakelite_M"], [], ""],
["CUP_arifle_AK74M", "CUP_muzzle_snds_KZRZP_AK545", "", "CUP_optic_1p63", ["CUP_30Rnd_545x39_AK74M_M", "CUP_30Rnd_545x39_AK74M_M", "CUP_30Rnd_TE1_Red_Tracer_545x39_AK74M_M"], [], ""],
["CUP_arifle_AK103", "CUP_muzzle_snds_KZRZP_AK762", "", "CUP_optic_PSO_1_AK", ["CUP_30Rnd_762x39_AK103_bakelite_M", "CUP_30Rnd_762x39_AK103_bakelite_M", "CUP_30Rnd_TE1_Red_Tracer_762x39_AK103_bakelite_M"], [], ""],
["CUP_arifle_AK74M", "CUP_muzzle_snds_KZRZP_AK545", "", "CUP_optic_PSO_1_AK", ["CUP_30Rnd_545x39_AK74M_M", "CUP_30Rnd_545x39_AK74M_M", "CUP_30Rnd_TE1_Red_Tracer_545x39_AK74M_M"], [], ""]
]];
_sfLoadoutData setVariable ["carbines", [
["CUP_arifle_mk18_black", "CUP_muzzle_snds_M16", "", "CUP_optic_MARS", ["CUP_30Rnd_556x45_Stanag", "CUP_30Rnd_556x45_Stanag", "CUP_30Rnd_556x45_Stanag_Tracer_Red"], [], ""],
["CUP_arifle_AK104", "CUP_muzzle_snds_KZRZP_AK762", "", "CUP_optic_1p63", ["CUP_30Rnd_762x39_AK103_bakelite_M", "CUP_30Rnd_762x39_AK103_bakelite_M", "CUP_30Rnd_TE1_Red_Tracer_762x39_AK103_bakelite_M"], [], ""],
["CUP_arifle_AK105", "CUP_muzzle_snds_KZRZP_AK545", "", "CUP_optic_1p63", ["CUP_30Rnd_545x39_AK74M_M", "CUP_30Rnd_545x39_AK74M_M", "CUP_30Rnd_TE1_Red_Tracer_545x39_AK74M_M"], [], ""]
]];
_sfLoadoutData setVariable ["grenadeLaunchers", [
["CUP_arifle_mk18_m203_black", "CUP_muzzle_snds_M16", "", "CUP_optic_MARS", ["CUP_30Rnd_556x45_Stanag", "CUP_30Rnd_556x45_Stanag", "CUP_30Rnd_556x45_Stanag_Tracer_Red"], ["CUP_1Rnd_HE_M203", "CUP_1Rnd_HE_M203", "CUP_1Rnd_HEDP_M203", "CUP_1Rnd_StarCluster_White_M203", "CUP_1Rnd_Smoke_M203"], ""],
["CUP_arifle_M4A1_BUIS_camo_GL", "CUP_muzzle_snds_M16_camo", "", "CUP_optic_ACOG", ["CUP_30Rnd_556x45_Stanag", "CUP_30Rnd_556x45_Stanag", "CUP_30Rnd_556x45_Stanag_Tracer_Red"], ["CUP_1Rnd_HE_M203", "CUP_1Rnd_HE_M203", "CUP_1Rnd_HEDP_M203", "CUP_1Rnd_StarCluster_White_M203", "CUP_1Rnd_Smoke_M203"], ""],
["CUP_arifle_AK103_GL", "CUP_muzzle_snds_KZRZP_AK762", "", "CUP_optic_1p63", ["CUP_30Rnd_762x39_AK103_bakelite_M", "CUP_30Rnd_762x39_AK103_bakelite_M", "CUP_30Rnd_TE1_Red_Tracer_762x39_AK103_bakelite_M"], ["CUP_1Rnd_HE_GP25_M", "CUP_1Rnd_HE_GP25_M", "CUP_1Rnd_SMOKE_GP25_M", "CUP_IlumFlareWhite_GP25_M"], ""],
["CUP_arifle_AK74M_GL", "CUP_muzzle_snds_KZRZP_AK545", "", "CUP_optic_1p63", ["CUP_30Rnd_545x39_AK74M_M", "CUP_30Rnd_545x39_AK74M_M", "CUP_30Rnd_TE1_Red_Tracer_545x39_AK74M_M"], ["CUP_1Rnd_HE_GP25_M", "CUP_1Rnd_HE_GP25_M", "CUP_1Rnd_SMOKE_GP25_M", "CUP_IlumFlareWhite_GP25_M"], ""]
]];

_sfLoadoutData setVariable ["SMGs", [
["CUP_smg_vityaz_vfg", "CUP_muzzle_Bizon", "", "CUP_optic_1p63", ["CUP_30Rnd_9x19AP_Vityaz"], [], ""],
["CUP_smg_EVO", "CUP_muzzle_snds_MP5", "", "CUP_optic_HoloBlack", ["CUP_30Rnd_9x19_EVO"], [], ""]
]];
_sfLoadoutData setVariable ["machineGuns", [
["CUP_lmg_m249_pip3", "CUP_muzzle_snds_M16", "", "CUP_optic_ElcanM145", ["CUP_200Rnd_TE4_Red_Tracer_556x45_M249"], [], ""],
["CUP_arifle_RPK74", "CUP_muzzle_snds_KZRZP_AK762", "", "CUP_optic_PechenegScope", ["CUP_75Rnd_TE4_LRT4_Green_Tracer_762x39_RPK_M"], [], ""],
["CUP_arifle_RPK74_45", "CUP_muzzle_snds_KZRZP_AK545", "", "CUP_optic_PechenegScope", ["CUP_45Rnd_TE4_LRT4_Green_Tracer_545x39_RPK_M"], [], ""]
]];
_sfLoadoutData setVariable ["marksmanRifles", [
["CUP_srifle_M14_DMR", "CUP_muzzle_snds_M14", "", "CUP_optic_Leupold_VX3", ["CUP_20Rnd_762x51_DMR", "CUP_20Rnd_762x51_DMR", "CUP_20Rnd_TE1_Red_Tracer_762x51_DMR"], [], "CUP_bipod_Harris_1A2_L_BLK"],
["CUP_srifle_VSSVintorez", "", "", "CUP_optic_PSO_1", ["CUP_10Rnd_9x39_SP5_VSS_M"], [], ""]
]];
_sfLoadoutData setVariable ["sniperRifles", [
["CUP_srifle_M107_Base", "CUP_muzzle_mfsup_Suppressor_M107_Grey", "", "CUP_optic_LeupoldMk4_25x50_LRT", ["CUP_10Rnd_127x99_M107"], [], ""],
["CUP_srifle_M107_Base", "CUP_muzzle_mfsup_Suppressor_M107_Grey", "", "CUP_optic_AN_PVS_10_black", ["CUP_10Rnd_127x99_M107"], [], ""]
]];
_sfLoadoutData setVariable ["sidearms", [
["CUP_hgun_Mk23", "CUP_muzzle_snds_mk23", "", "", ["CUP_12Rnd_45ACP_mk23"], [], ""]
]];
/////////////////////////////////
//    Military Loadout Data    //
/////////////////////////////////

private _militaryLoadoutData = _loadoutData call _fnc_copyLoadoutData; 
_militaryLoadoutData setVariable ["uniforms", ["CUP_U_B_CDF_FST_1", "CUP_U_B_CDF_FST_2"]];
_militaryLoadoutData setVariable ["vests", ["CUP_V_CDF_6B3_1_FST", "CUP_V_CDF_6B3_2_FST","CUP_V_CDF_6B3_3_FST", "CUP_V_CDF_6B3_5_FST"]];			
_militaryLoadoutData setVariable ["Hvests", []];
_militaryLoadoutData setVariable ["GLvests", ["CUP_V_CDF_6B3_4_FST"]];
_militaryLoadoutData setVariable ["backpacks", ["CUP_B_AlicePack_OD"]];		
_militaryLoadoutData setVariable ["helmets", ["CUP_H_CDF_H_PASGT_FST", "CUP_H_CDF_OfficerCap_FST"]];		
_militaryLoadoutData setVariable ["ATLaunchers", [
	["CUP_launch_RPG7V", "", "", "CUP_optic_PGO7V3", ["CUP_PG7VL_M", "CUP_PG7VL_M", "CUP_PG7VM_M"], [], ""],
	["CUP_launch_RPG7V", "", "", "CUP_optic_PGO7V3", ["CUP_PG7VL_M", "CUP_PG7VL_M", "CUP_OG7_M"], [], ""],
	["CUP_launch_RPG7V", "", "", "CUP_optic_PGO7V3", ["CUP_PG7VL_M", "CUP_TBG7V_M", "CUP_OG7_M"], [], ""],
	["CUP_launch_RPG7V", "", "", "CUP_optic_PGO7V3", ["CUP_PG7VR_M", "CUP_PG7VR_M", "CUP_PG7VL_M"], [], ""]
	]];
_militaryLoadoutData setVariable ["lightATLaunchers", ["CUP_launch_RPG26"]];
_militaryLoadoutData setVariable ["missileATLaunchers", [
	["CUP_launch_RPG7V", "", "", "CUP_optic_PGO7V3", ["CUP_PG7VL_M", "CUP_PG7VL_M", "CUP_PG7VM_M"], [], ""],
	["CUP_launch_RPG7V", "", "", "CUP_optic_PGO7V3", ["CUP_PG7VL_M", "CUP_PG7VL_M", "CUP_OG7_M"], [], ""],
	["CUP_launch_RPG7V", "", "", "CUP_optic_PGO7V3", ["CUP_PG7VL_M", "CUP_TBG7V_M", "CUP_OG7_M"], [], ""],
	["CUP_launch_RPG7V", "", "", "CUP_optic_PGO7V3", ["CUP_PG7VR_M", "CUP_PG7VR_M", "CUP_PG7VL_M"], [], ""]
]];   
_militaryLoadoutData setVariable ["AALaunchers", [
	["CUP_launch_9K32Strela", "", "", "", ["CUP_Strela_2_M"], [], ""]	
	]];

_militaryLoadoutData setVariable ["rifles", [
["CUP_arifle_AK74", "", "CUP_acc_Flashlight", "", ["CUP_30Rnd_545x39_AK_M", "CUP_30Rnd_545x39_AK_M", "CUP_30Rnd_TE1_Red_Tracer_545x39_AK_M"], [], ""],
["CUP_arifle_AK74", "", "CUP_acc_Flashlight", "CUP_optic_OKP_7", ["CUP_30Rnd_545x39_AK_M", "CUP_30Rnd_545x39_AK_M", "CUP_30Rnd_TE1_Red_Tracer_545x39_AK_M"], [], ""],
["CUP_arifle_AKS74", "", "CUP_acc_Flashlight", "CUP_optic_OKP_7", ["CUP_30Rnd_545x39_AK_M", "CUP_30Rnd_545x39_AK_M", "CUP_30Rnd_TE1_Red_Tracer_545x39_AK_M"], [], ""],
["CUP_arifle_M16A4_Base", "", "CUP_acc_Flashlight", "CUP_optic_CompM2_low", ["CUP_20Rnd_556x45_Stanag", "CUP_20Rnd_556x45_Stanag", "CUP_20Rnd_556x45_Stanag_Tracer_Red"], [], ""]
]];
_militaryLoadoutData setVariable ["carbines", [
["CUP_arifle_AKS74U", "", "", "", ["CUP_30Rnd_545x39_AK74_plum_M", "CUP_30Rnd_545x39_AK74_plum_M", "CUP_30Rnd_TE1_Red_Tracer_545x39_AK74_plum_M"], [], ""],
["CUP_arifle_OTS14_GROZA_762", "", "", "", ["30Rnd_762x39_Mag_F", "30Rnd_762x39_Mag_F", "30Rnd_762x39_Mag_Tracer_F"], [], ""]
]];
_militaryLoadoutData setVariable ["grenadeLaunchers", [
["CUP_arifle_AK74_GL", "", "CUP_acc_Flashlight", "", ["CUP_30Rnd_545x39_AK_M", "CUP_30Rnd_545x39_AK_M", "CUP_30Rnd_TE1_Red_Tracer_545x39_AK_M"], ["CUP_1Rnd_HE_GP25_M", "CUP_1Rnd_HE_GP25_M", "CUP_1Rnd_SMOKE_GP25_M", "CUP_IlumFlareWhite_GP25_M"], ""],
["CUP_arifle_AK74_GL", "", "CUP_acc_Flashlight", "CUP_optic_OKP_7", ["CUP_30Rnd_545x39_AK_M", "CUP_30Rnd_545x39_AK_M", "CUP_30Rnd_TE1_Red_Tracer_545x39_AK_M"], ["CUP_1Rnd_HE_GP25_M", "CUP_1Rnd_HE_GP25_M", "CUP_1Rnd_SMOKE_GP25_M", "CUP_IlumFlareWhite_GP25_M"], ""],
["CUP_arifle_AKS74_GL", "", "CUP_acc_Flashlight", "CUP_optic_OKP_7", ["CUP_30Rnd_545x39_AK_M", "CUP_30Rnd_545x39_AK_M", "CUP_30Rnd_TE1_Red_Tracer_545x39_AK_M"], ["CUP_1Rnd_HE_GP25_M", "CUP_1Rnd_HE_GP25_M", "CUP_1Rnd_SMOKE_GP25_M", "CUP_IlumFlareWhite_GP25_M"], ""],
["CUP_arifle_M16A4_GL", "", "CUP_acc_Flashlight", "CUP_optic_CompM2_low", ["CUP_20Rnd_556x45_Stanag", "CUP_20Rnd_556x45_Stanag", "CUP_20Rnd_556x45_Stanag_Tracer_Red"], ["CUP_1Rnd_HE_M203", "CUP_1Rnd_HE_M203", "CUP_1Rnd_HEDP_M203", "CUP_1Rnd_StarCluster_White_M203", "CUP_1Rnd_Smoke_M203"], ""],
["CUP_arifle_OTS14_GROZA_762_GL", "", "", "", ["30Rnd_762x39_Mag_F", "30Rnd_762x39_Mag_F", "30Rnd_762x39_Mag_Tracer_F"], ["CUP_1Rnd_HE_GP25_M", "CUP_1Rnd_HE_GP25_M", "CUP_1Rnd_SMOKE_GP25_M", "CUP_IlumFlareWhite_GP25_M"], ""]
]];
_militaryLoadoutData setVariable ["SMGs", [
["CUP_arifle_OTS14_GROZA", "", "", "", ["CUP_20Rnd_9x39_SP5_GROZA_M"], [], ""],
["CUP_smg_vityaz_vfg", "", "", "", ["CUP_30Rnd_9x19_Vityaz", "CUP_30Rnd_9x19_Vityaz", "CUP_30Rnd_9x19AP_Vityaz"], [], ""]
]];
_militaryLoadoutData setVariable ["machineGuns", [
["CUP_lmg_PKM", "", "", "", ["CUP_100Rnd_TE4_LRT4_762x54_PK_Tracer_Green_M", "CUP_100Rnd_TE4_LRT4_762x54_PK_Tracer_Red_M", "CUP_100Rnd_TE4_LRT4_762x54_PK_Tracer_Yellow_M"], [], ""],
["CUP_arifle_RPK74", "", "", "", ["CUP_75Rnd_TE4_LRT4_Green_Tracer_762x39_RPK_M"], [], ""],
["CUP_arifle_RPK74_45", "", "", "", ["CUP_45Rnd_TE4_LRT4_Green_Tracer_545x39_RPK_M"], [], ""]
]];
_militaryLoadoutData setVariable ["marksmanRifles", [
["CUP_srifle_SVD", "", "", "CUP_optic_PSO_1", ["CUP_10Rnd_762x54_SVD_M"], [], ""]
]];
_militaryLoadoutData setVariable ["sniperRifles", [
["CUP_arifle_AKM", "", "", "CUP_optic_PSO_1_AK", ["CUP_30Rnd_762x39_AK47_M", "CUP_30Rnd_762x39_AK47_M", "CUP_30Rnd_TE1_Green_Tracer_762x39_AK47_M"], [], ""]
]];
_militaryLoadoutData setVariable ["sidearms", [
["CUP_hgun_PMM", "", "", "", ["CUP_12Rnd_9x18_PMM_M"], [], ""]
]];

/////////////////////////////////
//    Elite Loadout Data    //
/////////////////////////////////
private _eliteLoadoutData = _loadoutData call _fnc_copyLoadoutData; 
_eliteLoadoutData setVariable ["uniforms", ["CUP_U_B_CDF_MNT_1", "CUP_U_B_CDF_MNT_2"]];	
_eliteLoadoutData setVariable ["sniperuniforms", ["CUP_U_O_RUS_Ghillie"]];
_eliteLoadoutData setVariable ["vests", ["CUP_V_CDF_6B3_1_MNT", "CUP_V_CDF_6B3_2_MNT","CUP_V_CDF_6B3_3_MNT", "CUP_V_CDF_6B3_5_MNT"]];			
_eliteLoadoutData setVariable ["Hvests", []];
_eliteLoadoutData setVariable ["GLvests", ["CUP_V_CDF_6B3_4_MNT"]];
_eliteLoadoutData setVariable ["backpacks", ["CUP_B_AlicePack_Khaki"]];		
_eliteLoadoutData setVariable ["helmets", ["CUP_H_CDF_H_PASGT_MNT", "CUP_H_CDF_OfficerCap_MNT"]];		
_eliteLoadoutData setVariable ["binoculars", ["CUP_Vector21Nite"]];
_eliteLoadoutData setVariable ["lightATLaunchers", ["CUP_launch_RPG26","CUP_launch_RShG2"]]; 
_eliteLoadoutData setVariable ["ATLaunchers", [
	["CUP_launch_MAAWS", "", "", "CUP_optic_MAAWS_Scope", ["CUP_MAAWS_HEAT_M", "CUP_MAAWS_HEDP_M"], [], ""]
]];
_eliteLoadoutData setVariable ["missileATLaunchers", [
["CUP_launch_Metis", "", "", "", ["CUP_AT13_M"], [], ""]
]]; 
_eliteLoadoutData setVariable ["AALaunchers", [
	["CUP_launch_Igla", "", "", "", ["CUP_Igla_M"], [], ""]
]];

_eliteLoadoutData setVariable ["rifles", [
["CUP_arifle_AK74M", "", "", "CUP_optic_1p63", ["CUP_30Rnd_545x39_AK74M_M", "CUP_30Rnd_545x39_AK74M_M", "CUP_30Rnd_TE1_Red_Tracer_545x39_AK74M_M"], [], ""],
["CUP_arifle_AK74M", "", "", "CUP_optic_Kobra", ["CUP_30Rnd_545x39_AK74M_M", "CUP_30Rnd_545x39_AK74M_M", "CUP_30Rnd_TE1_Red_Tracer_545x39_AK74M_M"], [], ""],
["CUP_arifle_AKM", "", "", "CUP_optic_1p63", ["CUP_30Rnd_762x39_AK47_M", "CUP_30Rnd_762x39_AK47_M", "CUP_30Rnd_TE1_Green_Tracer_762x39_AK47_M"], [], ""],
["CUP_arifle_AKM", "", "", "CUP_optic_ekp_8_02", ["CUP_30Rnd_762x39_AK47_M", "CUP_30Rnd_762x39_AK47_M", "CUP_30Rnd_TE1_Green_Tracer_762x39_AK47_M"], [], ""],
["CUP_arifle_M4A1_black", "", "", "CUP_optic_AIMM_M68_BLK", ["CUP_30Rnd_556x45_Stanag", "CUP_30Rnd_556x45_Stanag", "CUP_30Rnd_556x45_Stanag_Tracer_Red"], [], ""]
]];
_eliteLoadoutData setVariable ["carbines", [
["CUP_arifle_AKS74U", "", "", "CUP_optic_Kobra", ["CUP_30Rnd_545x39_AK74_plum_M", "CUP_30Rnd_545x39_AK74_plum_M", "CUP_30Rnd_TE1_Red_Tracer_545x39_AK74_plum_M"], [], ""],
["CUP_arifle_AKMS", "", "", "CUP_optic_1p63", ["CUP_30Rnd_762x39_AK47_M", "CUP_30Rnd_762x39_AK47_M", "CUP_30Rnd_TE1_Green_Tracer_762x39_AK47_M"], [], ""],
["CUP_arifle_AKMS", "", "", "CUP_optic_ekp_8_02", ["CUP_30Rnd_762x39_AK47_M", "CUP_30Rnd_762x39_AK47_M", "CUP_30Rnd_TE1_Green_Tracer_762x39_AK47_M"], [], ""]
]];
_eliteLoadoutData setVariable ["grenadeLaunchers", [
["CUP_arifle_AK74M_GL", "", "", "CUP_optic_1p63", ["CUP_30Rnd_545x39_AK74M_M", "CUP_30Rnd_545x39_AK74M_M", "CUP_30Rnd_TE1_Red_Tracer_545x39_AK74M_M"], ["CUP_1Rnd_HE_GP25_M", "CUP_1Rnd_HE_GP25_M", "CUP_1Rnd_SMOKE_GP25_M", "CUP_IlumFlareWhite_GP25_M"], ""],
["CUP_arifle_AKM_GL", "", "", "CUP_optic_ekp_8_02", ["CUP_30Rnd_762x39_AK47_M", "CUP_30Rnd_762x39_AK47_M", "CUP_30Rnd_TE1_Green_Tracer_762x39_AK47_M"], ["CUP_1Rnd_HE_GP25_M", "CUP_1Rnd_HE_GP25_M", "CUP_1Rnd_SMOKE_GP25_M", "CUP_IlumFlareWhite_GP25_M"], ""],
["CUP_arifle_M4A1_BUIS_GL", "", "", "CUP_optic_AIMM_M68_BLK", ["CUP_30Rnd_556x45_Stanag", "CUP_30Rnd_556x45_Stanag", "CUP_30Rnd_556x45_Stanag_Tracer_Red"], ["CUP_1Rnd_HE_M203", "CUP_1Rnd_HE_M203", "CUP_1Rnd_HEDP_M203", "CUP_1Rnd_StarCluster_White_M203", "CUP_1Rnd_Smoke_M203"], ""]
]];
_eliteLoadoutData setVariable ["SMGs", [
["CUP_smg_vityaz_vfg", "", "", "CUP_optic_Kobra", ["CUP_30Rnd_9x19_Vityaz", "CUP_30Rnd_9x19_Vityaz", "CUP_30Rnd_9x19AP_Vityaz"], [], ""]
]];
_eliteLoadoutData setVariable ["machineGuns", [
["CUP_lmg_PKMN", "", "", "CUP_optic_PechenegScope", ["CUP_100Rnd_TE4_LRT4_762x54_PK_Tracer_Green_M", "CUP_100Rnd_TE4_LRT4_762x54_PK_Tracer_Red_M", "CUP_100Rnd_TE4_LRT4_762x54_PK_Tracer_Yellow_M"], [], ""],
["CUP_arifle_RPK74", "", "", "CUP_optic_PechenegScope", ["CUP_75Rnd_TE4_LRT4_Green_Tracer_762x39_RPK_M"], [], ""],
["CUP_arifle_RPK74_45", "", "", "CUP_optic_PechenegScope", ["CUP_45Rnd_TE4_LRT4_Green_Tracer_545x39_RPK_M"], [], ""],
["CUP_lmg_m249_pip1", "", "", "CUP_optic_ElcanM145", ["CUP_200Rnd_TE4_Red_Tracer_556x45_M249"], [], ""]
]];
_eliteLoadoutData setVariable ["marksmanRifles", [
["CUP_arifle_G3A3_modern_ris", "", "", "CUP_optic_LeupoldMk4", ["CUP_20Rnd_762x51_G3", "CUP_20Rnd_762x51_G3", "CUP_20Rnd_TE1_Red_Tracer_762x51_G3"], [], "CUP_bipod_G3SG1"]
]];
_eliteLoadoutData setVariable ["sniperRifles", [
["CUP_srifle_SVD", "", "CUP_SVD_camo_g", "CUP_optic_PSO_3", ["CUP_10Rnd_762x54_SVD_M"], [], ""],
["CUP_srifle_ksvk", "", "", "CUP_optic_PSO_3", ["CUP_5Rnd_127x108_KSVK_M"], [], ""]
]];
_eliteLoadoutData setVariable ["sidearms", [
["CUP_hgun_PMM", "", "", "", ["CUP_12Rnd_9x18_PMM_M"], [], ""]
]];

///////////////////////////////
//    Police Loadout Data    //
///////////////////////////////

private _policeLoadoutData = _loadoutData call _fnc_copyLoadoutData; 
_policeLoadoutData setVariable ["uniforms", ["CUP_U_C_Policeman_01"]];
_policeLoadoutData setVariable ["vests", ["CUP_V_C_Police_Holster"]];
_policeLoadoutData setVariable ["helmets", ["CUP_H_C_Policecap_01"]];
_policeLoadoutData setVariable ["NVGs", []];
_policeLoadoutData setVariable ["smgs", [
["CUP_smg_vityaz_vfg", "", "", "", ["CUP_30Rnd_9x19_Vityaz"], [], ""],
["CUP_arifle_AKS74U", "", "", "", ["CUP_30Rnd_545x39_AK74_plum_M"], [], ""]
]];
_policeLoadoutData setVariable ["sidearms", ["CUP_hgun_Makarov"]];

////////////////////////////////
//    Militia Loadout Data    //
////////////////////////////////

private _militiaLoadoutData = _loadoutData call _fnc_copyLoadoutData; 
_militiaLoadoutData setVariable ["uniforms", ["CUP_U_O_CHDKZ_Kam_06", "CUP_U_O_CHDKZ_Kam_05", "CUP_U_O_CHDKZ_Kam_04", "CUP_U_O_CHDKZ_Kam_03"]];		
_militiaLoadoutData setVariable ["vests", ["CUP_V_O_Ins_Carrier_Rig","CUP_V_CDF_6B3_1_Green"]];			
_militiaLoadoutData setVariable ["backpacks", ["CUP_B_AlicePack_OD"]];		
_militiaLoadoutData setVariable ["helmets", ["CUP_H_ChDKZ_Beanie", "CUP_H_RUS_SSH68_olive", "CUP_H_CDF_OfficerCap_FST", "CUP_H_FR_BandanaGreen"]];
_militialoadoutData setVariable ["Rangefinder", ["Binocular"]];
_militiaLoadoutData setVariable ["facewear", ["G_Bandanna_oli", "CUP_G_Scarf_Face_Grn"]];
_militiaLoadoutData setVariable ["ATLaunchers", [
	["CUP_launch_RPG7V", "", "", "", ["CUP_PG7V_M", "CUP_PG7V_M", "CUP_OG7_M"], [], ""],
	["CUP_launch_RPG7V", "", "", "", ["CUP_PG7V_M", "CUP_PG7V_M", "CUP_PG7VL_M"], [], ""],
	["CUP_launch_RPG7V", "", "", "", ["CUP_PG7V_M", "CUP_OG7_M", "CUP_OG7_M"], [], ""]
]];  
_militiaLoadoutData setVariable ["lightATLaunchers", ["CUP_launch_RPG18"]];

_militiaLoadoutData setVariable ["missileATLaunchers", [
	["CUP_launch_RPG7V", "", "", "", ["CUP_PG7V_M", "CUP_PG7V_M", "CUP_OG7_M"], [], ""],
	["CUP_launch_RPG7V", "", "", "", ["CUP_PG7V_M", "CUP_PG7V_M", "CUP_PG7VL_M"], [], ""],
	["CUP_launch_RPG7V", "", "", "", ["CUP_PG7V_M", "CUP_OG7_M", "CUP_OG7_M"], [], ""]
]];  

_militiaLoadoutData setVariable ["AALaunchers", []];

_militiaLoadoutData setVariable ["NVGs", []];

_militiaLoadoutData setVariable ["rifles", [
["CUP_arifle_M16A2", "", "CUP_acc_Flashlight", "", ["CUP_20Rnd_556x45_Stanag", "CUP_20Rnd_556x45_Stanag", "CUP_20Rnd_556x45_Stanag_Tracer_Red"], [], ""],
["CUP_arifle_AKM_Early", "", "CUP_acc_Flashlight", "", ["CUP_30Rnd_762x39_AK47_bakelite_M", "CUP_30Rnd_762x39_AK47_bakelite_M", "CUP_30Rnd_TE1_Red_Tracer_762x39_AK47_bakelite_M"], [], ""],
["CUP_arifle_AK74_Early", "", "CUP_acc_Flashlight", "", ["CUP_30Rnd_545x39_AK_M", "CUP_30Rnd_545x39_AK_M", "CUP_30Rnd_TE1_Red_Tracer_545x39_AK_M"], [], ""]
]];
_militiaLoadoutData setVariable ["carbines", [
["CUP_arifle_AKMS_Early", "", "CUP_acc_Flashlight", "", ["CUP_30Rnd_762x39_AK47_bakelite_M", "CUP_30Rnd_762x39_AK47_bakelite_M", "CUP_30Rnd_TE1_Red_Tracer_762x39_AK47_bakelite_M"], [], ""],
["CUP_arifle_AKS74_Early", "", "CUP_acc_Flashlight", "", ["CUP_30Rnd_545x39_AK_M", "CUP_30Rnd_545x39_AK_M", "CUP_30Rnd_TE1_Red_Tracer_545x39_AK_M"], [], ""]
]];
_militiaLoadoutData setVariable ["grenadeLaunchers", [
["CUP_arifle_AKM_GL_Early", "", "CUP_acc_Flashlight", "", ["CUP_30Rnd_762x39_AK47_bakelite_M", "CUP_30Rnd_762x39_AK47_bakelite_M", "CUP_30Rnd_TE1_Red_Tracer_762x39_AK47_bakelite_M"], ["CUP_1Rnd_HE_GP25_M", "CUP_1Rnd_HE_GP25_M", "CUP_1Rnd_SMOKE_GP25_M", "CUP_IlumFlareWhite_GP25_M"], ""],
["CUP_arifle_AK74_GL_Early", "", "CUP_acc_Flashlight", "", ["CUP_30Rnd_545x39_AK_M", "CUP_30Rnd_545x39_AK_M", "CUP_30Rnd_TE1_Red_Tracer_545x39_AK_M"], ["CUP_1Rnd_HE_GP25_M", "CUP_1Rnd_HE_GP25_M", "CUP_1Rnd_SMOKE_GP25_M", "CUP_IlumFlareWhite_GP25_M"], ""],
["CUP_arifle_AKMS_GL_Early", "", "CUP_acc_Flashlight", "", ["CUP_30Rnd_762x39_AK47_bakelite_M", "CUP_30Rnd_762x39_AK47_bakelite_M", "CUP_30Rnd_TE1_Red_Tracer_762x39_AK47_bakelite_M"], ["CUP_1Rnd_HE_GP25_M", "CUP_1Rnd_HE_GP25_M", "CUP_1Rnd_SMOKE_GP25_M", "CUP_IlumFlareWhite_GP25_M"], ""],
["CUP_arifle_AKS74_GL_Early", "", "CUP_acc_Flashlight", "", ["CUP_30Rnd_545x39_AK_M", "CUP_30Rnd_545x39_AK_M", "CUP_30Rnd_TE1_Red_Tracer_545x39_AK_M"], ["CUP_1Rnd_HE_GP25_M", "CUP_1Rnd_HE_GP25_M", "CUP_1Rnd_SMOKE_GP25_M", "CUP_IlumFlareWhite_GP25_M"], ""],
["CUP_arifle_M16A2_GL", "", "CUP_acc_Flashlight", "CUP_optic_CompM2_low", ["CUP_20Rnd_556x45_Stanag", "CUP_20Rnd_556x45_Stanag", "CUP_20Rnd_556x45_Stanag_Tracer_Red"], ["CUP_1Rnd_HE_M203", "CUP_1Rnd_HE_M203", "CUP_1Rnd_HEDP_M203", "CUP_1Rnd_StarCluster_White_M203", "CUP_1Rnd_Smoke_M203"], ""]
]];
_militiaLoadoutData setVariable ["SMGs", [
["CUP_smg_bizon", "", "", "", ["CUP_64Rnd_9x19_Bizon_M"], [], ""]
]];
_militiaLoadoutData setVariable ["shotguns", [
["CUP_sgun_Saiga12K", "", "", "", ["CUP_5Rnd_B_Saiga12_Buck_00", "CUP_5Rnd_B_Saiga12_Slug"], [], ""]
]];
_militiaLoadoutData setVariable ["machineGuns", [
["CUP_arifle_RPK74_45", "", "", "", ["CUP_45Rnd_TE4_LRT4_Green_Tracer_545x39_RPK_M"], [], ""]
]];
_militiaLoadoutData setVariable ["marksmanRifles", [
["CUP_srifle_M21", "", "", "CUP_optic_artel_m14", ["CUP_20Rnd_762x51_DMR"], [], "CUP_bipod_Harris_1A2_L_BLK"]
]];
_militiaLoadoutData setVariable ["sniperRifles", [
["CUP_srifle_SVD", "", "", "CUP_optic_PSO_1", ["CUP_10Rnd_762x54_SVD_M"], [], ""]
]];
_militiaLoadoutData setVariable ["sidearms", ["CUP_hgun_Makarov"]];

//////////////////////////
//    Misc Loadouts     //
//////////////////////////

private _crewLoadoutData = _militaryLoadoutData call _fnc_copyLoadoutData; 
_crewLoadoutData setVariable ["uniforms", ["CUP_U_B_CDF_MNT_2"]];			
_crewLoadoutData setVariable ["vests", ["CUP_V_CDF_CrewBelt"]];				
_crewLoadoutData setVariable ["helmets", ["CUP_H_RUS_TSH_4_Brown"]];			


private _pilotLoadoutData = _militaryLoadoutData call _fnc_copyLoadoutData;
_pilotLoadoutData setVariable ["uniforms", ["CUP_U_B_CDF_MNT_1"]];
_pilotLoadoutData setVariable ["vests", ["CUP_V_CDF_OfficerBelt"]];
_pilotLoadoutData setVariable ["helmets", ["CUP_H_RUS_ZSH_Shield_Up", "CUP_H_RUS_ZSH_Shield_Down"]];

// ##################### DO NOT TOUCH ANYTHING BELOW THIS LINE #####################


/////////////////////////////////
//    Unit Type Definitions    //
/////////////////////////////////
//These define the loadouts for different unit types.
//For example, rifleman, grenadier, squad leader, etc.
//In 95% of situations, you *should not need to edit these*.
//Almost all factions can be set up just by modifying the loadout data above.
//However, these exist in case you really do want to do a lot of custom alterations.

private _squadLeaderTemplate = {
	["helmets"] call _fnc_setHelmet;
	[["Hvests", "vests"] call _fnc_fallback] call _fnc_setVest;
	["uniforms"] call _fnc_setUniform;

	["backpacks"] call _fnc_setBackpack;

	[selectRandom ["grenadeLaunchers", "rifles"]] call _fnc_setPrimary;
	["primary", 6] call _fnc_addMagazines;
	["primary", 4] call _fnc_addAdditionalMuzzleMagazines;

	["sidearms"] call _fnc_setHandgun;
	["handgun", 2] call _fnc_addMagazines;

	["items_medical_standard"] call _fnc_addItemSet;
	["items_squadLeader_extras"] call _fnc_addItemSet;
	["items_miscEssentials"] call _fnc_addItemSet;
	["antiInfantryGrenades", 2] call _fnc_addItem;
	["smokeGrenades", 2] call _fnc_addItem;
	["signalsmokeGrenades", 2] call _fnc_addItem;

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
	["facewear"] call _fnc_setFacewear;
	["vests"] call _fnc_setVest;
	["uniforms"] call _fnc_setUniform;


	["rifles"] call _fnc_setPrimary;
	["primary", 6] call _fnc_addMagazines;

	["sidearms"] call _fnc_setHandgun;
	["handgun", 2] call _fnc_addMagazines;

	["items_medical_standard"] call _fnc_addItemSet;
	["items_rifleman_extras"] call _fnc_addItemSet;
	["items_miscEssentials"] call _fnc_addItemSet;
	["antiInfantryGrenades", 2] call _fnc_addItem;
	["smokeGrenades", 2] call _fnc_addItem;

	["maps"] call _fnc_addMap;
	["watches"] call _fnc_addWatch;
	["compasses"] call _fnc_addCompass;
	["radios"] call _fnc_addRadio;
	["NVGs"] call _fnc_addNVGs;
};

private _radiomanTemplate = {
	["helmets"] call _fnc_setHelmet;
	["vests"] call _fnc_setVest;
	["uniforms"] call _fnc_setUniform;
	["longRangeRadios"] call _fnc_setBackpack;

	[selectRandom ["rifles", "carbines"]] call _fnc_setPrimary;
	["primary", 6] call _fnc_addMagazines;

	["sidearms"] call _fnc_setHandgun;
	["handgun", 2] call _fnc_addMagazines;

	["items_medical_standard"] call _fnc_addItemSet;
	["items_rifleman_extras"] call _fnc_addItemSet;
	["items_miscEssentials"] call _fnc_addItemSet;
	["antiInfantryGrenades", 2] call _fnc_addItem;
	["smokeGrenades", 2] call _fnc_addItem;

	["maps"] call _fnc_addMap;
	["watches"] call _fnc_addWatch;
	["compasses"] call _fnc_addCompass;
	["radios"] call _fnc_addRadio;
	["NVGs"] call _fnc_addNVGs;
};

private _medicTemplate = {
	["helmets"] call _fnc_setHelmet;
	[["Hvests", "vests"] call _fnc_fallback] call _fnc_setVest;
	["uniforms"] call _fnc_setUniform;
	["backpacks"] call _fnc_setBackpack;

  	[selectRandom ["carbines", "smgs"]] call _fnc_setPrimary;
	["primary", 6] call _fnc_addMagazines;

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
	["facewear"] call _fnc_setFacewear;
	[["GLvests", "vests"] call _fnc_fallback] call _fnc_setVest;
	["uniforms"] call _fnc_setUniform;
	["backpacks"] call _fnc_setBackpack;

	["grenadeLaunchers"] call _fnc_setPrimary;
	["primary", 6] call _fnc_addMagazines;
	["primary", 10] call _fnc_addAdditionalMuzzleMagazines;

	["sidearms"] call _fnc_setHandgun;
	["handgun", 2] call _fnc_addMagazines;

	["items_medical_standard"] call _fnc_addItemSet;
	["items_grenadier_extras"] call _fnc_addItemSet;
	["items_miscEssentials"] call _fnc_addItemSet;
	["antiInfantryGrenades", 4] call _fnc_addItem;
	["smokeGrenades", 2] call _fnc_addItem;

	["maps"] call _fnc_addMap;
	["watches"] call _fnc_addWatch;
	["compasses"] call _fnc_addCompass;
	["radios"] call _fnc_addRadio;
	["NVGs"] call _fnc_addNVGs;
};

private _explosivesExpertTemplate = {
	["helmets"] call _fnc_setHelmet;
	["facewear"] call _fnc_setFacewear;
	[["GLvests", "vests"] call _fnc_fallback] call _fnc_setVest;
	["uniforms"] call _fnc_setUniform;
	["backpacks"] call _fnc_setBackpack;

	[selectRandom ["rifles", "carbines"]] call _fnc_setPrimary;
	["primary", 6] call _fnc_addMagazines;


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

	[["shotguns", "carbines"] call _fnc_fallback] call _fnc_setPrimary;
	["primary", 6] call _fnc_addMagazines;

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
	["primary", 6] call _fnc_addMagazines;

	["lightATLaunchers"] call _fnc_setLauncher;
	//TODO - Add a check if it's disposable.
	["launcher", 3] call _fnc_addMagazines;

	["sidearms"] call _fnc_setHandgun;
	["handgun", 2] call _fnc_addMagazines;

	["items_medical_standard"] call _fnc_addItemSet;
	["items_lat_extras"] call _fnc_addItemSet;
	["items_miscEssentials"] call _fnc_addItemSet;
	["antiInfantryGrenades", 1] call _fnc_addItem;
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

	[selectRandom ["rifles", "carbines"]] call _fnc_setPrimary;
	["primary", 6] call _fnc_addMagazines;

	[selectRandom ["ATLaunchers", "missileATLaunchers"]] call _fnc_setLauncher;
	//TODO - Add a check if it's disposable.
	["launcher", 3] call _fnc_addMagazines;

	["sidearms"] call _fnc_setHandgun;
	["handgun", 2] call _fnc_addMagazines;

	["items_medical_standard"] call _fnc_addItemSet;
	["items_at_extras"] call _fnc_addItemSet;
	["items_miscEssentials"] call _fnc_addItemSet;
	["antiInfantryGrenades", 1] call _fnc_addItem;
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

	[selectRandom ["rifles", "carbines"]] call _fnc_setPrimary;
	["primary", 6] call _fnc_addMagazines;

	["AALaunchers"] call _fnc_setLauncher;
	//TODO - Add a check if it's disposable.
	["launcher", 3] call _fnc_addMagazines;

	["sidearms"] call _fnc_setHandgun;
	["handgun", 2] call _fnc_addMagazines;

	["items_medical_standard"] call _fnc_addItemSet;
	["items_aa_extras"] call _fnc_addItemSet;
	["items_miscEssentials"] call _fnc_addItemSet;
	["antiInfantryGrenades", 1] call _fnc_addItem;
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
	["antiInfantryGrenades", 1] call _fnc_addItem;
	["smokeGrenades", 2] call _fnc_addItem;

	["maps"] call _fnc_addMap;
	["watches"] call _fnc_addWatch;
	["compasses"] call _fnc_addCompass;
	["radios"] call _fnc_addRadio;
	["NVGs"] call _fnc_addNVGs;
};

private _marksmanTemplate = {
	["helmets"] call _fnc_setHelmet;
	["facewear"] call _fnc_setFacewear;
	["vests"] call _fnc_setVest;
	["uniforms"] call _fnc_setUniform;


	["marksmanRifles"] call _fnc_setPrimary;
	["primary", 6] call _fnc_addMagazines;

	["sidearms"] call _fnc_setHandgun;
	["handgun", 2] call _fnc_addMagazines;

	["items_medical_standard"] call _fnc_addItemSet;
	["items_marksman_extras"] call _fnc_addItemSet;
	["items_miscEssentials"] call _fnc_addItemSet;
	["antiInfantryGrenades", 1] call _fnc_addItem;
	["smokeGrenades", 2] call _fnc_addItem;

	["maps"] call _fnc_addMap;
	["watches"] call _fnc_addWatch;
	["compasses"] call _fnc_addCompass;
	["radios"] call _fnc_addRadio;
	["Rangefinder"] call _fnc_addBinoculars;
	["NVGs"] call _fnc_addNVGs;
};

private _sniperTemplate = {
	["helmets"] call _fnc_setHelmet;
	["vests"] call _fnc_setVest;
	[["sniperuniforms", "uniforms"] call _fnc_fallback] call _fnc_setUniform;


	["sniperRifles"] call _fnc_setPrimary;
	["primary", 7] call _fnc_addMagazines;

	["sidearms"] call _fnc_setHandgun;
	["handgun", 2] call _fnc_addMagazines;

	["items_medical_standard"] call _fnc_addItemSet;
	["items_sniper_extras"] call _fnc_addItemSet;
	["items_miscEssentials"] call _fnc_addItemSet;
	["antiInfantryGrenades", 1] call _fnc_addItem;
	["smokeGrenades", 2] call _fnc_addItem;

	["maps"] call _fnc_addMap;
	["watches"] call _fnc_addWatch;
	["compasses"] call _fnc_addCompass;
	["radios"] call _fnc_addRadio;
	["Rangefinder"] call _fnc_addBinoculars;
	["NVGs"] call _fnc_addNVGs;
};

private _policeTemplate = {
	["helmets"] call _fnc_setHelmet;
	["vests"] call _fnc_setVest;
	["uniforms"] call _fnc_setUniform;


	["smgs"] call _fnc_setPrimary;
	["primary", 3] call _fnc_addMagazines;

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

	[selectRandom ["carbines", "smgs"]] call _fnc_setPrimary;
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

private _traitorTemplate = {
	call _unarmedTemplate;
	["sidearms"] call _fnc_setHandgun;
	["handgun", 2] call _fnc_addMagazines;
};

////////////////////////////////////////////////////////////////////////////////////////
//  You shouldn't touch below this line unless you really really know what you're doing.
//  Things below here can and will break the gamemode if improperly changed.
////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////
//  Special Forces Units   //
/////////////////////////////
private _prefix = "SF";
private _unitTypes = [
	["SquadLeader", _squadLeaderTemplate],
	["Rifleman", _riflemanTemplate],
	["Radioman", _radiomanTemplate],
	["Medic", _medicTemplate, [["medic", true]]],
	["Engineer", _engineerTemplate, [["engineer", true]]],
	["ExplosivesExpert", _explosivesExpertTemplate, [["explosiveSpecialist", true]]],
	["Grenadier", _grenadierTemplate],
	["LAT", _latTemplate],
	["AT", _atTemplate],
	["AA", _aaTemplate],
	["MachineGunner", _machineGunnerTemplate],
	["Marksman", _marksmanTemplate],
	["Sniper", _sniperTemplate]
];

[_prefix, _unitTypes, _sfLoadoutData] call _fnc_generateAndSaveUnitsToTemplate;

/*{
	params ["_name", "_loadoutTemplate"];
	private _loadouts = [_sfLoadoutData, _loadoutTemplate] call _fnc_buildLoadouts;
	private _finalName = _prefix + _name;
	[_finalName, _loadouts] call _fnc_saveToTemplate;
} forEach _unitTypes;
*/

///////////////////////
//  Military Units   //
///////////////////////
private _prefix = "military";
private _unitTypes = [
	["SquadLeader", _squadLeaderTemplate],
	["Rifleman", _riflemanTemplate],
	["Radioman", _radiomanTemplate],
	["Medic", _medicTemplate, [["medic", true]]],
	["Engineer", _engineerTemplate, [["engineer", true]]],
	["ExplosivesExpert", _explosivesExpertTemplate, [["explosiveSpecialist", true]]],
	["Grenadier", _grenadierTemplate],
	["LAT", _latTemplate],
	["AT", _atTemplate],
	["AA", _aaTemplate],
	["MachineGunner", _machineGunnerTemplate],
	["Marksman", _marksmanTemplate],
	["Sniper", _sniperTemplate]
];

[_prefix, _unitTypes, _militaryLoadoutData] call _fnc_generateAndSaveUnitsToTemplate;

///////////////////////
//  Elite Units   //
///////////////////////
private _prefix = "elite";
private _unitTypes = [
	["SquadLeader", _squadLeaderTemplate],
	["Rifleman", _riflemanTemplate],
	["Radioman", _radiomanTemplate],
	["Medic", _medicTemplate, [["medic", true]]],
	["Engineer", _engineerTemplate, [["engineer", true]]],
	["ExplosivesExpert", _explosivesExpertTemplate, [["explosiveSpecialist", true]]],
	["Grenadier", _grenadierTemplate],
	["LAT", _latTemplate],
	["AT", _atTemplate],
	["AA", _aaTemplate],
	["MachineGunner", _machineGunnerTemplate],
	["Marksman", _marksmanTemplate],
	["Sniper", _sniperTemplate]
];

[_prefix, _unitTypes, _eliteLoadoutData] call _fnc_generateAndSaveUnitsToTemplate;

////////////////////////
//    Police Units    //
////////////////////////
private _prefix = "police";
private _unitTypes = [
	["SquadLeader", _policeTemplate],
	["Standard", _policeTemplate]
];

[_prefix, _unitTypes, _policeLoadoutData] call _fnc_generateAndSaveUnitsToTemplate;

////////////////////////
//    Militia Units    //
////////////////////////
private _prefix = "militia";
private _unitTypes = [
	["SquadLeader", _squadLeaderTemplate],
	["Rifleman", _riflemanTemplate],
	["Radioman", _radiomanTemplate],
	["Medic", _medicTemplate, [["medic", true]]],
	["Engineer", _engineerTemplate, [["engineer", true]]],
	["ExplosivesExpert", _explosivesExpertTemplate, [["explosiveSpecialist", true]]],
	["Grenadier", _grenadierTemplate],
	["LAT", _latTemplate],
	["AT", _atTemplate],
	["AA", _aaTemplate],
	["MachineGunner", _machineGunnerTemplate],
	["Marksman", _marksmanTemplate],
	["Sniper", _sniperTemplate]
];

[_prefix, _unitTypes, _militiaLoadoutData] call _fnc_generateAndSaveUnitsToTemplate;

//////////////////////
//    Misc Units    //
//////////////////////


["other", [["Crew", _crewTemplate]], _crewLoadoutData] call _fnc_generateAndSaveUnitsToTemplate;

["other", [["Pilot", _crewTemplate]], _pilotLoadoutData] call _fnc_generateAndSaveUnitsToTemplate;

["other", [["Official", _policeTemplate]], _militaryLoadoutData] call _fnc_generateAndSaveUnitsToTemplate;

["other", [["Traitor", _traitorTemplate]], _militaryLoadoutData] call _fnc_generateAndSaveUnitsToTemplate;

["other", [["Unarmed", _unarmedTemplate]], _militaryLoadoutData] call _fnc_generateAndSaveUnitsToTemplate;
