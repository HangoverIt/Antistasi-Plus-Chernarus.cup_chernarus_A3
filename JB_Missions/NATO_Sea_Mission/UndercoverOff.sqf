
waitUntil {sleep 1; 
	leader grpRus call BIS_fnc_enemyDetected == true
};

if (!isServer and hasInterface) exitWith{

if ((captive player) && (player distance signalFire < 200)) then
{
    [player, false] remoteExec["setCaptive"];
    player setCaptive false;
};

if !(isNull (objectParent player)) then
{
    {
        if (isPlayer _x) then
        {
            [_x, false] remoteExec["setCaptive", 0, _x];
            _x setCaptive false;
        }
    } forEach((assignedCargo(vehicle player)) + (crew(vehicle player)) - [player]);
};

["Undercover OFF", 0, 0, 4, 0, 0, 4] spawn bis_fnc_dynamicText;
[] spawn A3A_fnc_statistics;

        if (vehicle player != player) then
        {
            reportedVehs pushBackUnique (objectParent player);
            publicVariable "reportedVehs";
        }
        else
        {
            player setVariable["compromised", (dateToNumber[date select 0, date select 1, date select 2, date select 3, (date select 4) + 30])];
        };

["Undercover", "Meeting NATO spec ops on a beach at night with a big box of weapons is pretty sus..."] call A3A_fnc_customHint;

};

sleep 240;
 
grprfGetOut = false;
 
heli = "CUP_O_Mi8AMT_RU" createVehicle [12156.9,12616.3,0];

_grppil = createGroup OPfor;
	_pil1 = [_grppil, "CUP_O_RU_Pilot", [0,0,0], [], 0, "FORM"] call A3A_fnc_createUnit;
		_pil1 addEventHandler ["HandleDamage", A3A_fnc_handleDamageAAF]; 
		_pil1 addEventHandler ["killed", A3A_fnc_occupantInvaderUnitKilledEH];
	_pil2 = [_grppil, "CUP_O_RU_Pilot", [0,0,0], [], 0, "FORM"] call A3A_fnc_createUnit;	
		_pil2 addEventHandler ["HandleDamage", A3A_fnc_handleDamageAAF]; 
		_pil2 addEventHandler ["killed", A3A_fnc_occupantInvaderUnitKilledEH];
	_pil3 = [_grppil, "CUP_O_RU_Pilot", [0,0,0], [], 0, "FORM"] call A3A_fnc_createUnit; 
		_pil3 addEventHandler ["HandleDamage", A3A_fnc_handleDamageAAF]; 
		_pil3 addEventHandler ["killed", A3A_fnc_occupantInvaderUnitKilledEH];
	_pil4 = [_grppil, "CUP_O_RU_Pilot", [0,0,0], [], 0, "FORM"] call A3A_fnc_createUnit;
		_pil4 addEventHandler ["HandleDamage", A3A_fnc_handleDamageAAF]; 
		_pil4 addEventHandler ["killed", A3A_fnc_occupantInvaderUnitKilledEH];

_grprf = createGroup OPfor;
	_rf1 = [_grprf, "CUP_O_RU_Soldier_TL_EMR", [0,0,0], [], 0, "FORM"] call A3A_fnc_createUnit;  
		_rf1 addPrimaryWeaponItem "CUP_acc_Flashlight";
		_rf1 addEventHandler ["HandleDamage", A3A_fnc_handleDamageAAF]; 
		_rf1 addEventHandler ["killed", A3A_fnc_occupantInvaderUnitKilledEH];
	_rf2 = [_grprf, "CUP_O_RU_Medic_EMR", [0,0,0], [], 0, "FORM"] call A3A_fnc_createUnit; 
		_rf2 addEventHandler ["HandleDamage", A3A_fnc_handleDamageAAF]; 
		_rf2 addEventHandler ["killed", A3A_fnc_occupantInvaderUnitKilledEH];
	_rf3 = [_grprf, "CUP_O_RU_Soldier_EMR", [0,0,0], [], 0, "FORM"] call A3A_fnc_createUnit;
		_rf3 setUnitLoadout (getUnitLoadout Rus_T34_Rifle);
		_rf3 addPrimaryWeaponItem "CUP_acc_Flashlight";	
		_rf3 addEventHandler ["HandleDamage", A3A_fnc_handleDamageAAF]; 
		_rf3 addEventHandler ["killed", A3A_fnc_occupantInvaderUnitKilledEH];
	_rf4 = [_grprf, "CUP_O_RU_Soldier_EMR", [0,0,0], [], 0, "FORM"] call A3A_fnc_createUnit;
		_rf4 setUnitLoadout (getUnitLoadout Rus_T34_Rifle);
		_rf4 addPrimaryWeaponItem "CUP_acc_Flashlight";	
		_rf4 addEventHandler ["HandleDamage", A3A_fnc_handleDamageAAF]; 
		_rf4 addEventHandler ["killed", A3A_fnc_occupantInvaderUnitKilledEH];
	_rf5 = [_grprf, "CUP_O_RU_Soldier_AR_EMR", [0,0,0], [], 0, "FORM"] call A3A_fnc_createUnit; 
		_rf5 addEventHandler ["HandleDamage", A3A_fnc_handleDamageAAF]; 
		_rf5 addEventHandler ["killed", A3A_fnc_occupantInvaderUnitKilledEH];
	_rf6 = [_grprf, "CUP_O_RU_Soldier_AR_EMR", [0,0,0], [], 0, "FORM"] call A3A_fnc_createUnit;
		_rf6 addEventHandler ["HandleDamage", A3A_fnc_handleDamageAAF]; 
		_rf6 addEventHandler ["killed", A3A_fnc_occupantInvaderUnitKilledEH];
	_rf7 = [_grprf, "CUP_O_RU_Soldier_LAT_EMR", [0,0,0], [], 0, "FORM"] call A3A_fnc_createUnit;
		_rf7 addPrimaryWeaponItem "CUP_acc_Flashlight";	
		_rf7 addEventHandler ["HandleDamage", A3A_fnc_handleDamageAAF]; 
		_rf7 addEventHandler ["killed", A3A_fnc_occupantInvaderUnitKilledEH];
	_rf8 = [_grprf, "CUP_O_RU_Soldier_LAT_EMR", [0,0,0], [], 0, "FORM"] call A3A_fnc_createUnit;
		_rf8 addPrimaryWeaponItem "CUP_acc_Flashlight";
		_rf8 addEventHandler ["HandleDamage", A3A_fnc_handleDamageAAF]; 
		_rf8 addEventHandler ["killed", A3A_fnc_occupantInvaderUnitKilledEH];
	_rf9 = [_grprf, "CUP_O_RU_Soldier_EMR", [13878.1,11290.1,0], [], 0, "FORM"] call A3A_fnc_createUnit;
		_rf9 setUnitLoadout (getUnitLoadout Rus_T34_Rifle);
		_rf9 addPrimaryWeaponItem "CUP_acc_Flashlight";	
		_rf9 addEventHandler ["HandleDamage", A3A_fnc_handleDamageAAF]; 
		_rf9 addEventHandler ["killed", A3A_fnc_occupantInvaderUnitKilledEH];
	_rf10 = [_grprf, "CUP_O_RU_Soldier_EMR", [13878.1,11290.1,0], [], 0, "FORM"] call A3A_fnc_createUnit;
		_rf10 setUnitLoadout (getUnitLoadout Rus_T34_Rifle);
		_rf10 addPrimaryWeaponItem "CUP_acc_Flashlight";	
		_rf10 addEventHandler ["HandleDamage", A3A_fnc_handleDamageAAF]; 
		_rf10 addEventHandler ["killed", A3A_fnc_occupantInvaderUnitKilledEH];
	_rf11 = [_grprf, "CUP_O_RU_Soldier_AR_EMR", [13878.1,11290.1,0], [], 0, "FORM"] call A3A_fnc_createUnit; 
		_rf11 addEventHandler ["HandleDamage", A3A_fnc_handleDamageAAF]; 
		_rf11 addEventHandler ["killed", A3A_fnc_occupantInvaderUnitKilledEH];
	_rf12 = [_grprf, "CUP_O_RU_Soldier_AR_EMR", [13878.1,11290.1,0], [], 0, "FORM"] call A3A_fnc_createUnit;
		_rf12 addEventHandler ["HandleDamage", A3A_fnc_handleDamageAAF]; 
		_rf12 addEventHandler ["killed", A3A_fnc_occupantInvaderUnitKilledEH];
	
	_pil1 moveInDriver heli;
	_pil2 moveInTurret [heli, [2]];
	_pil3 moveInTurret [heli, [0]];
	_pil4 moveInTurret [heli, [1]];
	
	{_x moveInCargo heli;} foreach units _grprf;
	
_heliwp1 = _grppil addWaypoint [[14109,11458.3,0], 0];
_heliwp1 setWaypointType "MOVE";

_heliwp2 = _grppil addWaypoint [[14080.2,11374.9,0], 0];
_heliwp2 setWaypointType "SCRIPTED";
_heliwp2 setWaypointScript "A3\functions_f\waypoints\fn_wpLand.sqf";
_heliwp2 setWaypointStatements ["true", "heli engineOn false; grprfGetOut = true"];

waitUntil {sleep 1; grprfGetOut == true};
doGetOut (units _grprf);
(units _grprf) allowGetIn false;

_rfwp1 = _grprf addWaypoint [[14060.1,11359.9,0], 0];
_rfwp1 setWaypointType "SAD";

waitUntil {sleep 10; ["NATOSeaTask"] call BIS_fnc_taskState == "SUCCEEDED"};
{deleteVehicle _x} foreach units _grppil;
{deleteVehicle _x} foreach units _grprf;
deleteVehicle heli;