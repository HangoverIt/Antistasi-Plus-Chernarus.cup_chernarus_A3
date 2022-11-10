/*
 * Name:	fn_reorgLoadoutUnit
 * Date:	12/09/2022
 * Version: 1.0
 * Author:  JB
 *
 * Description:
 * converts loadout to usable array
 *
 * Parameter(s):
 * _PARAM1 (TYPE): DESCRIPTION.
 * _PARAM2 (TYPE): DESCRIPTION.
 *
 * Returns:
 * %RETURNS%
 */

if (isNil "_this") exitWith {[]};
_this params ["_primary", "_secondary", "_handgun", "_uniform", "_vest", "_backpack", "_headgear", "_facewear", "_binocular", "_items"];

_loadoutArray = _primary + _secondary + _handgun + _binocular;
_loadoutArray append _items;
_loadoutArray pushBack _headgear;
_loadoutArray pushBack _facewear;
{
	if (count _x > 0) then { _loadoutArray pushBack (_x select 0); _loadoutArray append (_x select 1) };
}forEach [_uniform, _vest, _backpack] ;

for "_i" from count _loadoutArray -1 to 0 step -1 do{
	if ((_loadoutArray select _i) isEqualTo []) then {_loadoutArray deleteAt _i} ;
};

_loadoutArray = _loadoutArray - [""];

_singleArray = [];
_doubleArray = [];
_tripleArray = [];

{
	if (count _x == 2) then { _doubleArray pushBack _x };
	if (count _x == 3) then { _tripleArray pushBack _x }
} forEach _loadoutArray;

_singleArray = _loadoutArray - _doubleArray - _tripleArray;

//single code

_singleCons = _singleArray call BIS_fnc_consolidateArray;


//treble code

_tripleCons = [];	
{
	_tripleCons append [[(_x select 0),(_x select 1) * (_x select 2)]]
} foreach _tripleArray;

//consolidate all

_cons = _singleCons + _doubleArray + _tripleCons;

_fullUnitGear = [];   
 { 
 	_fullUnitGear = [_fullUnitGear, (_x select 0),(_x select 1)] call BIS_fnc_addToPairs 
 } foreach _Cons;
 	
 _fullUnitGear;

