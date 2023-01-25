// All random civilian weapons they stashed under their beds
params ["_unit"] ;

private _pool = if (random 4 > 3) then {allshotguns} else {allhandguns};

private _wpn = selectRandom _pool;

if !(primaryWeapon _unit isEqualTo "") then {
	if (_wpn == primaryWeapon _unit) exitWith {};
	private _magazines = getArray (configFile / "CfgWeapons" / (primaryWeapon _unit) / "magazines");
	{_unit removeMagazines _x} forEach _magazines;			// Broken, doesn't remove mags globally. Pain to fix.
	_unit removeWeapon (primaryWeapon _unit);
};

[_unit, _wpn, 5, 0] call BIS_fnc_addWeapon;
