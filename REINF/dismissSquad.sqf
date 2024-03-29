//if (!isServer) exitWith{};
private ["_groups","_hr","_resourcesFIA","_wp","_groupX","_veh","_leave"];

_groups = _this select 0;
_hr = 0;
_resourcesFIA = 0;
_leave = false;

{
	if ((groupID _x) in ["MineF", "Watch"]
		|| { isPlayer (leader _x)
		|| { (units _x) findIf { _x == petrovsky } != -1 }})
	exitWith { _leave = true; };
} forEach _groups;

if (_leave) exitWith {["Dismiss Squad", "You cannot dismiss player led, Watchpost, Roadblocks or Minefield building squads."] call A3A_fnc_customHint;};

{
if (_x getVariable ["esNATO",false]) then {_leave = true};
} forEach _groups;

if (_leave) exitWith {["Dismiss Squad", "You cannot dismiss NATO groups."] call A3A_fnc_customHint;};

_pos = getMarkerPos respawnTeamPlayer;

{
	theBoss sideChat format ["%2, I'm sending %1 back to base", _x,name petrovsky];
	theBoss hcRemoveGroup _x;
	_wp = _x addWaypoint [_pos, 0];
	_wp setWaypointType "MOVE";
	sleep 3
} forEach _groups;

sleep 10;

private _assignedVehicles =	[];
private _allLoadouts = [];

{
	_groupX = _x;
	{
		if (alive _x) then
		{
			_hr = _hr + 1;
			_resourcesFIA = _resourcesFIA + (server getVariable [_x getVariable "unitType",0]);
			if (!isNull (assignedVehicle _x) and {isNull attachedTo (assignedVehicle _x)}) then
			{
				_assignedVehicles pushBackUnique (assignedVehicle _x);
			};
			_backpck = backpack _x;
			if (_backpck != "") then
			{
				switch (_backpck) do
				{
					case MortStaticSDKB: {_resourcesFIA = _resourcesFIA + ([SDKMortar] call A3A_fnc_vehiclePrice)};
					case AAStaticSDKB: {_resourcesFIA = _resourcesFIA + ([staticAAteamPlayer] call A3A_fnc_vehiclePrice)};
					case MGStaticSDKB: {_resourcesFIA = _resourcesFIA + ([SDKMGStatic] call A3A_fnc_vehiclePrice)};
					case ATStaticSDKB: {_resourcesFIA = _resourcesFIA + ([staticATteamPlayer] call A3A_fnc_vehiclePrice)};
				};
			};
		};		
		
		if (backpack _x in ["CUP_B_DShkM_Gun_Bag","CUP_B_DShkM_TripodHigh_Bag","CUP_B_SPG9_Gun_Bag","CUP_B_SPG9_Tripod_Bag","CUP_B_Podnos_Gun_Bag","CUP_B_Podnos_Bipod_Bag"]) then {
		removeBackpackGlobal _x};
		
		_unitLoadout = getUnitLoadout _x;
		_allLoadouts pushBack _unitLoadout;
		deleteVehicle _x;
	} forEach units _groupX;
	deleteGroup _groupX;
} forEach _groups;

{
	private _veh = _x;
	if !(typeOf _veh in vehFIA) then { continue };
	_resourcesFIA = _resourcesFIA + ([typeOf _veh] call A3A_fnc_vehiclePrice);
	{
		if !(typeOf _x in vehFIA) then { continue };
		_resourcesFIA = _resourcesFIA + ([typeOf _x] call A3A_fnc_vehiclePrice);
		deleteVehicle _x;
	} forEach attachedObjects _veh;
	deleteVehicle _veh;
} forEach _assignedVehicles;

//JB code to return gear to arsenal
_fullSquadGear = _allLoadouts call A3A_fnc_reorgLoadoutSquad;
 	
{ [_x select 0 call jn_fnc_arsenal_itemType, _x select 0, _x select 1]call jn_fnc_arsenal_addItem } forEach _fullSquadGear;

// JB code end

_nul = [_hr,_resourcesFIA] remoteExec ["A3A_fnc_resourcesFIA",2];
