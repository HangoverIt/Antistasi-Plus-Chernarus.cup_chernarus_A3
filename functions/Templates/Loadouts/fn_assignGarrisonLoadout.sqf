// Author: HangoverIt
//
// Updated: 10/11/2022
// 
// Assign loadout to a unit and flags loadout as being used. Randomises the uniform
// Params
// 1. Unit object to assign
// 2. Loadout data
//
// Returns if load out was successful (true/false)
//
params["_unit", "_garrisonData"];

private _fn = "fn_assignGarrisonLoadout" ;
private _defaultLoadout = configFile >> "EmptyLoadout" ;
private _useloadout = _defaultLoadout ;
private _return = true ;
private _unitType = "";
{
	_x params["_type", "_loadout", "_used"] ;
	_unitType = _unit getVariable ["unitType", "UKN"];
	if (_unitType == _type && !_used) exitWith {
		_x set [2, true] ;
		if (isNil "_loadout") then {
			diag_log format["ASSERTION ERROR: %3 - garrison loadout is invalid (nil) for unit %1 of type %2", _unit, _unitType, _fn] ;
		}else{
			diag_log format["DEBUG: %4 - assignGarrisonLoadout matched type of (%1) - %2, against loadout type %3", _unit, _unitType, _type, _fn] ;
			_useloadout = _loadout ;
		};
	};
}forEach _garrisonData ;

if (_useloadout isEqualTo _defaultLoadout) then {
	diag_log format["WARNING: %3 - not able to assign a garrison loadout to %1 of type %2", _unit, _unit getVariable ["unitType", "UKN"], _fn] ;
	_return = false ;
};
_unit setUnitLoadout _useloadout ; 

if (randomizeRebelLoadoutUniforms) then {
	private _uniforms = A3A_faction_reb getVariable "uniforms";
	private _uniformItems = uniformItems _unit;

	_unit forceAddUniform (selectRandom _uniforms);
	{_unit addItemToUniform _x} forEach _uniformItems;

	private _headgear = headgear _unit;

	//if it isn't a helmet - randomize
	if !(_headgear in allArmoredHeadgear) then {
		_unit addHeadgear (selectRandom (A3A_faction_reb getVariable "headgear"));
	};
};
_return ;