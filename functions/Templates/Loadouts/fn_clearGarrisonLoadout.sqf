// Author: HangoverIt
//
// Updated: 10/11/2022
// 
// Clear garrison data for a location
// Params
//   1. Marker location for garrison
//
// Returns nothing
//
params["_markerX", ["_delete", false]];

if (_delete) then {
	SDKgarrLoadouts setVariable [_markerX,nil,true];
}else{
	SDKgarrLoadouts setVariable [_markerX,[],true];
};