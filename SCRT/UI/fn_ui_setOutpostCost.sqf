disableSerialization;

private _display = findDisplay 60000;

if (str (_display) == "no display") exitWith {};

private _costTextBox = _display displayCtrl 2751;
private _comboBox = _display displayCtrl 2750;
private _index = lbCurSel _comboBox;
private _outpostType =  lbData [2750, _index];

outpostType = _outpostType;
private _costs = 50;
private _hr = 0;

switch (outpostType) do {
    case ("WATCHPOST"): {
        _costs = 50;
        _hr = 0;
        {
            _costs = _costs + (server getVariable [_x,0]);
            _hr = _hr + 1; 
        } forEach groupsSDKSniper;
        _costTextBox ctrlSetText format ["Costs %1 HR and %2%3", _hr, _costs, currencySymbol];
    };
    case ("ROADBLOCK"): {
       if (tierWar > 3) then {  _costs = [vehSDKHeavyArmed] call A3A_fnc_vehiclePrice } else {  _costs = [vehSDKLightArmed] call A3A_fnc_vehiclePrice }; //MG car
        _hr = 0; //static gunner
        private _rbhr = [];
        _rbhr append (if (tierWar < 4) then {groupsSDKmid + [SDKMil,SDKMedic]} else {groupsSDKSquad});
        {
            _costs = _costs + (server getVariable [_x,0]);
            _hr = _hr + 1;
        } forEach _rbhr;
        _costTextBox ctrlSetText format ["Costs %1 HR and %2%3", _hr, _costs, currencySymbol];
    };
    case ("AA"): {
        _costs = [staticAAteamPlayer] call A3A_fnc_vehiclePrice;
        _hr = 0;
        {
            _costs = _costs + (server getVariable [_x,0]); 
            _hr = _hr +1;
        } forEach [SDKSL,SDKMG,SDKMil,SDKMil,SDKMedic];
       _costTextBox ctrlSetText format ["Costs %1 HR and %2%3", _hr, _costs, currencySymbol];
    };
    case ("AT"): {
        _costs = [staticATteamPlayer] call A3A_fnc_vehiclePrice; //AT
        _hr = 0; //static gunner
        {
            _costs = _costs + (server getVariable [_x,0]); 
            _hr = _hr +1;
        } forEach [SDKSL,SDKMil,SDKATman,SDKATman,SDKMedic];
       _costTextBox ctrlSetText format ["Costs %1 HR and %2%3", _hr, _costs, currencySymbol];
    };
    case ("MORTAR"): {
        _costs = [SDKMortar] call A3A_fnc_vehiclePrice; //Mortar
        _hr = 0; //static gunner
        {
            _costs = _costs + (server getVariable [_x,0]); 
            _hr = _hr +1;
        } forEach [SDKSL,SDKMG,SDKMil,SDKMil,SDKMedic];
       _costTextBox ctrlSetText format ["Costs %1 HR and %2%3", _hr, _costs, currencySymbol];
    };
    case ("HMG"): {
        _costs = [SDKMGStatic] call A3A_fnc_vehiclePrice;
        _hr = 0; //static gunner
        {
            _costs = _costs + (server getVariable [_x,0]); 
            _hr = _hr +1;
        } forEach [SDKSL,SDKMG,SDKMil,SDKMil,SDKMedic];
       _costTextBox ctrlSetText format ["Costs %1 HR and %2%3", _hr, _costs, currencySymbol];
    };
    default {
		[1, "Bad outpost type.", "fn_setOutpostCost"] call A3A_fnc_log;
	};
};

outpostCost = [_costs, _hr];