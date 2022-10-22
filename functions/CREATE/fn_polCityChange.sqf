/*
 * Name:	fn_polCityChange
 * Date:	27/09/2022
 * Version: 1.0
 * Author:  JB
 *
 * Description:
 * What happens to police stations on flipping to rebels
 *
 * Parameter(s):
 * _PARAM1 (TYPE): DESCRIPTION.
 * _PARAM2 (TYPE): DESCRIPTION.
 *
 * Returns:
 * %RETURNS%
 */
if (!isServer and hasInterface) exitWith{};

private ["_markerX", "_sideX","_polStn","_reinfOrigin", "_banner","_officer", "_grunt", "_polTask", "_milOfficer", "_marksman", "_milGrunt", "_milTypeVehX", "_typeVehX","_transport","_StaticMG","_groupX","_groupY", "_roofGunsList"];

//import from marker change

_markerX = _this select 0;
_sideX = _this select 1;

if (_sideX == teamPlayer) exitWith {};
if (_markerX in destroyedSites) exitWith {};
		
switch (_markerX) do {

	case "city_StarySobor": {
		_polStn = polStn_1;
		_reinfOrigin = [4539.29,9858.7,0];
		_banner = bannerPol_1;
		_polTask = "StarySoborTask"
	};
	case "city_Vybor": {
		_polStn = polStn_2;
		_reinfOrigin = [4539.29,9858.7,0];
		_banner = bannerPol_2;
		_polTask = "VyborTask"	
	};
	case "city_Berezino": {
		_polStn = polStn_3;
		_reinfOrigin = [11487.7,7568.68,0];
		_banner = bannerPol_3;
		_polTask = "BerezinoTask"
	};
	case "city_Solnychniy": {
		_polStn = polStn_4;
		_reinfOrigin = [11487.7,7568.68,0];
		_banner = bannerPol_4;
		_polTask = "SolnychniyTask"
	};
	case "City_Severograd": {
		_polStn = polStn_5;
		_reinfOrigin = [7800.58,14546.7,0];
		_banner = bannerPol_5;
		_polTask = "SeverogradTask"
	};
	case "city_Elektrozavodsk": {
		_polStn = polStn_6;
		_reinfOrigin = [9395.33,3170.6,0];
		_banner = bannerPol_6;
		_polTask = "ElektrozavodskTask"
	};
	case "city_Chernogorsk": {
		_polStn = polStn_7;
		_reinfOrigin = [4623.39,2608.66,0];
		_banner = bannerPol_7;
		_polTask = "ChernogorskTask"
	};
	case "city_Svetloyarsk": {
		_polStn = polStn_8;
		_reinfOrigin = [12354.4,12678.3,0];
		_banner = bannerPol_8;
		_polTask = "SvetloyarskTask"
	};
	case "city_Zelenogorsk": {
		_polStn = polStn_9;
		_reinfOrigin = [1953.28,3384.33,0];
		_banner = bannerPol_9;
		_polTask = "ZelenogorskTask"
	};
	case "city_Novodmitrovsk": {
		_polStn = polStn_10;
		_reinfOrigin = [11736.7,12589.1,0];
		_banner = bannerPol_10;
		_polTask = "NovodmitrovskTask"
	};
	case "City_NovayaPetrovka": {
		_polStn = polStn_11;
		_reinfOrigin = [1786.5,14282.6,0];
		_banner = bannerPol_11;
		_polTask = "NovayaPetrovkaTask"
	};
};

if (damage _polStn == 1) exitWith {};
_polStn setVariable ["attacked", false, true];

sleep 5;

//choose side

	switch (_sideX) do {
		
		case Occupants: {

				_officer = "loadouts_occ_police_SquadLeader";
				_grunt = "loadouts_occ_police_Standard";
				_typeVehX = vehPoliceCars select 1;
				_milOfficer = [NATOOfficer] call SCRT_fnc_unit_selectInfantryTier;
				_milGrunt = NATOGrunt call SCRT_fnc_unit_selectInfantryTier;
				_marksman = NATOMarksman call SCRT_fnc_unit_selectInfantryTier;
				_milTypeVehX = if (tierWar > 5) then {selectRandom vehNATOLightArmed} else {"CUP_I_LR_MG_RACS"};
				_transport = selectRandom vehNATOTrucks;
				_banner setObjectTextureGlobal [0,"ca\ca_e\data\flag_cr_co.paa"]
		};
		
		case Invaders: {
				_milOfficer = [CSATOfficer] call SCRT_fnc_unit_selectInfantryTier;
				_milGrunt = CSATGrunt call SCRT_fnc_unit_selectInfantryTier;
				_marksman = CSATMarksman call SCRT_fnc_unit_selectInfantryTier;
				_milTypeVehX = selectRandom vehCSATLightArmed;
				_transport = selectRandom vehCSATTrucks;
				_banner setObjectTextureGlobal [0,"ca\data\flag_rus_co.paa"]
		};
	};
	
private _positionX = getPosASL _polStn;
private _city = [citiesX, _positionX] call BIS_fnc_nearestPosition;
private _nameDest = [_city] call A3A_fnc_localizar;
private _naming = if (_sideX == Occupants) then {nameOccupants} else {nameInvaders};

private _governmentCitySide = if (gameMode == 4) then {Invaders} else {Occupants};
private _governmentCityColor = if (gameMode == 4) then {colorInvaders} else {colorOccupants};
private _governmentCityName = if (gameMode == 4) then {nameInvaders} else {nameOccupants};

switch (true) do {
	
	//not spawned
	case ((spawner getVariable _markerX == 2)): {
	
	private _endtTime = numberToDate [2025, (dateToNumber date + 0.000115)];
	private _textEndTimeHr = (if (_endtTime select 3 < 10) then { "0" } else { "" }) + str (_endtTime select 3);
	private _textEndTimetMin = (if (_endtTime select 4 < 10) then { "0" } else { "" }) + str (_endtTime select 4);
	
	[[teamPlayer,civilian],_polTask, [format ["%1 has changed its allegiance to us, but the police station is still in enemy hands, and they have called in reinforcements. If we do not capture it by %3:%4 the %2 will enforce their presence and the city will fall back under their control. Go there, eliminate the enemy presence and capture the police station.",_nameDest,_naming,_textEndTimeHr,_textEndTimetMin],"Capture Police Station"],_polStn,"CREATED",-1,true,"attack",true] call BIS_fnc_taskCreate;

	if ((_sideX == Occupants) && (tierWar < 6)) then {
		_groupX = createGroup _sideX;
		private _unit1 = [_groupX, _officer, _polStn buildingPos 8, [], 0, "NONE"] call A3A_fnc_createUnit;
		private _unit2 = [_groupX, _grunt, _polStn buildingPos 6, [], 0, "NONE"] call A3A_fnc_createUnit;
		private _unit3 = [_groupX, _grunt, _polStn getRelPos [9, 47], [], 0, "NONE"] call A3A_fnc_createUnit;
		private _unit4 = [_groupX, _grunt, _polStn buildingPos 1, [], 0, "NONE"] call A3A_fnc_createUnit;
		private _unit5 = [_groupX, _grunt, _polStn buildingPos 2, [], 0, "NONE"] call A3A_fnc_createUnit;
		private _unit6 = [_groupX, _grunt, _polStn buildingPos 11, [], 0, "NONE"] call A3A_fnc_createUnit;
		private _unit7 = [_groupX, _grunt, _polStn buildingPos 9, [], 0, "NONE"] call A3A_fnc_createUnit;
		private _unit8 = [_groupX, _grunt, _polStn buildingPos 12, [], 0, "NONE"] call A3A_fnc_createUnit;
		
		_groupX setFormDir ((getDir _polStn) + 180);		
		_unit3 doWatch (_polStn getRelPos [200, 90]);
		_unit6 doWatch (_polStn getRelPos [200, 315]);
		_unit7 doWatch (_polStn getRelPos [200, 135]);
		_unit8 doWatch (_polStn getRelPos [200, 225]);
		
	} else {
		private _unit1 = [_groupX, _milOfficer, _polStn buildingPos 8, [], 0, "NONE"] call A3A_fnc_createUnit;
		private _unit2 = [_groupX, _milGrunt, _polStn buildingPos 6, [], 0, "NONE"] call A3A_fnc_createUnit;
		private _unit3 = [_groupX, _milGrunt, _polStn getRelPos [9, 47], [], 0, "NONE"] call A3A_fnc_createUnit;
		private _unit4 = [_groupX, _milGrunt, _polStn buildingPos 1, [], 0, "NONE"] call A3A_fnc_createUnit;
		private _unit5 = [_groupX, _milGrunt, _polStn buildingPos 2, [], 0, "NONE"] call A3A_fnc_createUnit;
		private _unit6 = [_groupX, _marksman, _polStn buildingPos 11, [], 0, "NONE"] call A3A_fnc_createUnit;
		
		_roofGunsList = [];
		private _roofGun1 = _StaticMG createVehicle [0,0,0];
		private _roofGun2 = _StaticMG createVehicle [0,0,0];
		_roofGun1 setDir (getDir _polStn) + 135;
		_roofGun1 setPos (_polStn buildingPos 9);
		_roofGun2 setDir (getDir _polStn) + 225;
		_roofGun2 setPos (_polStn buildingPos 12);
	
		_roofGunsList pushBack _roofGun1;
		_roofGunsList pushBack _roofGun2;
		
		private _unit7 = [_groupX, _milGrunt, [0,0,0], [], 0, "NONE"] call A3A_fnc_createUnit;
		private _unit8 = [_groupX, _milGrunt, [0,0,0], [], 0, "NONE"] call A3A_fnc_createUnit;
		
		_unit7 moveInGunner _roofGun1;
		_unit8 moveInGunner _roofGun2;
		
		_groupX setFormDir ((getDir _polStn) + 180);		
		_unit3 doWatch (_polStn getRelPos [200, 90]);
		_unit6 doWatch (_polStn getRelPos [200, 315]);
		_unit7 doWatch (_polStn getRelPos [200, 135]);
		_unit8 doWatch (_polStn getRelPos [200, 225]);
	};
			
	{
	[_x] call A3A_fnc_NATOinit;
	_x disableAI "PATH";
	} forEach units _groupX;
	
	
	private _road = [_polStn getRelPos [9, 230], 100] call BIS_fnc_nearestRoad;
	private _direction = _road call A3A_fnc_getRoadDirection;
 
		private _reinfVeh = _milTypeVehX createVehicle getPos _road;
	
	_groupY = createGroup _sideX;
		private _unit9 = [_groupY, _milOfficer, _polStn getRelPos [6, 210], [], 0, "NONE"] call A3A_fnc_createUnit;
		private _unit10 = [_groupY, _milGrunt, _polStn getRelPos [6, 170], [], 0, "NONE"] call A3A_fnc_createUnit;
		private _unit11 = [_groupY, _milGrunt, _polStn getRelPos [9, 230], [], 0, "NONE"] call A3A_fnc_createUnit;
		private _unit12 = [_groupY, _milGrunt, [0,0,0], [], 0, "NONE"] call A3A_fnc_createUnit;
		
		_unit12 moveInGunner _reinfVeh;
		
	{
	[_x] call A3A_fnc_NATOinit;
	_x disableAI "PATH";
	} forEach units _groupY;
	_groupY setFormDir ((getDir _polStn) + 180);
	
	[
	_banner,											// Object the action is attached to
	"Capture Police Station",										// Title of the action
	"\a3\ui_f_orange\Data\CfgOrange\Missions\action_fia_ca.paa",	// Idle icon shown on screen
	"\a3\ui_f_orange\Data\CfgOrange\Missions\action_fia_ca.paa",	// Progress icon shown on screen
	"_this distance _target < 3",						// Condition for the action to be shown
	"_caller distance _target < 3 && _caller distance (_caller findNearestEnemy _caller) > 100 && !(captive _caller)",						// Condition for the action to progress
	{},													// Code executed when action starts
	{},													// Code executed on every progress tick
	{ 	_this params ["_target", "_caller", "_actionId", "_arguments"];
		_target setObjectTextureGlobal [0,"ca\data\flag_napa_co.paa"];
	
	},												// Code executed on completion
	{	if (_caller distance (_caller findNearestEnemy _caller) < 100) then {["Capture Police Station", "There are still enemies nearby."] call A3A_fnc_customHint}; 
		if (captive _caller) then {["Capture Police Station", "You cannot capture the Police Station whilst undercover."] call A3A_fnc_customHint}
	},													// Code executed on interrupted
	[],													// Arguments passed to the scripts as _this select 3
	5,													// Action duration in seconds
	1000,													// Priority
	true,												// Remove on completion
	false												// Show in unconscious state
	] remoteExec ["BIS_fnc_holdActionAdd", 0, _banner];	// MP compatible implementation

	waitUntil  { sleep 1; ((getObjectTextures _banner) select 0 == "ca\data\flag_napa_co.paa") || (date isEqualTo _endtTime) };
	
		switch(true) do {
			case ((getObjectTextures _banner) select 0 == "ca\data\flag_napa_co.paa"): {
			[_polTask, "SUCCEEDED"] call BIS_fnc_taskSetState;
			};
		
			case (date isEqualTo _endtTime): {
			[_polTask, "FAILED"] call BIS_fnc_taskSetState;
			
			[100,-100,_markerX] remoteExec ["A3A_fnc_citySupportChange",2];
			
			["TaskFailed", ["", format ["%1 joined %2",[_markerX, false] call A3A_fnc_location,_governmentCityName]]] remoteExec ["BIS_fnc_showNotification",teamPlayer];
			sidesX setVariable [_markerX,_governmentCitySide,true];
			[_governmentCitySide, -10, 45] remoteExec ["A3A_fnc_addAggression",2];
			_mrkD = format ["Dum%1",_markerX];
			_mrkD setMarkerColor _governmentCityColor;
			garrison setVariable [_markerX,[],true];
			
			};
		};
	};

	//spawned
	default {

	[[teamPlayer,civilian],_polTask, [format ["%1 has changed its allegiance to us, but the %2 will not relinquish the town so easily. They are sending reinforcements to the police station. Ensure the police station is in our hands, and then defend it at all costs, else %1 will fall back under %2 control.",_nameDest,_naming],"Capture Police Station"],_polStn,"CREATED",-1,true,"defend",true] call BIS_fnc_taskCreate;

	[
	_banner,											// Object the action is attached to
	"Capture Police Station",										// Title of the action
	"\a3\ui_f_orange\Data\CfgOrange\Missions\action_fia_ca.paa",	// Idle icon shown on screen
	"\a3\ui_f_orange\Data\CfgOrange\Missions\action_fia_ca.paa",	// Progress icon shown on screen
	"_this distance _target < 3",						// Condition for the action to be shown
	"_caller distance _target < 3 && _caller distance (_caller findNearestEnemy _caller) > 100 && !(captive _caller)",						// Condition for the action to progress
	{},													// Code executed when action starts
	{},													// Code executed on every progress tick
	{ 	_this params ["_target", "_caller", "_actionId", "_arguments"];
		_target setObjectTextureGlobal [0,"ca\data\flag_napa_co.paa"];
	
	},												// Code executed on completion
	{	if (_caller distance (_caller findNearestEnemy _caller) < 100) then {["Capture Police Station", "There are still enemies nearby."] call A3A_fnc_customHint}; 
		if (captive _caller) then {["Capture Police Station", "You cannot capture the Police Station whilst undercover."] call A3A_fnc_customHint}
	},													// Code executed on interrupted
	[],													// Arguments passed to the scripts as _this select 3
	5,													// Action duration in seconds
	1000,													// Priority
	true,												// Remove on completion
	false												// Show in unconscious state
	] remoteExec ["BIS_fnc_holdActionAdd", 0, _banner];	// MP compatible implementation

	private _rienfTime = numberToDate [2025, (dateToNumber date + 0.0000286)];

	waitUntil  { sleep 10; ((getObjectTextures _banner) select 0 == "ca\data\flag_napa_co.paa") || (date isEqualTo _rienfTime) };

	private _road = [_reinfOrigin, 50] call BIS_fnc_nearestRoad;
	private _direction = _road call A3A_fnc_getRoadDirection;
  
		private _reinfVeh = _milTypeVehX createVehicle getPos _road;
		if (_markerX in ["city_Solnychniy","city_Elektrozavodsk","city_Svetloyarsk","city_Zelenogorsk","City_NovayaPetrovka"]) then {
			_reinfVeh setDir (_direction + 180);
			} else {
			_reinfVeh setDir _direction;
		};

		private _destination = getPos ([getPosATL _polStn, 50] call BIS_fnc_nearestRoad);

	if ((_sideX == Occupants) && (tierWar < 6)) then {

		private _transVeh = _typeVehX createVehicle (_reinfVeh getRelPos [10, 180]);
		
		_transVeh animate ["Majak_start",1];_transVeh switchLight "On"; [_transVeh,"CustomSoundController1",1,0.2] remoteExec ["BIS_fnc_setCustomSoundController"];
		
		if (_markerX in ["city_Solnychniy","city_Elektrozavodsk","city_Svetloyarsk","city_Zelenogorsk","City_NovayaPetrovka"]) then {
			_transVeh setDir (_direction + 180);
			} else {
			_transVeh setDir _direction;
		};


		_groupX = createGroup _sideX;
		private _unit1 = [_groupX, _milOfficer, [0,0,0], [], 0, "NONE"] call A3A_fnc_createUnit;
		private _unit2 = [_groupX, _milGrunt, [0,0,0], [], 0, "NONE"] call A3A_fnc_createUnit;
		private _unit3 = [_groupX, _milGrunt, [0,0,0], [], 0, "NONE"] call A3A_fnc_createUnit;
		private _unit4 = [_groupX, _milGrunt, [0,0,0], [], 0, "NONE"] call A3A_fnc_createUnit;
		private _unit5 = [_groupX, _officer, [0,0,0], [], 0, "NONE"] call A3A_fnc_createUnit;
		private _unit6 = [_groupX, _grunt, [0,0,0], [], 0, "NONE"] call A3A_fnc_createUnit;
		private _unit7 = [_groupX, _grunt, [0,0,0], [], 0, "NONE"] call A3A_fnc_createUnit;
		private _unit8 = [_groupX, _grunt, [0,0,0], [], 0, "NONE"] call A3A_fnc_createUnit;
		private _unit9 = [_groupX, _grunt, [0,0,0], [], 0, "NONE"] call A3A_fnc_createUnit;
		private _unit10 = [_groupX, _grunt, [0,0,0], [], 0, "NONE"] call A3A_fnc_createUnit;
		
		_unit1 moveInDriver _reinfVeh;
		_unit2 moveInAny _reinfVeh;
		_unit3 moveInAny _reinfVeh;
		_unit4 moveInAny _reinfVeh;
		_unit5 moveInDriver _transVeh;
		_unit6 moveInAny _transVeh;
		_unit7 moveInAny _transVeh;
		_unit8 moveInAny _transVeh;
		_unit9 moveInAny _transVeh;
		_unit10 moveInAny _transVeh;
	
	} else {	
		
		
		private _transVeh = _transport createVehicle (_reinfVeh getRelPos [10, 180]);
		
		if (_markerX in ["city_Solnychniy","city_Elektrozavodsk","city_Svetloyarsk","city_Zelenogorsk","City_NovayaPetrovka"]) then {
			_transVeh setDir (_direction + 180);
			} else {
			_transVeh setDir _direction;
		};
		
		
		_groupX = createGroup _sideX;
		private _unit1 = [_groupX, _milOfficer, [0,0,0], [], 0, "NONE"] call A3A_fnc_createUnit;
		private _unit2 = [_groupX, _milGrunt, [0,0,0], [], 0, "NONE"] call A3A_fnc_createUnit;
		private _unit3 = [_groupX, _milGrunt, [0,0,0], [], 0, "NONE"] call A3A_fnc_createUnit;
		private _unit4 = [_groupX, _milGrunt, [0,0,0], [], 0, "NONE"] call A3A_fnc_createUnit;
		
		_unit1 moveInDriver _reinfVeh;
		_unit2 moveInAny _reinfVeh;
		_unit3 moveInAny _reinfVeh;
		_unit4 moveInAny _reinfVeh;
		
		private _squads = [_sideX, "SQUAD"] call SCRT_fnc_unit_getGroupSet;
		private _groupY = [_reinfOrigin,_sideX, (selectRandom _squads)] call A3A_fnc_spawnGroup;
		
		{_x moveInAny _transVeh} forEach units _groupY;
		
		(units _groupY) joinSilent _groupX;
		
		};	
		
		{
		[_x] call A3A_fnc_NATOinit;
		} forEach units _groupX;	
		
		_groupX setBehaviour "SAFE";
		_groupX setFormation "COLUMN";
		
		_wp1 = _groupX addWaypoint [_destination, 0];
		_wp1 setWaypointType "UNLOAD";
		if ((_sideX == Occupants) && (tierWar < 6)) then { _wp1 setWaypointStatements ["true", "[vehicle (thisList select 4),'CustomSoundController1',0,0.4] remoteExec ['BIS_fnc_setCustomSoundController']; group _this setBehaviour 'AWARE'"]};
		
		sleep 1800;
		
		_enemyForce = {side _x == _sideX} count nearestObjects [_polStn,["Man"],200];
		_friendlyForce = {side _x == teamPlayer} count nearestObjects [_polStn,["Man"],200];
		
		if (_enemyForce > _friendlyForce) then { [_polTask, "FAILED"] call BIS_fnc_taskSetState;
			[100,-100,_markerX] remoteExec ["A3A_fnc_citySupportChange",2]; 
			[_sideX,_markerX] remoteExec ["A3A_fnc_markerChange",2];
				
			["TaskFailed", ["", format ["%1 joined %2",[_markerX, false] call A3A_fnc_location,_governmentCityName]]] remoteExec ["BIS_fnc_showNotification",teamPlayer];
			sidesX setVariable [_markerX,_governmentCitySide,true];
			[_governmentCitySide, -10, 45] remoteExec ["A3A_fnc_addAggression",2];
			_mrkD = format ["Dum%1",_markerX];
			_mrkD setMarkerColor _governmentCityColor;
			garrison setVariable [_markerX,[],true];
				
				} else { 
			[_polTask, "SUCCEEDED"] call BIS_fnc_taskSetState}
		};
	};
