

if (!isServer and hasInterface) exitWith{};
if (introDone == true) exitWith {};

sleep 180;

[[teamPlayer,civilian], "polTsk", ["We are in dire need of weapons. A good place to start would be police stations, which can be found in some of the larger towns, marked by the letters PD on the map.<br/><br/>After the invasion the police were taken over by the military police. They are widely hated, as they are little more than enforcers of the illegal government, which therefore makes them our enemies. Each police station should have a small stash of weapons, not to mention those you can pry out of the cold dead hands of the corrupt police. One such station is in Stary Sobor, go there and see what weapons you can find.", "Acquire Weapons", ""], getPos polStn_1,"CREATED",-1,true,"rifle",true] call BIS_fnc_taskCreate;

	polWpn_1 addWeaponCargoGlobal ["CUP_hgun_Makarov", 2];
	polWpn_1 addWeaponCargoGlobal ["CUP_smg_vityaz_vfg", 2];
	polWpn_1 addWeaponCargoGlobal ["CUP_arifle_AKS74U", 2];
	polWpn_1 addMagazineCargoGlobal ["CUP_8Rnd_9x18_Makarov_M", 8];
	polWpn_1 addMagazineCargoGlobal ["CUP_30Rnd_9x19_Vityaz", 8];
	polWpn_1 addMagazineCargoGlobal ["CUP_30Rnd_545x39_AK74_plum_M", 8];
	
polWpn_1 addEventHandler ["ContainerOpened", {
	["polTsk", "SUCCEEDED"] call BIS_fnc_taskSetState;
[Occupants, 15, 90] remoteExec ["A3A_fnc_addAggression", 2];

{ [30, _x] call A3A_fnc_playerScoreAdd } forEach (call BIS_fnc_listPlayers) select { side _x == teamPlayer || side _x == civilian};
[20, theBoss] call A3A_fnc_playerScoreAdd;   

}];

