private _title = call SCRT_fnc_misc_getMissionTitle;

_credits = [ 
	[ _title, [antistasiPlusVersion]], 
	[ "Antistasi Version:", [antistasiVersion]], 
	[ "Antistasi Plus Authors:", ["Socrates"]], 
	[ "Antistasi Authors:", ["Barbolani","Official Antistasi Community"]] 
];
_layer = "credits1" call bis_fnc_rscLayer;
_delay = 4;
_duration = 4;
{
	_title = _x param [0,""];
	_names = _x select 1;
	_text = format ["<t size=1.5 font='PuristaBold'>%1</t>",toUpper (_title)] + "<br />";
	{
		//Second line break controls size of gap between authors. &#160; is a non-breaking space character, which prevents the size being ignored.
		_text = _text + _x + "<br /><t size='0.2'>&#160;</t><br />";
	} foreach _names;
	_text = format ["<t size='1' shadow='2'>%1</t>",_text];
	_index = _foreachindex % 2;
	[_layer,_text,_index,_duration] spawn {
		disableserialization;
		_layer = _this select 0;
		_text = _this select 1;
		_index = _this select 2;
		_duration = _this select 3;
		_fadeTime = 0.5;
		_time = time + _duration - _fadeTime;
		_layer cutrsc ["RscDynamicText","plain"];
		_display = uinamespace getvariable ["BIS_dynamicText",displaynull];
		_ctrlText = _display displayctrl 9999;
		_ctrlText ctrlsetstructuredtext parsetext _text;
		_offsetX = 0.1;
		_offsetY = 0.3;

		_width = safeZoneW;
		_height = ctrltextheight _ctrlText;
		_pos = [safezoneX, safeZoneY + _offsetY,_width,_height];

		_ctrlText ctrlsetposition _pos;
		_ctrlText ctrlsetfade 1;
		_ctrlText ctrlcommit 0;
		_ctrlText ctrlsetfade 0;
		_ctrlText ctrlcommit _fadeTime;
		waituntil {time > _time};
		_ctrlText ctrlsetfade 1;
		_ctrlText ctrlcommit _fadeTime;
	};
	_time = time + _delay;
	waituntil {time > _time};
} foreach _credits;

if (introDone == true) exitWith{};

sleep 1;

titleText ["<t color='#ffffff' size='5'>August 2022", "PLAIN", 1, true, true];

sleep 2;

titleFadeOut 2;

sleep 3;

titleText ["<t color='#ffffff' size='5'>Chernarus, Caucasus region", "PLAIN", 1, true, true];

sleep 2;

titleFadeOut 2;

sleep 3;

titleText ["<t color='#ffffff' size='2.4'>In 2009 the ex-Soviet republic of Chernarus was engulfed in a brutal civil war. Assisted by US forces and the resistance group NAPA, the Chernarus Defense Force defeated the pro-Russian separatists known as the Chedaki.", "PLAIN", 1, true, true]; 

sleep 6;

titleFadeOut 2;

sleep 3;

titleText ["<t color='#ffffff' size='2.4'>In the aftermath of the war, the government of Chernarus sought closer ties with NATO and Europe.", "PLAIN", 1, true, true]; 

sleep 5;

titleFadeOut 2;

sleep 3;

titleText ["<t color='#ffffff' size='2.4'>Moscow initially treated this with reluctant acceptance, but in recent years has aggressively sought to re-establish control over the ex-Soviet nations.", "PLAIN", 1, true, true];

sleep 6;

titleFadeOut 2;

sleep 3;

titleText ["<t color='#ffffff' size='2.4'>Earlier this year Russian forces invaded Chernarus, rapidly overwhelming the Chernarus Defense Force.", "PLAIN", 1, true, true];

sleep 4;

titleFadeOut 2;

sleep 3;

titleText ["<t color='#ffffff' size='2.4'>Despite Western protests, Chernarus had no formal alliances. No one came to her aid.", "PLAIN", 1, true, true];

sleep 4;

titleFadeOut 2;

sleep 3;

titleText ["<t color='#ffffff' size='2.4'>A pro-Russian puppet state was established, and the ranks of the CDF and police filled with pro-Russian cronies and collaborators.", "PLAIN", 1, true, true];

sleep 6;

titleFadeOut 2;

sleep 3;

titleText ["<t color='#ffffff' size='2.4'>Russia continues to occupy the natural resource and industry rich north of the country.", "PLAIN", 1, true, true];

sleep 4;

titleFadeOut 2;

sleep 3;

titleText ["<t color='#ffffff' size='2.4'>The deposed former president, Petrovsky, has gone into hiding and re-established the rebel group NAPA to resist the occupation.", "PLAIN", 1, true, true];

sleep 6;

titleFadeOut 2;

sleep 3;

titleText ["<t color='#ffffff' size='2.4'>With few resources and even fewer allies, a desperate Petrovsky recruits a group of mercenaries to lead the fledgling rebellion into battle…", "PLAIN", 1, true, true];
