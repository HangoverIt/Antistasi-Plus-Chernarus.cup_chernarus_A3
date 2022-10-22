private _unit = _this select 0;
private _playerX = _this select 1;
private _recruiting = _this select 3;

[_unit,"remove"] remoteExec ["A3A_fnc_flagaction",[teamPlayer,civilian],_unit];

if (!alive _unit) exitWith {};

private _sideX = side (group _unit);
private _interrogated = _unit getVariable ["interrogated", false];

private _modAggro = [0, 0];
private _modHR = false;
private _response = "";
private _fleeSide = _sideX;


if (_recruiting) then {
	_playerX globalChat "How about joining the good guys?";

	private _chance = 0;
	if (_sideX == Occupants) then
    {
		if ("militia_" in (_unit getVariable "unitType")) then { _chance = 60;}
		else { _chance = 20;};
	}
	else
    {
		if ("militia_" in (_unit getVariable "unitType")) then { _chance = 15;}
		else { _chance = 5;};
	};
	if (_interrogated) then { _chance = _chance / 2 };

	if (random 100 < _chance) then
    {
		_modAggro = [1, 30];
		_response = "Why not? It can't be any worse.";
		_modHR = true;
		_fleeSide = teamPlayer;
	}
	else
    {
		_response =  "Screw you, imperialist asshole!";
		_modAggro = [0, 0];
	};
}
else {
	_playerX globalChat "We'll release you this time. Go, tell your comrades of our mercy.";
	_response = selectRandom [
		"Okay, thank you. I owe you my life",
		"Thank you. I swear you won't regret it!",
		"Thank you, I won't forget this!"
	];

    _modAggro = [-3, 30];

	[player, _sideX] call SCRT_fnc_common_givePrisonerReleasePaycheck;
};


sleep 2;
_unit globalChat _response;

[_unit, _fleeSide] remoteExec ["A3A_fnc_fleeToSide", _unit];

private _group = group _unit;		// Group should be surrender-specific now
sleep 100;
if (alive _unit && {!(_unit getVariable ["incapacitated", false])}) then
{
	([_sideX] + _modAggro) remoteExec ["A3A_fnc_addAggression",2];
	if (_modHR) then { [1,0] remoteExec ["A3A_fnc_resourcesFIA",2] };
};

deleteVehicle _unit;
deleteGroup _group;
