waitUntil {sleep 1; 
	pol1 call BIS_fnc_enemyDetected == true || 
	pol2 call BIS_fnc_enemyDetected == true || 
	pol3 call BIS_fnc_enemyDetected == true || 
	pol4 call BIS_fnc_enemyDetected == true || 
	pol5 call BIS_fnc_enemyDetected == true || 
	pol6 call BIS_fnc_enemyDetected == true || 
	pol7 call BIS_fnc_enemyDetected == true};
{doGetOut _x} forEach (units polgrp); (units polgrp) allowGetIn false;