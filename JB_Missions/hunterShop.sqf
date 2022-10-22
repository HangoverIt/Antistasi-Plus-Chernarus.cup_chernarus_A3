/*
 * Name:	ww
 * Date:	3/10/2022
 * Version: 1.0
 * Author:  %AUTHOR%
 *
 * Description:
 * %DESCRIPTION%
 *
 * Parameter(s):
 * _PARAM1 (TYPE): - DESCRIPTION.
 * _PARAM2 (TYPE): - DESCRIPTION.
 */




private ["_rebelCar"];

if (!isServer and hasInterface) exitWith{};

waitUntil { sleep 60; (date isEqualTo [2022,8,8,19,03])};

[[teamPlayer,civilian], "gunShopTask", ["A hunting shop owner from Gvozdno has contacted us. Many of his sports guns and hunting rifles were confiscated by the military police after the invasion, however he did manage to hide some of his stock, and is willing to sell it to us at bargain prices. Go and see what he can provide.", "Acquire Weapons", ""], hunter,"CREATED",-1,true,"box",true] call BIS_fnc_taskCreate;

waitUntil { sleep 1; {_x distance hunter < 5} count allPlayers > 0 };

		["gunShopTask", "SUCCEEDED"] call BIS_fnc_taskSetState; 
		[hunter,"Welcome. As I cannot sell to the public, I may as well sell you my guns, they migh be helpful to the resistance. I would offer them for free, but a man has to eat... I also have first aid kits for sale. I will load your purchases straight into your car."] remoteExec ["globalChat",0];		
		

[hunter, ["Buy Saiga MK03 rifle ($150)", {
	params ["_target", "_caller", "_actionId", "_arguments"];
	private _resourcesFIA = player getVariable ["moneyX", 0];
	_rebelCar = nearestObject [_target, "car"];
	if(_rebelCar distance _target > 25) exitWith {_target globalChat "Bring your car closer."};
	if (150 > _resourcesFIA) exitWith {_target globalChat "You don't have enough money for that."};
	_rebelCar addWeaponCargoGlobal ["CUP_arifle_SAIGA_MK03", 1];
	[-150] call A3A_fnc_resourcesPlayer;
}]] remoteExec ["addAction", 2];

[hunter, ["Buy CZ550 hunting rifle with scope ($200)", {
	params ["_target", "_caller", "_actionId", "_arguments"];
	private _resourcesFIA = player getVariable ["moneyX", 0];
	_rebelCar = nearestObject [_target, "car"];
	if(_rebelCar distance _target > 25) exitWith {_target globalChat "Bring your car closer."};
	if (200 > _resourcesFIA) exitWith {_target globalChat "You don't have enough money for that."};
	_rebelCar addWeaponCargoGlobal ["CUP_srifle_CZ550", 1];
	[-200] call A3A_fnc_resourcesPlayer;
}]] remoteExec ["addAction", 2];

[hunter, ["Buy Saiga MK03 5x 10rnd magazines ($50)", {
	params ["_target", "_caller", "_actionId", "_arguments"];
	private _resourcesFIA = player getVariable ["moneyX", 0];
	_rebelCar = nearestObject [_target, "car"];
	if(_rebelCar distance _target > 25) exitWith {_target globalChat "Bring your car closer."};
	if (50 > _resourcesFIA) exitWith {_target globalChat "You don't have enough money for that."};
	_rebelCar addMagazineCargoGlobal ["CUP_10Rnd_762x39_SaigaMk03_M", 5];
	[-50] call A3A_fnc_resourcesPlayer;
}]] remoteExec ["addAction", 2];

[hunter, ["Buy CZ550 5x 5rnd clips ($50)", { 
	params ["_target", "_caller", "_actionId", "_arguments"];
	private _resourcesFIA = player getVariable ["moneyX", 0];
	_rebelCar = nearestObject [_target, "car"];
	if(_rebelCar distance _target > 25) exitWith {_target globalChat "Bring your car closer."};
	if (50 > _resourcesFIA) exitWith {_target globalChat "You don't have enough money for that."};
	_rebelCar addMagazineCargoGlobal ["CUP_5x_22_LR_17_HMR_M", 5];
	[-50] call A3A_fnc_resourcesPlayer;
}]] remoteExec ["addAction", 2];

[hunter, ["Buy 2x first aid kits ($50)", { 
	params ["_target", "_caller", "_actionId", "_arguments"];
	private _resourcesFIA = player getVariable ["moneyX", 0];
	_rebelCar = nearestObject [_target, "car"];
	if(_rebelCar distance _target > 25) exitWith {_target globalChat "Bring your car closer."};
	if (50 > _resourcesFIA) exitWith {_target globalChat "You don't have enough money for that."};
	_rebelCar addItemCargoGlobal ["FirstAidKit", 5];
	[-50] call A3A_fnc_resourcesPlayer;
}]] remoteExec ["addAction", 2];

waitUntil { sleep 1; ({_x distance hunter > 12} count allPlayers  > 0)};
		[hunter,"Thanks, and good luck. I'll be here if you need more."] remoteExec ["globalChat",0];		
		"hunterMarker" setMarkerAlpha 1;
