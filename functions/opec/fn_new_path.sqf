private [ "_cont_pick", "_cont_x", "_cont_y", "_n_found", "_s_found", "_e_found", "_w_found", "_check_n", "_check_s", "_check_e", "_check_w", "_len", "_left", "_all_cells_array", "_count_cells", "_time_stop", "_checker_n", "_path_center_x", "_path_center_y", "_path_logic", "_name_dir", "_checker_s", "_checker_e", "_checker_w" ];

_cont_pick = _this select 0;
_cont_x = _this select 1;
_cont_y = _this select 2;

_n_found = [ "n", _cont_pick ] call KK_fnc_inString;
_s_found = [ "s", _cont_pick ] call KK_fnc_inString;
_e_found = [ "e", _cont_pick ] call KK_fnc_inString;
_w_found = [ "w", _cont_pick ] call KK_fnc_inString;

_check_n = 0;
_check_s = 0;
_check_e = 0;
_check_w = 0;

_len = ( count all_cells ) - 1;
_left = [ all_cells, _len ] call KRON_fnc_strLeft;
_left = _left + "];";
_all_cells_array = call compile _left;
_count_cells = count _all_cells_array;
_time_stop = param_number <= _count_cells;

if ( _time_stop ) exitWith { were_done_here = true; };

if ( _n_found ) then {
	waitUntil {
		sleep 0.25;
		_check_n = nil;
		_checker_n = [ _cont_x, ( _cont_y + 1 ), false ] call opec_fnc_check_around;
		_check_n = _checker_n call BIS_fnc_selectRandom;
		!isNil "_check_n"
	};

	_path_center_x = ( ( _cont_x + 0.5 ) * 100 );
	_path_center_y = ( ( _cont_y + 1.5 ) * 100 );
	_path_logic = [ _path_center_x, _path_center_y, 0 ] nearestObject "LocationArea_F";
	if ( !isNull _path_logic ) exitWith {};

	_name_dir = _check_n select 0 select 3;
	all_cells = all_cells + str [ _cont_x, ( _cont_y + 1 ), _name_dir ] + ",";
	
	[ _cont_x, ( _cont_y + 1 ), [ _check_n ] ] spawn opec_fnc_build_go;
};
if ( _s_found ) then {
	waitUntil {
		sleep 0.25;
		_check_s = nil;
		_checker_s = [ _cont_x, ( _cont_y - 1 ), false ] call opec_fnc_check_around;
		_check_s = _checker_s call BIS_fnc_selectRandom;
		!isNil "_check_s"
	};

	_path_center_x = ( ( _cont_x + 0.5 ) * 100 );
	_path_center_y = ( ( _cont_y - 0.5 ) * 100 );
	_path_logic = [ _path_center_x, _path_center_y, 0 ] nearestObject "LocationArea_F";
	if ( !isNull _path_logic ) exitWith {};
	
	_name_dir = _check_s select 0 select 3;
	all_cells = all_cells + str [ _cont_x, ( _cont_y - 1 ), _name_dir ] + ",";
	
	[ _cont_x, ( _cont_y - 1 ), [ _check_s ] ] spawn opec_fnc_build_go;
};
if ( _e_found ) then {
	waitUntil {
		sleep 0.25;
		_check_e = nil;
		_checker_e = [ ( _cont_x + 1 ), _cont_y, false ] call opec_fnc_check_around;
		_check_e = _checker_e call BIS_fnc_selectRandom;
		!isNil "_check_e"
	};

	_path_center_x = ( ( _cont_x + 1.5 ) * 100 );
	_path_center_y = ( ( _cont_y + 0.5 ) * 100 );
	_path_logic = [ _path_center_x, _path_center_y, 0 ] nearestObject "LocationArea_F";
	if ( !isNull _path_logic ) exitWith {};
	
	_name_dir = _check_e select 0 select 3;
	all_cells = all_cells + str [ ( _cont_x + 1 ), _cont_y, _name_dir ] + ",";
	
	[ ( _cont_x + 1 ), _cont_y, [ _check_e ] ] spawn opec_fnc_build_go;
};
if ( _w_found ) then {
	waitUntil {
		sleep 0.25;
		_check_w = nil;
		_checker_w = [ ( _cont_x - 1 ), _cont_y, false ] call opec_fnc_check_around;
		_check_w = _checker_w call BIS_fnc_selectRandom;
		!isNil "_check_w"
	};

	_path_center_x = ( ( _cont_x - 0.5 ) * 100 );
	_path_center_y = ( ( _cont_y + 0.5 ) * 100 );
	_path_logic = [ _path_center_x, _path_center_y, 0 ] nearestObject "LocationArea_F";
	if ( !isNull _path_logic ) exitWith {};
	
	_name_dir = _check_w select 0 select 3;
	all_cells = all_cells + str [ ( _cont_x - 1 ), _cont_y, _name_dir ] + ",";
	
	[ ( _cont_x - 1 ), _cont_y, [ _check_w ] ] spawn opec_fnc_build_go;
};