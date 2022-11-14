// Author: HangoverIt
//
// Updated: 10/11/2022
// 
// Update data storing all the unit information and remove units
// Params
//   1. garrison data
//   2. Array of units to save at location
//   3. Optional - flag to also delete unit after adding to garrison
//
// Returns updated garrisonData
//
params["_garrisonData", "_units", ["_delete", true]];

{ 
	if (!isNil "_x") then {
		if (!isNull _x) then {
			if (alive _x) then {
				_unitType = _x getVariable ["unitType", "UKN"];
				_garrisonData pushBack [_unitType, (getUnitLoadout _x), false]; 
				if (_delete) then {deleteVehicle _x ;};
			}; 
		};
	};
} forEach _units;

_garrisonData ;