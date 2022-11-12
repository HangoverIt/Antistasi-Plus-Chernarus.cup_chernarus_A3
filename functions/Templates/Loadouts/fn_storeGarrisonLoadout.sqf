// Author: HangoverIt
//
// Updated: 10/11/2022
// 
// Create garrison data storing all the unit information and remove units
// Params
//   1. Marker location for garrison
//   2. Garrison data
//
// Returns number of units saved
//
params["_markerX", "_garrisonData"];

diag_log format["fn_storeGarrisonLoadout called for mkr %1, data %2", _markerX, _garrisonData] ;
diag_log str diag_stacktrace;
// Data fix-up for games run with old loadout data
if ((count _garrisonData > 0) && !(isNil "garrison")) then {
	if (count (_garrisonData select 0) != 3) then {
		// This is the old data format
		diag_log "DEBUG: fn_storeGarrisonLoadout - Old garrison loadout data format...converting...";
		_newGarrisonData = [] ;
		_garrisonUnits = garrison getVariable [_markerX, []] ;
		{
			// Assume garrison list is in order and matches the loadout (this was the previous code assumption)
			_type = _garrisonUnits select _forEachIndex ;
			if (isNil "_type") then {_type = SDKMil;} ; // attempt to fix data with rifleman if misaligned
			diag_log format["DEBUG: reformatting garrison loadout data for %1, with [%2,%3,%4]", _markerX, _type, _x, false] ;
			_newGarrisonData pushBack [_type, _x, false] ;
		}forEach _garrisonData ;
		_garrisonData = _newGarrisonData ; // Updated data structure for global var
		diag_log format ["DEBUG: fn_storeGarrisonLoadout - updating garrison data to %1", _garrisonData] ;
	};
};

SDKgarrLoadouts setVariable [_markerX, _garrisonData, true];
diag_log format["DEBUG: fn_storeGarrisonLoadout - Saved %1 loadouts to garrison %2", count _garrisonData, _markerX] ;

count _garrisonData ;