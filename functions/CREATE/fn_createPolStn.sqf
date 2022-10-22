/*
 * Name:	fn_CREATE_polStn
 * Date:	24/09/2022
 * Version: 1.0
 * Author:  JB
 *
 * Description:
 * creates police station mechanic
 *
 * Parameter(s):
 * _PARAM1 (TYPE): DESCRIPTION.
 * _PARAM2 (TYPE): DESCRIPTION.
 *
 * Returns:
 * %RETURNS%
 */

if (!isServer and hasInterface) exitWith{};
private ["_markerX", "_sideX","_polStn", "_weapBox","_reinfOrigin", "_banner","_officer", "_grunt", "_marksman", "_typeVehX","_StaticMG","_groupX","_groupY", "_roofGunsList"];

_markerX = _this select 0;
_sideX = _this select 1;

if (_markerX in destroyedSites) exitWith {};

switch (_markerX) do {

	case "city_StarySobor": {
		_polStn = polStn_1;
		_weapBox = polWpn_1;
		_reinfOrigin = polStn_2;
		_banner = bannerPol_1
	};
	
	case "city_Vybor": {
		_polStn = polStn_2;
		_weapBox = polWpn_2;
		_reinfOrigin = polStn_1;
		_banner = bannerPol_2
	};
	
	case "city_Berezino": {
		_polStn = polStn_3;
		_weapBox = polWpn_3;
		_reinfOrigin = polStn_4;
		_banner = bannerPol_3
	};
	
	case "city_Solnychniy": {
		_polStn = polStn_4;
		_weapBox = polWpn_4;
		_reinfOrigin = polStn_3;
		_banner = bannerPol_4
	};
	
	case "City_Severograd": {
		_polStn = polStn_5;
		_weapBox = polWpn_5;
		_reinfOrigin = polStn_11;
		_banner = bannerPol_5
	};
	
	case "city_Elektrozavodsk": {
		_polStn = polStn_6;
		_weapBox = polWpn_6;
		_reinfOrigin = polStn_7;
		_banner = bannerPol_6
	};
	
	case "city_Chernogorsk": {
		_polStn = polStn_7;
		_weapBox = polWpn_7;
		_reinfOrigin = polStn_6;
		_banner = bannerPol_7
	};
	
	case "city_Svetloyarsk": {
		_polStn = polStn_8;
		_weapBox = polWpn_8;
		_reinfOrigin = polStn_10;
		_banner = bannerPol_8
	};
	
	case "city_Zelenogorsk": {
		_polStn = polStn_9;
		_weapBox = polWpn_9;
		_reinfOrigin = polStn_7;
		_banner = bannerPol_9
	};
	
	case "city_Novodmitrovsk": {
		_polStn = polStn_10;
		_weapBox = polWpn_10;
		_reinfOrigin = polStn_8;
		_banner = bannerPol_10
	};
	
	case "City_NovayaPetrovka": {
		_polStn = polStn_11;
		_weapBox = polWpn_11;
		_reinfOrigin = polStn_5;
		_banner = bannerPol_11
	};
};

if (_sideX == teamPlayer) exitWith {_banner setObjectTextureGlobal [0,"ca\data\flag_napa_co.paa"]};
if (damage _polStn == 1) exitWith {};
if (_polStn getVariable "attacked" == true) exitWith {};

switch (_sideX) do {
		
		case Occupants: {
			if (tierWar > 5) then {
				_officer = [NATOOfficer] call SCRT_fnc_unit_selectInfantryTier;
				_grunt = NATOGrunt call SCRT_fnc_unit_selectInfantryTier;
				_marksman = NATOMarksman call SCRT_fnc_unit_selectInfantryTier;
				_typeVehX = selectRandom vehNATOLightArmed;
				_StaticMG = NATOMG select 0
			} else {
				_officer = "loadouts_occ_police_SquadLeader";
				_grunt = "loadouts_occ_police_Standard";
				_typeVehX = vehPoliceCars select 0
			};
			_banner setObjectTextureGlobal [0,"ca\ca_e\data\flag_cr_co.paa"]
		};
		
		case Invaders: {
				_officer = [CSATOfficer] call SCRT_fnc_unit_selectInfantryTier;
				_grunt = CSATGrunt call SCRT_fnc_unit_selectInfantryTier;
				_marksman = CSATMarksman call SCRT_fnc_unit_selectInfantryTier;
				_typeVehX = selectRandom vehCSATLightArmed;
				_banner setObjectTextureGlobal [0,"ca\data\flag_rus_co.paa"];
				_StaticMG = CSATMG select 0
		};
	};

_groupX = createGroup _sideX;

_roofGunsList = [];

private _unit1 = [_groupX, _officer, _polStn buildingPos 8, [], 0, "NONE"] call A3A_fnc_createUnit;
private _unit2 = [_groupX, _grunt, _polStn buildingPos 6, [], 0, "NONE"] call A3A_fnc_createUnit;
private _unit3 = [_groupX, _grunt, _polStn getRelPos [6, 170], [], 0, "NONE"] call A3A_fnc_createUnit;
private _unit4 = [_groupX, _grunt, _polStn getRelPos [9, 230], [], 0, "NONE"] call A3A_fnc_createUnit;

if (_sideX == Occupants && tierWar < 6) then {
	private _unit5 = [_groupX, _grunt, _polStn getRelPos [9, 47], [], 0, "NONE"] call A3A_fnc_createUnit;
		_unit5 doWatch (_polStn getRelPos [200, 90]);
	private _unit6 = [_groupX, _grunt, _polStn buildingPos (selectRandom [9,12]), [], 0, "NONE"] call A3A_fnc_createUnit;
	} else {
	private _roofGun1 = _StaticMG createVehicle [0,0,0];
	private _roofGun2 = _StaticMG createVehicle [0,0,0];
	_roofGun1 setDir (getDir _polStn) + 135;
	_roofGun1 setPos (_polStn buildingPos 9);
	_roofGun2 setDir (getDir _polStn) + 225;
	_roofGun2 setPos (_polStn buildingPos 12);
	
	_roofGunsList pushBack _roofGun1;
	_roofGunsList pushBack _roofGun2;

	private _unit5 = [_groupX, _grunt, [0,0,0], [], 0, "NONE"] call A3A_fnc_createUnit;
	private _unit6 = [_groupX, _grunt, [0,0,0], [], 0, "NONE"] call A3A_fnc_createUnit;

	_unit5 moveInGunner _roofGun1;
		_unit5 doWatch (_polStn getRelPos [200, 135]);
	_unit6 moveInGunner _roofGun2;
		_unit6 doWatch (_polStn getRelPos [200, 225]);
	private _unit7 = [_groupX, _grunt, _polStn getRelPos [9, 47], [], 0, "NONE"] call A3A_fnc_createUnit;
		_unit7 doWatch (_polStn getRelPos [200, 90]);
	private _unit8 = [_groupX, _marksman, _polStn buildingPos 11, [], 0, "NONE"] call A3A_fnc_createUnit;
		_unit8 doWatch (_polStn getRelPos [200, 315]);
	};
{
[_x] call A3A_fnc_NATOinit;
_x disableAI "PATH";
} forEach units _groupX;

_groupX setFormDir ((getDir _polStn) + 180);

private _num1 = (round random 2 + 2);
private _num2 = (round random 3 + 1);
private _num3 = (round random 3 + 1);

if ((_sideX == Occupants) && (tierWar < 6)) then {
		_weapBox addWeaponCargoGlobal ["CUP_hgun_Makarov", _num1];
		_weapBox addWeaponCargoGlobal ["CUP_smg_vityaz_vfg", _num2];
		_weapBox addWeaponCargoGlobal ["CUP_arifle_AKS74U", _num3];
		_weapBox addMagazineCargoGlobal ["CUP_8Rnd_9x18_Makarov_M", (_num1 * 4)];
		_weapBox addMagazineCargoGlobal ["CUP_30Rnd_9x19_Vityaz", (_num2 * 4)];
		_weapBox addMagazineCargoGlobal ["CUP_30Rnd_545x39_AK74_plum_M", (_num3 * 4)];
	} else {
	private _handgun = handgunWeapon _unit2;
	private _handgunAmmo = (handgunMagazine _unit2) select 0;
	private _weap1 = primaryWeapon _unit1;
	private _weap1Ammo = (primaryWeaponMagazine _unit1) select 0;
	private _weap2 = primaryWeapon _unit2;
	private _weap2Ammo = (primaryWeaponMagazine _unit2) select 0;
	
	_weapBox addWeaponCargoGlobal [_handgun, _num1];
	_weapBox addWeaponCargoGlobal [_weap2, _num2];
	_weapBox addWeaponCargoGlobal [_weap1, _num3];
	_weapBox addMagazineCargoGlobal [_handgunAmmo, (_num1 * 4)];
	_weapBox addMagazineCargoGlobal [_weap2Ammo, (_num2 * 4)];
	_weapBox addMagazineCargoGlobal [_weap1Ammo, (_num3 * 4)];
		
		if (count (primaryWeaponItems _unit2) > 0) then {
		private _weap2Optic = (primaryWeaponItems _unit2) select 0;
		_weapBox addItemCargoGlobal [_weap2Optic, (_num2 * 4)];
		}
	};

waitUntil { sleep 1; 
		(_unit1 call BIS_fnc_enemyDetected == true) || (spawner getVariable _markerX == 2);
	};

switch(true) do {
    case((_unit1 call BIS_fnc_enemyDetected == true)): {

		_polStn setVariable ["attacked", true, true];
		
        sleep 10;

	if ((alive _unit1) && !(lifeState _unit1 == "INCAPACITATED") && !(captive _unit1)) then {
		
	_road = [getPos _reinfOrigin, 100] call BIS_fnc_nearestRoad;
	_direction = _road call A3A_fnc_getRoadDirection;
 
		private _reinfVeh = _typeVehX createVehicle getPos _road;
		
		if (_markerX in ["city_StarySobor","city_Vybor","city_Berezino","city_Solnychniy","city_Elektrozavodsk","city_Novodmitrovsk","City_NovayaPetrovka"]) then {
			_reinfVeh setDir (_direction + 180);
			} else {
			_reinfVeh setDir _direction;
		};

		private _destination = getPos ([getPosATL _polStn, 50] call BIS_fnc_nearestRoad);

		_groupY = createGroup _sideX;
		private _unit9 = [_groupY, _officer, [0,0,0], [], 0, "NONE"] call A3A_fnc_createUnit;
		private _unit10 = [_groupY, _grunt, [0,0,0], [], 0, "NONE"] call A3A_fnc_createUnit;
		private _unit11 = [_groupY, _grunt, [0,0,0], [], 0, "NONE"] call A3A_fnc_createUnit;
		private _unit12 = [_groupY, _grunt, [0,0,0], [], 0, "NONE"] call A3A_fnc_createUnit;

		{
		[_x] call A3A_fnc_NATOinit;
		} forEach units _groupY;
		_groupY setBehaviour "SAFE";
			
			if (_typeVehX in vehPoliceCars) then {
				_unit9 moveInDriver _reinfVeh;
				_unit10 moveInCargo _reinfVeh;
				_unit11 moveInCargo _reinfVeh;
				_unit12 moveInCargo _reinfVeh;
				_reinfVeh animate ["Majak_start",1];_reinfVeh switchLight "On"; [_reinfVeh,"CustomSoundController1",1,0.2] remoteExec ["BIS_fnc_setCustomSoundController"];
				_wp1 = _groupY addWaypoint [_destination, 0];
				_wp1 setWaypointType "UNLOAD";
				_wp1 setWaypointStatements ["true", "[vehicle this,'CustomSoundController1',0,0.4] remoteExec ['BIS_fnc_setCustomSoundController']; group _this setBehaviour 'AWARE'"]
				
			} else {
			_unit9 moveInDriver _reinfVeh;
			_unit10 moveInAny _reinfVeh;
			_unit11 moveInAny _reinfVeh;
			_unit12 moveInAny _reinfVeh;
			_wp1 = _groupY addWaypoint [_destination, 0];
			_wp1 setWaypointType "UNLOAD";
			};

			private _counter = 0;
			while { _polStn getVariable "attacked" == true || _counter < 7200 } do { sleep 1; _counter = _counter + 1 };

			_polStn setVariable ["attacked", false, true];
			
		waitUntil { sleep 1; 
		(spawner getVariable _markerX == 2);
		};
			
			{if (alive _x) then {deleteVehicle _x}} forEach units _groupX;
			deleteGroup _groupX;
			
			clearWeaponCargoGlobal _weapBox;
			clearMagazineCargoGlobal _weapBox;
			clearItemCargoGlobal _weapBox;
			
			{if (alive _x) then {deleteVehicle _x}} forEach _roofGunsList;
			
			{if (alive _x) then {deleteVehicle _x}} forEach units _groupY;
			deleteGroup _groupY;
			if (alive _reinfVeh) then {deleteVehicle _reinfVeh};
		};
	};

	case((spawner getVariable _markerX == 2)): {

		{if (alive _x) then {deleteVehicle _x}} forEach units _groupX;
			deleteGroup _groupX;
			
			clearWeaponCargoGlobal _weapBox;
			clearMagazineCargoGlobal _weapBox;
			clearItemCargoGlobal _weapBox;
			
			{if (alive _x) then {deleteVehicle _x}} forEach _roofGunsList;
	};
};