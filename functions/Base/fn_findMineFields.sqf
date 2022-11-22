/*
MB If an engineer is in the garrison reveal mines within a 1km radius of the base every 24 hours
more work on this to come
HangoverIt - updated 25th Nov 2022
*/

waitUntil {sleep 1; !isNil "placementDone"};
waitUntil {sleep 1; placementDone};

// check every day of game time, the dateToNumber function starts from month 1, day 1 so we set the day to 2 to get one day as an interval
// This will only work as long as the year doesn't change, should be easy to adapt to take year into account though, if needed
private _mineCheckIntervalAsNumber = dateToNumber [(date select 0), 1, 1, 0, 2];   // [(date select 0), 1, 2, 0, 0]

while {true} do{
    // run this every 2 minutes to ensure there is a large enough time gap between runs for 
    // dateToNumber to register a difference in the interval. this should avoid an intermittent
    // issue of mines being found instantly
    diag_log "MINECHECK: starting mine check";
    sleep 300;
    // Simple code to reveal mines in a 1 km radius when an engineer is in the base
    // find all our bases
    // (markersX - watchpostsFIA - roadblocksFIA - aapostsFIA - atpostsFIA - mortarpostsFIA - hmgpostsFIA) select {sidesX getVariable [_x,sideUnknown] == teamPlayer};
    private _markers = markersX select { sidesX getVariable [_x, sideUnknown] == teamPlayer};

    diag_log format ["MINECHECK: before loop: datesSinceLastBaseMineChecks = %1", datesSinceLastBaseMineChecks]; 

	private _currentDateAsNumber = dateToNumber date;
    // loop through base markers
    {
		private _currentMarker = _x;
		private _markerPos = getMarkerPos _currentMarker;
        private _garrison = garrison getVariable [_currentMarker, []];
		
		// get date if available
		private _lastCheckAsNumber = dateToNumber datesSinceLastBaseMineChecks get _currentMarker;

		// Only do something if engineer is in garrison
		if (SDKEng in _garrison) then {
			// If no last check then this is a new engineer and we can start the work of detecting mines
			if (isNil "_lastCheckAsNumber") then {
				_lastCheckAsNumber = date ;
				datesSinceLastBaseMineChecks set [_currentMarker, _lastCheckAsNumber];
				diag_log format ["MINECHECK: new engineer added: datesSinceLastBaseMineChecks = %1", datesSinceLastBaseMineChecks];
			};
			if (_currentDateAsNumber > (_lastCheckAsNumber + _mineCheckIntervalAsNumber)) then {
				diag_log format ["MINECHECK: Checking for mines around %1", _currentMarker];
				datesSinceLastBaseMineChecks set [_currentMarker, date];
				diag_log format ["MINECHECK: mine check: datesSinceLastBaseMineChecks = %1", datesSinceLastBaseMineChecks]; 
				
				// seems to detect most kinds of mines and explosives
                _minesX = allmines select {(_x distance _markerPos) < 1000};
				
				{
					if (!(_x mineDetectedBy playerSide)) then {
						// a flat 60% chance of finding a mine
						if (mineActive _x && (random 5 < 3)) then
						{
							diag_log format ["MINECHECK: mine detected: %1", _x];
							playerSide revealMine _x;
						};
					};
				}forEach _minesX ;
			};
		}else{
			// not engineer, but if it has a last check then remove - engineer probably removed from garrison
			if (!isNil "_lastCheckAsNumber") then {
				datesSinceLastBaseMineChecks set [_currentMarker, Nil];
			}; 
		} ;
    }forEach(_markers - watchpostsFIA - roadblocksFIA - aapostsFIA - atpostsFIA - mortarpostsFIA - hmgpostsFIA);
};
