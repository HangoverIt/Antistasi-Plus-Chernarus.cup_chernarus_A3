//NOTA: TAMBIÉN LO USO PARA FIA
if (!isServer and hasInterface) exitWith{};

private ["_markerX","_groups","_soldiers","_positionX","_num","_dataX","_prestigeOPFOR","_prestigeBLUFOR","_esAAF","_params","_frontierX","_array","_countX","_groupX","_dog","_grp","_sideX"];
_markerX = _this select 0;

testMarker = _markerX;

_groups = [];
_soldiers = [];

_positionX = getMarkerPos (_markerX);

_num = [_markerX] call A3A_fnc_sizeMarker;
_sideX = sidesX getVariable [_markerX,sideUnknown];

//
if (_markerX in ["city_StarySobor","city_Vybor","city_Berezino","city_Solnychniy","City_Severograd","city_Elektrozavodsk","city_Chernogorsk","city_Svetloyarsk","city_Zelenogorsk","city_Novodmitrovsk","City_NovayaPetrovka"]) then {
[_markerX, _sideX] spawn A3A_fnc_createPolStn;
};
//

if ((markersX - controlsX) findIf {(getMarkerPos _x inArea _markerX) and (sidesX getVariable [_x,sideUnknown] != _sideX)} != -1) exitWith {};
_num = round (_num / 100);

diag_log format ["[Antistasi] Spawning City Patrol in %1 (createAICities.sqf)", _markerX];

_dataX = server getVariable _markerX;
_prestigeOPFOR = _dataX select 2;
_prestigeBLUFOR = _dataX select 3;
_esAAF = true;
if (_markerX in destroyedSites) then {
	_esAAF = false;
	_params = [_positionX,Invaders,CSATSpecOp];
} else {
	switch (_sideX) do {
		case Occupants: {
			_num = round (_num * (_prestigeOPFOR + _prestigeBLUFOR)/100);
			_frontierX = [_markerX] call A3A_fnc_isFrontline;
			if (_frontierX) then {
				_num = _num * 2;
				private _sentry = groupsNATOSentry call SCRT_fnc_unit_selectInfantryTier;
				_params = [_positionX, Occupants, _sentry];
			} else {
				_params = [_positionX, Occupants, [policeOfficer, policeGrunt]];
			};
		};
		case Invaders: {
			_num = round (_num * (_prestigeOPFOR + _prestigeBLUFOR)/100);
			_frontierX = [_markerX] call A3A_fnc_isFrontline;
			if (_frontierX || {gameMode != 4}) then {
				_num = _num * 2;
				private _sentry = groupsCSATSentry call SCRT_fnc_unit_selectInfantryTier;
				_params = [_positionX, Invaders, _sentry];
			} else {
				_params = [_positionX, Invaders, [policeOfficer, policeGrunt]];
			};
		};
		case teamPlayer: {
			_esAAF = false;
			_num = round (_num * (_prestigeBLUFOR/100));
			_array = groupsSDKSentry;
			_params = [_positionX, teamPlayer, _array];
		};
	};
};
if (_num < 1) then {_num = 1};

_countX = 0;
while {(spawner getVariable _markerX != 2) and (_countX < _num)} do
	{
	_groupX = _params call A3A_fnc_spawnGroup;
	sleep 1;
	if (_esAAF) then
		{
		if (random 10 < 2.5) then
			{
			_dog = [_groupX, "Fin_random_F",_positionX,[],0,"FORM"] call A3A_fnc_createUnit;
			[_dog] spawn A3A_fnc_guardDog;
			};
		};
	_nul = [leader _groupX, _markerX, "SAFE", "RANDOM", "SPAWNED","NOVEH2", "NOFOLLOW"] execVM "scripts\UPSMON.sqf";//TODO need delete UPSMON link
	_groups pushBack _groupX;
	_countX = _countX + 1;
	};

if ((_esAAF) or (_markerX in destroyedSites)) then
	{
	{_grp = _x;
	// Forced non-spawner for performance and consistency with other garrison patrols
	{[_x,"",false] call A3A_fnc_NATOinit; _soldiers pushBack _x} forEach units _grp;} forEach _groups;
	}
else
	{
	{_grp = _x;
	{[_x] spawn A3A_fnc_FIAinitBases; _soldiers pushBack _x} forEach units _grp;} forEach _groups;
	};

waitUntil {sleep 1;(spawner getVariable _markerX == 2)};

{if (alive _x) then {deleteVehicle _x}} forEach _soldiers;
{deleteGroup _x} forEach _groups;
