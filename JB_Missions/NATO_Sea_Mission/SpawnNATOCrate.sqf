if (!isServer and hasInterface) exitWith{};

sleep 2;

titleText ["<t color='#ffffff' size='1.4'>Here are your presents from NATO. Use them well, and good luck.", "PLAIN DOWN", -1, true, true];

crate1 = "B_CargoNet_01_ammo_F" createVehicle [14072.9,11379.9,0];
crate1 call A3A_fnc_logistics_addLoadAction;
clearWeaponCargoGlobal crate1;
clearMagazineCargoGlobal crate1;
clearItemCargoGlobal crate1;
clearBackpackCargoGlobal crate1;
crate1 addWeaponCargoGlobal ["CUP_arifle_M16A4_Base", 25];
crate1 addWeaponCargoGlobal ["CUP_arifle_M16A4_GL", 10];
crate1 addWeaponCargoGlobal ["CUP_lmg_M249_pip1", 8];
crate1 addWeaponCargoGlobal ["CUP_lmg_M240_B", 6];
crate1 addWeaponCargoGlobal ["CUP_srifle_M14_DMR", 6];
crate1 addMagazineCargoGlobal ["CUP_30Rnd_556x45_Stanag", 100];
crate1 addMagazineCargoGlobal ["CUP_200Rnd_TE1_Red_Tracer_556x45_M249", 36];
crate1 addMagazineCargoGlobal ["CUP_100Rnd_TE4_LRT4_White_Tracer_762x51_Belt_M", 32];
crate1 addMagazineCargoGlobal ["CUP_20Rnd_762x51_DMR", 32];
crate1 addMagazineCargoGlobal ["CUP_1Rnd_HE_M203", 32];
crate1 addMagazineCargoGlobal ["CUP_1Rnd_HEDP_M203", 32];
crate1 addMagazineCargoGlobal ["CUP_HandGrenade_M67", 40];
crate1 addWeaponCargoGlobal ["CUP_launch_M72A6", 20];
crate1 addWeaponCargoGlobal ["CUP_launch_NLAW", 8];
crate1 addWeaponCargoGlobal ["CUP_launch_FIM92Stinger", 6];
crate1 addWeaponCargoGlobal ["CUP_launch_Javelin", 2];
crate1 addMagazineCargoGlobal ["CUP_Javelin_M", 6];
crate1 addItemCargoGlobal ["ItemRadio", 20];
crate1 addItemCargoGlobal ["ChemicalDetector_01_watch_F", 10];
crate1 addItemCargoGlobal ["CUP_optic_CompM2_low", 20];
crate1 addItemCargoGlobal ["CUP_optic_ACOG2", 10];
crate1 addItemCargoGlobal ["CUP_optic_LeupoldMk4", 6];
crate1 addItemCargoGlobal ["CUP_optic_ElcanM145", 8];
crate1 addItemCargoGlobal ["CUP_optic_AN_PVS_4_M14", 2];
crate1 addItemCargoGlobal ["CUP_bipod_Harris_1A2_L_BLK", 10];
crate1 addItemCargoGlobal ["CUP_NVG_PVS14", 15];
crate1 addItemCargoGlobal ["CUP_Vector21Nite", 10];
crate1 addItemCargoGlobal ["CUP_LRTV", 5];
crate1 addItemCargoGlobal ["CUP_V_CPC_Fastbelt_rngr", 20];
crate1 addItemCargoGlobal ["G_AirPurifyingRespirator_01_F", 20];
crate1 addItemCargoGlobal ["FirstAidKit", 25];
crate1 addItemCargoGlobal ["Medikit", 8];
crate1 addItemCargoGlobal ["ToolKit", 8];
crate1 addItemCargoGlobal ["I_UavTerminal", 2];
crate1 addBackpackCargoGlobal ["I_UAV_01_backpack_F", 2];
publicVariable "crate1";

waitUntil {sleep 10; crate1 distance flagX < 50};
["NATOSeaTask", "SUCCEEDED"] call BIS_fnc_taskSetState;
[0,5000] remoteExec ["A3A_fnc_resourcesFIA",2];

{ [30, _x] call A3A_fnc_playerScoreAdd } forEach (call BIS_fnc_listPlayers) select { side _x == teamPlayer || side _x == civilian};
[20, theBoss] call A3A_fnc_playerScoreAdd;

deleteVehicle signalFire;

sleep 300;

["NATOSeaTask"] call BIS_fnc_deleteTask;
