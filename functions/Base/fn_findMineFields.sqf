/*
if an engineer is in the garrison reveal mines within a 1km radius of the base every 24 hours
more work on this to come
*/

while {true} do
{
<<<<<<< HEAD
    sleep 10; // run this every minute
=======
    // run this every 2 minutes to ensure there is a large enough time gap between runs for 
    // dateToNumber to register a difference in the interval. this should avoid an intermittent
    // issue of mines being found instantly
    sleep 120; // 120 
>>>>>>> 793fd4fd789caeb4fd36ed8028ae3e2bae69fd0f

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
    private _lastCheckAsNumber = dateToNumber DateSinceLastMineCheck;
    
    private _currentDateAsNumber = dateToNumber date;
    // check every day of game time, the dateToNumber function starts from month 1, day 1 so we set the day to 2 to get one day as an interval
    // This will only work as long as the year doesn't change, should be easy to adapt to take year into account though, if needed

    private _mineCheckIntervalAsNumber = dateToNumber [(date select 0), 1, 2, 0, 0];   // [(date select 0), 1, 2, 0, 0]
    
    private _garrison = garrison getVariable ["Synd_HQ", []];
    private _posHQ = getMarkerPos "Synd_HQ";

    if(_garrison find SDKEng > -1 && _currentDateAsNumber > (_lastCheckAsNumber + _mineCheckIntervalAsNumber)) then
    {
        diag_log "Checking for mines around HQ";

        DateSinceLastMineCheck = date;
        publicVariable "DateSinceLastMineCheck";
        
        // seems to detect most kinds of mines and explosives
        _minesX = allmines select {(_x distance _posHQ) < 1000};

        if (count _minesX > 0) then
        {
            {
                // a flat 60% chance of finding a mine
                if (mineActive _x && !(_x mineDetectedBy playerSide) && (random 5 < 3)) then
                {
                    diag_log format ["mine detected: %1", _x];
                    playerSide revealMine _x;
                };
            } forEach _minesX;        
        };
    };
};
