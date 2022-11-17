diag_log format ["%1: [Antistasi] | INFO | loadServer Starting.",servertime];
if (isServer) then {
	diag_log format ["%1: [Antistasi] | INFO | Starting Persistent Load.",servertime];
	petrovsky allowdamage false;

	A3A_saveVersion = 0;
	["version"] call A3A_fnc_getStatVariable;
	["savedPlayers"] call A3A_fnc_getStatVariable;
	["watchpostsFIA"] call A3A_fnc_getStatVariable; publicVariable "watchpostsFIA";
	["roadblocksFIA"] call A3A_fnc_getStatVariable; publicVariable "roadblocksFIA";
	["aapostsFIA"] call A3A_fnc_getStatVariable; publicVariable "aapostsFIA";
	["mortarpostsFIA"] call A3A_fnc_getStatVariable; publicVariable "mortarpostsFIA";
	["hmgpostsFIA"] call A3A_fnc_getStatVariable; publicVariable "hmgpostsFIA";
	["atpostsFIA"] call A3A_fnc_getStatVariable; publicVariable "atpostsFIA";
	["mrkSDK"] call A3A_fnc_getStatVariable;
	["mrkCSAT"] call A3A_fnc_getStatVariable;
	["destroyedSites"] call A3A_fnc_getStatVariable;
	["minesX"] call A3A_fnc_getStatVariable;
	["attackCountdownOccupants"] call A3A_fnc_getStatVariable;
    ["attackCountdownInvaders"] call A3A_fnc_getStatVariable;
	["antennas"] call A3A_fnc_getStatVariable;
	["hr"] call A3A_fnc_getStatVariable;
	["dateX"] call A3A_fnc_getStatVariable;
    ["DateSinceLastMineCheck"] call A3A_fnc_getStatVariable; publicVariable "DateSinceLastMineCheck";    
	["weather"] call A3A_fnc_getStatVariable;
	["prestigeOPFOR"] call A3A_fnc_getStatVariable;
	["prestigeBLUFOR"] call A3A_fnc_getStatVariable;
	["resourcesFIA"] call A3A_fnc_getStatVariable;
	["garrison"] call A3A_fnc_getStatVariable;
	["usesWurzelGarrison"] call A3A_fnc_getStatVariable;
	["skillFIA"] call A3A_fnc_getStatVariable;
	["maxConstructions"] call A3A_fnc_getStatVariable;
	["membersX"] call A3A_fnc_getStatVariable;
	["vehInGarage"] call A3A_fnc_getStatVariable;
    ["HR_Garage"] call A3A_fnc_getStatVariable;
	["destroyedBuildings"] call A3A_fnc_getStatVariable;
	["idlebases"] call A3A_fnc_getStatVariable;
	["idleassets"] call A3A_fnc_getStatVariable;
	["killZones"] call A3A_fnc_getStatVariable;
	["controlsSDK"] call A3A_fnc_getStatVariable;
	["bombRuns"] call A3A_fnc_getStatVariable;
	["supportPoints"] call A3A_fnc_getStatVariable;
	waitUntil {!isNil "arsenalInit"};
	["jna_dataList"] call A3A_fnc_getStatVariable;
	["isTraderQuestCompleted"] call A3A_fnc_getStatVariable;
	["traderPosition"] call A3A_fnc_getStatVariable;
	["traderDiscount"] call A3A_fnc_getStatVariable;
	["areOccupantsDefeated"] call A3A_fnc_getStatVariable;
	["areInvadersDefeated"] call A3A_fnc_getStatVariable;
	["rebelLoadouts"] call A3A_fnc_getStatVariable;
	["randomizeRebelLoadoutUniforms"] call A3A_fnc_getStatVariable;

	["boxXWeapons"] call A3A_fnc_getStatVariable;
	["boxXMagazines"] call A3A_fnc_getStatVariable;
	["boxXItems"] call A3A_fnc_getStatVariable;
	["boxXBackpacks"] call A3A_fnc_getStatVariable;
	
	["introDone"] call A3A_fnc_getStatVariable;
	publicVariable "introDone";
	
	["EEMissionStarted"] call A3A_fnc_getStatVariable;
	["EEMissionFailed"] call A3A_fnc_getStatVariable;
	["EEMissionCompleted"] call A3A_fnc_getStatVariable;
	["NATOSeaMissionStarted"] call A3A_fnc_getStatVariable;
	["NATOSeaMissionCompleted"] call A3A_fnc_getStatVariable;
	["T34MissionStarted"] call A3A_fnc_getStatVariable;
	["T34MissionCompleted"] call A3A_fnc_getStatVariable;
	["radar1Destroyed"] call A3A_fnc_getStatVariable;
	["radar2Destroyed"] call A3A_fnc_getStatVariable;
	
	["garrisonLoadouts"] call A3A_fnc_getStatVariable;

	//===========================================================================
	#include "\A3\Ui_f\hpp\defineResinclDesign.inc"

	//RESTORE THE STATE OF THE 'UNLOCKED' VARIABLES USING JNA_DATALIST
	{
		private _arsenalTabDataArray = _x;
		private _unlockedItemsInTab = _arsenalTabDataArray select { _x select 1 == -1 } apply { _x select 0 };
		{
			[_x, true] call A3A_fnc_unlockEquipment;
		} forEach _unlockedItemsInTab;
	} forEach jna_dataList;

	if !(unlockedNVGs isEqualTo []) then {
		haveNV = true; publicVariable "haveNV"
	};

	//Check if we have radios unlocked and update haveRadio.
	call A3A_fnc_checkRadiosUnlocked;

	//Sort optics list so that snipers pick the right sight
	unlockedOptics = [unlockedOptics,[],{getNumber (configfile >> "CfgWeapons" >> _x >> "ItemInfo" >> "mass")},"DESCEND"] call BIS_fnc_sortBy;

	{
		if (sidesX getVariable [_x,sideUnknown] != teamPlayer) then {
			_positionX = getMarkerPos _x;
			_nearX = [(markersX - controlsX - watchpostsFIA - roadblocksFIA - aapostsFIA - atpostsFIA - mortarpostsFIA - hmgpostsFIA),_positionX] call BIS_fnc_nearestPosition;
			_sideX = sidesX getVariable [_nearX,sideUnknown];
			sidesX setVariable [_x,_sideX,true];
		};
	} forEach controlsX;


	{
		if (sidesX getVariable [_x,sideUnknown] == sideUnknown) then {
			sidesX setVariable [_x,Occupants,true];
		};
	} forEach markersX;

	{
		[_x] call A3A_fnc_mrkUpdate
	} forEach (markersX - controlsX);

	if (count watchpostsFIA > 0) then {
		markersX = markersX + watchpostsFIA;
		publicVariable "markersX";
	};

	if (count roadblocksFIA > 0) then {
		markersX = markersX + roadblocksFIA;
		publicVariable "markersX";
	};

	if (count aapostsFIA > 0) then {
		markersX = markersX + aapostsFIA;
		publicVariable "markersX";
	};

	if (count mortarpostsFIA > 0) then {
		markersX = markersX + mortarpostsFIA;
		publicVariable "markersX";
	};

	if (count atpostsFIA > 0) then {
		markersX = markersX + atpostsFIA;
		publicVariable "markersX";
	};

	if (count hmgpostsFIA > 0) then {
		markersX = markersX + hmgpostsFIA;
		publicVariable "markersX";
	};

	{
		if (_x in destroyedSites) then {
			sidesX setVariable [_x, Invaders, true];
			[_x] call A3A_fnc_destroyCity
		};
	} forEach citiesX;

    //Load aggro stacks and level and calculate current level
    ["aggressionOccupants"] call A3A_fnc_getStatVariable;
	["aggressionInvaders"] call A3A_fnc_getStatVariable;
    [true] call A3A_fnc_calculateAggression;

	["chopForest"] call A3A_fnc_getStatVariable;


	["posHQ"] call A3A_fnc_getStatVariable;
	["nextTick"] call A3A_fnc_getStatVariable;
	["staticsX"] call A3A_fnc_getStatVariable;
	["constructionsX"] call A3A_fnc_getStatVariable;

	{_x setPos getMarkerPos respawnTeamPlayer} forEach ((call A3A_fnc_playableUnits) select {side _x == teamPlayer});
	_sites = markersX select {sidesX getVariable [_x,sideUnknown] == teamPlayer};

	tierPreference = 1;
	publicVariable "tierPreference";

	// update war tier silently, calls updatePreference if changed
	[true] call A3A_fnc_tierCheck;

	if (isNil "usesWurzelGarrison") then {
		//Create the garrison new
		diag_log "No WurzelGarrison found, creating new!";
		[airportsX, "Airport", [0,0,0]] spawn A3A_fnc_createGarrison;	//New system
		[resourcesX, "Other", [0,0,0]] spawn A3A_fnc_createGarrison;	//New system
		[factories, "Other", [0,0,0]] spawn A3A_fnc_createGarrison;
		[outposts, "Outpost", [1,1,0]] spawn A3A_fnc_createGarrison;
		[milbases, "MilitaryBase", [0,0,0]] spawn A3A_fnc_createGarrison;
		[seaports, "Other", [1,0,0]] spawn A3A_fnc_createGarrison;

	} else {
		//Garrison save in wurzelformat, load it
		diag_log "WurzelGarrison found, loading it!";
		["wurzelGarrison"] call A3A_fnc_getStatVariable;
	};

	//JB limited weapons, load garrison loadouts
	private _loadoutMarker = [];
	private _loadout = [];

	_num = 0;
	{
		_loadoutMarker = ((garrisonLoadouts select _num) select 0);
		_loadout = ((garrisonLoadouts select _num) select 1);
		SDKgarrLoadouts setVariable [_loadoutMarker, _loadout, true];
		_num = _num + 1;
	} foreach garrisonLoadouts;

    //Load state of testing timer
    ["testingTimerIsActive"] call A3A_fnc_getStatVariable;

	clearMagazineCargoGlobal boxX;
	clearWeaponCargoGlobal boxX;
	clearItemCargoGlobal boxX;
	clearBackpackCargoGlobal boxX;
	
	{boxX addWeaponCargoGlobal [_x,1];
		} forEach boxXWeapons;

	{boxX addMagazineCargoGlobal [_x,1];
		} forEach boxXMagazines;

	{boxX addItemCargoGlobal [_x,1];
		} forEach boxXItems;

	{boxX addBackpackCargoGlobal [_x,1];
		} forEach boxXBackpacks;
	
	[] remoteExec ["A3A_fnc_statistics",[teamPlayer,civilian]];
	diag_log format ["%1: [Antistasi] | INFO | Persistent Load Completed.",servertime];
	diag_log format ["%1: [Antistasi] | INFO | Generating Map Markers.",servertime];
	["tasks"] call A3A_fnc_getStatVariable;
	if !(isMultiplayer) then {
		{//Can't we go around this using the initMarker? And only switching marker?
			_pos = getMarkerPos _x;
			_dmrk = createMarker [format ["Dum%1",_x], _pos];
			_dmrk setMarkerShape "ICON";
			[_x] call A3A_fnc_mrkUpdate;
			if (sidesX getVariable [_x,sideUnknown] != teamPlayer) then {
				_nul = [_x] call A3A_fnc_createControls;
			};
		} forEach airportsX;

		{
			_pos = getMarkerPos _x;
			_dmrk = createMarker [format ["Dum%1",_x], _pos];
			_dmrk setMarkerShape "ICON";
			_dmrk setMarkerType "loc_rock";
			_dmrk setMarkerText "Resources";
			[_x] call A3A_fnc_mrkUpdate;
			if (sidesX getVariable [_x,sideUnknown] != teamPlayer) then {
				_nul = [_x] call A3A_fnc_createControls;
			};
		} forEach resourcesX;

		{
			_pos = getMarkerPos _x;
			_dmrk = createMarker [format ["Dum%1",_x], _pos];
			_dmrk setMarkerShape "ICON";
			_dmrk setMarkerType "u_installation";
			_dmrk setMarkerText "Factory";
			[_x] call A3A_fnc_mrkUpdate;
			if (sidesX getVariable [_x,sideUnknown] != teamPlayer) then {
				_nul = [_x] call A3A_fnc_createControls;
			};
		} forEach factories;

		{
			_pos = getMarkerPos _x;
			_dmrk = createMarker [format ["Dum%1",_x], _pos];
			_dmrk setMarkerShape "ICON";
			_dmrk setMarkerType "loc_bunker";
			[_x] call A3A_fnc_mrkUpdate;
			if (sidesX getVariable [_x,sideUnknown] != teamPlayer) then {
				_nul = [_x] call A3A_fnc_createControls;
			};
		} forEach outposts;

		{
			_pos = getMarkerPos _x;
			_dmrk = createMarker [format ["Dum%1",_x], _pos];
			_dmrk setMarkerShape "ICON";
			_dmrk setMarkerType "b_naval";
			if (toLower worldName in ["enoch", "vn_khe_sanh"]) then {
				_dmrk setMarkerText "River Port";
			} else {
				_dmrk setMarkerText "Sea Port";
			};
			[_x] call A3A_fnc_mrkUpdate;
			if (sidesX getVariable [_x,sideUnknown] != teamPlayer) then {
				_nul = [_x] call A3A_fnc_createControls;
			};
		} forEach seaports;

		{
			_pos = getMarkerPos _x;
			_dmrk = createMarker [format ["Dum%1",_x], _pos];
			_dmrk setMarkerShape "ICON";
			_dmrk setMarkerType "b_hq";
			_dmrk setMarkerText "Military Base";
			[_x] call A3A_fnc_mrkUpdate;
			if (sidesX getVariable [_x,sideUnknown] != teamPlayer) then {
				_nul = [_x] call A3A_fnc_createControls;
			};
		} forEach milbases;
	};

	placementDone = true; publicVariable "placementDone";
	petrovsky allowdamage true;
};
diag_log format ["%1: [Antistasi] | INFO | loadServer Completed.",servertime];
