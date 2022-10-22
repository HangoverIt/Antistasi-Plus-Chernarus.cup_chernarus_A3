if (!isServer and hasInterface) exitWith{};
if (NATOSeaMissionCompleted == true) exitWith{};

waitUntil { sleep 60; (date isEqualTo [2022,8,8,21,00] or NATOSeaMissionStarted == true) };

[[teamPlayer,civilian], "NATOSeaTask", ["NATO have become aware of our resistance and want to assist us. They have arranged to covertly drop off some weapons and supplies by sea at a small peninsula south of Svetloyarsk. They will be on station between 01:00 and 03:00. Light a fire on the beach, they will see the signal and drop off the supplies. A Russian military outpost is not far from the rendevouz point, be on the look out for patrols.", "Collect NATO supplies", ""], [14076.5,11376.0,0],"CREATED",-1,true,"box",true] call BIS_fnc_taskCreate;

NATOSeaMissionStarted = true;
publicVariable "NATOSeaMissionStarted";

    waitUntil { sleep 60; (date isEqualTo [2022,8,9,00,55]) };
	signalFire = "Land_Campfire_F" createVehicle [14076.5,11376.0,0];
	
	waitUntil { sleep 10; 
		(inflamed signalFire) || (date isEqualTo [2022,8,9,03,10])
	};

switch(true) do {
    case((date isEqualTo [2022,8,9,03,10])): {

        ["NATOSeaTask", "FAILED"] call BIS_fnc_taskSetState;
        NATOSeaMissionCompleted = true;
		publicVariable "NATOSeaMissionCompleted";
		deleteVehicle signalFire;
		
		sleep 300;
		
		["NATOSeaTask"] call BIS_fnc_deleteTask;
    };

	case((inflamed signalFire)): {

NATOSeaMissionCompleted = true;
publicVariable "NATOSeaMissionCompleted";

crewSub = createGroup Independent;

_sub = [[14099.4,11019.8,-5], 0, "I_SDV_01_F", crewSub] call bis_fnc_spawnvehicle;

(_sub select 0) setVehicleVarName "sub";
_sub call compile format ["%1=_this select 0","sub"];
sub allowDamage false;
sub setObjectTextureGlobal [0, "a3\boat_f_beta\sdv_01\data\sdv_ext_co.paa"];
publicVariable "sub";
sub setVehicleLock "LOCKEDPLAYER";
	
	(driver sub) allowDamage false;
	(driver sub) setSkill 1;
	(driver sub) setUnitLoadout (getUnitLoadout NATO_Diver_1);
	[(driver sub), "Male03_F"] remoteExec ["setSpeaker"];
	[(driver sub), "LIEUTENANT"] remoteExec ["setRank"];
	[(driver sub), "James Knox"] remoteExec ["setName"];
	
	(gunner sub) allowDamage false;
	(gunner sub) setSkill 1;
	(gunner sub) setUnitLoadout (getUnitLoadout NATO_Diver_1);
	[(gunner sub), "Male05_F"] remoteExec ["setSpeaker"];
	[(gunner sub), "SERGEANT"] remoteExec ["setRank"];
	[(gunner sub), "Ben Cavill"] remoteExec ["setName"];

//Create Russian Patrol

	private _squads = [Invaders, "SQUAD"] call SCRT_fnc_unit_getGroupSet;
	grpRus = [[13878.1,11290.1,0],Invaders, (selectRandom _squads)] call A3A_fnc_spawnGroup;

	{
	[_x] call A3A_fnc_NATOinit;
	} forEach units grpRus;	

["JB_Missions\NATO_Sea_Mission\UndercoverOff.sqf"] remoteExec ["execVM",0];

_Cwp1 = grpRus addWaypoint [[13930,11291.8,0], 0];
_Cwp1 setWaypointType "HOLD";
_Cwp1 setWaypointSpeed "NORMAL";

_Cwp2 = grpRus addWaypoint [[13985,11333.4,0], 0];
_Cwp2 setWaypointType "MOVE";
_Cwp2 setWaypointSpeed "NORMAL";

_Cwp3 = grpRus addWaypoint [[14070.2,11375.6,0], 0];
_Cwp3 setWaypointType "MOVE";
_Cwp3 setWaypointSpeed "FULL";

//Sub waypoints;

_wp0 = crewSub addWaypoint [[14099.4,11019.8,0], 0];
_wp0 setWaypointType "MOVE";
_wp0 setWaypointSpeed "FULL";
_wp0 setWaypointStatements ["true", "(driver sub) swimInDepth -5"];

_wp1 = crewSub addWaypoint [[14098.3,11305.9,0], 0];
_wp1 setWaypointType "MOVE";
_wp1 setWaypointSpeed "FULL";
_wp1 setWaypointStatements ["true", "(driver sub) swimInDepth -1"];

_wp2 = crewSub addWaypoint [[14101.0,11372.5,0], 0];
_wp2 setWaypointType "GETOUT";
_wp2 setWaypointSpeed "FULL";
_wp2 setWaypointStatements ["true", "grpRus setCurrentWaypoint [grpRus, 2]"];

_wp3 = crewSub addWaypoint [[14078,11379.7,0], 0];
_wp3 setWaypointType "MOVE";
_wp3 setWaypointSpeed "FULL";
_wp3 setWaypointStatements ["true", "['JB_Missions\NATO_Sea_Mission\SpawnNATOCrate.sqf'] remoteExec ['execVM',2];"];

_wp4 = crewSub addWaypoint [[14078,11379.7,0], 0];
_wp4 setWaypointType "MOVE";
_wp4 setWaypointSpeed "FULL";
_wp4 setWaypointTimeout [60, 60, 60];

_wp5 = crewSub addWaypoint [[14101.0,11372.5,0], 0];
_wp5 setWaypointType "GETIN";
_wp5 setWaypointSpeed "FULL";
_wp5 setWaypointStatements ["true", "{_x disableAI 'AUTOTARGET'; _x disableAI 'TARGET'} forEach (units crewSub); crewSub setBehaviour 'CARELESS'"];

_wp6 = crewSub addWaypoint [[14199.5,11550.8,0], 0];
_wp6 setWaypointType "MOVE";
_wp6 setWaypointSpeed "FULL";
_wp6 setWaypointStatements ["true", "(driver sub) swimInDepth -5"];

_wp7 = crewSub addWaypoint [[14399.6,11601,0], 0];
_wp7 setWaypointType "MOVE";
_wp7 setWaypointSpeed "FULL";
_wp7 setWaypointStatements ["true", "{ deleteVehicle _x } forEach (crew sub); deleteVehicle sub;"];

	};
};
