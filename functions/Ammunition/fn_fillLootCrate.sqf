private _filename = "fn_fillLootCrate";
params ["_crate", 
["_crateWepTypeMax", crateWepTypeMax], "_crateWepNum", 
["_crateItemTypeMax", crateItemTypeMax], "_crateItemNum", 
["_crateAmmoTypeMax", crateAmmoTypeMax], "_crateAmmoNum", 
["_crateExplosiveTypeMax", crateExplosiveTypeMax], "_crateExplosiveNum", 
["_crateAttachmentTypeMax", crateAttachmentTypeMax], "_crateAttachmentNum", 
["_crateBackpackTypeMax", crateBackpackTypeMax], "_crateBackpackNum", 
["_crateHelmetTypeMax", crateHelmetTypeMax], "_crateHelmetNum", 
["_crateVestTypeMax", crateVestTypeMax], "_crateVestNum", 
["_crateDeviceTypeMax", crateDeviceTypeMax], "_crateDeviceNum"
];
private _unlocks = (unlockedHeadgear + unlockedVests + unlockedNVGs + unlockedOptics + unlockedItems + unlockedWeapons + unlockedBackpacks + unlockedMagazines);
private _available = objNull;
private _amount = objNull;
//Empty the crate
clearMagazineCargoGlobal _crate;
clearWeaponCargoGlobal _crate;
clearItemCargoGlobal _crate;
clearBackpackCargoGlobal _crate;
//Double max types if the crate is an ammo truck
if (typeOf _crate in vehAmmoTrucks) then {
	[4, "Ammo Truck Detected: Quadupling Types", _filename] call A3A_fnc_log;
	_crateWepTypeMax = _crateWepTypeMax * 4;
	_crateItemTypeMax = _crateItemTypeMax * 4;
	_crateAmmoTypeMax = _crateAmmoTypeMax * 4;
	_crateExplosiveTypeMax = _crateExplosiveTypeMax * 4;
	_crateAttachmentTypeMax = _crateAttachmentTypeMax * 4;
	_crateBackpackTypeMax = _crateBackpackTypeMax * 4;
	_crateHelmetTypeMax = _crateHelmetTypeMax * 4;
	_crateVestTypeMax = _crateVestTypeMax * 4;
	_crateDeviceTypeMax = _crateDeviceTypeMax * 4;
};


private _quantityScalingFactor = if (!cratePlayerScaling) then {1} else {
	private _playerCount = if(!isNil "spoofedPlayerCount") then {spoofedPlayerCount} else {count (call A3A_fnc_playableUnits)};
	//Scale it down to a 50% loot rate at 20 players.
	1 / (1 + _playerCount / 20);
};

//Loot contents adjusted by J.Bennett for Chernarus map.
//Weapons
lootRifles = ["CUP_arifle_M16A2","CUP_arifle_AKM_Early","CUP_arifle_AK74_Early","CUP_arifle_AKMS_Early","CUP_arifle_AKS74_Early","CUP_arifle_AKM_GL_Early","CUP_arifle_AK74_GL_Early","CUP_arifle_AKMS_GL_Early","CUP_arifle_AKS74_GL_Early","CUP_arifle_AKS74U"];

if (tierWar > 3) then {
	lootRifles append ["CUP_arifle_M16A4_Base","CUP_arifle_M16A4_GL","CUP_arifle_M16A2_GL","CUP_arifle_OTS14_GROZA_762","CUP_arifle_OTS14_GROZA_762_GL","CUP_arifle_AK74M","CUP_arifle_AK74M_GL"]};

if (tierWar > 7) then {
	lootRifles append ["CUP_arifle_M4A1_black","CUP_arifle_M4A1_BUIS_GL","CUP_glaunch_6G30","CUP_arifle_AK12_black","CUP_arifle_AK15_black","CUP_arifle_AK104_top_rail","CUP_arifle_AK105_top_rail"]};

lootHandguns = ["CUP_hgun_Makarov"];

if (tierWar > 3) then {
	lootHandguns append ["CUP_hgun_PMM"]};
	
lootMachineGuns = ["CUP_arifle_RPK74_45","CUP_arifle_RPK74","CUP_lmg_PKM"];

if (tierWar > 3) then {
	lootMachineGuns append ["CUP_lmg_PKMN","CUP_arifle_RPK74M"]};

if (tierWar > 7) then {
	lootMachineGuns append ["CUP_lmg_m249_pip1","CUP_lmg_Pecheneg_B50_vfg"]};

lootShotguns = ["CUP_sgun_Saiga12K"];

lootSMGs = ["CUP_smg_bizon","CUP_smg_vityaz_vfg"];

if (tierWar > 3) then {
	lootSMGs append ["CUP_arifle_OTS14_GROZA","CUP_arifle_SR3M_Vikhr"]};

lootSniperRifles = ["CUP_srifle_SVD"];

if (tierWar > 3) then {
	lootSniperRifles append ["CUP_srifle_ksvk"]};

if (tierWar > 7) then {
	lootSniperRifles append ["CUP_arifle_G3A3_modern_ris","CUP_srifle_SVD_wdl"]};

lootRocketLaunchers = ["CUP_launch_RPG18","CUP_launch_RPG7V"];

if (tierWar > 3) then {
	lootRocketLaunchers append ["CUP_launch_RPG26","CUP_launch_RShG2"]};

if (tierWar > 7) then {
	lootRocketLaunchers append ["CUP_launch_MAAWS"]};

lootMissileLaunchers = ["CUP_launch_9K32Strela"];

if (tierWar > 7) then {
	lootMissileLaunchers append ["CUP_launch_Igla","CUP_launch_Metis"]};

//Items
lootChernItems = ["ItemRadio","FirstAidKit","Medikit","ToolKit"];

if (tierWar > 3) then {
	lootChernItems append ["CUP_NVG_PVS7","CUP_NVG_1PN138","CUP_Vector21Nite","GPS","ChemicalDetector_01_watch_F","I_UavTerminal","I_UAV_01_backpack_F"]};

if (tierWar > 7) then {
	lootChernItems append ["CUP_LRTV"]};

//Magazines
lootChernMagazines = ["CUP_PG7V_M","CUP_PG7V_M","CUP_OG7_M","CUP_20Rnd_556x45_Stanag","CUP_20Rnd_556x45_Stanag","CUP_20Rnd_556x45_Stanag_Tracer_Red","CUP_20Rnd_556x45_Stanag", "CUP_20Rnd_556x45_Stanag", "CUP_20Rnd_556x45_Stanag_Tracer_Red","CUP_30Rnd_545x39_AK_M", "CUP_30Rnd_545x39_AK_M", "CUP_30Rnd_TE1_Red_Tracer_545x39_AK_M","CUP_1Rnd_HE_GP25_M", "CUP_1Rnd_HE_GP25_M", "CUP_1Rnd_SMOKE_GP25_M", "CUP_IlumFlareWhite_GP25_M","CUP_1Rnd_SmokeRed_GP25_M","CUP_1Rnd_SmokeGreen_GP25_M","CUP_1Rnd_SmokeYellow_GP25_M","CUP_6Rnd_FlareGreen_GP25_M","CUP_6Rnd_FlareRed_GP25_M","CUP_6Rnd_FlareYellow_GP25_M","CUP_30Rnd_9x19_Vityaz","CUP_30Rnd_545x39_AK74_plum_M","CUP_5Rnd_B_Saiga12_Buck_00","CUP_5Rnd_B_Saiga12_Slug","CUP_45Rnd_TE4_LRT4_Green_Tracer_545x39_RPK_M","CUP_10Rnd_762x54_SVD_M","CUP_8Rnd_9x18_Makarov_M","CUP_HandGrenade_RGD5","SmokeShellRed","SmokeShellGreen","SmokeShellYellow","SmokeShellPurple","SmokeShellBlue","SmokeShellOrange","CUP_75Rnd_TE4_LRT4_Green_Tracer_762x39_RPK_M","CUP_100Rnd_TE4_LRT4_762x54_PK_Tracer_Green_M","CUP_64Rnd_9x19_Bizon_M"];

if (tierWar > 3) then {
	lootChernMagazines append ["CUP_1Rnd_HE_M203","CUP_1Rnd_HEDP_M203","CUP_1Rnd_StarCluster_White_M203","CUP_1Rnd_Smoke_M203","30Rnd_762x39_Mag_F","30Rnd_762x39_Mag_Tracer_F","CUP_20Rnd_9x39_SP5_GROZA_M","CUP_30Rnd_9x19AP_Vityaz","CUP_12Rnd_9x18_PMM_M","CUP_45Rnd_TE4_LRT4_Green_Tracer_545x39_RPK74M_M","CUP_5Rnd_127x108_KSVK_M","CUP_30Rnd_545x39_AK74M_M", "CUP_30Rnd_TE1_Green_Tracer_545x39_AK74M_M","CUP_30Rnd_9x39_SP5_VIKHR_M"]};

if (tierWar > 7) then {
	lootChernMagazines append ["CUP_200Rnd_TE4_Red_Tracer_556x45_M249","CUP_20Rnd_762x51_G3", "CUP_20Rnd_TE1_Red_Tracer_762x51_G3","CUP_MAAWS_HEAT_M", "CUP_MAAWS_HEDP_M","CUP_AT13_M","CUP_6Rnd_HE_GP25_M","CUP_30Rnd_545x39_AK12_M", "CUP_30Rnd_TE1_Green_Tracer_545x39_AK12_M","CUP_30Rnd_762x39_AK15_M", "CUP_30Rnd_TE1_Green_Tracer_762x39_AK15_M","CUP_30Rnd_762x39_AK103_bakelite_M", "CUP_30Rnd_TE1_Green_Tracer_762x39_AK103_bakelite_M","CUP_100Rnd_TE4_LRT4_762x54_PK_Tracer_Red_M", "CUP_100Rnd_TE4_LRT4_762x54_PK_Tracer_Yellow_M"]};

//Explosives
lootChernExplosives = ["SatchelCharge_Remote_Mag","DemoCharge_Remote_Mag","APERSTripMine_Wire_Mag","APERSMine_Range_Mag"];

if (tierWar > 3) then {
	lootChernExplosives append ["APERSBoundingMine_Range_Mag","CUP_MineE_M"]};

if (tierWar > 7) then {
	lootChernExplosives append ["ClaymoreDirectionalMine_Remote_Mag"]};

//Attachments
lootChernAttachments = ["CUP_acc_Flashlight","CUP_optic_PSO_1","CUP_optic_OKP_7"];

if (tierWar > 3) then {
	lootChernAttachments append ["CUP_optic_PSO_3","CUP_optic_CompM2_low","CUP_optic_PechenegScope","CUP_optic_ekp_8_02","CUP_optic_PSO_1_AK","CUP_optic_1p63"]};

if (tierWar > 7) then {
	lootChernAttachments append ["CUP_optic_AIMM_M68_BLK","CUP_optic_ElcanM145","CUP_optic_LeupoldMk4","CUP_bipod_G3SG1","CUP_optic_MAAWS_Scope","CUP_bipod_VLTOR_Modpod_black","CUP_optic_Kobra","CUP_optic_1P87_RIS","CUP_optic_1P87_1P90_BLK","CUP_optic_GOSHAWK","CUP_muzzle_snds_KZRZP_AK545","CUP_muzzle_snds_KZRZP_AK762","CUP_muzzle_Bizon","CUP_muzzle_snds_KZRZP_PK"]};

//Backpacks
lootChernBackpacks = ["CUP_B_AlicePack_OD","CUP_B_AlicePack_Khaki"];

if (tierWar > 3) then {
	lootChernBackpacks append ["CUP_B_RUS_Pack_Medic"]};

if (tierWar > 7) then {
	lootChernBackpacks append ["CUP_O_RUS_Patrol_bag_Summer", "CUP_O_RUS_Patrol_bag_Summer_Shovel"]};

//Helmets
lootChernHelmets = ["CUP_H_RUS_SSH68_olive"];

if (tierWar > 3) then {
	lootChernHelmets append ["CUP_H_CDF_H_PASGT_FST","CUP_H_RUS_6B27_cover"]};

if (tierWar > 7) then {
	lootChernHelmets append ["CUP_H_CDF_H_PASGT_MNT","CUP_H_RUS_6B47_v2_Summer", "CUP_H_RUS_6B47_v2_GogglesClosed_Summer", "CUP_H_RUS_6B47_v2_GogglesDown_Summer", "CUP_H_RUS_6B47_v2_GogglesUp_Summer"]};

//Vests
lootChernVests = ["CUP_V_O_Ins_Carrier_Rig","CUP_V_CDF_6B3_1_Green"];

if (tierWar > 3) then {
	lootChernVests append ["CUP_V_CDF_6B3_1_FST", "CUP_V_CDF_6B3_2_FST","CUP_V_CDF_6B3_3_FST", "CUP_V_CDF_6B3_4_FST", "CUP_V_CDF_6B3_5_FST","CUP_V_RUS_6B3_1", "CUP_V_RUS_6B3_2"]};

if (tierWar > 7) then {
	lootChernVests append ["CUP_V_CDF_6B3_1_MNT", "CUP_V_CDF_6B3_2_MNT","CUP_V_CDF_6B3_3_MNT", "CUP_V_RUS_6B45_4", "CUP_Vest_RUS_6B45_Sh117_VOG","CUP_V_RUS_6B45_4"]};

//Format [allWeapons, unlockedWeapons, Weighting]. 
//We need to know the corresponding unlockedWeapons array, so we can check if they're all unlocked.
private _weaponLootInfo = [
	[lootRifles, unlockedRifles, 3],
	[lootHandguns, unlockedHandguns, 1.2],
	[lootMachineGuns, unlockedMachineGuns, 2],
	[lootShotguns, unlockedShotguns, 1],
	[lootSMGs, unlockedSMGs, 2],
	[lootSniperRifles, unlockedSniperRifles, 0.9],
	[lootRocketLaunchers, unlockedRocketLaunchers, 0.5],
	[lootMissileLaunchers, unlockedMissileLaunchers, 0.5] //Increase weighting for RHS.
];

//Build the weighting array, as used by selectRandomWeighted
private _weaponLootWeighting = [];
{
	_x params ["_allX", "_unlockedX", "_weighting"];
	//If the array contains weapons, and we haven't unlocked everything, add it to the pool to be selected.
	if (count _allX > 0 && {(count _unlockedX / count _allX) < 1}) then {
		_weaponLootWeighting pushBack [_allX, _unlockedX];
		_weaponLootWeighting pushBack _weighting;
	};
} forEach _weaponLootInfo;

/**
Probabilistic function that checks that A is probably not in B.
  For a given array A, and another array B, this function selects an item from A that's not in B, with a probability that depends on how much of A is in B.
  This is purely a performance optimisation.

  X Axis - Attempt/Iteration number
  Y Axis - % of items from Array 1 in array 2
  Value - Probability of successfully returning a value from A not in B.

	       1     2       3        4         5          6           7            8             9             10
		-----------------------------------------------------------------------------------------------------------------
	0.9 | 0.1    0.19    0.271    0.3439    0.40951    0.468559    0.5217031    0.56953279    0.612579511    0.6513215599
	0.8 | 0.2    0.36    0.488    0.5904    0.67232    0.737856    0.7902848    0.83222784    0.865782272    0.8926258176
	0.7 | 0.3    0.51    0.657    0.7599    0.83193    0.882351    0.9176457    0.94235199    0.959646393    0.9717524751
	0.6 | 0.4    0.64    0.784    0.8704    0.92224    0.953344    0.9720064    0.98320384    0.989922304    0.9939533824
	0.5 | 0.5    0.75    0.875    0.9375    0.96875    0.984375    0.9921875    0.99609375    0.998046875    0.9990234375
	0.4 | 0.6    0.84    0.936    0.9744    0.98976    0.995904    0.9983616    0.99934464    0.999737856    0.9998951424
	0.3 | 0.7    0.91    0.973    0.9919    0.99757    0.999271    0.9997813    0.99993439    0.999980317    0.9999940951
	0.2 | 0.8    0.96    0.992    0.9984    0.99968    0.999936    0.9999872    0.99999744    0.999999488    0.9999998976
	0.1 | 0.9    0.99    0.999    0.9999    0.99999    0.999999    0.9999999    0.99999999    0.999999999    0.9999999999
    0.0 |  1      1        1         1         1           1            1            1             1               1

	Best case - two arrays of 400 elements, we see a 20x speedup.
	Worst case- two arrays of 1 element, 3x slowdown.
	100 array case - 10x speedup.

	Yes, this is over-engineered.
**/

private _fnc_pickRandomFromAProbablyNotInB = {
	params ["_arrayA", "_arrayB"];

	//Only run if there's more than 100 items in the array.
	if (count _arrayA min count _arrayB < 100) exitWith {
		selectRandom (_arrayA - _arrayB);
	};

	//Calculate what % of arrayB is likely in arrayA. 
	//Let's never go over 100% loaded. It's theoretically possible if arrayB ever is somehow larger than arrayA/
	//There's not a lot of value in running more than 10 iterations on a 90%+ loading anyway.
	private _percentageLoaded = (count _arrayB / count _arrayA) min 1;
	//Rough heuristic for how many iterations we need to run to get a good chance of success.
	private _iterations = floor (10 * _percentageLoaded);

	private _choice = selectRandom _arrayA;
	[3, format ["Function check for: %1", _choice], _filename] call A3A_fnc_log;
	private _foundValid = true;
	if (_choice in _arrayB) then {
		_foundValid = false;
		[3, format ["Item already unlocked, rolling again."], _filename] call A3A_fnc_log;
		for "_i" from 0 to _iterations do {
			_choice = selectRandom _arrayA;
			//We did it!
			if !(_choice in _arrayB) exitWith {
				_foundValid = true;
			};
		}
	};

	if (_foundValid) then {
		_choice;
	} else {
		//We failed, just... return something.
		selectRandom _arrayA;
	};
};

//Pick a weapon for the crate. Pick carefully, unless in CHAOS MODE, in which case, we just pick totally at random.
private _fnc_pickWeapon = if (bobChaosCrates) then 
{
	{
		private _category = (selectRandom _weaponLootInfo) select 0;
		selectRandom _category;
	}
} 
else 
{
	{
		private _category = selectRandomWeighted _weaponLootWeighting;
		if (isNil "_category") exitWith {};

		[4, format ["Selected Weapon Category: %1", _category], _filename] call A3A_fnc_log;
		//Category is in format [allX, unlockedX];
		[_category select 0, _category select 1] call _fnc_pickRandomFromAProbablyNotInB;
	}
};

//Pick the amount of X to spawn. Use gaussian distribution, unless we're in CHAOS MODE.
private _fnc_pickAmount = if (bobChaosCrates) then 
{
	{
		params ["_max"];
		round random _max;
	}
} 
else 
{
	{
		params ["_max"];
		//Never have a greater than 50% chance of getting nothing
		if (_max * _quantityScalingFactor < 1) then {
			round random 1
		} else {
			round (random [1, floor (_max/2), _max] * _quantityScalingFactor)
		}
	}
};

private _fnc_pickNumberOfTypes = if (bobChaosCrates) then
{
	{
		params ["_max"];
		floor random _max;
	}
} 
else 
{
	{
		params ["_max"];
		floor random [1, floor (_max/2), _max];
	}
};

//Weapons Loot
if (_crateWepTypeMax != 0) then {
	[3, "Generating Weapons", _filename] call A3A_fnc_log;
	for "_i" from 0 to (_crateWepTypeMax call _fnc_pickNumberOfTypes) do {
		private _loot = call _fnc_pickWeapon;

		if (isNil "_loot") then {
			[3, "No Weapons Left in Loot List Or Pick Random Failed", _filename] call A3A_fnc_log;
		}
		else 
		{
			_amount = if (isNil "_crateWepNum") then {crateWepNumMax call _fnc_pickAmount;} else {_crateWepNum};
			_crate addWeaponWithAttachmentsCargoGlobal [[ _loot, "", "", "", [], [], ""], _amount];
			[4, format ["Adding %1 weapons of type %2", _amount, _loot], _filename] call A3A_fnc_log;

			private _cfgArray = getArray (configFile / "CfgWeapons" / _loot / "magazines");
			private _magazines = [];
			{
			if (_x in _cfgArray) then {_magazines pushBack _x}
			} forEach lootChernMagazines;
			
			if (count _magazines < 1) exitWith {};
			if (_loot in lootShotguns) then { _magazines = [_magazines select 0] };		// prevent doomsday

			for "_i" from 0 to _amount do {
				_magazine = selectRandom _magazines;
				_magAmount = if ((getText (configFile >> "CfgMagazines" >> _magazine >> "ammo") isKindOf "MissileBase")) then {
					floor random 3;
				} else {
					floor random [1,6,1]
				};
				[4, format ["Spawning %1 magazines of %2 for %3", _magAmount, _magazine, _loot], _filename] call A3A_fnc_log;
				_crate addMagazineCargoGlobal [_magazine, _magAmount];
			};
		};
	};
};

//Items Loot
if (_crateItemTypeMax != 0) then {
	[3, "Generating Items", _filename] call A3A_fnc_log;
	for "_i" from 0 to floor random _crateItemTypeMax do {
		_available = (lootChernItems - _unlocks - itemCargo _crate);
		[4, format ["Breakdown: %1, %2, %3", lootChernItems, _unlocks, itemCargo _crate], _filename] call A3A_fnc_log;
		[4, format ["Items available: %1", _available], _filename] call A3A_fnc_log;
		_loot = selectRandom _available;

		if (isNil "_loot") then {
			[3, "No Items Left in Loot List", _filename] call A3A_fnc_log;
		}
		else {
			_amount = if (isNil "_crateItemNum") then { round random crateItemNumMax;} else {_crateItemNum};
			if (_loot == "FirstAidKit") then {_amount = _amount * 3};
			_crate addItemCargoGlobal [_loot,_amount];
			[4, format ["Spawning %1 of %2", _amount,_loot], _filename] call A3A_fnc_log;
		};
	};
};
//Ammo Loot
if (_crateAmmoTypeMax != 0) then {
	for "_i" from 0 to floor random _crateAmmoTypeMax do {
		_available = (lootChernMagazines - _unlocks - itemCargo _crate);
		_loot = selectRandom _available;
		if (isNil "_loot") then {
			[3, "No Ammo Left in Loot List", _filename] call A3A_fnc_log;
		}
		else {
			_amount = if (isNil "_crateAmmoNum") then {crateAmmoNumMax call _fnc_pickAmount;} else {_crateAmmoNum};
			_crate addMagazineCargoGlobal [_loot,_amount];
			[4, format ["Spawning %1 of %2", _amount,_loot], _filename] call A3A_fnc_log;
		};
	};
};
//Explosives Loot
if (_crateExplosiveTypeMax != 0) then {
	for "_i" from 0 to floor random _crateExplosiveTypeMax do {
		_available = (lootChernExplosives - _unlocks - itemCargo _crate);
		_loot = selectRandom _available;
		if (isNil "_loot") then {
			[3, "No Explosives Left in Loot List", _filename] call A3A_fnc_log;
		}
		else {
			_amount = if (isNil "_crateExplosiveNum") then { round random crateExplosiveNumMax;} else {_crateExplosiveNum};
			_crate addMagazineCargoGlobal [_loot,_amount];
			[4, format ["Spawning %1 of %2", _amount,_loot], _filename] call A3A_fnc_log;
		};
	};
};
//Attachments Loot
if (_crateAttachmentTypeMax != 0) then {
	for "_i" from 0 to (_crateAttachmentTypeMax call _fnc_pickNumberOfTypes) do {
		_available = (lootChernAttachments - _unlocks - itemCargo _crate);
		_loot = selectRandom _available;
		if (isNil "_loot") then {
			[3, "No Attachment Left in Loot List", _filename] call A3A_fnc_log;
		}
		else {
			_amount = if (isNil "_crateAttachmentNum") then { crateAttachmentNumMax  call _fnc_pickAmount;} else {_crateAttachmentNum};
			_crate addItemCargoGlobal [_loot,_amount];
			[4, format ["Spawning %1 of %2", _amount,_loot], _filename] call A3A_fnc_log;
		};
	};
};
//Backpacks Loot
if (_crateBackpackTypeMax != 0) then {
	for "_i" from 0 to floor random _crateBackpackTypeMax do {
		_available = (lootChernBackpacks - _unlocks - itemCargo _crate);
		_loot = selectRandom _available;
		if (isNil "_loot") then {
			[3, "No Backpacks Left in Loot List", _filename] call A3A_fnc_log;
		}
		else {
			_amount = if (isNil "_crateBackpackNum") then {round random crateBackpackNumMax;} else {_crateBackpackNum};
			_crate addBackpackCargoGlobal [_loot,_amount];
			[4, format ["Spawning %1 of %2", _amount,_loot], _filename] call A3A_fnc_log;
		};
	};
};
//Helmets Loot
if (_crateHelmetTypeMax != 0) then {
	for "_i" from 0 to floor random _crateHelmetTypeMax do {
		_available = (lootChernHelmets - _unlocks - itemCargo _crate);
		_loot = selectRandom _available;
		if (isNil "_loot") then {
			[3, "No Helmets Left in Loot List", _filename] call A3A_fnc_log;
		}
		else {
			_amount = if (isNil "_crateHelmetNum") then { round random crateHelmetNumMax;} else {_crateHelmetNum};
			_crate addItemCargoGlobal [_loot,_amount];
			[4, format ["Spawning %1 of %2", _amount,_loot], _filename] call A3A_fnc_log;
		};
	};
};
//Vests Loot
if (_crateVestTypeMax != 0) then {
	for "_i" from 0 to floor random _crateVestTypeMax do {
		_available = (lootChernVests - _unlocks - itemCargo _crate);
		_loot = selectRandom _available;
		if (isNil "_loot") then {
			[3, "No Vests Left in Loot List", _filename] call A3A_fnc_log;
		}
		else {
			_amount = if (isNil "_crateVestNum") then { round random crateVestNumMax;} else {_crateVestNum};
			_crate addItemCargoGlobal [_loot,_amount];
			[4, format ["Spawning %1 of %2", _amount,_loot], _filename] call A3A_fnc_log;
		};
	};
};
