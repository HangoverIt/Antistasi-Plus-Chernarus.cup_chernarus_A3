private ["_hr","_resourcesFIA","_typeX","_costs","_markerX","_garrison","_positionX","_unit","_groupX","_veh","_pos","_loadout", "_arsenalIndex"];

_hr = server getVariable "hr";

if (_hr < 1) exitWith {
	["Garrison", "You don't have enough HR to recruit a new unit.", "FAIL"] call SCRT_fnc_ui_showDynamicTextMessage;
};

_resourcesFIA = server getVariable "resourcesFIA";

_typeX = _this select 0;

private _costs = server getVariable _typeX;

if (_costs > _resourcesFIA) exitWith {
	["Garrison",  format ["You do not have enough money for this kind of unit (%1%2 needed).", _costs, currencySymbol], "FAIL"] call SCRT_fnc_ui_showDynamicTextMessage;
};

_markerX = positionXGarr;

if (_typeX == staticCrewTeamPlayer && _markerX in (watchpostsFIA + roadblocksFIA + aapostsFIA + atpostsFIA + mortarpostsFIA + hmgpostsFIA)) exitWith {
	["Garrison", "You cannot add mortars to a Roadblock, Watchpost, AA, AT, Mortar, HMG emplacement garrisons.", "FAIL"] call SCRT_fnc_ui_showDynamicTextMessage;
};

_positionX = getMarkerPos _markerX;

if (surfaceIsWater _positionX) exitWith {
	["Garrison", "This Garrison is still updating, please try again in a few seconds.", "FAIL"] call SCRT_fnc_ui_showDynamicTextMessage;
};

if ([_positionX, 500] call A3A_fnc_enemyNearCheck) exitWith {
	["Garrison", "You cannot recruit with enemies near the zone.", "FAIL"] call SCRT_fnc_ui_showDynamicTextMessage;
};

private _exit = false;
{
	if (_x == _typeX) then {
		_exit = true;
	};
} forEach [SDKMG, SDKGL, SDKSniper];

if (_exit && {tierWar < 2}) exitWith {
	["Garrison", "You can not recruit this type of unit at war level 1.", "FAIL"] call SCRT_fnc_ui_showDynamicTextMessage;
};

if (_typeX == SDKATman && {tierWar < 4}) exitWith {
	["Garrison", "You can not recruit this type of unit at war level 3 or less.", "FAIL"] call SCRT_fnc_ui_showDynamicTextMessage;
};

if (_typeX == staticCrewTeamPlayer && {tierWar < 5}) exitWith {
	["Garrison", "You can not recruit this type of unit at war level 4 or less.", "FAIL"] call SCRT_fnc_ui_showDynamicTextMessage;
};

// JB Code for limited gear
_loadout = rebelLoadouts get _typeX;

_fullUnitGear = _loadout call A3A_fnc_reorgLoadoutUnit;

_cannotAllocateList = [];
{
	_arsenalIndex = (_x select 0) call jn_fnc_arsenal_itemType;
	if (_arsenalIndex >= 0) then {
		private _number = [jna_dataList select (_arsenalIndex), _x select 0] call jn_fnc_arsenal_itemCount; 
		if (_number < ((2 * ((_x select 1) + 1))) && (_number != -1)) then { _cannotAllocateList pushBack (_x select 0) };
	};
} forEach _fullUnitGear;

if (count _cannotAllocateList > 0) exitWith {
	
	private _weaps = [];
	private _mags = [];
	private _strings = [];
	
	{
		_weaps = getText (configFile >> "CfgWeapons" >> _x >> "displayName");
		_strings pushBack _weaps;
		_mags = getText (configFile >> "CfgMagazines" >> _x >> "displayName");
		_strings pushBack _mags;
	} forEach _cannotAllocateList;
	
	_strings = _strings - [""];
	
	["Garrison", format ["The following gear has run too low for you to recruit this unit: <t color='#ffff00'>%1", _strings], "FAIL"] call SCRT_fnc_ui_showDynamicTextMessage;
};

_garrLoadouts = (SDKgarrLoadouts getVariable [_markerX + "_loadouts",[]]);
_garrLoadouts pushBack _loadout;	
SDKgarrLoadouts setVariable [_markerX + "_loadouts", _garrLoadouts, true];

{ 
	_arsenalIndex = (_x select 0) call jn_fnc_arsenal_itemType;
	if (_arsenalIndex >= 0) then {
		[_x select 0 call jn_fnc_arsenal_itemType, _x select 0, _x select 1] call jn_fnc_arsenal_removeItem ;
	};
} forEach _fullUnitGear;
//

[-1,-_costs] remoteExec ["A3A_fnc_resourcesFIA",2];

_countX = count (garrison getVariable [_markerX,[]]);
[_typeX,teamPlayer,_markerX,1] remoteExec ["A3A_fnc_garrisonUpdate",2];
waitUntil {(_countX < count (garrison getVariable [_markerX, []])) or (sidesX getVariable [_markerX,sideUnknown] != teamPlayer)};

if (sidesX getVariable [_markerX,sideUnknown] == teamPlayer) then {
	private _garrisonInfo = format ["Soldier has been recruited.%1", [_markerX] call A3A_fnc_garrisonInfo];
	["Garrison", _garrisonInfo] call SCRT_fnc_ui_showDynamicTextMessage;

	if (spawner getVariable _markerX != 2) then {
		[_markerX,_typeX] remoteExec ["A3A_fnc_createSDKGarrisonsTemp",2];
	};
};
