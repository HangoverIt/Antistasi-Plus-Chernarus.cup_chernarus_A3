if (!isServer and hasInterface) exitWith{};
private _filename = "fn_createAIcontrols";

private ["_pos", "_posMG", "_posAT", "_veh", "_roads","_conquered","_dirVeh","_markerX","_positionX","_vehiclesX","_soldiers","_radiusX","_bunker", "_groupE","_unit" ,"_typeGroup","_groupX","_timeLimit","_dateLimit","_dateLimitNum","_base","_dog","_sideX","_cfg","_isFIA","_leave","_isControl","_radiusX","_typeVehX","_typeUnit","_markersX","_frontierX","_uav","_groupUAV","_allUnits","_closest","_winner","_timeLimit","_dateLimit","_dateLimitNum","_size","_base","_mineX","_loser","_sideX", "_vehMG", "_typeVehMG", "_vehAT", "_typeVehAT", "_zOffset"];

_markerX = _this select 0;
_positionX = getMarkerPos _markerX;
_sideX = sidesX getVariable [_markerX,sideUnknown];

[2, format ["Spawning Control Point %1", _markerX], _filename] call A3A_fnc_log;

if ((_sideX == teamPlayer) or (_sideX == sideUnknown)) exitWith {};
if ({if ((sidesX getVariable [_x,sideUnknown] != _sideX) and (_positionX inArea _x)) exitWith {1}} count markersX >1) exitWith {};
_vehiclesX = [];
_soldiers = [];
_pilots = [];
_conquered = false;
_groupX = grpNull;
_isFIA = false;
_leave = false;

_isControl = if (isOnRoad _positionX) then {true} else {false};

if (_isControl) then {
	if (gameMode != 4) then{
		if (_sideX == Occupants) then{
			if ((random 10 > (tierWar + difficultyCoef)) and (!([_markerX] call A3A_fnc_isFrontline))) then{
				_isFIA = true;
			};
		};
	}else{
		if (_sideX == Invaders) then{
			if ((random 10 > (tierWar + difficultyCoef)) and (!([_markerX] call A3A_fnc_isFrontline))) then{
				_isFIA = true;
			};
		};
	};

	// Attempt to find nearby road with two connected roads
	_radiusX = 20;
	while {_radiusX < 100} do {
		_roads = _positionX nearRoads _radiusX;
		_roads = _roads select { count (roadsConnectedTo _x) == 2 };
		if (count _roads > 0) exitWith {};
		_radiusX = _radiusX + 10;
	};

	if (_radiusX >= 100) then {
		// fallback case, shouldn't happen unless the map is very broken
		[1, format ["Roadblock error for %1 at %2", _markerX, _positionX], _filename] call A3A_fnc_log;
		_roads = _positionX nearRoads 20;		// guaranteed due to isOnRoad check
		_dirveh = random 360;
	} else {
		private _roadscon = roadsConnectedto (_roads select 0);
		_dirveh = [_roads select 0, _roadscon select 0] call BIS_fnc_DirTo;
	};

	if (!_isFIA) then {
		
		if (tierWar > 7 && (random 10) > 5) then {
			_groupE = grpNull;
			_pos = [_positionX, 8, _dirveh + 270] call BIS_Fnc_relPos; 
			_bunker = "Land_BagBunker_Tower_F" createVehicle _pos; 
			_bunker setDir (_dirveh + 180); 
			_bunker setVectorUp surfaceNormal position _bunker;
			_pos = getPosATL _bunker;
			_typeVehMG = if (_sideX == Occupants) then {selectRandom NATOMG} else {selectRandom CSATMG};
			_typeVehAT = if (_sideX == Occupants) then {staticATOccupants} else {staticATInvaders};
			_vehMG = _typeVehMG createVehicle _pos;
			_vehMG setDir _dirveh;
			_zOffset = [0, 0, 2.7];
			_posMG = (_bunker getRelPos [2.5,195]) vectorAdd _zOffset;
			_vehMG setPos _posMG;
			_vehiclesX pushBack _vehMG;

			_vehAT = _typeVehAT createVehicle _pos;
			_vehAT setDir (_dirveh + 180);
			_posAT = (_bunker getRelPos [2.4,0]) vectorAdd _zOffset;
			_vehAT setPos _posAT;
			_vehiclesX pushBack _vehAT;

			_groupE = createGroup _sideX;
			_typeUnit = if (_sideX == Occupants) then {
				staticCrewOccupants call SCRT_fnc_unit_selectInfantryTier
			} else {
				staticCrewInvaders call SCRT_fnc_unit_selectInfantryTier
			};
			_unit = [_groupE, _typeUnit, _positionX, [], 0, "NONE"] call A3A_fnc_createUnit;
			_unit moveInGunner _vehMG;
			_unit = [_groupE, _typeUnit, _positionX, [], 0, "NONE"] call A3A_fnc_createUnit;
			_unit moveInGunner _vehAT;

			_pos = [_positionX, 8, _dirveh + 90] call BIS_Fnc_relPos; 
			_bunker = "Land_BagBunker_Tower_F" createVehicle _pos; 
			_bunker setDir _dirveh; 
			_bunker setVectorUp surfaceNormal position _bunker;
			_pos = getPosATL _bunker;
			_vehMG = _typeVehMG createVehicle _pos;
			_vehMG setDir (_dirveh + 180);
			_zOffset = [0, 0, 2.7];
			_posMG = (_bunker getRelPos [2.5,195]) vectorAdd _zOffset;
			_vehMG setPos _posMG;
			_vehiclesX pushBack _vehMG;

			_vehAT = _typeVehAT createVehicle _pos;
			_vehAT setDir _dirveh;
			_posAT = (_bunker getRelPos [2.4,0]) vectorAdd _zOffset;
			_vehAT setPos _posAT;
			_vehiclesX pushBack _vehAT;

			_unit = [_groupE, _typeUnit, _positionX, [], 0, "NONE"] call A3A_fnc_createUnit;
			_unit moveInGunner _vehMG;
			_unit = [_groupE, _typeUnit, _positionX, [], 0, "NONE"] call A3A_fnc_createUnit;
			_unit moveInGunner _vehAT;
			sleep 1;
			
			_pos = [getPos _bunker, 6, getDir _bunker] call BIS_fnc_relPos;
			_typeVehX = if (_sideX == Occupants) then {NATOFlag} else {CSATFlag};
			_veh = createVehicle [_typeVehX, _pos, [],0, "NONE"];
			_vehiclesX pushBack _veh;
			_veh setPosATL _pos;
			_veh setDir _dirVeh;
			sleep 1;

			{ [_x, _sideX] call A3A_fnc_AIVEHinit } forEach _vehiclesX;
			private _mid = [_sideX, "SQUAD"] call SCRT_fnc_unit_getGroupSet;
			_typeGroup = selectRandom _mid;
			_groupX = [_positionX,_sideX, _typeGroup, true] call A3A_fnc_spawnGroup;
			if !(isNull _groupX) then {
				{[_x] join _groupX} forEach units _groupE;
				deleteGroup _groupE;
				if (random 10 < 2.5) then {
					_dog = [_groupX, "Fin_random_F",_positionX,[],0,"FORM"] call A3A_fnc_createUnit;
					[_dog,_groupX] spawn A3A_fnc_guardDog;
				};
				_nul = [leader _groupX, _markerX, "SAFE","SPAWNED","NOVEH2","NOFOLLOW"] execVM "scripts\UPSMON.sqf";//TODO need delete UPSMON link
				// Forced non-spawner as they're very static.
				{[_x,"",false] call A3A_fnc_NATOinit; _soldiers pushBack _x} forEach units _groupX;
			};
		
		} else {	
			_groupE = grpNull;
			_pos = [_positionX, 7, _dirveh + 270] call BIS_Fnc_relPos;
			_bunker = smallBunker createVehicle _pos;
			_vehiclesX pushBack _bunker;
			_bunker setDir (_dirveh + 180);
			_bunker setVectorUp surfaceNormal position _bunker;
			_pos = getPosATL _bunker;
			_typeVehX = if (_sideX == Occupants) then {selectRandom NATOMG} else {selectRandom CSATMG};
			_veh = _typeVehX createVehicle _positionX;
			_vehiclesX pushBack _veh;
			_veh setPosATL _pos;
			_veh setDir _dirVeh;

			_groupE = createGroup _sideX;
			_typeUnit = if (_sideX == Occupants) then {
				staticCrewOccupants call SCRT_fnc_unit_selectInfantryTier
			} else {
				staticCrewInvaders call SCRT_fnc_unit_selectInfantryTier
			};
			_unit = [_groupE, _typeUnit, _positionX, [], 0, "NONE"] call A3A_fnc_createUnit;
			_unit moveInGunner _veh;
			sleep 1;
			_pos = [_positionX, 8, _dirveh + 90] call BIS_Fnc_relPos;
			_bunker = smallBunker createVehicle _pos;
			_vehiclesX pushBack _bunker;
			_bunker setDir _dirveh;
			_bunker setVectorUp surfaceNormal position _bunker;
			_pos = getPosATL _bunker;
			_veh = _typeVehX createVehicle _positionX;
			_vehiclesX pushBack _veh;
			_veh setPosATL _pos;
			_veh setDir (_dirVeh + 180);
			_unit = [_groupE, _typeUnit, _positionX, [], 0, "NONE"] call A3A_fnc_createUnit;
			_unit moveInGunner _veh;
			sleep 1;
		
			_pos = [getPos _bunker, 6, getDir _bunker] call BIS_fnc_relPos;
			_typeVehX = if (_sideX == Occupants) then {NATOFlag} else {CSATFlag};
			_veh = createVehicle [_typeVehX, _pos, [],0, "NONE"];
			_vehiclesX pushBack _veh;
			_veh setPosATL _pos;
			_veh setDir _dirVeh;
			sleep 1;

			{ [_x, _sideX] call A3A_fnc_AIVEHinit } forEach _vehiclesX;
			private _mid = [_sideX, "MID"] call SCRT_fnc_unit_getGroupSet;
			_typeGroup = selectRandom _mid;
			_groupX = [_positionX,_sideX, _typeGroup, true] call A3A_fnc_spawnGroup;
			if !(isNull _groupX) then {
				{[_x] join _groupX} forEach units _groupE;
				deleteGroup _groupE;
				if (random 10 < 2.5) then {
					_dog = [_groupX, "Fin_random_F",_positionX,[],0,"FORM"] call A3A_fnc_createUnit;
					[_dog,_groupX] spawn A3A_fnc_guardDog;
				};
				_nul = [leader _groupX, _markerX, "SAFE","SPAWNED","NOVEH2","NOFOLLOW"] execVM "scripts\UPSMON.sqf";//TODO need delete UPSMON link
				// Forced non-spawner as they're very static.
				{[_x,"",false] call A3A_fnc_NATOinit; _soldiers pushBack _x} forEach units _groupX;
			};
		};
	} else { // isFIA
		_typeVehX = if(random 10 < (tierWar + (difficultyCoef / 2))) then {
			if (_sideX == Occupants) then {selectRandom vehFIAAPC} else {selectRandom vehWAMAPC};
		} else {
			if (_sideX == Occupants) then {selectRandom vehFIAArmedCars} else {selectRandom vehWAMArmedCars};
		};
		
		_pos = [_positionX, 7, _dirveh + 270] call BIS_Fnc_relPos;
		_veh = _typeVehX createVehicle _pos;
		_veh setDir _dirveh;
		[_veh, _sideX] call A3A_fnc_AIVEHinit;
		_vehiclesX pushBack _veh;
		sleep 1;
		_typeGroup = if (_sideX == Occupants) then {selectRandom groupsFIAMid} else {selectRandom groupsWAMMid};
		_pos = [_positionX, 7, _dirveh + 90] call BIS_Fnc_relPos;
		_groupX = [_pos, _sideX, _typeGroup, true] call A3A_fnc_spawnGroup;
		if !(isNull _groupX) then {
			private _fiaRifleman = if(_sideX == Occupants) then {FIARifleman} else {WAMRifleman};
			_unit = [_groupX, _fiaRifleman, _positionX, [], 0, "NONE"] call A3A_fnc_createUnit;
			_unit moveInGunner _veh;
			sleep 1;
			{
				_soldiers pushBack _x;
				[_x,"", false] call A3A_fnc_NATOinit;
			} forEach units _groupX;
			sleep 1;
			_groupX setFormation "STAG COLUMN";
			sleep 1;
			_groupX setFormDir _dirveh;
			_unit doWatch (_veh getRelPos [200, 5]);
		};
	};
	// Set night time additional lights
	if (sunOrMoon < 1) then {
		_fn_flare = {
			params["_unit", "_grp"] ;
			private _secs = 80 ;
			private _launched = false ;
			private _flare = objNull ;
			private _flarelight = objNull ;
			private _roadblockpos = getPos _unit ;
			private _flarepos = [] ;
			private _flaretypes = [["F_40mm_White",[1,1,1]], ["F_40mm_Red", [1,0,0]], ["F_40mm_Yellow", [1,1,0]], ["F_40mm_Green", [0,1,0]]] ;
			private _useflare = selectRandom _flaretypes ;
			while {true} do {
				if (isNull _grp) exitWith {} ;
				if (count ((units _grp) select {alive _x && !(_x getVariable ["incapacitated",false])}) <= 2) exitWith {} ; // Stop firing if numbers too low
				if (isNull _unit) exitWith {};
				if (!alive _unit) exitWith {};
				if (!_launched) then {
					{
						if (_x isKindOf "Man" || count (crew _x) > 0) then {
							if ((_grp knowsAbout _x) > 0.7 || (side _x == civilian && _x distance _roadblockpos < 25)) exitWith {
								// Fire flare
								_useflare = selectRandom _flaretypes ;
								diag_log format["DEBUG: Roadblock %1 knows about %2, launch illumination flare %3", _unit, _x, _useflare#0] ;
								
								_flarepos = _roadblockpos vectorAdd [(random 30)-15,(random 30)-15,200];
								[_flarepos, _useflare#0, _useflare#1] remoteExec ["SCRT_fnc_effect_flare",-2]; // run on clients for visuals
								_flare = ([_flarepos, _useflare#0, _useflare#1] call SCRT_fnc_effect_flare) ; // run locally for server to get flare object
								
								_launched = true;
							};
						};
					}forEach ((nearestObjects[_roadblockpos, ["Man", "Car", "Tank"], 100, false]) select {alive _x && !(side _grp == side _x)});
				}else{				
					sleep 0.1;
					if !(alive _flare) then {
						_secs = _secs - 1;
					};
					if (_secs <= 0) then {_launched = false ;_secs=(random 80) + 80;};
				};
			};
		};
		_veh setPilotLight true;
		
		_pos = _positionX getPos [8, _dirveh + 45] ;
		_lamp = createVehicle ["RoadCone_L_F", _pos, [], 0, "CAN_COLLIDE"];
		_lamp setDir _dirveh;
		_vehiclesX pushBack _lamp;
		_pos = _positionX getPos [8, _dirveh + 135] ;
		_lamp = createVehicle ["RoadCone_L_F", _pos, [], 0, "CAN_COLLIDE"];
		_lamp setDir _dirveh;
		_vehiclesX pushBack _lamp ;
		_pos = _positionX getPos [8, _dirveh + 225] ;
		_lamp = createVehicle ["RoadCone_L_F", _pos, [], 0, "CAN_COLLIDE"];
		_lamp setDir _dirveh;
		_vehiclesX pushBack _lamp ;
		_pos = _positionX getPos [8, _dirveh + 315] ;
		_lamp = createVehicle ["RoadCone_L_F", _pos, [], 0, "CAN_COLLIDE"];
		_lamp setDir _dirveh;
		_vehiclesX pushBack _lamp ;
		[_veh, _groupX] spawn _fn_flare;
	};
} else { // not isControl (marker not on a road)
	_markersX = markersX select {(getMarkerPos _x distance _positionX < distanceSPWN) and (sidesX getVariable [_x,sideUnknown] == teamPlayer)};
	_markersX = _markersX - ["Synd_HQ"] - watchpostsFIA - roadblocksFIA - aapostsFIA - atpostsFIA - mortarpostsFIA - hmgpostsFIA - citiesX;
	_frontierX = if (count _markersX > 0) then {true} else {false};
	if (_frontierX) then {
		_cfg = CSATSpecOp;
		_sideX = Invaders ;
		if (sidesX getVariable [_markerX,sideUnknown] == Occupants) then{
			_cfg = NATOSpecOp;
			_sideX = Occupants;
		};
		_size = [_markerX] call A3A_fnc_sizeMarker;
		if ({if (_x inArea _markerX) exitWith {1}} count allMines == 0 && (random 2) < 1) then {
			diag_log format ["%1: [Antistasi]: Server | Creating a Minefield at %1", _markerX];
			private _mines = ([A3A_faction_inv,A3A_faction_occ] select (_sideX == Occupants)) getVariable "minefieldAPERS";
			private _revealTo = [Invaders,Occupants] select (_sideX == Occupants);
			for "_i" from 1 to 20 do {
				_mineX = createMine [ selectRandom _mines ,_positionX,[],_size];
				_revealTo revealMine _mineX;
			};
		};
		_groupX = [_positionX,_sideX, _cfg] call A3A_fnc_spawnGroup;
		_nul = [leader _groupX, _markerX, "SAFE","SPAWNED","RANDOM","NOVEH2","NOFOLLOW"] execVM "scripts\UPSMON.sqf";//TODO need delete UPSMON link

		sleep 1;
		{_soldiers pushBack _x} forEach units _groupX;
		_typeVehX = if (_sideX == Occupants) then {vehNATOUAVSmall} else {vehCSATUAVSmall};
		if (_typeVehX != "not_supported") then {
			_uav = createVehicle [_typeVehX, _positionX, [], 0, "FLY"];
			[_sideX, _uav] call A3A_fnc_createVehicleCrew;
			_vehiclesX pushBack _uav;
			_groupUAV = group (crew _uav select 1);
			if (!isNil "_groupUAV") then {
				if (!isNull _groupUAV) then {
					{[_x] joinSilent _groupX; _pilots pushBack _x} forEach units _groupUAV;
					deleteGroup _groupUAV;
				};
			};
		};

		{[_x,""] call A3A_fnc_NATOinit} forEach units _groupX;
	} else{
		_leave = true;
	};
};

if (_leave) exitWith {};

{ _x setVariable ["originalPos", getPos _x] } forEach _vehiclesX;

_spawnStatus = 0;
while {(spawner getVariable _markerX != 2) and ({[_x,_markerX] call A3A_fnc_canConquer} count _soldiers > 0)} do
	{
	if ((spawner getVariable _markerX == 1) and (_spawnStatus != spawner getVariable _markerX)) then
		{
		_spawnStatus = 1;
		if (isMultiplayer) then
			{
			{if (vehicle _x == _x) then {[_x,false] remoteExec ["enableSimulationGlobal",2]}} forEach _soldiers
			}
		else
			{
			{if (vehicle _x == _x) then {_x enableSimulationGlobal false}} forEach _soldiers
			};
		}
	else
		{
		if ((spawner getVariable _markerX == 0) and (_spawnStatus != spawner getVariable _markerX)) then
			{
			_spawnStatus = 0;
			if (isMultiplayer) then
				{
				{if (vehicle _x == _x) then {[_x,true] remoteExec ["enableSimulationGlobal",2]}} forEach _soldiers
				}
			else
				{
				{if (vehicle _x == _x) then {_x enableSimulationGlobal true}} forEach _soldiers
				};
			};
		};
	sleep 3;
	};

waitUntil {sleep 1;((spawner getVariable _markerX == 2))  or ({[_x,_markerX] call A3A_fnc_canConquer} count _soldiers == 0)};

_conquered = false;
_winner = Occupants;
if (spawner getVariable _markerX != 2) then
	{
	_conquered = true;
	_allUnits = allUnits select {(side _x != civilian) and (side _x != _sideX) and (alive _x) and (!captive _x)};
	_closest = [_allUnits,_positionX] call BIS_fnc_nearestPosition;
	_winner = side _closest;
	_loser = Occupants;
	diag_log format ["%1: [Antistasi]: Server | Control %2 captured by %3. Is Roadblock: %4",servertime, _markerX, _winner, _isControl];
	if (_isControl) then
		{
		["TaskSucceeded", ["", "Roadblock Destroyed"]] remoteExec ["BIS_fnc_showNotification",_winner];
		["TaskFailed", ["", "Roadblock Lost"]] remoteExec ["BIS_fnc_showNotification",_sideX];
		};
	if (sidesX getVariable [_markerX,sideUnknown] == Occupants) then
		{
		if (_winner == Invaders) then
			{
			_nul = [-5,0,_positionX] remoteExec ["A3A_fnc_citySupportChange",2];
			sidesX setVariable [_markerX,Invaders,true];
			}
		else
			{
			sidesX setVariable [_markerX,teamPlayer,true];
			};
		}
	else
		{
		_loser = Invaders;
		if (_winner == Occupants) then
			{
			sidesX setVariable [_markerX,Occupants,true];
			_nul = [5,0,_positionX] remoteExec ["A3A_fnc_citySupportChange",2];
			}
		else
			{
			sidesX setVariable [_markerX,teamPlayer,true];
			_nul = [0,5,_positionX] remoteExec ["A3A_fnc_citySupportChange",2];
			};
		};
	};

waitUntil {sleep 1;(spawner getVariable _markerX == 2)};


{ if (alive _x) then { deleteVehicle _x } } forEach (_soldiers + _pilots);
deleteGroup _groupX;

{
	// delete all vehicles that haven't been captured
	if (_x getVariable ["ownerSide", _sideX] == _sideX) then {
		if (_x distance2d (_x getVariable "originalPos") < 100) then { deleteVehicle _x }
		else { if !(_x isKindOf "StaticWeapon") then { [_x] spawn A3A_fnc_VEHdespawner } };
	};
} forEach _vehiclesX;

{
	// delete all vehicles that haven't been captured
	if !(_x getVariable ["inDespawner", false]) then { deleteVehicle _x };
} forEach _vehiclesX;

if (_conquered) then
	{
	_indexX = controlsX find _markerX;
	if (_indexX > defaultControlIndex) then
		{
		_timeLimit = 120;//120
		_dateLimit = [date select 0, date select 1, date select 2, date select 3, (date select 4) + _timeLimit];
		_dateLimitNum = dateToNumber _dateLimit;
		waitUntil {sleep 60;(dateToNumber date > _dateLimitNum)};
		_base = [(markersX - controlsX),_positionX] call BIS_fnc_nearestPosition;
		if (sidesX getVariable [_base,sideUnknown] == Occupants) then
			{
			sidesX setVariable [_markerX,Occupants,true];
			}
		else
			{
			if (sidesX getVariable [_base,sideUnknown] == Invaders) then
				{
				sidesX setVariable [_markerX,Invaders,true];
				};
			};
		};
	};
