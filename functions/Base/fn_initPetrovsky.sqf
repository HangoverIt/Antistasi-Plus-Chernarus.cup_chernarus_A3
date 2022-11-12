private _fileName = "fn_initPetrovsky";
[2,"initPetrovsky started",_fileName] call A3A_fnc_log;
scriptName "fn_initPetrovsky";
removeHeadgear petrovsky;
removeGoggles petrovsky;
petrovsky setSkill 1;
petrovsky setVariable ["respawning",false];
petrovsky allowDamage false;
petrovsky addMagazine "CUP_16Rnd_9x19_cz75";
petrovsky addWeapon "CUP_hgun_CZ75";
petrovsky addMagazines ["CUP_16Rnd_9x19_cz75", 2];
petrovsky addItem "FirstAidKit";

if (tierWar == 1) then {
	petrovsky addVest "CUP_V_RUS_Smersh_New_Full";
	petrovsky addMagazine "CUP_30Rnd_9x19_Vityaz";
	petrovsky addWeapon "CUP_smg_vityaz";
	petrovsky addMagazines  ["CUP_30Rnd_9x19_Vityaz", 3];
	};

if ((tierWar > 1) && (tierWar < 4)) then {
	petrovsky addVest "CUP_V_CDF_6B3_5_Green";
	petrovsky addMagazine "CUP_30Rnd_545x39_AK74_plum_M";
	petrovsky addPrimaryWeaponItem "CUP_optic_OKP_7";
	petrovsky addWeapon "CUP_arifle_AKS74U";
	petrovsky addMagazines  ["CUP_30Rnd_545x39_AK74_plum_M", 3];
	};
	
if ((tierWar > 3) && (tierWar < 6)) then {
	petrovsky addVest "CUP_V_RUS_6B3_Flora_2";
	petrovsky addMagazine "CUP_30Rnd_545x39_AK_M";
	petrovsky addWeapon "CUP_arifle_AKS74";
	petrovsky addPrimaryWeaponItem "CUP_optic_ekp_8_02";
	petrovsky addMagazines  ["CUP_30Rnd_545x39_AK_M", 3];
	petrovsky linkItem "CUP_NVG_PVS15_Hide";
	};

if ((tierWar > 5) && (tierWar < 8)) then {
	petrovsky addVest "CUP_V_RUS_6B3_Flora_2";
	petrovsky addMagazine "CUP_30Rnd_545x39_AK74M_M";
	petrovsky addWeapon "CUP_arifle_AK74M";
	petrovsky addPrimaryWeaponItem "CUP_optic_1p63";
	petrovsky addMagazines  ["CUP_30Rnd_545x39_AK74M_M", 3];
	petrovsky linkItem "CUP_NVG_PVS15_Hide";
	};
	
if (tierWar > 7) then {
	petrovsky addVest "CUP_V_B_Armatus_BB_OD";
	petrovsky addMagazine "CUP_30Rnd_545x39_AK74M_M";
	petrovsky addWeapon "CUP_arifle_AK105_top_rail";
	petrovsky addPrimaryWeaponItem "CUP_optic_1P87_1P90_BLK";
	petrovsky addMagazines  ["CUP_30Rnd_545x39_AK74M_M", 3];
	petrovsky linkItem "CUP_NVG_PVS15_Hide";
	};

petrovsky selectWeapon (primaryWeapon petrovsky);
[petrovsky,true] call A3A_fnc_punishment_FF_addEH;
petrovsky setRank "COLONEL";
petrovsky addEventHandler
[
    "HandleDamage",
    {
    _part = _this select 1;
    _damage = _this select 2;
    _injurer = _this select 3;

    _victim = _this select 0;
    _instigator = _this select 6;
    if (isPlayer _injurer) then
    {
        _damage = (_this select 0) getHitPointDamage (_this select 7);
    };
    if ((isNull _injurer) or (_injurer == petrovsky)) then {_damage = 0};
        if (_part == "") then
        {
            if (_damage > 1) then
            {
                if (!(petrovsky getVariable ["incapacitated",false])) then
                {
                    petrovsky setVariable ["incapacitated",true,true];
                    _damage = 0.9;
                    if (!isNull _injurer) then {[petrovsky,side _injurer] spawn A3A_fnc_unconscious} else {[petrovsky,sideUnknown] spawn A3A_fnc_unconscious};
                }
                else
                {
                    _overall = (petrovsky getVariable ["overallDamage",0]) + (_damage - 1);
                    if (_overall > 1) then
                    {
                        petrovsky removeAllEventHandlers "HandleDamage";
                    }
                    else
                    {
                        petrovsky setVariable ["overallDamage",_overall];
                        _damage = 0.9;
                    };
                };
            };
        };
    _damage;
    }
];

petrovsky addMPEventHandler ["mpkilled",
{
    removeAllActions petrovsky;
    _killer = _this select 1;
    if (isServer) then
	{
        if ((side _killer == Invaders) or (side _killer == Occupants) and !(isPlayer _killer) and !(isNull _killer)) then
		{
			_nul = [] spawn {
				garrison setVariable ["Synd_HQ",[],true];
				["Synd_HQ"] call A3A_fnc_clearGarrisonLoadout ;
				_hrT = server getVariable "hr";
				_resourcesFIAT = server getVariable "resourcesFIA";
				[-1*(round(_hrT*0.9)),-1*(round(_resourcesFIAT*0.9))] remoteExec ["A3A_fnc_resourcesFIA",2];
				waitUntil {count allPlayers > 0};
				if (!isNull theBoss) then {
					[] remoteExec ["A3A_fnc_placementSelection",theBoss];
				} else {
					private _playersWithRank =
						(call A3A_fnc_playableUnits)
						select {(side (group _x) == teamPlayer) && isPlayer _x && _x == _x getVariable ["owner", _x]}
						apply {[([_x] call A3A_fnc_numericRank) select 0, _x]};
					_playersWithRank sort false;

					 [] remoteExec ["A3A_fnc_placementSelection", _playersWithRank select 0 select 1];
				};
			};
			{
				if (side _x == Occupants) then {_x setPos (getMarkerPos respawnOccupants)};
			} forEach (call A3A_fnc_playableUnits);
		}
        else
		{
            [] call A3A_fnc_createPetrovsky;
		};
	};
}];
[] spawn {sleep 120; petrovsky allowDamage true;};

private _removeProblematicAceInteractions = {
    _this spawn {
        //Wait until we've got A3A_hasACE initialised fully
        waitUntil {!isNil "initVar"};
        //Disable ACE Interactions
        if (hasInterface && A3A_hasACE) then {
            [typeOf _this, 0,["ACE_ApplyHandcuffs"]] call ace_interact_menu_fnc_removeActionFromClass;
            [typeOf _this, 0,["ACE_MainActions", "ACE_JoinGroup"]] call ace_interact_menu_fnc_removeActionFromClass;
        };
    };
};

//We're doing it per-init of petrovsky, because the type of petrovsky on respawn might be different to initial type.
//This'll prevent it breaking in the future.
[petrovsky, _removeProblematicAceInteractions] remoteExec ["call", 0, petrovsky];

[2,"initPetrovsky completed",_fileName] call A3A_fnc_log;
