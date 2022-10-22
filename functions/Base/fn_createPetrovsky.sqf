params [["_location", []]];

private _oldPetrovsky = if (isNil "petrovsky") then {objNull} else {petrovsky};
private _groupPetrovsky = if (!isNull _oldPetrovsky && {side group _oldPetrovsky == teamPlayer}) then {group _oldPetrovsky} else {createGroup teamPlayer};

// Hack-fix for bugged case where petrovsky is killed by enemy while being moved
if (count _location > 0 && count units _groupPetrovsky > 1) then { _groupPetrovsky = createGroup teamPlayer };

private _position = if (count _location > 0) then {
	_location
} else {
	if (getPos _oldPetrovsky isEqualTo [0,0,0]) then {
		getMarkerPos respawnTeamPlayer
	} else {
		getPos _oldPetrovsky
	};
};

petrovsky = [_groupPetrovsky, typePetrovsky, _position, [], 10, "NONE"] call A3A_fnc_createUnit;
publicVariable "petrovsky";

deleteVehicle _oldPetrovsky;		// Petrovsky should now be leader unless there's a player in the group

private _name = if (worldName == "Tanoa") then {"Maru"} else {"Petrovsky"};
[petrovsky, "friendlyX"] remoteExec ["setIdentity", 0];
[petrovsky, _name] remoteExec ["setName", 0];

if (petrovsky == leader _groupPetrovsky) then {
	_groupPetrovsky setGroupIdGlobal ["Petrovsky","GroupColor4"];
	petrovsky disableAI "MOVE";
	petrovsky disableAI "AUTOTARGET";
	petrovsky setBehaviour "SAFE";
	[Petrovsky,"mission"] remoteExec ["A3A_fnc_flagaction",[teamPlayer,civilian]]
} else {
	[Petrovsky,"buildHQ"] remoteExec ["A3A_fnc_flagaction",[teamPlayer,civilian]]
};

call A3A_fnc_initPetrovsky;
