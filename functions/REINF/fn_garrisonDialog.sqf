params ["_typeX", "_site"];

private ["_garrison","_costs","_hr","_size"];

private _watchpostFIA = if (_site in watchpostsFIA) then {true} else {false};
private _roadblockFIA = if (_site in roadblocksFIA) then {true} else {false};
private _aapostFIA = if (_site in aapostsFIA) then {true} else {false};
private _atpostFIA = if (_site in atpostsFIA) then {true} else {false};
private _mortarpostFIA = if (_site in mortarpostsFIA) then {true} else {false};
private _hmgpostFIA = if (_site in hmgpostsFIA) then {true} else {false};

_garrison = if (!_watchpostFIA) then {
	garrison getVariable [_site,[]]
} else {
	SDKSniper
};
//JB code

private _garrLoadouts = [_site] call A3A_fnc_fetchGarrisonLoadout ;

if (_typeX == "rem") then {
	if ((count _garrison == 0) and {!(_watchpostFIA) || !(_roadblockFIA) || !(_aapostFIA) || !(_atpostFIA)}) exitWith {
		[
			"FAIL",
			"Disband",
			parseText "This place has no garrisoned troops to remove.",
			30
		] spawn SCRT_fnc_ui_showMessage;
	};
	_costs = 0;
	_hr = 0;

	switch (true) do {
		case (_watchpostFIA): {
			_costs = 50;
			_hr = 0;
			{
				_costs = _costs + (server getVariable [_x,0]);
				_hr = _hr + 1;
			} forEach groupsSDKSniper;
			_costs = round (_costs * 0.75);
		};
		case (_roadblockFIA): {
			if (tierWar > 4) then { _costs = [vehSDKHeavyArmed] call A3A_fnc_vehiclePrice } else { _costs = [vehSDKLightArmed] call A3A_fnc_vehiclePrice }; //car with mg
			_hr = 0;
			{
				_costs = _costs + (server getVariable [_x,0]);
				_hr = _hr + 1;
			} forEach groupsSDKSquad;
			_costs = round (_costs * 0.75);
		};
		case (_aapostFIA): {
			_costs = [staticAAteamPlayer] call A3A_fnc_vehiclePrice; //AA
			_hr = 0;
			{
				_costs = _costs + (server getVariable [_x,0]);
				_hr = _hr +1;
			} forEach [SDKSL,SDKMG,SDKMil,SDKMil,SDKMedic];
			_costs = round (_costs * 0.75);
		};
		case (_atpostFIA): {
			_costs = [staticATteamPlayer] call A3A_fnc_vehiclePrice; //AT
			_hr = 0;
			{
				_costs = _costs + (server getVariable [_x,0]);
				_hr = _hr +1;
			} forEach [SDKSL,SDKMil,SDKATman,SDKATman,SDKMedic];
			_costs = round (_costs * 0.75);
		};
		case (_mortarpostFIA): {
			_costs = [SDKMortar] call A3A_fnc_vehiclePrice; //Mortar
			_hr = 0;
			{
				_costs = _costs + (server getVariable [_x,0]);
				_hr = _hr +1;
			} forEach [SDKSL,SDKMG,SDKMil,SDKMil,SDKMedic];
			_costs = round (_costs * 0.75);
		};
		case (_hmgpostFIA): {
			_costs = [SDKMGStatic] call A3A_fnc_vehiclePrice; //HMG
			_hr = 0;
			{
				_costs = _costs + (server getVariable [_x,0]);
				_hr = _hr +1;
			} forEach [SDKSL,SDKMG,SDKMil,SDKMil,SDKMedic];
			_costs = round (_costs * 0.75);
		};
		default {
			{
				if (_x == staticCrewTeamPlayer) then {
					if (_outpostFIA) then {
						_costs = _costs + ([vehSDKLightArmed] call A3A_fnc_vehiclePrice)
					} else {
						_costs = _costs + ([SDKMortar] call A3A_fnc_vehiclePrice)
					};
				};
				_hr = _hr + 1;
				_costs = _costs + (server getVariable [_x,0]);
			} forEach _garrison;
		};
	};

	[_hr,_costs] remoteExec ["A3A_fnc_resourcesFIA",2];

	//JB code to return gear to arsenal
	
	_allSingle = []; 
	_allDouble = [];
	_allTriple = [];

	{ 
		_loadout = _x select 1 ;
		_loadout params ["_primary", "_secondary", "_handgun", "_uniform", "_vest", "_backpack", "_headgear", "_facewear", "_binocular", "_items"];
		
		_loadoutArray = _primary + _secondary + _handgun + _binocular;
		_loadoutArray append _items;
		_loadoutArray pushBack _headgear;
		_loadoutArray pushBack _facewear;
		if (count _uniform > 0) then { _loadoutArray pushBack (_uniform select 0); _loadoutArray append (_uniform select 1) };
		if (count _vest > 0) then { _loadoutArray pushBack (_vest select 0); _loadoutArray append (_vest select 1) };
		if (count _backpack > 0) then { _loadoutArray pushBack (_backpack select 0); _loadoutArray append (_backpack select 1) };
		
		for "_i" from count _loadoutArray -1 to 0 step -1 do{
			if ((_loadoutArray select _i) isEqualTo []) then {_loadoutArray deleteAt _i} ;
		};
		
		_loadoutArray = _loadoutArray - [""];
		
		_singleArray = [];
		_doubleArray = [];
		_tripleArray = [];
		
		{
			if (count _x == 2) then { _doubleArray pushBack _x };
			if (count _x == 3) then { _tripleArray pushBack _x };
		} forEach _loadoutArray;
		
		_singleArray = _loadoutArray - _doubleArray - _tripleArray;
		
		_allSingle append _singleArray; 
		_allDouble append _doubleArray;
		_allTriple append _tripleArray;	
		
	} forEach _garrLoadouts;

	//single code

	_allSingleCons = _allSingle call BIS_fnc_consolidateArray;


	//treble code

	_allTripleCons = [];	
	{
		_allTripleCons append [[(_x select 0),(_x select 1) * (_x select 2)]] ;
	} foreach _allTriple;

	//consolidate all

	_allCons = _allSingleCons + _allDouble + _allTripleCons;
	
	//for "_i" from count _allCons -1 to 0 step -1 do {
	//	if ((_allCons select _i) isEqualTo []) then {_allCons deleteAt _i} ;
	//};

	private _fullSquadGear = [];   
	{ 
		_fullSquadGear = [_fullSquadGear, (_x select 0),(_x select 1)] call BIS_fnc_addToPairs ;
		if (isNil "_allTripleCons") then {diag_log format["ERROR: cannot create squad gear list for _allCons %1", _allCons];};
	} foreach _allCons;

	{ [_x select 0 call jn_fnc_arsenal_itemType, _x select 0, _x select 1]call jn_fnc_arsenal_addItem } forEach _fullSquadGear;
	[_site, true] call A3A_fnc_clearGarrisonLoadout ;


	switch (true) do {
		case (_watchpostFIA): {
			garrison setVariable [_site,nil,true];
			watchpostsFIA = watchpostsFIA - [_site]; publicVariable "watchpostsFIA";
			markersX = markersX - [_site]; publicVariable "markersX";
			deleteMarker _site;
			sidesX setVariable [_site,nil,true];
		};
		case (_roadblockFIA): {
			garrison setVariable [_site,nil,true];
			roadblocksFIA = roadblocksFIA - [_site]; publicVariable "roadblocksFIA";
			markersX = markersX - [_site]; publicVariable "markersX";
			deleteMarker _site;
			sidesX setVariable [_site,nil,true];
		};
		case (_aapostFIA): {
			garrison setVariable [_site,nil,true];
			aapostsFIA = aapostsFIA - [_site]; publicVariable "aapostsFIA";
			markersX = markersX - [_site]; publicVariable "markersX";
			deleteMarker _site;
			sidesX setVariable [_site,nil,true];
		};
		case (_atpostFIA): {
			garrison setVariable [_site,nil,true];
			atpostsFIA = atpostsFIA - [_site]; publicVariable "atpostsFIA";
			markersX = markersX - [_site]; publicVariable "markersX";
			deleteMarker _site;
			sidesX setVariable [_site,nil,true];
		};
		case (_mortarpostFIA): {
			garrison setVariable [_site,nil,true];
			mortarpostsFIA = mortarpostsFIA - [_site]; publicVariable "mortarpostsFIA";
			markersX = markersX - [_site]; publicVariable "markersX";
			deleteMarker _site;
			sidesX setVariable [_site,nil,true];
		};
		case (_hmgpostFIA): {
			garrison setVariable [_site,nil,true];
			hmgpostsFIA = hmgpostsFIA - [_site]; publicVariable "hmgpostsFIA";
			markersX = markersX - [_site]; publicVariable "markersX";
			deleteMarker _site;
			sidesX setVariable [_site,nil,true];
		};
		default {
			garrison setVariable [_site,[],true];
			{if (_x getVariable ["markerX",""] == _site) then {deleteVehicle _x}} forEach allUnits;
		};
	};
	
	[_site] call A3A_fnc_mrkUpdate;

	[
		"SUCCESS",
		"Disband",
		parseText format ["Garrison removed. Gear returned to arsenal.<br/>Recovered Money: %1%3<br/>Recovered HR: %2", _costs, _hr, currencySymbol],
		30
	] spawn SCRT_fnc_ui_showMessage;
} else {
    
	positionXGarr = _site;
	["Garrison", format ["Info%1",[_site] call A3A_fnc_garrisonInfo]] call A3A_fnc_customHint;
	createDialog "garrisonRecruit";
	sleep 1;
	disableSerialization;

	_display = findDisplay 100;

	if (str (_display) != "no display") then {
		_ChildControl = _display displayCtrl 104;
		_ChildControl  ctrlSetTooltip format ["Cost: %1%2",server getVariable SDKMil, currencySymbol];
		_ChildControl = _display displayCtrl 105;
		_ChildControl  ctrlSetTooltip format ["Cost: %1%2",server getVariable SDKMG, currencySymbol];
		_ChildControl = _display displayCtrl 126;
		_ChildControl  ctrlSetTooltip format ["Cost: %1%2",server getVariable SDKMedic, currencySymbol];
		_ChildControl = _display displayCtrl 107;
		_ChildControl  ctrlSetTooltip format ["Cost: %1%2",server getVariable SDKSL, currencySymbol];
		_ChildControl = _display displayCtrl 108;
		_ChildControl  ctrlSetTooltip format ["Cost: %1%2",server getVariable SDKATman, currencySymbol];
		_ChildControl = _display displayCtrl 109;
		_ChildControl  ctrlSetTooltip format ["Cost: %1%2",server getVariable SDKGL, currencySymbol];
		_ChildControl = _display displayCtrl 110;
		_ChildControl  ctrlSetTooltip format ["Cost: %1%2",server getVariable SDKSniper, currencySymbol];
		_ChildControl = _display displayCtrl 111;
		_ChildControl  ctrlSetTooltip format ["Cost: %1%2",server getVariable SDKEng, currencySymbol];
	};
};