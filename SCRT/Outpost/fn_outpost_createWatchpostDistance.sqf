if (!isServer and hasInterface) exitWith {};

private _markerX = _this select 0;
private _positionX = getMarkerPos _markerX;
// JB limited gear code
private _garrLoadouts = (SDKgarrLoadouts getVariable [_markerX + "_loadouts",[]]);
//
private _props = [];

private _groupX = [_positionX, teamPlayer, groupsSDKSniper] call A3A_fnc_spawnGroup;
_groupX setBehaviour "STEALTH";
_groupX setCombatMode "GREEN";
// JB limited gear code
private _num = 0;
{
	[_x,_markerX] spawn A3A_fnc_FIAinitBases; //
	private _loadout = _garrLoadouts select _num;
	_x setUnitLoadout _loadout;
	_num = _num +1
} forEach units _groupX;

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

waitUntil {sleep 1; (spawner getVariable _markerX == 2) or (!(_markerX in watchpostsFIA))};

private _outpLoadoutDespawn = [];
{ if (alive _x) then { _loadoutEnd = getUnitLoadout _x; _outpLoadoutDespawn append [_loadoutEnd]; deleteVehicle _x }; } forEach units _groupX;
SDKgarrLoadouts setVariable [_markerX + "_loadouts", _outpLoadoutDespawn, true];

{ 
    deleteVehicle _x 
} forEach units _groupX;
deleteGroup _groupX;

{
	deleteVehicle _x;
} forEach _props;