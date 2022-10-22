if (!isServer and hasInterface) exitWith{};

[[Independent,civilian], "tsk2", ["Retrieve the hidden weapons from the explosives specialist's house.", "Retrieve Weapons", ""], [12087.1,9012.81,0],"CREATED",-1,true,"rifle",true] call BIS_fnc_taskCreate;
		
		crateCDF = "Box_EAF_Wps_F" createVehicle [13859.1,2931.35,0];
		crateCDF setDir 314;
		crateCDF call A3A_fnc_logistics_addLoadAction;
		clearWeaponCargoGlobal crateCDF;
		clearMagazineCargoGlobal crateCDF;
		clearItemCargoGlobal crateCDF;
		clearBackpackCargoGlobal crateCDF;
		publicVariable "crateCDF";

		crateCDF addWeaponCargoGlobal ["CUP_arifle_AK74_Early", 12];
		crateCDF addWeaponCargoGlobal ["CUP_arifle_RPK74_45", 5];
		crateCDF addMagazineCargoGlobal ["CUP_30Rnd_545x39_AK_M", 50];
		crateCDF addMagazineCargoGlobal ["CUP_45Rnd_TE4_LRT4_Green_Tracer_545x39_RPK_M", 20];
		
		crateExp = "CUP_BOX_CDF_AmmoOrd_F" createVehicle [13855.4,2913.93,0];
		crateExp setDir 314;
		crateExp call A3A_fnc_logistics_addLoadAction;
		clearWeaponCargoGlobal crateExp;
		clearMagazineCargoGlobal crateExp;
		clearItemCargoGlobal crateExp;
		clearBackpackCargoGlobal crateExp;

		crateExp addItemCargoGlobal ["SatchelCharge_Remote_Mag", 4];
		crateExp addItemCargoGlobal ["DemoCharge_Remote_Mag", 4];
		crateExp addItemCargoGlobal ["APERSMine_Range_Mag", 6];
		crateExp addItemCargoGlobal ["CUP_MineE_M", 6];
		crateExp addMagazineCargoGlobal ["CUP_HandGrenade_RGD5", 12];

		publicVariable "crateExp";
		
		vehPol = "CUP_C_S1203_Militia_CIV" createVehicle [11972.2,9193.75,0];
		vehPol setDir 173;
		grp11 = createGroup blufor;
			_unit11 = [grp11, policeOfficer, [0, 0, 0], [], 0, "FORM"] call A3A_fnc_createUnit;
			_unit12 = [grp11, policeGrunt, [0, 0, 0], [], 0, "FORM"] call A3A_fnc_createUnit;
			_unit13 = [grp11, policeGrunt, [0, 0, 0], [], 0, "FORM"] call A3A_fnc_createUnit;
			_unit14 = [grp11, policeGrunt, [0, 0, 0], [], 0, "FORM"] call A3A_fnc_createUnit;
			_unit15 = [grp11, policeGrunt, [0, 0, 0], [], 0, "FORM"] call A3A_fnc_createUnit;
			_unit16 = [grp11, policeGrunt, [0, 0, 0], [], 0, "FORM"] call A3A_fnc_createUnit;
			
			{
			[_x] call A3A_fnc_NATOinit;
			} forEach units grp11;			
			
			_unit11 moveInDriver vehPol;
			_unit12 moveInCargo vehPol;
			_unit13 moveInCargo vehPol;
			_unit14 moveInCargo vehPol;
			_unit15 moveInCargo vehPol;
			_unit16 moveInCargo vehPol;
			
			_wp11 = grp11 addWaypoint [getPos vehPol, 0];
			_wp11 setWaypointType "HOLD";
			
			_wp12 = grp11 addWaypoint [[12038,9099.13,0], 0];
			_wp12 setWaypointType "MOVE";
			_wp12 setWaypointStatements ["true", "[vehPol,'CustomSoundController1',1,0.2] remoteExec ['BIS_fnc_setCustomSoundController']"];
		
			_wp13 = grp11 addWaypoint [[12038.2,9031.2,0], 0];
			_wp13 setWaypointType "GETOUT";
		
			_wp14 = grp11 addWaypoint [[12083.3,9001.77,0], 0];
			_wp14 setWaypointType "MOVE";
	
	trgPol = createTrigger ["EmptyDetector", [12086.4,9009.9,0]];
	trgPol setTriggerArea [10, 10, -1, false];
	trgPol setTriggerActivation ["ANYPLAYER", "PRESENT", false];
	trgPol setTriggerStatements ["this", "grp11 setCurrentWaypoint [grp11, 2]", ""];
		
		[
	waterTank,											// Object the action is attached to
	"Retrieve Weapons",										// Title of the action
	"\a3\data_f_destroyer\data\UI\IGUI\Cfg\holdactions\holdAction_unloadVehicle_ca.paa",	// Idle icon shown on screen
	"\a3\data_f_destroyer\data\UI\IGUI\Cfg\holdactions\holdAction_unloadVehicle_ca.paa",	// Progress icon shown on screen
	"_this distance _target < 5",						// Condition for the action to be shown
	"_caller distance _target < 5",						// Condition for the action to progress
	{},													// Code executed when action starts
	{},													// Code executed on every progress tick
	{ 	
		crateCDF setpos [12082.8,9003.37,0];
			
			sleep 2;
			
		crateExp setpos [12081.9,9004.3,0];
	},												// Code executed on completion
	{},													// Code executed on interrupted
	[],													// Arguments passed to the scripts as _this select 3
	10,													// Action duration in seconds
	1000,													// Priority
	true,												// Remove on completion
	false												// Show in unconscious state
] remoteExec ["BIS_fnc_holdActionAdd", 0, waterTank];	// MP compatible implementation

waitUntil {sleep 10; crateCDF distance flagX < 50 && crateEXP distance flagX < 50 };
["tsk2", "SUCCEEDED"] call BIS_fnc_taskSetState;

deleteVehicle trgPol;

sleep 300;

["tsk2"] call BIS_fnc_deleteTask;