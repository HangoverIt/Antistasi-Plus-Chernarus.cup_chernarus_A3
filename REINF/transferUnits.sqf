private ["_positionTel","_allPlayers","_thingX","_groupX","_nearPlayers","_distance","_distances","_closestDistance","_index","_selectedPlayer","_SL","_name","_costs","_hr","_SLType"];

_thingX = _this select 0;

_groupX = grpNull;
_unitsX = objNull;

if ((_thingX select 0) isEqualType grpNull) then {
	_groupX = _thingX select 0;
	_unitsX = units _groupX;
} else {
	_unitsX = _thingX;
};

showCommandingMenu "";

if (((_thingX select 0) isEqualType grpNull) && (count _thingX > 1)) exitWith {["Transfer units", "Select only one squad at a time to transfer."] call A3A_fnc_customHint;};

if (!visibleMap) then {openMap true};
positionTel = [];

onMapSingleClick "positionTel = _pos";

["Transfer Units", "Select the player to transfer units to."] call A3A_fnc_customHint;

waitUntil {sleep 0.5; (count positionTel > 0) or (not visiblemap)};
onMapSingleClick "";

if (!visibleMap) exitWith {};

_positionTel = positionTel;

_nearPlayers = [50, _positionTel, teamPlayer] call SCRT_fnc_common_getNearPlayers;

if (!((_thingX select 0) isEqualType grpNull) && (player in _nearPlayers)) then {_nearPlayers = _nearPlayers - [player]};

if (count _nearPlayers == 0) exitWith {["Transfer Units", "You must click near a player unit."] call A3A_fnc_customHint;};

if (count _nearPlayers > 1) then {
	{
	_distance = _x distance _positionTel;
	_distances pushBack _distance;
	} forEach _nearPlayers;
	_closestDistance = selectMin _distances;
	_index = _distances find _closestDistance;
	_selectedPlayer = _nearPlayers select _index;
} else {
	_selectedPlayer = _nearPlayers select 0;
};

if (lifeState _selectedPlayer == "INCAPACITATED") exitWith {["Transfer Units", "The selected player is incapacitated."] call A3A_fnc_customHint;};

if ((_unitsX select 0) distance _selectedPlayer > 250) exitWith {["Transfer Units", "The units are too far from the chosen player (max 250m)."] call A3A_fnc_customHint;};

createDialog "transferQuery";
sleep 1;
disableSerialization;
private _display = findDisplay 100;

_name = name _selectedPlayer;

if (str (_display) != "no display") then {
	private _ChildControl = _display displayCtrl 104;
	_ChildControl  ctrlSetTooltip format ["Transfer units to %1.", _name];
	_ChildControl = _display displayCtrl 105;
	_ChildControl  ctrlSetTooltip "Cancel transfer";
};

waitUntil {(!dialog) or (!isNil "transferQuery")};
if ((!dialog) and (isNil "transferQuery")) exitWith {["Transfer Units", "Transfer cancelled."] call A3A_fnc_customHint;};

transferQuery = nil;

_SL = _unitsX select {(_x getVariable "unitType") in squadLeaders};
if (count _SL > 0) then {
	_unitsX = _unitsX - _SL;
	_costs = 0;
	_hr = 0;
	_SLType = [];
	{
	_cost = _costs + (server getVariable (_x getVariable "unitType"));
	_hr = _hr + 1;
	_SLType pushBack (_x getVariable "unitType");
	} forEach _SL;
	[_hr,_costs,_SLType] remoteExec ["A3A_fnc_resourcesFIA",2];
	{
	deleteVehicle _x;
	} forEach _SL;
};

_unitsX join (group _selectedPlayer);
if (_groupX isEqualType grpNull) then {deleteGroup _groupX};

["Transfer Units", format ["Transferring units to %1.", _name]] call A3A_fnc_customHint;

if (visibleMap) then {openMap false};