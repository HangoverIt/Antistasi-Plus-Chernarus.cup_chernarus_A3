disableSerialization;

private _display = findDisplay 110000;

if (str (_display) == "no display") exitWith {};

private _vehicleTypeComboBox = _display displayCtrl 715;
private _index = lbCurSel _vehicleTypeComboBox;
private _vehicleType = _vehicleTypeComboBox lbData _index;
private _shopLookupArray = [];

switch(_vehicleType) do {
    case("CIV"): {
        private _avaialbleVehs = [civBike, civCar, civTruck, civHeli, civBoat] select {_x != "not_supported"};
        _shopLookupArray = _avaialbleVehs;
    };
    case("MIL"): {
        _shopLookupArray = [vehSDKTruck, vehSDKLightUnarmed];
        if (tierWar > 1 && tierWar < 4) then {
            _shopLookupArray append [vehSDKLightArmed];
        };

		if (tierWar > 1) then {
            _shopLookupArray append [SDKMGStatic];
        };

        if (tierWar > 3) then {
            private _avaialbleVehs = [vehSDKHeavyArmed, vehSDKAT, vehSDKAA, staticATteamPlayer, staticAAteamPlayer] select {_x != "not_supported"};
            _shopLookupArray append _avaialbleVehs;
        };

        if (tierWar > 4) then {
            _shopLookupArray pushBack SDKMortar;
        };

        if ({sidesX getVariable [_x,sideUnknown] == teamPlayer} count resourcesX > 4) then {
            _shopLookupArray pushBack vehSDKFuel;
        };

        if ({sidesX getVariable [_x,sideUnknown] == teamPlayer} count factories > 4) then {
            _shopLookupArray pushBack vehSDKRepair;
        };

        if ({sidesX getVariable [_x,sideUnknown] == teamPlayer} count airportsX > 0) then {
            _shopLookupArray pushBack vehSDKPlane;
        };
    };
    case("TECH"): {
        if (tierWar > 2) then {
            _shopLookupArray pushBack vehSDKLightUnarmedArmored;
        };

        if (tierWar > 4) then {
            _shopLookupArray append [technicalArmoredBtr, technicalArmoredAa, technicalArmoredSpg, technicalArmoredMg];
        };
    };
    default { 
        [1, format ["Bad Vehicle Type - %1 ", _vehicleType], "fn_ui_setAvailableBuyVehicleTypes"] call A3A_fnc_log;
    };
};

if (isNil "_shopLookupArray") exitWith {
    [1, "Fatal Error - no lookup array for vehicle store, aborting.", "fn_ui_setAvailableBuyVehicleTypes"] call A3A_fnc_log;
};


private _vehicleComboBox = _display displayCtrl 705;
lbClear _vehicleComboBox;

private _fillCombo = {
    params ["_shopArray", "_comboBox"];

    {
        private _name = getText (configFile >> "CfgVehicles" >> _x >> "displayName");
        _comboBox lbAdd _name;
        _comboBox lbSetData [_forEachIndex, _x];
    } forEach _shopArray;
};

[_shopLookupArray, _vehicleComboBox] call _fillCombo;

_vehicleComboBox lbSetCurSel 0;