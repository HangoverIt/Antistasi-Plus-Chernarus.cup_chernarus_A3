/*
 * Name:	hunterWeaps
 * Date:	5/10/2022
 * Version: 1.0
 * Author:  JB
 *
 * Description:
 * %DESCRIPTION%
 *
 * Parameter(s):
 * _PARAM1 (TYPE): - DESCRIPTION.
 * _PARAM2 (TYPE): - DESCRIPTION.
 */

scriptName "hunterWeaps";

private ["_gunBox"];

if (!isServer and hasInterface) exitWith{};

waitUntil { sleep 60; (date isEqualTo [2022,8,8,19,03])};

sleep 4;

[[teamPlayer,civilian], "gunWeapTask", ["The hunter believes some of his confiscated stock is still being kept in Severograd police station, if we cared to help ourselves to it. Go and relieve the police of this burden.", "Steal Weapons", ""], polStn_5,"CREATED",-1,true,"rifle",true] call BIS_fnc_taskCreate;

_gunBox = "Box_EAF_Equip_F" createVehicle [0,0,0];
clearWeaponCargoGlobal _gunBox;
clearMagazineCargoGlobal _gunBox;
clearItemCargoGlobal _gunBox;
clearBackpackCargoGlobal _gunBox;
_gunBox setPos (polStn_5 buildingPos 7);
_gunBox call A3A_fnc_logistics_addLoadAction;
[_gunBox] remoteExec ["SCRT_fnc_common_addActionMove", 0, _gunBox];
_gunBox addWeaponCargoGlobal ["CUP_arifle_SAIGA_MK03", 10];
_gunBox addWeaponCargoGlobal ["CUP_srifle_CZ550", 7];
_gunBox addMagazineCargoGlobal ["CUP_10Rnd_762x39_SaigaMk03_M", 50];
_gunBox addMagazineCargoGlobal ["CUP_5x_22_LR_17_HMR_M", 40];

waitUntil { sleep 5; _gunBox distance flagX < 50 };

["gunWeapTask", "SUCCEEDED"] call BIS_fnc_taskSetState;
[Occupants, 15, 90] remoteExec ["A3A_fnc_addAggression", 2];

{ [30, _x] call A3A_fnc_playerScoreAdd } forEach (call BIS_fnc_listPlayers) select { side _x == teamPlayer || side _x == civilian};
[20, theBoss] call A3A_fnc_playerScoreAdd;
