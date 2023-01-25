/*
	author: Socrates
	description: Adds auto looter action to vehicle.
	returns: nothing
*/
params ["_vehicle"];

diag_log format ["%1: [Antistasi] | INFO | fn_loot_addActionLoot | Adding loot action to loot object.",servertime];

private _lootActionID = _vehicle getVariable ["scrt_lootActionID", Nil];

//Check if action exists already
if(!isnil "_lootActionID") then
{
	_vehicle removeAction _lootActionID;
};

//add action
_lootActionID = [_vehicle,
	localize "STR_antistasi_actions_loot_around_text",
	"\a3\ui_f_orange\Data\CfgOrange\Missions\action_fia_ca.paa",
	"\a3\ui_f_orange\Data\CfgOrange\Missions\action_fia_ca.paa",
	"vehicle player == player && _this distance _target < 5",
	"vehicle player == player && _caller distance _target < 5 && !([_caller, _caller, 100] call SCRT_fnc_loot_enemyNear) && !(captive _caller)",
	{},
	{},
	{
		[_this select 0, 50] remoteExec ["SCRT_fnc_loot_gatherLoot", 2];
	},
	{if ([_caller, _caller, 100] call SCRT_fnc_loot_enemyNear) then {["Gather Scattered Loot", "You cannot gather loot while there are enemy units within 100m of your position."] call A3A_fnc_customHint};
	if (captive _caller) then {["Gather Scattered Loot", "You cannot loot whilst you are undercover."] call A3A_fnc_customHint}},
	[],
	8,
	5,
	false,
	false
] call BIS_fnc_holdActionAdd;

diag_log format ["%1: [Antistasi] | INFO | fn_loot_addActionLoot | Loot action to loot truck has been added.",servertime];

_vehicle setVariable ["scrt_lootActionID", _lootActionID, false];

//add event handler to remove action from vehicle when it's killed
_vehicle addEventHandler ["Killed", {
	params ["_unit", "_killer", "_instigator", "_useEffects"];
	[_unit] remoteExec ["SCRT_fnc_loot_removeActionLoot",0, _unit];
}];

_lootActionID;