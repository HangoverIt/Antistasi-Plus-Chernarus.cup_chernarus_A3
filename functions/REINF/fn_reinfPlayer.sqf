params ["_typeUnit"];

if !(player call A3A_fnc_isMember) exitWith {["AI Recruitment", "Only Server Members can recruit AI units."] call A3A_fnc_customHint;};

if (recruitCooldown > time) exitWith {["AI Recruitment", format ["You need to wait %1 seconds to be able to recruit units again.",round (recruitCooldown - time)]] call A3A_fnc_customHint;};

if (player != player getVariable ["owner",player]) exitWith {["AI Recruitment", "You cannot buy units while you are controlling AI."] call A3A_fnc_customHint;};

if ([player,300] call A3A_fnc_enemyNearCheck) exitWith {["AI Recruitment", "You cannot Recruit Units with enemies nearby."] call A3A_fnc_customHint;};

if (player != leader group player) exitWith {["AI Recruitment", "You cannot recruit units as you are not your group leader."] call A3A_fnc_customHint;};

private _hr = server getVariable "hr";

if (_hr < 1) exitWith {["AI Recruitment", "You do not have enough HR for this request."] call A3A_fnc_customHint;};
private _costs = server getVariable _typeUnit;
private _resourcesFIA = player getVariable ["moneyX", 0];


private _exit = false;
{
	if (_x == _typeUnit) exitWith {
		_exit = true;
	};
} forEach [SDKMG, SDKGL, SDKSniper, SDKExp];

if (_exit && {tierWar < 2}) exitWith {
	["Recruit Squad", "War level must be 2 or greater to recruit this type of unit."] call SCRT_fnc_misc_showDeniedActionHint;
};

if (_typeUnit == SDKATman && {tierWar < 3}) exitWith {
	["Recruit Squad", "War level must be 3 or greater to recruit this type of unit."] call SCRT_fnc_misc_showDeniedActionHint;
};

if (_costs > _resourcesFIA) exitWith {["AI Recruitment", format ["You do not have enough money for this kind of unit (%1%2 needed).", _costs, currencySymbol]] call A3A_fnc_customHint;};

if ((count units group player) + (count units stragglers) > 9) exitWith {["AI Recruitment", "Your squad is full or you have too many scattered units with no radio contact."] call A3A_fnc_customHint;};

// JB Code for limited gear
private "_unit";

_loadout = rebelLoadouts get _typeUnit;

_fullUnitGear = _loadout call A3A_fnc_reorgLoadoutUnit;

	_emptyList = [];
	{
	private "_number";
	_number = [jna_dataList select (_x select 0 call jn_fnc_arsenal_itemType), _x select 0]call jn_fnc_arsenal_itemCount; 
	if (_number < ((2 * ((_x select 1) + 1))) && !(_number == -1)) then { _emptyList pushBack (_x select 0) }
	} forEach _fullUnitGear;
	
	if (count _emptyList > 0) exitWith {
		
		equipUnit = false;
		
		private _weaps = [];
		private _mags = [];
		private _strings = [];
		
		{
			_weaps = getText (configFile >> "CfgWeapons" >> _x >> "displayName");
			_strings pushBack _weaps;
			_mags = getText (configFile >> "CfgMagazines" >> _x >> "displayName");
			_strings pushBack _mags;
		} forEach _emptyList;
		
		_strings = _strings - [""];
				
		if (_typeUnit == SDKMedic) then {
			titleText [format["<t color='#ff0000' size='2'>Recruit Squad<br/><t color='#ffffff' size='1.5'>The following gear has run too low for you to recruit this unit: <t color='#ffff00' size='1.5'>%1<br/><t color='#fffff' size='1.5'>Unarmed medic recruited instead. Use AI control to equip the unit from the arsenal.", _strings], "PLAIN DOWN", 1, true, true];
			_unit = [group player, SDKMedic, position player, [], 0, "NONE"] call A3A_fnc_createUnit;
			};
		
		if (_typeUnit == SDKEng) then {
			titleText [format["<t color='#ff0000' size='2'>Recruit Squad<br/><t color='#ffffff' size='1.5'>The following gear has run too low for you to recruit this unit: <t color='#ffff00' size='1.5'>%1<br/><t color='#fffff' size='1.5'>Unarmed engineer recruited instead. Use AI control to equip the unit from the arsenal.", _strings], "PLAIN DOWN", 1, true, true];
			_unit = [group player, SDKEng, position player, [], 0, "NONE"] call A3A_fnc_createUnit;
			};
		
		if (_typeUnit == SDKExp) then {
			titleText [format["<t color='#ff0000' size='2'>Recruit Squad<br/><t color='#ffffff' size='1.5'>The following gear has run too low for you to recruit this unit: <t color='#ffff00' size='1.5'>%1<br/><t color='#fffff' size='1.5'>Unarmed demolitionist recruited instead. Use AI control to equip the unit from the arsenal.", _strings], "PLAIN DOWN", 1, true, true];
			_unit = [group player, SDKExp, position player, [], 0, "NONE"] call A3A_fnc_createUnit;
			};
			
		if (_typeUnit in [SDKMil, SDKMG, SDKGL, SDKSniper, SDKATman]) then {	
			_costs = server getVariable SDKMil;
			titleText [format["<t color='#ff0000' size='2'>Recruit Squad<br/><t color='#ffffff' size='1.5'>The following gear has run too low for you to recruit this unit: <t color='#ffff00' size='1.5'>%1<br/><t color='#fffff' size='1.5'>Unarmed rifleman recruited instead. Use AI control to equip the unit from the arsenal.", _strings], "PLAIN DOWN", 1, true, true];
			_unit = [group player, SDKMil, position player, [], 0, "NONE"] call A3A_fnc_createUnit;
			};
	
	if (!isMultiPlayer) then {
	_nul = [-1, -_costs] remoteExec ["A3A_fnc_resourcesFIA",2];

		} else {

	_nul = [-1, 0] remoteExec ["A3A_fnc_resourcesFIA",2];
	[- _costs] call A3A_fnc_resourcesPlayer;
	["AI Recruitment", "Soldier Recruited.<br/><br/>Remember: if you use the group menu to switch groups you will lose control of your recruited AI."] call A3A_fnc_customHint;
	};
	
	[_unit] spawn A3A_fnc_FIAinit;
	_unit disableAI "AUTOCOMBAT";
	sleep 1;
	petrovsky directSay "SentGenReinforcementsArrived";
		
};

private _unit = [group player, _typeUnit, position player, [], 0, "NONE"] call A3A_fnc_createUnit;
{ [_x select 0 call jn_fnc_arsenal_itemType, _x select 0, _x select 1]call jn_fnc_arsenal_removeItem } forEach _fullUnitGear;

if (!isMultiPlayer) then {
	_nul = [-1, - _costs] remoteExec ["A3A_fnc_resourcesFIA",2];
} else {
	_nul = [-1, 0] remoteExec ["A3A_fnc_resourcesFIA",2];
	[- _costs] call A3A_fnc_resourcesPlayer;
	["AI Recruitment", "Soldier Recruited.<br/><br/>Remember: if you use the group menu to switch groups you will lose control of your recruited AI."] call A3A_fnc_customHint;
};

[_unit] spawn A3A_fnc_FIAinit;
_unit disableAI "AUTOCOMBAT";
sleep 1;
petrovsky directSay "SentGenReinforcementsArrived";
