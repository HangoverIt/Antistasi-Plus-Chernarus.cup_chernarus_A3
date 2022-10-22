/*
 * Name:	fn_initHunter
 * Date:	5/10/2022
 * Version: 1.0
 * Author:  JB
 *
 * Description:
 * Inits hunters addons
 *
 * Parameter(s):
 * _PARAM1 (TYPE): DESCRIPTION.
 * _PARAM2 (TYPE): DESCRIPTION.
 *
 * Returns:
 * %RETURNS%
 */

	private ["_rebelCar"];
	
[hunter, ["Buy Saiga MK03 rifle ($150)", {
	params ["_target", "_caller", "_actionId", "_arguments"];
	private _resourcesFIA = player getVariable ["moneyX", 0];
	_rebelCar = nearestObject [_target, "car"];
	if(_rebelCar distance _target > 25) exitWith {_target globalChat "Bring your car closer."};
	if (150 > _resourcesFIA) exitWith {_target globalChat "You don't have enough money for that."};
	_rebelCar addWeaponCargoGlobal ["CUP_arifle_SAIGA_MK03", 1];
	[-150] call A3A_fnc_resourcesPlayer;
}]] remoteExec ["addAction", 0];

[hunter, ["Buy CZ550 hunting rifle with scope ($200)", {
	params ["_target", "_caller", "_actionId", "_arguments"];
	private _resourcesFIA = player getVariable ["moneyX", 0];
	_rebelCar = nearestObject [_target, "car"];
	if(_rebelCar distance _target > 25) exitWith {_target globalChat "Bring your car closer."};
	if (200 > _resourcesFIA) exitWith {_target globalChat "You don't have enough money for that."};
	_rebelCar addWeaponCargoGlobal ["CUP_srifle_CZ550", 1];
	[-200] call A3A_fnc_resourcesPlayer;
}]] remoteExec ["addAction", 0];

[hunter, ["Buy Saiga MK03 5x 10rnd magazines ($50)", {
	params ["_target", "_caller", "_actionId", "_arguments"];
	private _resourcesFIA = player getVariable ["moneyX", 0];
	_rebelCar = nearestObject [_target, "car"];
	if(_rebelCar distance _target > 25) exitWith {_target globalChat "Bring your car closer."};
	if (50 > _resourcesFIA) exitWith {_target globalChat "You don't have enough money for that."};
	_rebelCar addMagazineCargoGlobal ["CUP_10Rnd_762x39_SaigaMk03_M", 5];
	[-50] call A3A_fnc_resourcesPlayer;
}]] remoteExec ["addAction", 0];

[hunter, ["Buy CZ550 5x 5rnd clips ($50)", { 
	params ["_target", "_caller", "_actionId", "_arguments"];
	private _resourcesFIA = player getVariable ["moneyX", 0];
	_rebelCar = nearestObject [_target, "car"];
	if(_rebelCar distance _target > 25) exitWith {_target globalChat "Bring your car closer."};
	if (50 > _resourcesFIA) exitWith {_target globalChat "You don't have enough money for that."};
	_rebelCar addMagazineCargoGlobal ["CUP_5x_22_LR_17_HMR_M", 5];
	[-50] call A3A_fnc_resourcesPlayer;
}]] remoteExec ["addAction", 0];

[hunter, ["Buy 2x first aid kits ($50)", { 
	params ["_target", "_caller", "_actionId", "_arguments"];
	private _resourcesFIA = player getVariable ["moneyX", 0];
	_rebelCar = nearestObject [_target, "car"];
	if(_rebelCar distance _target > 25) exitWith {_target globalChat "Bring your car closer."};
	if (50 > _resourcesFIA) exitWith {_target globalChat "You don't have enough money for that."};
	_rebelCar addItemCargoGlobal ["FirstAidKit", 2];
	[-50] call A3A_fnc_resourcesPlayer;
}]] remoteExec ["addAction", 0];