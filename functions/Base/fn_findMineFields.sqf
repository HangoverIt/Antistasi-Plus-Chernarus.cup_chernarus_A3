/*
if an engineer is in the garrison reveal mines within a 1km radius of the base every 24 hours
more work on this to come
*/

while {true} do
{
    // leave all this in so we can expand the code to cover all bases in the future
    // as well as check for a mine detector (perhaps to improve chance of detection)
    // I had problems working out how to get garrison details such as if the garrison
    // includes an engineer and what his loadout is
    // private _loadoutMarkers = [];
    // private _loadoutMarkers = allVariables SDKgarrLoadouts;
    
    // {
        // private _garrisonLoadout = [];
        // _garrisonLoadout pushback [_x, SDKgarrLoadouts getVariable _x];
        
        // private _garrison = garrison getVariable [_x, []];
        
        // diag_log format ["_garrison: %1", _garrison];
        // diag_log format ["_garrisonLoadout: %1", _garrisonLoadout];

        
    // } foreach _loadoutMarkers;	
    
    
    
    // Simple code to reveal mines in a 1 km radius when an engineer is in the base
    // only works for the HQ
    sleep 86,400; // 86,400 secs is a 24 hour period

    private _garrison = garrison getVariable ["Synd_HQ", []];
    private _posHQ = getMarkerPos "Synd_HQ";

    if(_garrison find SDKEng > -1) then
    {
        // seems to detect most kinds of mines and explosives
        _minesX = allmines select {(_x distance _posHQ) < 1000};

        if (count _minesX > 0) then
        {
            {
                if (mineActive _x && !(_x mineDetectedBy playerSide)) then
                {
                    diag_log format ["mine detected: %1", _x];
                    playerSide revealMine _x;
                };
            } forEach _minesX;        
        };
    };
};
