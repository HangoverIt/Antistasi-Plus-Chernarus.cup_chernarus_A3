params ["_typeGroup", ["_withBackpck", ""]];

if (player != theBoss) exitWith {["Recruit Squad", "Only the Commander has access to this function."] call A3A_fnc_customHint;};
if (markerAlpha respawnTeamPlayer == 0) exitWith {["Recruit Squad", "You cannot recruit a new squad while you are moving your HQ."] call A3A_fnc_customHint;};
if (!([player] call A3A_fnc_hasRadio)) exitWith {
    ["Recruit Squad", "You need a radio in your inventory to be able to give orders to other squads."] call A3A_fnc_customHint;
};

private _exit = false;
{
	if (((side _x == Invaders) or (side _x == Occupants)) and (_x distance petrovsky < 500) and ([_x] call A3A_fnc_canFight) and !(isPlayer _x)) exitWith {_exit = true};
} forEach allUnits;
if (_exit) exitWith {["Recruit Squad", "You cannot recruit squads with enemies near your HQ."] call A3A_fnc_customHint;};

if (_typeGroup isEqualType "") then {
	if (_typeGroup == "not_supported") then {_exit = true; ["Recruit Squad", "The group or vehicle type you requested is not supported in your modset."] call A3A_fnc_customHint;};
};

if (_exit) exitWith {};

if (_typeGroup isEqualTo groupsSDKAT && {tierWar < 3}) exitWith {
	["Recruit Squad", "You need to be at War Level 3 to be able to hire AT Teams."] call SCRT_fnc_misc_showDeniedActionHint;
};

if (_typeGroup in [SDKMGStatic, vehSDKLightArmed] && {tierWar < 2}) exitWith {
	["Recruit Squad", "You need to be at War Level 2 to be able to hire MG Squads and MG Cars."] call SCRT_fnc_misc_showDeniedActionHint;
};

if (_typeGroup in [vehSDKAT, staticAAteamPlayer] && {tierWar < 4}) exitWith {
	["Recruit Squad", "You need to be at War Level 4 to be able to hire AT or AA cars."] call SCRT_fnc_misc_showDeniedActionHint;
};

if (_typeGroup isEqualTo SDKMortar && {tierWar < 5}) exitWith {
	["Recruit Squad", "You need to be at War Level 5 to be able to hire Mortar Teams."] call SCRT_fnc_misc_showDeniedActionHint;
};

if (_typeGroup isEqualTo groupsSDKSquadSupp && {tierWar < 4}) exitWith {
	["Recruit Squad", "You need to be at War Level 4 to be able to hire Support squads."] call SCRT_fnc_misc_showDeniedActionHint;
};

private _isInfantry = false;
private _typeVehX = "";
private _costs = 0;
private _costHR = 0;
private _formatX = [];
private _format = "Squd-";

private _hr = server getVariable "hr";
private _resourcesFIA = server getVariable "resourcesFIA";

if (_typeGroup isEqualType []) then {
	{
		private _typeUnit = _x;
		_formatX pushBack _typeUnit;
		_costs = _costs + (server getVariable _typeUnit);
		_costHR = _costHR + 1;
	} forEach _typeGroup;

	if (_withBackpck == "MG") then {_costs = _costs + ([SDKMGStatic] call A3A_fnc_vehiclePrice)};
	if (_withBackpck == "Mortar") then {_costs = _costs + ([SDKMortar] call A3A_fnc_vehiclePrice)};
	_isInfantry = true;

} else {
	_costs = _costs + (2*(server getVariable staticCrewTeamPlayer)) + ([_typeGroup] call A3A_fnc_vehiclePrice);
	if (_typeGroup == staticAAteamPlayer) then { _costs = _costs + ([vehSDKTruck] call A3A_fnc_vehiclePrice) };
    _formatX = [staticCrewTeamPlayer,staticCrewTeamPlayer];
	_costHR = 2;

	if ((_typeGroup == SDKMortar) or (_typeGroup == SDKMGStatic)) exitWith { _isInfantry = true };
};

if (_hr < _costHR) then {_exit = true; ["Recruit Squad", format ["You do not have enough HR for this request (%1 required).",_costHR]] call A3A_fnc_customHint;};

if (_resourcesFIA < _costs) then {_exit = true; ["Recruit Squad", format ["You do not have enough money for this request (%1%2 required).",_costs, currencySymbol]] call A3A_fnc_customHint;};

if (_exit) exitWith {};

//JB code
private _squad = [];

if (_typeGroup in [SDKMGStatic, vehSDKAT, staticAAteamPlayer, SDKMortar, vehSDKLightArmed, vehSDKHeavyArmed]) then {
	_squad append [staticCrewTeamPlayer, staticCrewTeamPlayer];
};

if (_typeGroup in [groupsSDKAT, groupsSDKSniper, groupsSDKCrew, groupsSDKmid, groupsSDKSquad, groupsSDKSquadEng, groupsSDKSquadSupp, groupsSDKSentry]) then {
	_squad = +_typeGroup;
};

private ["_loadout"];
private _squadLoadout = [];
{
_loadout = rebelLoadouts get _x;
_squadLoadout pushBack _loadout;
} forEach _squad;

_fullSquadGear = _squadLoadout call A3A_fnc_reorgLoadoutSquad;

	_emptyList = [];
	{
	private "_number";
	_number = [jna_dataList select (_x select 0 call jn_fnc_arsenal_itemType), _x select 0]call jn_fnc_arsenal_itemCount; 
	if (_number < ((2 * ((_x select 1) + 1))) && !(_number == -1)) then { _emptyList pushBack (_x select 0) }
	} forEach _fullSquadGear;

if (count _emptyList > 0) exitWith {
		
		private _weaps = [];
		private _mags = [];
		private _strings = [];
		
		{
			_weaps = getText (configFile >> "CfgWeapons" >> _x >> "displayName");
			_strings pushBack _weaps;
			_mags = getText (configFile >> "CfgMagazines" >> _x >> "displayName");
			_strings pushBack _mags;
		} forEach _emptyList;
		
		_strings = _strings - [""];
		
	["Recruit Squad", format ["The following gear has run too low for you to recruit this squad: <t color='#ffff00'>%1", _strings], "FAIL"] call SCRT_fnc_ui_showDynamicTextMessage;
	};

{ [_x select 0 call jn_fnc_arsenal_itemType, _x select 0, _x select 1]call jn_fnc_arsenal_removeItem } forEach _fullSquadGear;

//
private _mounts = [];
private _vehType = switch true do {
    case (!_isInfantry && _typeGroup isEqualTo staticAAteamPlayer): {
        if (vehSDKAA isEqualTo "not_supported") exitWith {_mounts pushBack [staticAAteamPlayer,-1,[[1],[],[]]]; vehSDKTruck};
        vehSDKAA
    };
    case (!_isInfantry): {_typeGroup};
    case (count _formatX isEqualTo 2): {vehSDKBike};
    case (count _formatX > 4): {vehSDKTruck};
    default {vehSDKLightUnarmed};
};
private _idFormat = switch _typeGroup do {
    case groupsSDKmid: {"Tm-"};
    case groupsSDKAT: {"AT-"};
    case groupsSDKSniper: {"Snpr-"};
    case groupsSDKSentry: {"Stry-"};
    case groupsSDKCrew: {"Crew-"};
    case SDKMortar: {"Mort-"};
    case SDKMGStatic: {"MG-"};
    case vehSDKAT: {"M.AT-"};
    case vehSDKLightArmed: {"M.MG-"};
    case staticAAteamPlayer: {"M.AA-"};
    default {
        switch _withBackpck do {
            case "MG": {"SqMG-"};
            case "Mortar": {"Mortar"};
            default {"Squd-"};
        };
    };
};
private _special = if (_isInfantry) then {
    if (_typeGroup isEqualType []) then { _withBackpck } else {"staticAutoT"};
} else {
    if (_mounts isNotEqualTo []) exitWith {"BuildAA"};
    "VehicleSquad"
};

private _vehiclePlacementMethod = if (getMarkerPos respawnTeamPlayer distance player > 50) then {
    {
        private _searchCenter = getMarkerPos respawnTeamPlayer getPos [20 + random 30, random 360];
        private _spawnPos = _searchCenter findEmptyPosition [0, 30, _vehType];
        if (_spawnPos isEqualTo []) then {_spawnPos = _searchCenter};
        private _vehicle = _vehType createVehicle _spawnPos;

        if (_mounts isNotEqualTo []) then {
            private _static = staticAAteamPlayer createVehicle _spawnPos;
            private _nodes = [_vehicle, _static] call A3A_fnc_logistics_canLoad;
            if (_nodes isEqualType 0) exitWith {};
            (_nodes + [true]) call A3A_fnc_logistics_load;
            _static call HR_GRG_fnc_vehInit;
        };

        [_formatX, _idFormat, _special, _vehicle] spawn A3A_fnc_spawnHCGroup;
    }
} else { HR_GRG_fnc_confirmPlacement };
if (!_isInfantry) exitWith { [_vehType, "HCSquadVehicle", [_formatX, _idFormat, _special], _mounts] call _vehiclePlacementMethod };

private _vehCost = [_vehType] call A3A_fnc_vehiclePrice;
if (_isInfantry and (_costs + _vehCost) > server getVariable "resourcesFIA") exitWith {
    ["Recruit Squad", format ["No money left to buy a transport vehicle (%1%2 required), creating barefoot squad.",_vehCost, currencySymbol]] call A3A_fnc_customHint;
    [_formatX, _idFormat, _special, objNull] spawn A3A_fnc_spawnHCGroup;
};

createDialog "vehQuery";
sleep 1;
disableSerialization;
private _display = findDisplay 100;

if (str (_display) != "no display") then {
	private _ChildControl = _display displayCtrl 104;
	_ChildControl  ctrlSetTooltip format ["Buy a vehicle for this squad for %1%2.", _vehCost, currencySymbol];
	_ChildControl = _display displayCtrl 105;
	_ChildControl  ctrlSetTooltip "Barefoot Infantry";
};

waitUntil {(!dialog) or (!isNil "vehQuery")};
if ((!dialog) and (isNil "vehQuery")) exitWith { [_formatX, _idFormat, _special, objNull] spawn A3A_fnc_spawnHCGroup }; //spawn group call here

vehQuery = nil;
[_vehType, "HCSquadVehicle", [_formatX, _idFormat, _special], _mounts] call _vehiclePlacementMethod;
