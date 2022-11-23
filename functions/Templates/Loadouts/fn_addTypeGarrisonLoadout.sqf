// Author: HangoverIt
//
// Updated: 10/11/2022
// 
// Update data storing a type and loadout
// Params
//   1. garrison data
//   2. Type of unit
//   3. Loadout of unit
//
// Returns updated garrisonData
//
params["_garrisonData", "_unitType", "_loadout"];

_garrisonData pushBack [_unitType, _loadout, false]; 
_garrisonData ;