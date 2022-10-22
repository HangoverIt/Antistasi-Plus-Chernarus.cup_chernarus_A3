  if (!isServer and hasInterface) exitWith{};
  
  if (EEMissionFailed == true || EEMissionCompleted == false) exitwith{};
  
  while {true} do {
    
    waitUntil {sleep 60; ((date select 3 == 10 && date select 4 == 15) || (date select 3 == 13 && date select 4 == 15) || (date select 3 == 16 && date select 4 == 15) || (date select 3 == 19 && date select 4 == 15))};
    boxX addItemCargoGlobal ["CUP_IED_V3_M", 1];
	boxX addItemCargoGlobal ["CUP_IED_V4_M", 1];

};
