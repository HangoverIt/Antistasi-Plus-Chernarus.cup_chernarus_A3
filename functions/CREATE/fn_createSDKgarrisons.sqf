if (!isServer and hasInterface) exitWith{};

private ["_markerX","_vehiclesX","_groups","_soldiers","_positionX","_staticsX","_garrison","_loadout"];

_markerX = _this select 0;

_vehiclesX = [];
_groups = [];
_soldiers = [];
_civs = [];
_positionX = getMarkerPos (_markerX);

if (_markerX != "Synd_HQ") then
{
	if (!(_markerX in citiesX)) then
	{
		private _veh = createVehicle [SDKFlag, _positionX, [],0, "NONE"];
		_veh allowDamage false;
		_vehiclesX pushBack _veh;
		[_veh,"SDKFlag"] remoteExec ["A3A_fnc_flagaction",0,_veh];

		if (_markerX in seaports) then
		{
			[_veh,"seaport"] remoteExec ["A3A_fnc_flagaction",[teamPlayer,civilian],_veh];
		};
	};
	if ((_markerX in resourcesX) or (_markerX in factories)) then
	{
		if (not(_markerX in destroyedSites)) then
		{
			if ((daytime > 8) and (daytime < 18)) then
			{
				private _groupCiv = createGroup civilian;
				_groups pushBack _groupCiv;
				for "_i" from 1 to 4 do
				{
					if (spawner getVariable _markerX != 2) then
					{
						private _civ = [_groupCiv, "C_man_w_worker_F", _positionX, [],0, "NONE"] call A3A_fnc_createUnit;
						_nul = _civ spawn A3A_fnc_CIVinit;
						_civs pushBack _civ;
						_civ setVariable ["markerX",_markerX,true];
						sleep 0.5;
						_civ addEventHandler ["Killed",
						{
							if (({alive _x} count units group (_this select 0)) == 0) then
							{
								private _markerX = (_this select 0) getVariable "markerX";
								private _nameX = [_markerX] call A3A_fnc_localizar;
								destroyedSites pushBackUnique _markerX;
								publicVariable "destroyedSites";
								["TaskFailed", ["", format ["%1 Destroyed",_nameX]]] remoteExec ["BIS_fnc_showNotification",[teamPlayer,civilian]];
							};
						}];
					};
				};
				//_nul = [_markerX,_civs] spawn destroyCheck;
				_nul = [leader _groupCiv, _markerX, "SAFE", "SPAWNED","NOFOLLOW", "NOSHARE","DORELAX","NOVEH2"] execVM "scripts\UPSMON.sqf";//TODO need delete UPSMON link
			};
		};
	};
};

private _size = [_markerX] call A3A_fnc_sizeMarker;
_staticsX = staticsToSave select {_x distance2D _positionX < _size};

_garrison = [];
_garrison = _garrison + (garrison getVariable [_markerX,[]]);

TestVar1 = _garrison;

private _garrLoadouts = [];
_garrLoadouts = _garrLoadouts + (SDKgarrLoadouts getVariable [_markerX + "_loadouts",[]]);

// Don't create these unless required
private _groupStatics = grpNull;
private _groupMortars = grpNull;

// Move riflemen into saved static weapons in area
{
	if !(isNil {_x getVariable "lockedForAI"}) then { continue };
	private _index = _garrison findIf {_x == SDKMil};
	if (_index == -1) exitWith {};
	private _unit = objNull;
	private _vehMortars = [SDKMortar, NATOMortar, CSATMortar];
	if (CSATHowitzer != "not_supported") then {
		_vehMortars pushBack CSATHowitzer;
	};
	if (NATOHowitzer != "not_supported") then {
		_vehMortars pushBack NATOHowitzer;
	};

	if (typeOf _x in _vehMortars) then {
		if (isNull _groupMortars) then { _groupMortars = createGroup teamPlayer };
		_unit = [_groupMortars, (_garrison select _index), _positionX, [], 0, "NONE"] call A3A_fnc_createUnit;
		_unit moveInGunner _x;
		_nul=[_x] execVM "scripts\UPSMON\MON_artillery_add.sqf";//TODO need delete UPSMON link
	}
	else {
		if (isNull _groupStatics) then { _groupStatics = createGroup teamPlayer };
		_unit = [_groupStatics, (_garrison select _index), _positionX, [], 0, "NONE"] call A3A_fnc_createUnit;
		_unit moveInGunner _x;
	};
	[_unit,_markerX] call A3A_fnc_FIAinitBases;
	
	_unit setUnitLoadout (configFile >> "EmptyLoadout");
	private _loadout = _garrLoadouts select _index;
	_unit setUnitLoadout _loadout;
	
	_soldiers pushBack _unit;
	_garrison deleteAT _index;
	
	_garrLoadouts deleteAT _index;
	
} forEach _staticsX;


// Make 8-man groups out of the remainder of the garrison

//JB Create indexed array

private _indexedGarr = [];
private _num = 0;
{
_indexedGarr append [[_num, _x]];
_num = _num + 1;
} foreach _garrison;

_indexedGarr = _indexedGarr call A3A_fnc_SDKGarrisonReorg;

_loadoudIndex = [];
_garrison = [];
	{
	_loadoudIndex pushBack (_x select 0);
	_garrison pushBack (_x select 1)
	} foreach _indexedGarr;
	
TestVar2 = _garrison;

private _totalUnits = count _garrison;
private _countUnits = 0;
private _countGroup = 8;
private _groupX = grpNull;

while {(spawner getVariable _markerX != 2) and (_countUnits < _totalUnits)} do
{
	if (_countGroup == 8) then
	{
		_groupX = createGroup teamPlayer;
		_groups pushBack _groupX;
		_countGroup = 0;
	};
	private _typeX = _garrison select _countUnits;
	private _unit = [_groupX, _typeX, _positionX, [], 0, "NONE"] call A3A_fnc_createUnit;
	if (_typeX == SDKSL) then {_groupX selectLeader _unit};
	[_unit,_markerX] call A3A_fnc_FIAinitBases;
	
	private _unitIndex = _loadoudIndex select _countUnits;
	private _loadout = _garrLoadouts select _unitIndex;
	_unit SetUnitLoadout _loadout;
	
	if (randomizeRebelLoadoutUniforms) then {
		private _uniforms = A3A_faction_reb getVariable "uniforms";
		private _uniformItems = uniformItems _unit;

		_unit forceAddUniform (selectRandom _uniforms);
		{_unit addItemToUniform _x} forEach _uniformItems;

		private _headgear = headgear _unit;

		//if it isn't a helmet - randomize
		if !(_headgear in allArmoredHeadgear) then {
			_unit addHeadgear (selectRandom (A3A_faction_reb getVariable "headgear"));
		};
	};
	
	_soldiers pushBack _unit;
	_countUnits = _countUnits + 1;
	_countGroup = _countGroup + 1;
	
	sleep 0.5;
};

TestVar3 = _soldiers;

for "_i" from 0 to (count _groups) - 1 do
{
	_groupX = _groups select _i;
	if (_i == 0) then
	{
		_nul = [leader _groupX, _markerX, "SAFE","SPAWNED","RANDOMUP","NOVEH2","NOFOLLOW"] execVM "scripts\UPSMON.sqf";//TODO need delete UPSMON link
	}
	else
	{
		_nul = [leader _groupX, _markerX, "SAFE","SPAWNED","RANDOM","NOVEH2","NOFOLLOW"] execVM "scripts\UPSMON.sqf";//TODO need delete UPSMON link
	};
};
waitUntil {sleep 1; (spawner getVariable _markerX == 2)};

private _garrLoadoutDespawn = [];
{ if (alive _x) then { _loadoutEnd = getUnitLoadout _x; _garrLoadoutDespawn append [_loadoutEnd]; deleteVehicle _x }; } forEach _soldiers;
SDKgarrLoadouts setVariable [_markerX + "_loadouts", _garrLoadoutDespawn, true];

{deleteVehicle _x} forEach _civs;

{deleteGroup _x} forEach _groups;
deleteGroup _groupStatics;
deleteGroup _groupMortars;

{if (!(_x in staticsToSave)) then {deleteVehicle _x}} forEach _vehiclesX;
