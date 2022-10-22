if (!isServer and hasInterface) exitWith {};

private _markerX = _this select 0;
private _positionX = getMarkerPos _markerX;

private _radiusX = 1;
private _garrison = garrison getVariable [_markerX, []];
// JB limited gear code
private _garrLoadouts = (SDKgarrLoadouts getVariable [_markerX + "_loadouts",[]]);
//
private _veh = objNull;
private _road = objNull;


if (isNil "_garrison") then {//this is for backward compatibility, remove after v12
    _garrison = if (tierWar < 4) then {groupsSDKmid + [SDKMil,SDKMedic]} else {groupsSDKSquad};
    garrison setVariable [_markerX,_garrison,true];
};

while {true} do {
    _road = _positionX nearRoads _radiusX;
    if (count _road > 0) exitWith {};
    _radiusX = _radiusX + 5;
};

private _roadcon = roadsConnectedto (_road select 0);
private _dirveh = if(count _roadcon > 0) then {[_road select 0, _roadcon select 0] call BIS_fnc_DirTo} else {random 360};
private _roadPosition = getPos (_road select 0);

_pos = [_positionX, 7, _dirveh + 270] call BIS_Fnc_relPos;

if (SDKMil in _garrison) then {
    if (tierWar > 4) then { _veh = vehSDKHeavyArmed createVehicle _pos; _veh setDir _dirveh; } else { _veh = vehSDKLightArmed createVehicle _pos; _veh setDir _dirveh; };
    
    _veh lock 3;
    [_veh, teamPlayer] call A3A_fnc_AIVEHinit;
};


_pos = [_positionX, 9, _dirveh + 45] call BIS_Fnc_relPos;
_groupX = [_pos, teamPlayer, _garrison,true,false] call A3A_fnc_spawnGroup;
private _groupXUnits = units _groupX;
// JB limited gear code
private _num = 0;
{
    [_x,_markerX] spawn A3A_fnc_FIAinitBases; //
    private _loadout = _garrLoadouts select _num;
	_x setUnitLoadout _loadout;
	_num = _num +1
} forEach _groupXUnits;

sleep 1;
_groupX setFormation "STAG COLUMN";
sleep 1;
_groupX setFormDir _dirveh;
//
private _crewManIndex = _groupXUnits findIf {(_x getVariable "unitType") == "loadouts_reb_militia_Rifleman"};
if (_crewManIndex != -1) then {
    private _crewMan = _groupXUnits select _crewManIndex;
    _crewMan moveInGunner _veh;
    sleep 1;
    _crewMan lookAt (_crewMan getRelPos [200, _dirveh]);
};

		if (sunOrMoon < 1) then {
	_pos = [_positionX, 8, _dirveh + 220] call BIS_Fnc_relPos;
	private _lamp = createVehicle ["Land_LampStreet_small_F", _pos, [], 0, "CAN_COLLIDE"];
	_lamp setDir _dirveh;
	};

	_pos = [_positionX, -3.7, _dirveh + 270] call BIS_Fnc_relPos;
	_barrier = createVehicle ["Land_BarGate_F", _positionX, [], 0, "CAN_COLLIDE"];
	_barrier setDir _dirveh;
	_barrier setPos _pos;
	_barrier allowDamage false;

	_nul = [_barrier] SPAWN {while {true} do { 
		private _vehList = [];    
 		waitUntil {sleep 0.1; _vehList = (getposATL (_this select 0)) nearEntities [["Car", "Motorcycle", "Tank", "TrackedAPC", "WheeledAPC"], 60]; 
		count (_vehList select {(side _x isEqualTo independent or side _x isEqualTo civilian)}) > 1};
		(_this select 0) animate ["Door_1_rot", 1]; 

		waitUntil {sleep 1; count ((getposATL (_this select 0)) nearEntities [["Car", "Motorcycle", "Tank", "TrackedAPC", "WheeledAPC"], 60] select {(side _x isEqualTo independent or side _x isEqualTo civilian)}) == 1};    
		(_this select 0) animate ["Door_1_rot", 0];     
		};
	};

waitUntil {
	sleep 1; 
	((spawner getVariable _markerX == 2)) or 
	({alive _x} count units _groupX == 0) or (!(_markerX in roadblocksFIA))
};

if ({alive _x} count units _groupX == 0) then {
	roadblocksFIA = roadblocksFIA - [_markerX]; publicVariable "roadblocksFIA";
	markersX = markersX - [_markerX]; publicVariable "markersX";
	sidesX setVariable [_markerX,nil,true];
	_nul = [5,-5,_positionX] remoteExec ["A3A_fnc_citySupportChange",2];
	deleteMarker _markerX;
	["TaskFailed", ["", "Roadblock Lost"]] remoteExec ["BIS_fnc_showNotification", 0];
};

waitUntil {sleep 1; (spawner getVariable _markerX == 2) or (!(_markerX in roadblocksFIA))};

private _outpLoadoutDespawn = [];
{ if (alive _x) then { _loadoutEnd = getUnitLoadout _x; _outpLoadoutDespawn append [_loadoutEnd]; deleteVehicle _x }; } forEach units _groupX;
SDKgarrLoadouts setVariable [_markerX + "_loadouts", _outpLoadoutDespawn, true];

deleteVehicle _barricade;
deleteVehicle _lamp;
deleteVehicle _barrier;



if (!isNull _veh) then { 
    deleteVehicle _veh;
};

{ 
    deleteVehicle _x 
} forEach units _groupX;
deleteGroup _groupX;