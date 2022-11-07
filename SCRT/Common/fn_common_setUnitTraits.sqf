/*
Author: Barbolani, DoomMetal, MeltedPixel, Bob-Murphy, Wurzel0701, Socrates
    Sets the units traits (camouflage, medic, engineer) for the selected role of the player
    THIS FUNCTION DEPENDS ON ONLY THE DEFAULT COMMANDER HAVING A ROLE DESCRIPTION!

Arguments:
    <NULL>

Return Value:
    <NULL>

Scope: Local
Environment: Any
Public: No
Dependencies:
    <NULL>

Example:
    [] spawn SCRT_fnc_common_setUnitTraits;
*/

private _type = typeOf player;
private _text = "";
if(roleDescription player == "Commander, Medic") then {
    player setUnitTrait ["camouflageCoef",0.8];
    player setUnitTrait ["audibleCoef",0.8];
    player setUnitTrait ["loadCoef",0.8];
    player setUnitTrait ["medic", true];
	player setUnitTrait ["UAVHacker",true];
	player setSpeaker "Male04ENGB";
    _text = "Commander role.<br/><br/>The commander is a unit with increased camouflage, medical and UAV hacking capabilities with the access to exclusive Commander Menu (CTRL+T)";
}
else
{
    switch (_type) do
    {
    	case typePetrovsky: {player setUnitTrait ["UAVHacker",true]};
    	//cases for greenfor missions
    	case "I_E_Soldier_Pathfinder_F": {player setUnitTrait ["camouflageCoef",0.6]; player setUnitTrait ["audibleCoef",0.6]; player setUnitTrait ["loadCoef",1]; player setUnitTrait ["medic", true]; player setSpeaker "Male02ENGB"; _text = "the Pathfinder role.<br/><br/>You are a special forces operative specialised in stealth, recon, offensive operations and battlefield medicine"};
    	case "CUP_I_RACS_MMG": {player setUnitTrait ["camouflageCoef",1.2]; player setUnitTrait ["audibleCoef",1.2]; player setUnitTrait ["loadCoef",0.6]; player setUnitTrait ["engineer", true]; player setUnitTrait ["explosiveSpecialist", true]; player setSpeaker "Male01ENGB"; _text = "the Machine Gunner role.<br/><br/>You are a heavy weapons specialist, with engineering and explosives handling skills. You can carry more, but have less stealth than other roles"}; 
    	case "I_G_Sharpshooter_F":  {player setUnitTrait ["audibleCoef",0.4]; player setUnitTrait ["camouflageCoef",0.4];  player setUnitTrait ["loadCoef",1.2]; player setUnitTrait ["engineer", true]; player setSpeaker "Male11ENG";  _text = "the Sharpshooter role.<br/><br/>You are an expert marksman with increased stealth, but cannot carry as much as other roles. You also have engineering skills"}; 
    	case "I_G_engineer_F":  {_text = "Engineer role.<br/><br/>Engineers do not have any bonus or penalties, but have the ability to use Repair Kits for vehicle repair and can locate and recover mines."}; 
    	//cases for pvp blue - added - 9th January 2020, Bob Murphy
    	case "B_recon_medic_F":  {_text = "Medic role.<br/><br/>Medics do not have any bonus or penalties, but have the ability to use certain medical items for full health restoration."}; //added - 9th January 2020, Bob Murphy
    	case "B_recon_TL_F": {player setUnitTrait ["camouflageCoef",0.8]; player setUnitTrait ["audibleCoef",0.8]; player setUnitTrait ["loadCoef",1.4]; _text = "Teamleader role.<br/><br/>Teamleader are more lightweight units with increased camouflage capabilities."}; //added - 9th January 2020, Bob Murphy
    	case "B_recon_M_F": {player setUnitTrait ["camouflageCoef",0.8]; player setUnitTrait ["loadCoef",1.4]; _text = "Marksman role.<br/><br/>Marksmen are more suitable to silent sneak but have less carrying capacity."}; //added - 9th January 2020, Bob Murphy
    	case "B_Patrol_Soldier_MG_F": {player setUnitTrait ["audibleCoef",1.2]; player setUnitTrait ["loadCoef",0.8]; _text = "Autorifleman role.<br/><br/>Autoriflemen have a slight bonus on carry capacity, but make too much noise when they move."}; //added - 9th January 2020, Bob Murphy
    	case "B_recon_LAT_F":  {player setUnitTrait ["audibleCoef",1.2]; player setUnitTrait ["loadCoef",0.8]; _text = "Antitank role.<br/><br/>Antitanks have a slight bonus on carry capacity, but make too much noise when they move."}; //added - 9th January 2020, Bob Murphy
    	//cases for pvp red - added - 9th January 2020, Bob Murphy
    	case "O_T_Recon_Medic_F":  {_text = "Medic role.<br/><br/>Medics do not have any bonus or penalties, but have the ability to use certain medical items for full health restoration"}; //added - 9th January 2020, Bob Murphy
    	case "O_T_Recon_TL_F": {player setUnitTrait ["camouflageCoef",0.8]; player setUnitTrait ["audibleCoef",0.8]; player setUnitTrait ["loadCoef",1.4]; _text = "Teamleader role.<br/><br/>Teamleader are more lightweight units with increased camouflage capabilities."}; //added - 9th January 2020, Bob Murphy
    	case "O_T_Recon_M_F": {player setUnitTrait ["camouflageCoef",0.8]; player setUnitTrait ["loadCoef",1.4]; _text = "Marksman role.<br/><br/>Marksmen are more suitable to silent sneak but have less carrying capacity."}; //added - 9th January 2020, Bob Murphy
    	case "O_Soldier_AR_F": {player setUnitTrait ["audibleCoef",1.2]; player setUnitTrait ["loadCoef",0.8]; _text = "Autorifleman role.<br/><br/>Autoriflemen have a slight bonus on carry capacity, but make too much noise when they move."}; //added - 9th January 2020, Bob Murphy
    	case "O_T_Recon_LAT_F":  {player setUnitTrait ["audibleCoef",1.2]; player setUnitTrait ["loadCoef",0.8]; _text = "Antitank role.<br/><br/>Antitanks have a slight bonus on carry capacity, but make too much noise when they move."}; //added - 9th January 2020, Bob Murphy
    };
};

if (isDiscordRichPresenceActive) then {
	if(player != theBoss) then {
		private _roleName = getText (configFile >> "CfgVehicles" >> _type >> "displayName");
		[["UpdateDetails", _roleName]] call SCRT_fnc_misc_updateRichPresence;
	} else {
		[["UpdateDetails", format ["%1 Commander", nameTeamPlayer]]] call SCRT_fnc_misc_updateRichPresence;
	};
};

["Unit Traits", format ["You have selected %1.",_text]] call A3A_fnc_customHint;