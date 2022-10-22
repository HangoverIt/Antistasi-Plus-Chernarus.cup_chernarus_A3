private ["_pos","_rnd","_posFire"];
_movedX = false;
if (petrovsky != (leader group petrovsky)) then
{
	private _groupPetrovsky = createGroup teamPlayer;
	[petrovsky] join _groupPetrovsky;
	_groupPetrovsky selectLeader petrovsky;
};
[petrovsky,"remove"] remoteExec ["A3A_fnc_flagaction",0];

petrovsky switchAction "PlayerStand";
petrovsky disableAI "MOVE";
petrovsky disableAI "AUTOTARGET";
petrovsky setBehaviour "SAFE";

// Put petrovsky back on the server, otherwise might cause issues on disconnect
[group petrovsky, 2] remoteExec ["setGroupOwner", 2];

[getPos petrovsky] call A3A_fnc_relocateHQObjects;

if (isNil "placementDone") then {placementDone = true; publicVariable "placementDone"};
sleep 5;
[Petrovsky,"mission"] remoteExec ["A3A_fnc_flagaction",[teamPlayer,civilian]];

