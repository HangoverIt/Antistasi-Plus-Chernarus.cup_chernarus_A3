if (!isServer and hasInterface) exitWith{};
if (EEMissionCompleted == true || EEMissionFailed == true) exitWith{};

waitUntil { sleep 60; (date isEqualTo [2022,8,8,14,04] or EEMissionStarted == true) };

[[teamPlayer,civilian], "tsk1", ["A former CDF explosives specialist who served with distinction during the invasion is to undergo a sham court-martial by the new puppet state in his hometown of Berezino. He is being moved from Krasnostav airbase to Berezino police station at 14:30 today. Rescue this valiant soldier, he would be an asset to our cause.", "Rescue Explosives Specialist", ""], [11978.7,9183.25,0],"CREATED",-1,true,"run",true] call BIS_fnc_taskCreate;

EEMissionStarted = true;
publicVariable "EEMissionStarted";

waitUntil { sleep 60; (date isEqualTo [2022,8,8,14,29]) };

vehcF = "CUP_LADA_LM_CIV" createVehicle [11839.4,12361.1,0];
vehcB = "CUP_LADA_LM_CIV" createVehicle [11842,12368.1,0];
publicVariable "vehcB";
vehcF setDir 200;
vehcB setDir 200;

polgrp = createGroup blufor;
	pol1 = [polgrp, policeOfficer, [0, 0, 0], [], 0, "FORM"] call A3A_fnc_createUnit; 
	pol2 = [polgrp, policeGrunt, [0, 0, 0], [], 0, "FORM"] call A3A_fnc_createUnit; 
	pol3 = [polgrp, policeGrunt, [0, 0, 0], [], 0, "FORM"] call A3A_fnc_createUnit; 
	pol4 = [polgrp, policeGrunt, [0, 0, 0], [], 0, "FORM"] call A3A_fnc_createUnit; 
	pol5 = [polgrp, policeGrunt, [0, 0, 0], [], 0, "FORM"] call A3A_fnc_createUnit; 
	pol6 = [polgrp, policeGrunt, [0, 0, 0], [], 0, "FORM"] call A3A_fnc_createUnit; 
	pol7 = [polgrp, policeGrunt, [0, 0, 0], [], 0, "FORM"] call A3A_fnc_createUnit; 

		{
		[_x] call A3A_fnc_NATOinit;
		} forEach units polgrp;

_grp2 = createGroup independent;
	prisoner = [_grp2, "I_E_Soldier_Exp_F", [0, 0, 0], [], 0, "FORM"] call A3A_fnc_createUnit;
	publicVariable "prisoner";
	prisoner setUnitLoadout (getUnitLoadout prisoner_Outfit);
	prisoner addEventHandler ["HandleDamage", A3A_fnc_handleDamageAAF];

prisoner setCaptive true;
prisoner disableAI "MOVE";
prisoner disableAI "AUTOTARGET";
prisoner disableAI "TARGET";
prisoner setBehaviour "CARELESS";
prisoner allowFleeing 0;

prisoner addMPEventHandler ["Killed", {["tsk1", "FAILED"] call BIS_fnc_taskSetState; EEMissionFailed = true; publicVariable "EEMissionFailed";
}];

pol1 moveInDriver vehcF;
pol2 moveInCargo vehcF;
pol3 moveInCargo vehcF;
pol4 moveInCargo vehcF;

pol5 moveInDriver vehcB;
pol6 moveInCargo vehcB;
pol7 moveInCargo vehcB;
prisoner moveInCargo vehcB;

prisonerMarker = true;
publicVariable "prisonerMarker";

ExecVM "JB_Missions\Explosives_Expert\Marker.sqf";

polgrp setFormation "FILE";
_wp1 = polgrp addWaypoint [[10434.9,9860.96,0], 0];
_wp1 setWaypointType "MOVE";

_wp2 = polgrp addWaypoint [[11978.7,9183.25,0], 0];
_wp2 setWaypointType "GETOUT";

	trgFail = createTrigger ["EmptyDetector", [11978.7,9183.25,0]];
	trgFail setTriggerArea [100, 100, -1, false];
	trgFail setTriggerActivation ["ANY", "PRESENT", false];
	trgFail setTriggerStatements ["this && prisoner in thisList", "['tsk1', 'FAILED'] call BIS_fnc_taskSetState; EEMissionFailed = true; publicVariable 'EEMissionFailed';", ""];
	publicVariable "trgFail";

[
	vehcB,											// Object the action is attached to
	"Free Prisoner",										// Title of the action
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unbind_ca.paa",	// Idle icon shown on screen
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unbind_ca.paa",	// Progress icon shown on screen
	"alive prisoner && _this distance _target < 3",						// Condition for the action to be shown
	"alive prisoner && _caller distance _target < 3",						// Condition for the action to progress
	{},													// Code executed when action starts
	{},													// Code executed on every progress tick
	{ 	_this params ["_target", "", "_id"];
		deleteVehicle trgFail;
		prisoner setCaptive false;
		prisoner enableAI "MOVE";
		prisoner enableAI "AUTOTARGET";
		prisoner enableAI "TARGET";
		prisoner setBehaviour "AWARE";
		prisoner allowFleeing 1;
		prisonerMarker = false;
		publicVariable "prisonerMarker";
		[_target, _id] remoteExecCall ["BIS_fnc_holdActionRemove", 0, _target];
		
		doGetOut prisoner;
		
		sleep 2;
		
		[prisoner] join _caller;
		[prisoner,"Thank you for rescuing me from these despicable collaborators, I owe you. I smuggled out a small quantity of weapons and explosives after the invasion which I have hidden on my property, they may be useful to the resistance. They are buried under a water tank next to the house."] remoteExec ["globalChat",0];		
		
		sleep 4;
		
		"JB_Missions\Explosives_Expert\ExplosivesExpert2.sqf" remoteExec ["execVM",2];
		},												// Code executed on completion
	{},													// Code executed on interrupted
	[],													// Arguments passed to the scripts as _this select 3
	5,													// Action duration in seconds
	1000,													// Priority
	true,												// Remove on completion
	false												// Show in unconscious state
] remoteExec ["BIS_fnc_holdActionAdd", 0, vehcB];	// MP compatible implementation

ExecVM "JB_Missions\Explosives_Expert\DetectEnemy.sqf";

waitUntil {sleep 10; prisoner distance flagX < 50};
["tsk1", "SUCCEEDED"] call BIS_fnc_taskSetState;
[Occupants, 15, 90] remoteExec ["A3A_fnc_addAggression", 2];

{ [30, _x] call A3A_fnc_playerScoreAdd } forEach (call BIS_fnc_listPlayers) select { side _x == teamPlayer || side _x == civilian};
[20, theBoss] call A3A_fnc_playerScoreAdd;

[prisoner] join grpNull;
doGetOut prisoner;
prisoner doMove (position petrovsky);

EEMissionCompleted = true;
publicVariable "EEMissionCompleted";

ExecVM "JB_Missions\Explosives_Expert\IEDMaker.sqf";

titleText ["<t color='#ffffff' size='1.4'>Now that the explosives specialist has joined our resistance, he can make IEDs for us.", "PLAIN DOWN", -1, true, true];

sleep 8;

titleText ["<t color='#ffffff' size='1.4'>One large and one small IEDs will be added to the inventory of the arsenal box every few hours during the day.", "PLAIN DOWN", -1, true, true];

sleep 600;

{boxX addWeaponCargoGlobal [_x,1];
		} forEach (weapons prisoner);

{boxX addMagazineCargoGlobal [_x,1];
		} forEach (magazines prisoner);

deleteVehicle prisoner;
["tsk1"] call BIS_fnc_deleteTask;
