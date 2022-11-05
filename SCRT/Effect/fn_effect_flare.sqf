//	Author: HangoverIt
// 
//	Description:
//	Creates a flare falling from sky and attaches light object for illumination
//
//	Returns:
//	Nothing
//
// 	How to use: 
// 	[_position, _flaretype, _flarecolour] remoteExec ["SCRT_fnc_effect_flare",0];
//
// Example: [_position, "F_40mm_White",[1,1,1]], [_position, "F_40mm_Red", [1,0,0]], [_position, "F_40mm_Yellow", [1,1,0]] or [_position, "F_40mm_Green", [0,1,0]]

params ["_position", "_flareType", "_flareColour"];

_fn_killFlare = {
	params["_flareObj", "_flareLight"] ;
	private _timeout = 600 ;
	waitUntil{sleep 0.1; _timeout = _timeout - 1; !(alive _flareObj) || _timeout <= 0} ;
	deleteVehicle _flareLight;
};

private _flare = (_flareType) createvehicleLocal (_position); 
_flare setVelocity [0,0,-8];
private _flarelight = "#lightpoint" createvehicleLocal (getPosASL _flare);
_flarelight attachTo [_flare, [0, 0, 0]];
_flarelight setLightColor _flareColour;
_flarelight setLightBrightness 13.0;
_flarelight setLightUseFlare true;

[_flare, _flarelight] spawn _fn_killFlare ;
//_flarelight setLightAmbient [1, 1, 1];
//_flarelight setLightIntensity 10000;
//_flarelight setLightFlareSize 10;
//_flarelight setLightFlareMaxDistance 600;
//_flarelight setLightDayLight true;
//_flarelight setLightAttenuation [4, 0, 0, 0.2, 1000, 2000];

// Return the flare object
_flare ;