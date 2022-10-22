/*
 * File: fn_loadout_setFacewear.sqf
 * Author: Spoffy
 * Description:
 *    Adds a helmet to a unit loadout
 * Params:
 *    _loadout - Loadout to add vest to
 *    _helmet - Helmet class to add
 * Returns:
 *    Modified loadout array
 * Example Usage:
 *    [_loadout, "H_HelmetSpecB_blk"] call A3A_fnc_setVest
 */
 
 
params ["_loadout", "_facewear"];

_loadout set [ 7,
	_facewear
];

_loadout