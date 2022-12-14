private ["_hr","_resourcesFIA","_hrT","_resourcesFIAT"];
waitUntil {!resourcesIsChanging};
resourcesIsChanging = true;
_hr = _this select 0;
_resourcesFIA = _this select 1;
if (isNil "_resourcesFIA") then {diag_log "Tienes algún costs sin definit en las tablas de FIA"};
if ((isNil "_hr") or (isNil "_resourcesFIA")) exitWith {resourcesIsChanging = false};
if ((floor _resourcesFIA == 0) and (floor _hr == 0)) exitWith {resourcesIsChanging = false};
_hrT = server getVariable "hr";
_resourcesFIAT = server getVariable "resourcesFIA";

_hrT = _hrT + _hr;
_resourcesFIAT = round (_resourcesFIAT + _resourcesFIA);

if (_hrT < 0) then {_hrT = 0};
if (_resourcesFIAT < 0) then {_resourcesFIAT = 0};

server setVariable ["hr",_hrT,true];
server setVariable ["resourcesFIA",_resourcesFIAT,true];
resourcesIsChanging = false;

_textX = "";
_hrSim = "";
if (_hr > 0) then {_hrSim = "+"};
_resourcesFIASim = "";
if (_resourcesFIA > 0) then {_resourcesFIASim = "+"};


switch (true) do {
	case ((_hr != 0) && (_resourcesFIA != 0)): {
		_textX = format ["<t size='0.6' color='#C1C0BB'>%5 Resources.<br/> <t size='0.5' color='#C1C0BB'><br/>HR: %3%1<br/>Money: %4%2 %6",_hr,_resourcesFIA,_hrSim,_resourcesFIASim,nameTeamPlayer,currencySymbol];
	};
	case (_hr != 0): {
		_textX = format ["<t size='0.6' color='#C1C0BB'>%5 Resources.<br/> <t size='0.5' color='#C1C0BB'><br/>HR: %3%1",_hr,_resourcesFIA,_hrSim,nameTeamPlayer];
	};
	case (_resourcesFIA != 5): {
		_textX = format ["<t size='0.6' color='#C1C0BB'>%5 Resources.<br/> <t size='0.5' color='#C1C0BB'><br/>Money: %4%2 %6",_hr,_resourcesFIA,_hrSim,_resourcesFIASim,nameTeamPlayer,currencySymbol];
	};
};

if (_textX != "") then {
	[petrovsky,"income",_textX] remoteExec ["A3A_fnc_commsMP",theBoss];
};