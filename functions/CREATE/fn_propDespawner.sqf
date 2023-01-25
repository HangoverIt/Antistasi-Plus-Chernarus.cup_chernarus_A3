// HangoverIt - remove a collection of props
// This clean up function assumes all props are close to each other as only the first is being used to check distance etc

_filename = "fn_propDespawner";
params ["_props", ["_checkNonRebel", false]];

private _obj = _props select 0 ;
private _pos = getPos _obj ;

if (!isNil {_obj getVariable "inDespawner"}) exitWith {};
{
	_x setVariable ["inDespawner", true, true];
}forEach _props;

while {true} do
{
	sleep 60;

	private _despawn = call {
		if (_pos distance getMarkerPos respawnTeamPlayer < 100) exitWith {false};
		if ([distanceSPWN,1,_pos,teamPlayer] call A3A_fnc_distanceUnits) exitWith {false};
		if !(_checkNonRebel) exitWith {true};
		if ([distanceSPWN,1,_pos,Occupants] call A3A_fnc_distanceUnits) exitWith {false};
		if ([distanceSPWN,1,_pos,Invaders] call A3A_fnc_distanceUnits) exitWith {false};
		true;
	};

	if (_despawn) exitWith {
		{deleteVehicle _x;} forEach _props ;
	};
};
