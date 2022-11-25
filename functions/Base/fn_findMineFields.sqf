/*
MB If an engineer is in the garrison reveal mines within a 1km radius of the base every 24 hours
more work on this to come
*/

while {true} do
{
    // run this every 2 minutes to ensure there is a large enough time gap between runs for 
    // dateToNumber to register a difference in the interval. this should avoid an intermittent
    // issue of mines being found instantly
    sleep 10; // 120 
    hint "starting mine check";
    sleep 5;
    // Simple code to reveal mines in a 1 km radius when an engineer is in the base



    // check every day of game time, the dateToNumber function starts from month 1, day 1 so we set the day to 2 to get one day as an interval
    // This will only work as long as the year doesn't change, should be easy to adapt to take year into account though, if needed
    private _mineCheckIntervalAsNumber = dateToNumber [(date select 0), 1, 1, 0, 2];   // [(date select 0), 1, 2, 0, 0]
    
    // find all our bases
    private _markers = markersX select { sidesX getVariable [_x, sideUnknown] == teamPlayer};

    diag_log format ["before loop: DatesSinceLastBaseMineChecks = %1", DatesSinceLastBaseMineChecks]; 

    // loop through base markers
    {
        private _garrison = garrison getVariable [_x, []];
        
        private _currentMarker = _x;
        
        // loop through garrison looking for new engineer
        {
            diag_log format ["_currentMarker = %1, _x = %2", _currentMarker, _x];
            diag_log format ["not (_currentMarker in DatesSinceLastBaseMineChecks) = %1", not (_currentMarker in DatesSinceLastBaseMineChecks)];
            
            if(_x == SDKEng && not (_currentMarker in DatesSinceLastBaseMineChecks)) then
            {
                DatesSinceLastBaseMineChecks set [_currentMarker, date];
                publicVariable "DatesSinceLastBaseMineChecks";
                diag_log format ["new engineer added: DatesSinceLastBaseMineChecks = %1", DatesSinceLastBaseMineChecks];                
            }
            
        } forEach _garrison;
        

        private _markerPos = getMarkerPos _x;
        diag_log format ["_marker: %1, pos: %2", _x, _markerPos];
        
        // a base with an engineer
        if(_currentMarker in DatesSinceLastBaseMineChecks) then
        {           
            private _lastCheckAsNumber = dateToNumber DatesSinceLastBaseMineChecks get _currentMarker;
            private _currentDateAsNumber = dateToNumber date;

            if(_garrison find SDKEng > -1 && _currentDateAsNumber > (_lastCheckAsNumber + _mineCheckIntervalAsNumber)) then
            {
                diag_log format ["Checking for mines around %1", _currentMarker];
                
                DatesSinceLastBaseMineChecks set [_currentMarker, date];
                publicVariable "DatesSinceLastBaseMineChecks";
                diag_log format ["mine check: DatesSinceLastBaseMineChecks = %1", DatesSinceLastBaseMineChecks]; 
                
                // seems to detect most kinds of mines and explosives
                _minesX = allmines select {(_x distance _markerPos) < 1000};

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
        
    }forEach(_markers - watchpostsFIA - roadblocksFIA - aapostsFIA - atpostsFIA - mortarpostsFIA - hmgpostsFIA);

};
