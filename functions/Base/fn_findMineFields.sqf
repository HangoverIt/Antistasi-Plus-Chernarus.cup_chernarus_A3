/*
MB If an engineer is in the garrison reveal mines within a 1km radius of the base every 24 hours
more work on this to come
HangoverIt - updated 25th Nov 2022
*/

waitUntil {sleep 1; !isNil "placementDone"};
waitUntil {sleep 1; placementDone};

// check every day of game time, the dateToNumber function starts from month 1, day 1 so we set the day to 2 to get one day as an interval
// This will only work as long as the year doesn't change, should be easy to adapt to take year into account though, if needed
private _mineCheckIntervalAsNumber = dateToNumber [(date select 0), 1, 1, 12, 0];   // 1 day = 0.00273974
private _chanceOfDiscovery = 50 ; // percent max
private _garrisionSearchRadius = 1000 ; // max distance an engineer will search around a base
private _engineerRadiusSearch = 50; // max distance an engineer will search after finding a mine

while {true} do{
    // run this every 2 minutes to ensure there is a large enough time gap between runs for 
    // dateToNumber to register a difference in the interval. this should avoid an intermittent
    // issue of mines being found instantly
	if (sunOrMoon < 1) then {
		// It's night time, no one is looking for mines right now
		sleep 1800 ; // long sleep of 30 min
		continue ;
	};
    sleep 300;
    diag_log "MINECHECK: starting mine check...";
    // Simple code to reveal mines in a 1 km radius when an engineer is in the base
    // find all our bases
    private _markers = markersX select { sidesX getVariable [_x, sideUnknown] == teamPlayer};

	private _currentDateAsNumber = dateToNumber date;
    // loop through base markers
    {
		private _currentMarker = _x;
		private _markerPos = getMarkerPos _currentMarker;
        private _garrison = garrison getVariable [_currentMarker, []];
		
		// get date if available
		private _lastCheckAsNumber = dateToNumber (datesSinceLastBaseMineChecks get _currentMarker);
		private _engineersInGarrison = {_x == SDKEng} count _garrison ;

		// Only do something if engineer is in garrison
		if (_engineersInGarrison > 0) then {
			// If no last check then this is a new engineer and we can start the work of detecting mines
			if (isNil "_lastCheckAsNumber") then {
				_lastCheckAsNumber = dateToNumber date ;
				datesSinceLastBaseMineChecks set [_currentMarker, date];
				diag_log format ["MINECHECK: new engineer added: last date check set to date now = %1", date];
			};
			if (_currentDateAsNumber > (_lastCheckAsNumber + _mineCheckIntervalAsNumber)) then {
				datesSinceLastBaseMineChecks set [_currentMarker, date];
				diag_log format ["MINECHECK: Engineer has been out searching for mines around %1, record updated to %2", _currentMarker, datesSinceLastBaseMineChecks get _currentMarker];
				
				// seems to detect most kinds of mines and explosives
                private _minesX = allmines select {((_x distance _markerPos) < _garrisionSearchRadius) && !(_x mineDetectedBy playerSide) && (mineActive _x)};
				private _engineersRemaining = _engineersInGarrison ; // Simulate search by number of engineers in garrison. They can each find a patch of mines
				{
					if (random 100 >= _chanceOfDiscovery) then {
						_foundMine = _x ; // found at least one mine
						// use the max chance percentage to discover additional mines at location (TO DO: mine detector on engineers could increase further)
						_otherDiscoveredMines = _minesX select {((_x distance _foundMine) < _engineerRadiusSearch) && (random 100 >= _chanceOfDiscovery)};
						_otherDiscoveredMines pushBack _foundMine;
						// Show all mines at location as though they are additionally discovered. Assume this is a single engineer and then goes home to report findings
						{playerSide revealMine _x} forEach _otherDiscoveredMines ;
						_engineersRemaining = _engineersRemaining - 1; // this engineer has completed discovery so remove from available count
						diag_log format ["MINECHECK: %1 mines detected at location %2 by a garrisoned engineer. %3 engineers remaining to search", count _otherDiscoveredMines, getPos _foundMine, _engineersRemaining];
					};
					if (_engineersRemaining <= 0) exitWith {};
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
