private [ "_len", "_left", "_all_cells_array", "_cells_x" , "_cells_y", "_x_go", "_y_go", "_wowzer", "_marker", "_marker_str", "_this_x", "_this_y", "_str_chk", "_is_found", "_check", "_checker", "_name_dir", "_invalid", "_finish_logic", "_nothing", "_cell_total", "_future_str" ];

_len = ( count all_cells ) - 1;
_left = [ all_cells, _len ] call KRON_fnc_strLeft;
_left = _left + "];";
_all_cells_array = call compile _left;

_cells_x = [];
_cells_y = [];

{
	_x_go = _x select 0;
	_y_go = _x select 1;
	_wowzer = _x select 2;
	
	_cells_x pushBack _x_go;
	_cells_y pushBack _y_go;
	
	_marker = [ [ _x_go, _y_go ], _wowzer ];
	_marker_str = str _marker + ";";
	_marker_str setMarkerColor "ColorUNKNOWN";
	
	{
		_this_x = _x select 0;
		_this_y = _x select 1;
		_finish_center_x = ( ( _x_go + 0.5 ) * 100 );
		_finish_center_y = ( ( _y_go + 0.5 ) * 100 );
		
		_wowmarkerstr = 0;
	
		switch ( _forEachIndex ) do {
			case 0 : {
				_wowmarkerstr = createMarker [ str [ _this_x, _this_y ] + "_n_check", [ _finish_center_x, ( _finish_center_y + 25 ) ] ];
				_wowmarkerstr setMarkerShape "RECTANGLE";
				_wowmarkerstr setMarkerType "EMPTY";
				_wowmarkerstr setMarkerColor "ColorRed";
				_wowmarkerstr setMarkerAlpha 0.5;
				_wowmarkerstr setMarkerSize [ 5, 28 ];
			};
			case 1 : {
				_wowmarkerstr = createMarker [ str [ _this_x, _this_y ] + "_e_check", [ ( _finish_center_x + 25 ), _finish_center_y ] ];
				_wowmarkerstr setMarkerShape "RECTANGLE";
				_wowmarkerstr setMarkerType "EMPTY";
				_wowmarkerstr setMarkerColor "ColorRed";
				_wowmarkerstr setMarkerAlpha 0.5;
				_wowmarkerstr setMarkerSize [ 28, 5 ];
			};
			case 2 : {
				_wowmarkerstr = createMarker [ str [ _this_x, _this_y ] + "_s_check", [ _finish_center_x, ( _finish_center_y - 25 ) ] ];
				_wowmarkerstr setMarkerShape "RECTANGLE";
				_wowmarkerstr setMarkerType "EMPTY";
				_wowmarkerstr setMarkerColor "ColorRed";
				_wowmarkerstr setMarkerAlpha 0.5;
				_wowmarkerstr setMarkerSize [ 5, 28 ];
			};
			case 3 : {
				_wowmarkerstr = createMarker [ str [ _this_x, _this_y ] + "_w_check", [ ( _finish_center_x - 25 ), _finish_center_y ] ];
				_wowmarkerstr setMarkerShape "RECTANGLE";
				_wowmarkerstr setMarkerType "EMPTY";
				_wowmarkerstr setMarkerColor "ColorRed";
				_wowmarkerstr setMarkerAlpha 0.5;
				_wowmarkerstr setMarkerSize [ 28, 5 ];
			};
		};
		
		_str_chk = ( str _this_x ) + "," + ( str _this_y );
		_is_found = [ _str_chk, all_cells ] call KK_fnc_inString;
			
		if ( !_is_found ) then {
			_wowmarkerstr setMarkerColor "ColorYellow";
			
			_check = 0;
			waitUntil {
				sleep 0.25;
				_check = nil;
				_checker = [ _this_x, _this_y, true ] call opec_fnc_check_around;
				_check = _checker call BIS_fnc_selectRandom;
				!isNil "_check"
			};

 			_name_dir = _check select 0 select 3;
			_invalid = _name_dir == "nsew";
			
			_finish_logic = [ ( ( _this_x * 100 ) + 50 ), ( ( _this_y * 100 ) + 50 ), 0 ] nearestObject "LocationArea_F";
			_nothing = isNull _finish_logic;
			
			if ( !_invalid && { _nothing } ) then {
				_wowmarkerstr setMarkerColor "ColorGreen";

				[ _this_x, _this_y, [ _check ] ] call opec_fnc_build_go;
				all_cells = all_cells + str [ _this_x, _this_y, _name_dir ] + ",";

				_cell_total = count _all_cells_array;
				_future_str = "Almost finished! 99.9% complete. " + ( str _cell_total ) + " cells made.";
			};
		};
		
		_wowmarkerstr spawn { sleep 0.5; deleteMarker _this; };
	} forEach [ [ _x_go, ( _y_go + 1 ) ], [ _x_go, ( _y_go - 1 ) ], [ ( _x_go + 1 ), _y_go ], [ ( _x_go - 1 ), _y_go ] ];
	
	_marker_str setMarkerColor "ColorCIV";
	
} forEach _all_cells_array;

_cells_x sort true;
_cells_y sort true;

sealand_x_min = ( ( _cells_x select 0 ) * 100 ) - 50;
sealand_y_min = ( ( _cells_y select 0 ) * 100 ) - 50;
sealand_x_max = ( ( _cells_x select ( ( count _cells_x ) - 1 ) ) * 100 ) + 50;
sealand_y_max = ( ( _cells_y select ( ( count _cells_y ) - 1 ) ) * 100 ) + 50;

"SunkenMission_0" setMarkerPos [ ( sealand_x_min - 100 ), ( sealand_y_min - 100 ), 0 ];
"SunkenMission_3" setMarkerPos [ ( sealand_x_min - 100 ), ( sealand_y_max + 100 ), 0 ];
"SunkenMission_4" setMarkerPos [ ( sealand_x_max + 100 ), ( sealand_y_max + 100 ), 0 ];
"SunkenMission_7" setMarkerPos [ ( sealand_x_max + 100 ), ( sealand_y_min - 100 ), 0 ];

/* VehStore8 setPosASL [ ( 18.7 + ( param_x * 100 ) ), ( 93.05 + ( param_y * 100 ) ), 6.79354 ];
GenStore8 setPosASL [ ( 81.8 + ( param_x * 100 ) ), ( 93.95 + ( param_y * 100 ) ), 6.79354 ];
GunStore8 setPosASL [ ( 93.8 + ( param_x * 100 ) ), ( 17.95 + ( param_y * 100 ) ), 6.79354 ]; */
{
	_old_pos = getMarkerPos _x;
 	_boatPos = [ _old_pos , 0, 100, 2, 0, 0, 0 ] call findSafePos;
/*	_old_veh = nearestObjects [ _old_pos, [ "Ship", "Submarine" ], 25 ];
	_pick_veh = _old_veh select 0;
	_pick_veh setPos _boatPos; */
	_x setMarkerPos _boatPos;
} forEach [
	"boatSpawn_31",
	"boatSpawn_32",
	"boatSpawn_33",
	"boatSpawn_34",
	"boatSpawn_35",
	"boatSpawn_36",
	"boatSpawn_37",
	"boatSpawn_38",
	"boatSpawn_39",
	"boatSpawn_40"
];

publicVariable "config_territory_markers";

sealand_complete = true;
publicVariable "sealand_complete";