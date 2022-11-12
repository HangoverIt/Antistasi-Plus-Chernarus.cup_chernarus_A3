// Author: HangoverIt
//
// Updated: 10/11/2022
// 
// Get garrison data for a location
// Params
//   1. Marker location for garrison
//
// Returns array of garrison data
//
params["_markerX"];

_ret = SDKgarrLoadouts getVariable [_markerX,[]] ;
if (isNil "_ret") then {_ret = [];};
_ret ;