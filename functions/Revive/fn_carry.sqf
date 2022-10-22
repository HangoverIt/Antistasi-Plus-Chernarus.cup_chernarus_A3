params ["_carried", "_carrier"];

if (!alive _carried) exitWith {
	["Carry/Drag", format ["%1 is dead.",name _carried]] call A3A_fnc_customHint;
};

if !(_carried getVariable ["incapacitated",false]) exitWith {
	["Carry/Drag", format ["%1 no longer needs your help.",name _carried]] call A3A_fnc_customHint;
};

if !(isNull attachedTo _carried) exitWith {
	["Carry/Drag", format ["%1 is being carried or transported and you cannot carry him.",name _carried]] call A3A_fnc_customHint;
};

if (captive _carrier) then {
	[_carrier,false] remoteExec ["setCaptive",0,_carrier]; _carrier setCaptive false
};

_carrier setVariable ["ais_DragDrop_Torso", _carried];
_carried setVariable ["ais_DragDrop_Player", _carrier, true];

_carried setVariable ["ais_hasHelper", _carrier, true];


detach _carrier;
detach _carried;

[_carried, "AinjPpneMrunSnonWnonDb"] remoteExec ["switchMove", 0];
[_carrier, "grabDrag"] remoteExec ["playActionNow", 0, false];
_carried setVariable ["helped", _carrier, true];

if (isPlayer _carrier && {isPlayer _carried}) then {
	private _carriedName = name _carried;
	[["UpdateState", format ["Carries unconscious %1", _carriedName]]] call SCRT_fnc_misc_updateRichPresence;
};

[_carried,"remove"] remoteExec ["A3A_fnc_flagaction", 0, _carried];

_attachPoint = [0, 1.1, 0.05];
_carried attachTo [_carrier, _attachPoint];
[_carried, 180] remoteExec ["setDir", 0, false];

private _timeOut = time + 60;

private _action = _carrier addAction [format ["Release %1",name _carried], {{detach _x} forEach (attachedObjects player)},nil,0,false,true,"","(isPlayer _this) and (_this == _this getVariable ['owner',objNull])"];

waitUntil {sleep 0.5; (!alive _carried)
	|| !([_carrier] call A3A_fnc_canFight)
	|| !(_carried getVariable ["incapacitated",false])
	|| ({!isNull _x} count attachedObjects _carrier == 0)
	|| (time > _timeOut)
	|| (vehicle _carrier != _carrier)
};

[] call SCRT_fnc_misc_updateRichPresence;

_carrier removeAction _action;

_carried = _carrier getVariable "ais_DragDrop_Torso";
_pos = getPos _carried;

_carrier setVariable ["ais_DragDrop_Torso", objNull];
_carried setVariable ["ais_DragDrop_Player", objNull, true];
_carrier setVariable ["ais_CarryDrop_Torso", false];

_carried setVariable ["ais_hasHelper", objNull, true];
_carrier playAction "released";

detach _carrier;
detach _carried;

if (alive _carried) then {
	[_carried, "AinjPpneMstpSnonWrflDb_release"] remoteExec ["switchMove", 0];
	//[_target, _pos] call AIS_Core_fnc_setPosAGLS;
	_carried setPos _pos;
};

if (_carried getVariable ["incapacitated",false]) then {
	[_carried,false] remoteExec ["setUnconscious",_carried];
	waitUntil {sleep 0.1; lifeState _carried != "incapacitated"};
	[_carried,true] remoteExec ["setUnconscious",_carried];
};

[_carried,"heal1"] remoteExec ["A3A_fnc_flagaction",0,_carried];

sleep 5;

_carried setVariable ["helped",objNull,true];
