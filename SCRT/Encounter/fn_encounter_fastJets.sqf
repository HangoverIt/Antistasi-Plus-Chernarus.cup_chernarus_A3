private _fileName = "fn_encounter_fastJets";
[2, "Fast Jets random event init.", _filename] call A3A_fnc_log;

//arrays for cleanup
private _vehicles = [];
private _groups = [] ;

private _allPlayers = (call BIS_fnc_listPlayers) select {side _x == teamPlayer || side _x == civilian};
if (_allPlayers isEqualTo []) exitWith {
	// No players
	[2, format ["No players found from BIS_fnc_listPlayers %1. Aborting Fast Jets event.",(call BIS_fnc_listPlayers)], _filename] call A3A_fnc_log;
	isEventInProgress = false;
    publicVariableServer "isEventInProgress";
};
private _player = selectRandom _allPlayers;
private _originPosition = position _player;
private _finPosition = [_originPosition, 8000, (random 360)] call BIS_fnc_relPos;
private _spawnPosition = [_originPosition, 8000, (random 360)] call BIS_fnc_relPos;
private _flybyPosition = [_originPosition, (random 700) + 300, (random 360)] call BIS_fnc_relPos;
private _jetType = selectRandom vehCSATPlanesAA;
private _startDir = _spawnPosition getDir _flybyPosition;

private _jets = [
				[[(_spawnPosition select 0), (_spawnPosition select 1), 500 ], _startDir, _jetType, Invaders] call A3A_fnc_spawnVehicle, 
				[[(_spawnPosition select 0), (_spawnPosition select 1), 800 ], _startDir, _jetType, Invaders] call A3A_fnc_spawnVehicle
				];
private _height = 200 + random 300 ;
private _wp = objNull ;
private _wp2 = objNull ;
{
	private _veh = _x#0 ;
	{
		_x addCuratorEditableObjects[[_veh], true] ;
	}forEach allCurators;
	_veh setVelocityModelSpace [0, 900, 0];
	[_veh, civilian] call A3A_fnc_AIVEHinit;
	private _jetCrew = _x#1;
	{_x spawn A3A_fnc_CIVinit} forEach _jetCrew;
	private _jetGroup = _x#2;
	_groups pushBack _jetGroup;
	_vehicles pushBack _veh;
	_veh flyInHeight _height;
	
	_wp = _jetGroup addWaypoint [_flybyPosition, 1];
	_wp setWaypointSpeed "FULL";
	_wp setWaypointType "MOVE";
	_wp setWaypointBehaviour "SAFE";

	_wp2 = _jetGroup addWaypoint [_finPosition, 2];
	_wp2 setWaypointSpeed "FULL";
	_wp2 setWaypointType "MOVE";
	_wp2 setWaypointBehaviour "SAFE";
	
	if (sunOrMoon < 1) then {
		_veh setCollisionLight true ;
	};
}forEach _jets ;

private _timeOut = time + 600;
waitUntil { sleep 5; (currentWaypoint (_groups#0) > 2) || (time > _timeOut) || ({!(canMove (_x select 0)) || !alive (driver (_x select 0)) } count _jets) > 0};

{[_x] spawn A3A_fnc_vehDespawner} forEach _vehicles;
{[_x] spawn A3A_fnc_groupDespawner} forEach _groups ;

isEventInProgress = false;
publicVariableServer "isEventInProgress";

[3, format ["Fast Jets clean up complete."], _filename] call A3A_fnc_log;