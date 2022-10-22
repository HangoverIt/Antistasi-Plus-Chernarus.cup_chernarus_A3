//if (!isServer) exitWith{};

if (player != leader group player) exitWith {["Dismiss Group", "You cannot dismiss anyone if you are not the squad leader."] call A3A_fnc_customHint;};

private ["_units","_hr","_resourcesFIA","_unit","_newGroup"];

_units = _this select 0;
_units = _units - [player];
_units = _units select { !(isPlayer _x) && { !(_x == petrovsky) } };
if (_units isEqualTo []) exitWith {};
if (_units findIf {!([_x] call A3A_fnc_canFight)} != -1) exitWith {["Dismiss Group", "You cannot disband suppressed, undercover or unconscious units."] call A3A_fnc_customHint;};
player globalChat "Stand down and get some rest, there will be more battles ahead.";

_newGroup = createGroup teamPlayer;
//if ({isPlayer _x} count units group player == 1) then {_ai = true; _newGroup = createGroup teamPlayer};

{
if ((_x getVariable "unitType") != SDKUnarmed) then
	{
	[_x] join _newGroup;
	arrayids = arrayids + [name _x];
	};
} forEach _units;

if (recruitCooldown < time) then {recruitCooldown = time + 60} else {recruitCooldown = recruitCooldown + 60};


_LeaderX = leader _newGroup;

{_x domove getMarkerPos respawnTeamPlayer} forEach units _newGroup;

_timeX = time + 120;

waitUntil {sleep 1; (time > _timeX) or ({(_x distance getMarkerPos respawnTeamPlayer < 50) and (alive _x)} count units _newGroup == {alive _x} count units _newGroup)};

_hr = 0;
_resourcesFIA = 0;

{_unit = _x;
if ([_unit] call A3A_fnc_canFight) then
	{
	_resourcesFIA = _resourcesFIA + (server getVariable (_unit getVariable "unitType"));
	_hr = _hr +1;
	_loadout = getUnitLoadout _x;
	_fullUnitGear = _loadout call A3A_fnc_reorgLoadoutUnit;
	{ [_x select 0 call jn_fnc_arsenal_itemType, _x select 0, _x select 1]call jn_fnc_arsenal_addItem } forEach _fullUnitGear;
	};
deleteVehicle _x;
} forEach units _newGroup;
if (!isMultiplayer) then {_nul = [_hr,_resourcesFIA] remoteExec ["A3A_fnc_resourcesFIA",2];} else {_nul = [_hr,0] remoteExec ["A3A_fnc_resourcesFIA",2]; [_resourcesFIA] call A3A_fnc_resourcesPlayer};

deleteGroup _newGroup;