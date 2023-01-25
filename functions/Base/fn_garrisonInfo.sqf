private ["_siteX","_textX","_garrison","_size","_positionX"];

_siteX = _this select 0;

_garrison = garrison getVariable [_siteX,[]];

_size = [_siteX] call A3A_fnc_sizeMarker;
_positionX = getMarkerPos _siteX;
_estatic = if (_siteX in roadblocksFIA) then {"Technicals"} else {"Statics"};
_textX = format [
    "<br/>Garrison men: %1<br/><br/>Squad Leaders: %2<br/>%12: %3<br/>Riflemen: %4<br/>Autoriflemen: %5<br/>Engineer: %6<br/>Medics: %7<br/>Grenadiers: %8<br/>Marksmen: %9<br/>AT Men: %10<br/>Static Weap: %11", 
    count _garrison, 
    {_x == SDKSL} count _garrison, 
    {_x == staticCrewTeamPlayer} count _garrison, 
    {_x == SDKMil} count _garrison, 
    {_x == SDKMG} count _garrison,
    {_x == SDKEng} count _garrison,
    {_x == SDKMedic} count _garrison,
    {_x == SDKGL} count _garrison,
    {_x == SDKSniper} count _garrison,
    {_x == SDKATman} count _garrison, 
    {_x distance _positionX < _size} count staticsToSave, 
    _estatic
];

_textX