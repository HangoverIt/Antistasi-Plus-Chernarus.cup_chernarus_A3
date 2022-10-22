if (!isServer and hasInterface) exitWith{};
if (T34MissionCompleted == true) exitWith{};

waitUntil { sleep 60; (date isEqualTo [2022,8,9,18,15] or T34MissionStarted == true) };

[[teamPlayer,civilian], "captureTank", ["An informer has told us that a working T34 tank, which last saw action with NAPA in the 2009 civil war against the Chedaki, is to be scrapped tomorrow by the Russians. Although old and outclassed by modern armour, it symbolised the courage of NAPA against overwhelming odds, and stood proudly on display after the war at the Novodmitrovsk factory where it was built 80 years ago. The Russians are destroying it as a symbol of their oppression, we cannot allow this to happen!", "Capture T34 Tank", ""], [],"CREATED",-1,true,"default",true] call BIS_fnc_taskCreate;

T34MissionStarted = true;
publicVariable "T34MissionStarted";

T34Captured = false;
publicVariable "T34Captured";

waitUntil {sleep 4; true};

[[teamPlayer,civilian], ["captureTank_1", "captureTank"], ["The T34 is in a smelting room at the factory, preparing to be dismantled. If you do not capture it by 08:00 tomorrow morning it will be too late.", "T34 Tank", ""], [12249.3,14267.5,0.195374],"CREATED",-1,true,"default",true] call BIS_fnc_taskCreate;

waitUntil {sleep 4; true};

[[teamPlayer,civilian], ["captureTank_2", "captureTank"], ["The informer has told us that the T34 has no ammo or fuel. The remaining supply of these have been transported to Svetloyarsk port to be shipped up the coast to Russia. You will need to capture them and take them to the tank to rearm and refuel it.", "T34 Supplies", ""], [14178,13337.4,0],"CREATED",-1,true,"rearm",true] call BIS_fnc_taskCreate;

tankT34 = "CUP_I_T34_NAPA" createVehicle [12250.8,14264.3,0];
tankT34 setFuel 0;
tankT34 setVehicleAmmo 0;
tankT34 setDamage 0.5;
tankT34 setDir 120;
publicVariable "tankT34";

T34Ammo = "Box_EAF_AmmoVeh_F" createVehicle [14175.5,13337,0];
T34Ammo setDir 188;
T34Ammo call A3A_fnc_logistics_addLoadAction;
T34Ammo allowDamage false;
publicVariable "T34Ammo";

T34Fuel = "CargoNet_01_barrels_F" createVehicle [14177.6,13336.7,0];
T34Fuel setDir 188;
T34Fuel call A3A_fnc_logistics_addLoadAction;
publicVariable "T34Fuel";

	_trgT34Supplies = createTrigger ["EmptyDetector", [14176.6,13336.8,0], true];
	_trgT34Supplies setTriggerArea [15, 10, -1, false];
	_trgT34Supplies triggerAttachVehicle [T34Fuel];
	_trgT34Supplies setTriggerActivation ["VEHICLE", "NOT PRESENT", false];
	_trgT34Supplies setTriggerStatements ["this", "['captureTank_2', 'SUCCEEDED'] call BIS_fnc_taskSetState;", ""];
	
	_trgT34 = createTrigger ["EmptyDetector", [12250.8,14266.3,0], true];
	_trgT34 setTriggerArea [50, 20, -1, false];
	_trgT34 triggerAttachVehicle [tankT34];
	_trgT34 setTriggerActivation ["VEHICLE", "NOT PRESENT", false];
	_trgT34 setTriggerStatements ["this",
		"_APC1 = 'CUP_O_BRDM2_RUS' createVehicle [13012.1,14061.2,0];
		_APC1 setDir 270;
		_grpAPC1 = createGroup opfor;
		_crew1 = [_grpAPC1, 'CUP_O_RU_Crew', [0, 0, 0], [], 0, 'FORM'] call A3A_fnc_createUnit;
		_crew2 = [_grpAPC1, 'CUP_O_RU_Crew', [0, 0, 0], [], 0, 'FORM'] call A3A_fnc_createUnit;
		_crew1 moveInDriver _APC1;
		_crew2 moveInGunner _APC1;
		_wp1 = _grpAPC1 addWaypoint [[12358.9,14373.6,0], 0];
		_wp1 setWaypointType 'MOVE';
		
		_APC2 = 'CUP_O_BRDM2_RUS' createVehicle [11210.3,14302.9,0];
		_APC2 setDir 90;
		_grpAPC2 = createGroup opfor;
		_crew3 = [_grpAPC2, 'CUP_O_RU_Crew', [0, 0, 0], [], 0, 'FORM'] call A3A_fnc_createUnit;
		_crew4 = [_grpAPC2, 'CUP_O_RU_Crew', [0, 0, 0], [], 0, 'FORM'] call A3A_fnc_createUnit;
		_crew3 moveInDriver _APC2;
		_crew4 moveInGunner _APC2;
		_wp2 = _grpAPC2 addWaypoint [[12358.9,14373.6,0], 0];
		_wp2 setWaypointType 'MOVE';
		
		T34Captured = true; publicVariable 'T34Captured';", ""];

[
	tankT34,															// Object the action is attached to
	"Rearm T34",														// Title of the action
	"\a3\missions_f_oldman\data\img\holdactions\holdAction_box_ca.paa",	// Idle icon shown on screen
	"\a3\missions_f_oldman\data\img\holdactions\holdAction_box_ca.paa",	// Progress icon shown on screen
	"_this distance _target < 5 && T34Ammo distance _target < 10",		// Condition for the action to be shown
	"_caller distance _target < 5 && T34Ammo distance _target < 10",	// Condition for the action to progress
	{},																	// Code executed when action starts
	{},																	// Code executed on every progress tick
	{ 	 [_this, 1] remoteExec ["setVehicleAmmoDef", 0]	},									// Code executed on completion
	{},																	// Code executed on interrupted
	[],																	// Arguments passed to the scripts as _this select 3
	8,																	// Action duration in seconds
	999,																	// Priority
	true,																// Remove on completion
	false																// Show in unconscious state
] remoteExec ["BIS_fnc_holdActionAdd", 0, tankT34];						// MP compatible implementation

[
	tankT34,															// Object the action is attached to
	"Refuel T34",														// Title of the action
	"\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\refuel_ca.paa",			// Idle icon shown on screen
	"\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\refuel_ca.paa",			// Progress icon shown on screen
	"_this distance _target < 5 && T34Fuel distance _target < 10",		// Condition for the action to be shown
	"_caller distance _target < 5 && T34Fuel distance _target < 10",	// Condition for the action to progress
	{},																	// Code executed when action starts
	{},																	// Code executed on every progress tick
	{ 	[_this, 1] remoteExec ["setFuel", 0]	},											// Code executed on completion
	{},																	// Code executed on interrupted
	[],																	// Arguments passed to the scripts as _this select 3
	8,																	// Action duration in seconds
	1000,																	// Priority
	true,																// Remove on completion
	false																// Show in unconscious state
] remoteExec ["BIS_fnc_holdActionAdd", 0, tankT34];						// MP compatible implementation

_grp1 = createGroup Opfor;
	_unit1 = [_grp1, "loadouts_inv_militia_Engineer", [12248.5,14269.2,0.187647], [], 0, "FORM"] call A3A_fnc_createUnit;
	_unit1 setDir 276;
	
_grp2 = createGroup Opfor;	
	_unit2 = [_grp2, "loadouts_inv_militia_Engineer", [12259.1,14265.8,8.02633], [], 0, "FORM"] call A3A_fnc_createUnit;
	_unit2 setDir 276;
	
_grp3 = createGroup Opfor;	
	_unit3 = [_grp3, "loadouts_inv_militia_Rifleman", [12261.3,14267.5,2.21376], [], 0, "FORM"] call A3A_fnc_createUnit;
	_unit3 setDir 276;

{
[_x] call A3A_fnc_NATOinit;
} forEach [_unit1,_unit2,_unit3];

tankT34 addMPEventHandler ["MPKilled", {
	["captureTank_1", "FAILED"] call BIS_fnc_taskSetState;
	["captureTank", "FAILED"] call BIS_fnc_taskSetState;
	deleteVehicle _trgT34Supplies;
	deleteVehicle _trgT34;
	T34MissionCompleted = true;
	publicVariable "T34MissionCompleted";
	}];

waitUntil { sleep 10; 
		(T34Captured == true) || (date isEqualTo [2022,8,10,08,06])
	};

switch(true) do {
    case((date isEqualTo [2022,8,10,08,06])): {

        ["captureTank_1", "FAILED"] call BIS_fnc_taskSetState;
        ["captureTank_2", "FAILED"] call BIS_fnc_taskSetState;
		["captureTank", "FAILED"] call BIS_fnc_taskSetState;
		deleteVehicle tankT34;
		deleteVehicle _trgT34Supplies;
		deleteVehicle _trgT34;
		T34MissionCompleted = true;
		publicVariable "T34MissionCompleted";

		sleep 300;
	
		["captureTank_1"] call BIS_fnc_deleteTask;
        ["captureTank_2"] call BIS_fnc_deleteTask;
		["captureTank"] call BIS_fnc_deleteTask;
	
		};

	case((T34Captured == true)): {

		T34MissionCompleted = true;
		publicVariable "T34MissionCompleted";
		waitUntil {sleep 10; tankT34 distance flagX < 50};
		["captureTank_1", "SUCCEEDED"] call BIS_fnc_taskSetState;
		["captureTank", "SUCCEEDED"] call BIS_fnc_taskSetState;
		tankT34 removeAllMPEventHandlers "MPKilled";

		[Invaders, 40, 120] remoteExec ["A3A_fnc_addAggression", 2];

		{ [100, _x] call A3A_fnc_playerScoreAdd } forEach (call BIS_fnc_listPlayers) select { side _x == teamPlayer || side _x == civilian};
		[50, theBoss] call A3A_fnc_playerScoreAdd;	
	
		deleteVehicle _trgT34Supplies;
		deleteVehicle _trgT34;

		sleep 300;
	
		["captureTank_1"] call BIS_fnc_deleteTask;
        ["captureTank_2"] call BIS_fnc_deleteTask;
		["captureTank"] call BIS_fnc_deleteTask;
	};
};
