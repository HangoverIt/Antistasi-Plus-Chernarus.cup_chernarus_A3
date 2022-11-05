private _moneyCost = outpostCost select 0;
private _hrCost = outpostCost select 1;

private _resourcesFIA = server getVariable "resourcesFIA";
private _hrFIA = server getVariable "hr";

if ((_resourcesFIA < _moneyCost) or (_hrFIA < _hrCost)) exitWith {
	[
        "FAIL",
        "Establish Outpost",  
        parseText format ["You have not enough resources to establish new outpost.<br/> %1 HR and %2%3 needed.", _hrCost, _moneyCost, currencySymbol], 
        15
    ] spawn SCRT_fnc_ui_showMessage;
};

if ("outpostTask" in A3A_activeTasks) exitWith {
    [
        "FAIL",
        "Establish Outpost",  
        parseText "We can only deploy / delete one outpost at time.", 
        15
    ] spawn SCRT_fnc_ui_showMessage;
};

if (!([player] call A3A_fnc_hasRadio)) exitWith {
    [
        "FAIL",
        "Establish Outpost",  
        parseText "You need a radio in your inventory to be able to give orders to other squads while establishing outpost.", 
        15
    ] spawn SCRT_fnc_ui_showMessage;
};

if (outpostType in ["ROADBLOCK", "HMG"] && {tierWar < 2}) exitWith {
    [
        "FAIL",
        "Establish Outpost",  
        parseText "You need to be at War Level 2 to be able to establish roadblocks or HMG emplacements.", 
        15
    ] spawn SCRT_fnc_ui_showMessage;
};

if (outpostType in ["AA", "AT"] && {tierWar < 4}) exitWith {
    [
        "FAIL",
        "Establish Outpost",  
        parseText "You need to be at War Level 4 to be able to establish AA/AT emplacement.", 
        15
    ] spawn SCRT_fnc_ui_showMessage;
};

if (outpostType == "MORTAR" && {tierWar < 5}) exitWith {
    [
        "FAIL",
        "Establish Outpost",  
        parseText "You need to be at War Level 5 to be able to establish mortar emplacement.", 
        15
    ] spawn SCRT_fnc_ui_showMessage;
};

_garrison = [];

if (outpostType == "AA") then {
            _garrison append [SDKSL,SDKMG,SDKMil,SDKMil,SDKMedic];
};

if (outpostType == "AT") then {
            _garrison append [SDKSL,SDKMil,SDKATman,SDKATman,SDKMedic];
};

if (outpostType in ["HMG", "MORTAR"]) then {
            _garrison append [SDKSL,SDKMG,SDKMil,SDKMil,SDKMedic];
};

if (outpostType == "ROADBLOCK") then {
            _garrison append (if (tierWar < 4) then {groupsSDKmid + [SDKMil,SDKMedic]} else {groupsSDKSquad});
};

if (outpostType == "WATCHPOST") then {
            _garrison append groupsSDKSniper;
};
diag_log format["DEBUG: Calling A3A_fnc_reorgLoadoutSquad with _garrison = %1", _garrison] ;
_fullSquadGear = _garrison call A3A_fnc_reorgLoadoutSquad;

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
		
	["Establish Outpost", format ["The following gear has run too low for you to recruit the squad for this outpost: <t color='#ffff00'>%1", _strings], "FAIL"] call SCRT_fnc_ui_showDynamicTextMessage;
	};

{ [_x select 0 call jn_fnc_arsenal_itemType, _x select 0, _x select 1]call jn_fnc_arsenal_removeItem } forEach _fullSquadGear;

["disbandGarrison", "onMapSingleClick"] call BIS_fnc_removeStackedEventHandler;
["establishOutpost", "onMapSingleClick"] call BIS_fnc_removeStackedEventHandler;
["minefieldMap", "onMapSingleClick"] call BIS_fnc_removeStackedEventHandler;
["recruitGarrison", "onMapSingleClick"] call BIS_fnc_removeStackedEventHandler;
["ADD"] call SCRT_fnc_ui_establishOutpostEventHandler;

[
    "INFO",
    "Establish Outpost",  
    parseText "Click on desired position on map to establish outpost there.", 
    60
] spawn SCRT_fnc_ui_showMessage;