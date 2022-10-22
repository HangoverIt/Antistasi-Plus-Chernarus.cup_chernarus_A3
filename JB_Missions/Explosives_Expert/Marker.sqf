while {prisonerMarker == true} do {
	_pMarker = createMarker ["Prisoner Transport", prisoner]; // Not visible yet.
	_pMarker setMarkerType "b_unknown"; // Visible.
	_pMarker setMarkerText "Prisoner Transport";
	sleep 10;
	deleteMarker _pMarker;
};