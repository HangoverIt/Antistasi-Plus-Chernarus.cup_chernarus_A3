params ["_marker"];

/*  Calculates the strength of the garrison, based on units active
*   Params:
*     _marker: STRING : The name of the marker on which the garrison should be checked
*
*   Returns:
*     _ratio: NUMBER : The ratio of alive troops to dead troops, 0 if none garrisoned
*/

private ["_debug", "_garrison", "_neededReinf", "_garrisonCount", "_reinfCount", "_allUnitsCount", "_preferredUnitsCount", "_data", "_ratio"];
_debug = debug;

if(isNil "_marker") exitWith {diag_log "GetGarrisonRatio: No marker given!";};

_garrison = [_marker] call A3A_fnc_getGarrison;
_neededReinf = [_marker] call A3A_fnc_getRequested;

if(_debug) then
{
  diag_log format ["GetGarrisonRatio: Calculating garrison strength now for %1!", _marker];
};

diag_log format["DEBUG: calling getGarrisonRatio for %1", _marker];
diag_log format["DEBUG:    _garrison is %1", _garrison];
diag_log format["DEBUG:    _neededReinf is %1", _neededReinf];
_garrisonCount = [_garrison, true] call A3A_fnc_countGarrison;
_reinfCount = [_neededReinf, true] call A3A_fnc_countGarrison;
_allUnitsCount = _garrisonCount + _reinfCount;
_preferredUnitsCount = _garrisonCount;
diag_log format["DEBUG:    _garrison count is %1", _garrisonCount];
diag_log format["DEBUG:    _neededReinf count is %1", _reinfCount];

if(_debug) then
{
  diag_log format ["GetGarrisonRatio: Found %1 units in total, %2 of them are alive", _allUnitsCount, _preferredUnitsCount];
};

_ratio = 1;
if(_allUnitsCount > 0) then
{
  _ratio = _preferredUnitsCount / _allUnitsCount;
};
diag_log format["DEBUG:    ratio for %1 is %2", _marker, _ratio];
_ratio;
