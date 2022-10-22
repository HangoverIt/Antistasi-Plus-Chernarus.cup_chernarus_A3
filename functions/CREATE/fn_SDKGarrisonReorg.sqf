

if (count _this <= 8) exitWith {_this};

if (([_indexedGarr, SDKSL] call BIS_fnc_findNestedElement isEqualTo []) && ([_indexedGarr, SDKMedic] call BIS_fnc_findNestedElement isEqualTo [])) exitWith {_this};

private _pool = +_this;

_indexSL = [_pool, SDKSL] call BIS_fnc_findAllNestedElements;
_SLPool = [];
_num = 0;
{								
_SLPool append [(_pool select (_x select 0) - _num)];
(_pool deleteAT (_x select 0) - _num);
_num = _num + 1;
} foreach _indexSL;

_indexMed = [_pool, SDKMedic] call BIS_fnc_findAllNestedElements;
_medPool = [];
_num = 0;
{
_medPool append [(_pool select (_x select 0) - _num)];
(_pool deleteAT (_x select 0) - _num);
_num = _num + 1;
} foreach _indexMed;

if (_pool isEqualTo []) exitWith {_this};

private _result = [];
while {!(_pool isEqualTo [])} do
	{
	_squad = [];
	_countX = 8;
	if (count _SLPool > 0) then
		{
		_squad pushBack (_SLPool select 0);
		_SLPool deleteAT 0;
		_countX = _countX - 1;
		};
	if (count _medPool > 0) then
		{
		_countX = _countX - 1;
		if (_countX > (count _pool)) then {_countX = count _pool};
		for "_i" from 1 to _countX do
			{
			_squad pushBack (_pool select 0);
			_pool deleteAt 0;
			};
		_squad pushBack (_medPool select 0);
		_medPool deleteAT 0;
		}
	else
		{
		if (_countX > (count _pool)) then {_countX = count _pool};
		for "_i" from 1 to _countX do
			{
			_squad pushBack (_pool select 0);
			_pool deleteAt 0;
			};
		};
	_result append _squad;
	};
if (count _SLPool > 0) then
	{
	for "_i" from 1 to count _SLPool do
		{
		_result pushBack (_SLPool select 0);
		};
	};
if (count _medPool > 0) then
	{
	for "_i" from 1 to count _medPool do
		{
		_result pushBack (_medPool select 0);
		};
	};
_result

