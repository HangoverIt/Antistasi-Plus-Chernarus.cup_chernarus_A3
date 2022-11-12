if (!isServer and hasInterface) exitWith {};

private _markerX = _this select 0;
private _positionX = getMarkerPos _markerX;
// JB limited gear code
private _garrLoadouts = [_markerX] call A3A_fnc_fetchGarrisonLoadout ;
//
private _props = [];

private _groupX = [_positionX, teamPlayer, groupsSDKSniper] call A3A_fnc_spawnGroup;
_groupX setBehaviour "STEALTH";
_groupX setCombatMode "GREEN";
// JB limited gear code
private _groupXUnits = units _groupX;
{
	[_x,_markerX] spawn A3A_fnc_FIAinitBases;
	[_x, _garrLoadouts] call A3A_fnc_assignGarrisonLoadout ;
}forEach _groupXUnits ;

private _campfire = createVehicle ["Land_Campfire_F", _positionX];
private _tent = ["Land_TentDome_F", getPosWorld _campfire] call BIS_fnc_createSimpleObject;
_tent setDir (random 360);
_tent setPos [(getPos _tent select 0) + 4, (getPos _tent select 1) + 4, (getPos _tent select 2) - 0.2]; 

_props pushBack _campfire;
_props pushBack _tent;

{
	_x setVectorUp surfaceNormal position _x;
} forEach _props;

waitUntil {
	sleep 1; 
	((spawner getVariable _markerX == 2)) or 
	({alive _x} count units _groupX == 0) or (!(_markerX in watchpostsFIA))
};

if ({alive _x} count units _groupX == 0) then {
	watchpostsFIA = watchpostsFIA - [_markerX]; publicVariable "watchpostsFIA";
	markersX = markersX - [_markerX]; publicVariable "markersX";
	sidesX setVariable [_markerX,nil,true];
	_nul = [5,-5,_positionX] remoteExec ["A3A_fnc_citySupportChange",2];
	deleteMarker _markerX;
	["TaskFailed", ["", "Watchpost Lost"]] remoteExec ["BIS_fnc_showNotification", 0];
};

//
waitUntil {sleep 1; (spawner getVariable _markerX == 2) or (!(_markerX in watchpostsFIA))};

// HangoverIt - ensure still an owned outpost. Clear and set all loadouts according to alive soldiers
private _outpLoadoutDespawn = [];
if (_markerX in watchpostsFIA) then {
	_mkrUnits = allunits select { (_x getVariable ["markerX", ""]) == _markerX; };
	_outpLoadoutDespawn = [_markerX] call A3A_fnc_fetchGarrisonLoadout ; // Fetch any other saved data (from other despawn routines)
	_outpLoadoutDespawn = [_outpLoadoutDespawn, _mkrUnits] call A3A_fnc_addGarrisonLoadout ;
	[_markerX, _outpLoadoutDespawn] call A3A_fnc_storeGarrisonLoadout;
};

{ 
    deleteVehicle _x 
} forEach units _groupX;
deleteGroup _groupX;

{
	deleteVehicle _x;
} forEach _props;