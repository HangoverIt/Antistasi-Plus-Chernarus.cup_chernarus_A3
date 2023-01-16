/*
	author: HangoverIt
	parameters: _object - object to test against side (is enemy of)
	            _position - object or position to check distance
				_distance - (optional) define radius to check within. If in this radius and an enemy then function returns true. Defaults to 1km
	description: Finds nearest enemies which are known to object group and are not unconcious, a vehicle or dead
	returns: boolean
*/
params ["_object", "_position", ["_distance", 1000, [0]]];

if (isNil "_object") exitWith {};
if (isNil "_position") exitWith {};

if (typeName _position == "OBJECT") then {
	if (isNull _position) exitWith {} ;
	_position = getPos _position;
};

if (isNull _object) exitWith {};

//private _enemy = (nearestObjects[_position, ["Men","Air","LandVehicle","Ship"]) select {alive _x && !(_x getVariable ["incapacitated",false]) && !(captive _x) && (_x distance _position < _distance) && [side _object,side _x] call BIS_fnc_sideIsEnemy} ;
private _enemy = allUnits select {alive _x && !(_x getVariable ["incapacitated",false]) && !(captive _x) && ((_x distance _position) < _distance) && [side _object,side _x] call BIS_fnc_sideIsEnemy} ;

(count _enemy > 0);