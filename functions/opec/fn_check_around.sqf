//Inspects all around the submitted coordinate, returns array of these arrays: [ string: direction of found coord, array: coordinate of found, string: type of thing found ]

private [ "_rnd_x", "_rnd_y", "_ending", "_rnd_n", "_rnd_s", "_rnd_e", "_rnd_w", "_found_logic_n", "_found_logic_s", "_found_logic_e", "_found_logic_w", "_rnd_array", "_cell", "_cell_coord", "_cell_types", "_equalto_n", "_equalto_s", "_equalto_e", "_equalto_w", "_must_have", "_must_not_have", "_rnd_dir", "_rnd_type", "_n_find", "_s_find", "_e_find", "_w_find", "_dir_n", "_dir_s", "_dir_e", "_dir_w", "_maybe_n", "_maybe_s", "_maybe_e", "_maybe_w", "_yes_n", "_no_n", "_yes_s", "_no_s", "_yes_e", "_no_e", "_yes_w", "_no_w", "_len", "_left", "_all_cells_array", "_count_cells", "_time_stop", "_check_return" ];

_rnd_x = _this select 0;
_rnd_y = _this select 1;
_ending = _this select 2;
	
_rnd_n = [ _rnd_x, ( _rnd_y + 1 ) ];
_rnd_s = [ _rnd_x, ( _rnd_y - 1 ) ];
_rnd_e = [ ( _rnd_x + 1 ), _rnd_y ];
_rnd_w = [ ( _rnd_x - 1 ), _rnd_y ];

_found_logic_n = [ ( ( _rnd_x * 100 ) + 50 ), ( ( ( _rnd_y + 1 ) * 100 ) + 50 ), 0 ] nearestObject "LocationArea_F";
_found_logic_s = [ ( ( _rnd_x * 100 ) + 50 ), ( ( ( _rnd_y - 1 ) * 100 ) + 50 ), 0 ] nearestObject "LocationArea_F";
_found_logic_e = [ ( ( ( _rnd_x + 1 ) * 100 ) + 50 ), ( ( _rnd_y * 100 ) + 50 ), 0 ] nearestObject "LocationArea_F";
_found_logic_w = [ ( ( ( _rnd_x - 1 ) * 100 ) + 50 ), ( ( _rnd_y * 100 ) + 50 ), 0 ] nearestObject "LocationArea_F";

_rnd_array = [];

if ( !isNull _found_logic_n ) then {
	_cell = _found_logic_n getVariable "logic_stuff";
	_cell_coord = _cell select 0;
	_cell_types = _cell select 1;
	_equalto_n = _cell_coord isEqualTo _rnd_n;
	if ( _equalto_n ) then {
		_rnd_array pushBack [ "n", _cell_types ];
	};
};

if ( !isNull _found_logic_s ) then {
	_cell = _found_logic_s getVariable "logic_stuff";
	_cell_coord = _cell select 0;
	_cell_types = _cell select 1;
	_equalto_s = _cell_coord isEqualTo _rnd_s;
	if ( _equalto_s ) then {
		_rnd_array pushBack [ "s", _cell_types ];
	};
};

if ( !isNull _found_logic_e ) then {
	_cell = _found_logic_e getVariable "logic_stuff";
	_cell_coord = _cell select 0;
	_cell_types = _cell select 1;
	_equalto_e = _cell_coord isEqualTo _rnd_e;
	if ( _equalto_e ) then {
		_rnd_array pushBack [ "e", _cell_types ];
	};
};

if ( !isNull _found_logic_w ) then {
	_cell = _found_logic_w getVariable "logic_stuff";
	_cell_coord = _cell select 0;
	_cell_types = _cell select 1;
	_equalto_w = _cell_coord isEqualTo _rnd_w;
	if ( _equalto_w ) then {
		_rnd_array pushBack [ "w", _cell_types ];
	};
};

_must_have = [];
_must_not_have = [];

{
	_rnd_dir = _x select 0;
	_rnd_type = _x select 1;
	
	_n_find = [ "n", _rnd_type ] call KK_fnc_inString;
	_s_find = [ "s", _rnd_type ] call KK_fnc_inString;
	_e_find = [ "e", _rnd_type ] call KK_fnc_inString;
	_w_find = [ "w", _rnd_type ] call KK_fnc_inString;
	
	_dir_n = _rnd_dir == "n";
	_dir_s = _rnd_dir == "s";
	_dir_e = _rnd_dir == "e";
	_dir_w = _rnd_dir == "w";
	
	if ( _dir_n && { _s_find } ) then {
		_must_have pushBack "n";
	};
	if ( _dir_s && { _n_find } ) then {
		_must_have pushBack "s";
	};
	if ( _dir_e && { _w_find } ) then {
		_must_have pushBack "e";
	};
	if ( _dir_w && { _e_find } ) then {
		_must_have pushBack "w";
	};
	
	if ( _dir_n && { !_s_find } ) then {
		_must_not_have pushBack "n";
	};
	if ( _dir_s && { !_n_find } ) then {
		_must_not_have pushBack "s";
	};
	if ( _dir_e && { !_w_find } ) then {
		_must_not_have pushBack "e";
	};
	if ( _dir_w && { !_e_find } ) then {
		_must_not_have pushBack "w";
	};
} forEach _rnd_array;

_maybe_n = false;
_maybe_s = false;
_maybe_e = false;
_maybe_w = false;

_yes_n = "n" in _must_have;
_no_n = "n" in _must_not_have;
_maybe_n = !( _yes_n && { _no_n } );
if ( _yes_n ) then { _maybe_n = false; };
if ( _no_n ) then { _maybe_n = false; };

_yes_s = "s" in _must_have;
_no_s = "s" in _must_not_have;
_maybe_s = !( _yes_s && { _no_s } );
if ( _yes_s ) then { _maybe_s = false; };
if ( _no_s ) then { _maybe_s = false; };

_yes_e = "e" in _must_have;
_no_e = "e" in _must_not_have;
_maybe_e = !( _yes_e && { _no_e } );
if ( _yes_e ) then { _maybe_e = false; };
if ( _no_e ) then { _maybe_e = false; };

_yes_w = "w" in _must_have;
_no_w = "w" in _must_not_have;
_maybe_w = !( _yes_n && { _no_w } );
if ( _yes_w ) then { _maybe_w = false; };
if ( _no_w ) then { _maybe_w = false; };

//_time_stop = param_number <= queue_total;
_len = ( count all_cells ) - 1;
_left = [ all_cells, _len ] call KRON_fnc_strLeft;
_left = _left + "];";
_all_cells_array = call compile _left;
_count_cells = count _all_cells_array;
_time_stop = param_number <= _count_cells;

if ( _time_stop ) then {
	if ( _maybe_n ) then {
		_no_n = true;
		_maybe_n = false;
	};
	if ( _maybe_s ) then {
		_no_s = true;
		_maybe_s = false;
	};
	if ( _maybe_e ) then {
		_no_e = true;
		_maybe_e = false;
	};
	if ( _maybe_w ) then {
		_no_w = true;
		_maybe_w = false;
	};
};

//diag_log format [ "[ %1, %2 ] N: %3/%4/%5, S: %6/%7/%8, E: %9/%10/%11, W: %12/%13/%14", _rnd_x, _rnd_y, _yes_n, _maybe_n, _no_n, _yes_s, _maybe_s, _no_s, _yes_e, _maybe_e, _no_e, _yes_w, _maybe_w, _no_w ]; //debug

//List of all possibilities and their potential outcomes. Removed "singles" (like n_sets) when more than one outcome present (so paths wouldn't close prematurely)
_check_return = nsew_sets;

if ( _ending ) then {
	if ( _yes_n && { _yes_s && { _yes_e && { _yes_w } } } ) then { _check_return = nsew_sets; };
	if ( _yes_n && { _yes_s && { _yes_e && { _maybe_w } } } ) then { _check_return = nes_sets; };
	if ( _yes_n && { _yes_s && { _yes_e && { _no_w } } } ) then { _check_return = nes_sets; };
	if ( _yes_n && { _yes_s && { _maybe_e && { _yes_w } } } ) then { _check_return = nws_sets; };
	if ( _yes_n && { _yes_s && { _maybe_e && { _maybe_w } } } ) then { _check_return = ns_sets; };
	if ( _yes_n && { _yes_s && { _maybe_e && { _no_w } } } ) then { _check_return = ns_sets; };
	if ( _yes_n && { _yes_s && { _no_e && { _yes_w } } } ) then { _check_return = nws_sets; };
	if ( _yes_n && { _yes_s && { _no_e && { _maybe_w } } } ) then { _check_return = ns_sets; };
	if ( _yes_n && { _yes_s && { _no_e && { _no_w } } } ) then { _check_return = ns_sets; };
	if ( _yes_n && { _maybe_s && { _yes_e && { _yes_w } } } ) then { _check_return = nwe_sets; };
	if ( _yes_n && { _maybe_s && { _yes_e && { _maybe_w } } } ) then { _check_return = ne_sets; };
	if ( _yes_n && { _maybe_s && { _yes_e && { _no_w } } } ) then { _check_return = ne_sets; };
	if ( _yes_n && { _maybe_s && { _maybe_e && { _yes_w } } } ) then { _check_return = nw_sets; };
	if ( _yes_n && { _maybe_s && { _maybe_e && { _maybe_w } } } ) then { _check_return = n_sets; };
	if ( _yes_n && { _maybe_s && { _maybe_e && { _no_w } } } ) then { _check_return = n_sets; };
	if ( _yes_n && { _maybe_s && { _no_e && { _yes_w } } } ) then { _check_return = n_sets; };
	if ( _yes_n && { _maybe_s && { _no_e && { _maybe_w } } } ) then { _check_return = n_sets; };
	if ( _yes_n && { _maybe_s && { _no_e && { _no_w } } } ) then { _check_return = n_sets; };
	if ( _yes_n && { _no_s && { _yes_e && { _yes_w } } } ) then { _check_return = nwe_sets; };
	if ( _yes_n && { _no_s && { _yes_e && { _maybe_w } } } ) then { _check_return = ne_sets; };
	if ( _yes_n && { _no_s && { _yes_e && { _no_w } } } ) then { _check_return = ne_sets; };
	if ( _yes_n && { _no_s && { _maybe_e && { _yes_w } } } ) then { _check_return = nw_sets; };
	if ( _yes_n && { _no_s && { _maybe_e && { _maybe_w } } } ) then { _check_return = n_sets; };
	if ( _yes_n && { _no_s && { _maybe_e && { _no_w } } } ) then { _check_return = n_sets; };
	if ( _yes_n && { _no_s && { _no_e && { _yes_w } } } ) then { _check_return = nw_sets; };
	if ( _yes_n && { _no_s && { _no_e && { _maybe_w } } } ) then { _check_return = n_sets; };
	if ( _yes_n && { _no_s && { _no_e && { _no_w } } } ) then { _check_return = n_sets; };
	if ( _maybe_n && { _yes_s && { _yes_e && { _yes_w } } } ) then { _check_return = ews_sets; };
	if ( _maybe_n && { _yes_s && { _yes_e && { _maybe_w } } } ) then { _check_return = es_sets; };
	if ( _maybe_n && { _yes_s && { _yes_e && { _no_w } } } ) then { _check_return = es_sets; };
	if ( _maybe_n && { _yes_s && { _maybe_e && { _yes_w } } } ) then { _check_return = ws_sets; };
	if ( _maybe_n && { _yes_s && { _maybe_e && { _maybe_w } } } ) then { _check_return = s_sets; };
	if ( _maybe_n && { _yes_s && { _maybe_e && { _no_w } } } ) then { _check_return = s_sets; };
	if ( _maybe_n && { _yes_s && { _no_e && { _yes_w } } } ) then { _check_return = ws_sets; };
	if ( _maybe_n && { _yes_s && { _no_e && { _maybe_w } } } ) then { _check_return = s_sets; };
	if ( _maybe_n && { _yes_s && { _no_e && { _no_w } } } ) then { _check_return = s_sets; };
	if ( _maybe_n && { _maybe_s && { _yes_e && { _yes_w } } } ) then { _check_return = ew_sets; };
	if ( _maybe_n && { _maybe_s && { _yes_e && { _maybe_w } } } ) then { _check_return = e_sets; };
	if ( _maybe_n && { _maybe_s && { _yes_e && { _no_w } } } ) then { _check_return = e_sets; };
	if ( _maybe_n && { _maybe_s && { _maybe_e && { _yes_w } } } ) then { _check_return = w_sets; };
	if ( _maybe_n && { _maybe_s && { _no_e && { _yes_w } } } ) then { _check_return = w_sets; };
	if ( _maybe_n && { _no_s && { _yes_e && { _yes_w } } } ) then { _check_return = e_sets; };
	if ( _maybe_n && { _no_s && { _yes_e && { _maybe_w } } } ) then { _check_return = e_sets; };
	if ( _maybe_n && { _no_s && { _yes_e && { _no_w } } } ) then { _check_return = e_sets; };
	if ( _maybe_n && { _no_s && { _maybe_e && { _yes_w } } } ) then { _check_return = w_sets; };
	if ( _maybe_n && { _no_s && { _no_e && { _yes_w } } } ) then { _check_return = w_sets; };
	if ( _no_n && { _yes_s && { _yes_e && { _yes_w } } } ) then { _check_return = ews_sets; };
	if ( _no_n && { _yes_s && { _yes_e && { _maybe_w } } } ) then { _check_return = es_sets; };
	if ( _no_n && { _yes_s && { _yes_e && { _no_w } } } ) then { _check_return = es_sets; };
	if ( _no_n && { _yes_s && { _maybe_e && { _yes_w } } } ) then { _check_return = ws_sets; };
	if ( _no_n && { _yes_s && { _maybe_e && { _maybe_w } } } ) then { _check_return = s_sets; };
	if ( _no_n && { _yes_s && { _maybe_e && { _no_w } } } ) then { _check_return = s_sets; };
	if ( _no_n && { _yes_s && { _no_e && { _yes_w } } } ) then { _check_return = ws_sets; };
	if ( _no_n && { _yes_s && { _no_e && { _maybe_w } } } ) then { _check_return = s_sets; };
	if ( _no_n && { _yes_s && { _no_e && { _no_w } } } ) then { _check_return = s_sets; };
	if ( _no_n && { _maybe_s && { _yes_e && { _yes_w } } } ) then { _check_return = ew_sets; };
	if ( _no_n && { _maybe_s && { _yes_e && { _maybe_w } } } ) then { _check_return = e_sets; };
	if ( _no_n && { _maybe_s && { _yes_e && { _no_w } } } ) then { _check_return = e_sets; };
	if ( _no_n && { _maybe_s && { _maybe_e && { _yes_w } } } ) then { _check_return = w_sets; };
	if ( _no_n && { _maybe_s && { _no_e && { _yes_w } } } ) then { _check_return = w_sets; };
	if ( _no_n && { _no_s && { _yes_e && { _yes_w } } } ) then { _check_return = ew_sets; };
	if ( _no_n && { _no_s && { _yes_e && { _maybe_w } } } ) then { _check_return = e_sets; };
	if ( _no_n && { _no_s && { _yes_e && { _no_w } } } ) then { _check_return = e_sets; };
	if ( _no_n && { _no_s && { _maybe_e && { _yes_w } } } ) then { _check_return = w_sets; };
	if ( _no_n && { _no_s && { _no_e && { _yes_w } } } ) then { _check_return = w_sets; };
} else {
	if ( _yes_n && { _yes_s && { _yes_e && { _yes_w } } } ) then { _check_return = nsew_sets; };
	if ( _yes_n && { _yes_s && { _yes_e && { _maybe_w } } } ) then { _check_return = nes_sets; }; //removed nsew
	if ( _yes_n && { _yes_s && { _yes_e && { _no_w } } } ) then { _check_return = nes_sets; };
	if ( _yes_n && { _yes_s && { _maybe_e && { _yes_w } } } ) then { _check_return = nws_sets; }; //removed nsew
	if ( _yes_n && { _yes_s && { _maybe_e && { _maybe_w } } } ) then { _check_return = ns_sets + ns_sets + nes_sets + nws_sets; }; //removed nsew
	if ( _yes_n && { _yes_s && { _maybe_e && { _no_w } } } ) then { _check_return = ns_sets + ns_sets + nes_sets; };
	if ( _yes_n && { _yes_s && { _no_e && { _yes_w } } } ) then { _check_return = nws_sets; };
	if ( _yes_n && { _yes_s && { _no_e && { _maybe_w } } } ) then { _check_return = ns_sets + ns_sets + nws_sets; };
	if ( _yes_n && { _yes_s && { _no_e && { _no_w } } } ) then { _check_return = ns_sets; };
	if ( _yes_n && { _maybe_s && { _yes_e && { _yes_w } } } ) then { _check_return = nwe_sets; }; //removed nsew
	if ( _yes_n && { _maybe_s && { _yes_e && { _maybe_w } } } ) then { _check_return = ne_sets + nes_sets + nwe_sets; }; //removed nsew
	if ( _yes_n && { _maybe_s && { _yes_e && { _no_w } } } ) then { _check_return = ne_sets + nes_sets; };
	if ( _yes_n && { _maybe_s && { _maybe_e && { _yes_w } } } ) then { _check_return = nw_sets + nws_sets + nwe_sets; }; //removed nsew
	if ( _yes_n && { _maybe_s && { _maybe_e && { _maybe_w } } } ) then { _check_return = ns_sets + ns_sets + ne_sets + nw_sets + nes_sets + nws_sets + nws_sets; }; //removed single, nsew
	if ( _yes_n && { _maybe_s && { _maybe_e && { _no_w } } } ) then { _check_return = ns_sets + ns_sets + ne_sets + nes_sets + nes_sets; }; //removed single
	if ( _yes_n && { _maybe_s && { _no_e && { _yes_w } } } ) then { _check_return = nw_sets + nws_sets; };
	if ( _yes_n && { _maybe_s && { _no_e && { _maybe_w } } } ) then { _check_return = ns_sets + ns_sets + nw_sets + nws_sets + nws_sets; }; //removed single
	if ( _yes_n && { _maybe_s && { _no_e && { _no_w } } } ) then { _check_return = ns_sets; }; //removed single
	if ( _yes_n && { _no_s && { _yes_e && { _yes_w } } } ) then { _check_return = nwe_sets; };
	if ( _yes_n && { _no_s && { _yes_e && { _maybe_w } } } ) then { _check_return = ne_sets + nwe_sets; };
	if ( _yes_n && { _no_s && { _yes_e && { _no_w } } } ) then { _check_return = ne_sets; };
	if ( _yes_n && { _no_s && { _maybe_e && { _yes_w } } } ) then { _check_return = nw_sets + nwe_sets; };
	if ( _yes_n && { _no_s && { _maybe_e && { _maybe_w } } } ) then { _check_return = ne_sets + nw_sets + nwe_sets; }; //removed single
	if ( _yes_n && { _no_s && { _maybe_e && { _no_w } } } ) then { _check_return = ne_sets; }; //removed single
	if ( _yes_n && { _no_s && { _no_e && { _yes_w } } } ) then { _check_return = nw_sets; };
	if ( _yes_n && { _no_s && { _no_e && { _maybe_w } } } ) then { _check_return = nw_sets; }; //removed single
	if ( _yes_n && { _no_s && { _no_e && { _no_w } } } ) then { _check_return = n_sets; };
	if ( _maybe_n && { _yes_s && { _yes_e && { _yes_w } } } ) then { _check_return = ews_sets; }; //removed nsew
	if ( _maybe_n && { _yes_s && { _yes_e && { _maybe_w } } } ) then { _check_return = es_sets + ews_sets + nes_sets; }; //removed nsew
	if ( _maybe_n && { _yes_s && { _yes_e && { _no_w } } } ) then { _check_return = es_sets + nes_sets; };
	if ( _maybe_n && { _yes_s && { _maybe_e && { _yes_w } } } ) then { _check_return = ws_sets + nws_sets + ews_sets; }; //removed nsew
	if ( _maybe_n && { _yes_s && { _maybe_e && { _maybe_w } } } ) then { _check_return = ns_sets + ns_sets + es_sets + ws_sets + nes_sets + ews_sets + nws_sets; }; //removed single, nsew
	if ( _maybe_n && { _yes_s && { _maybe_e && { _no_w } } } ) then { _check_return = es_sets + ns_sets + ns_sets + nes_sets; }; //removed single
	if ( _maybe_n && { _yes_s && { _no_e && { _yes_w } } } ) then { _check_return = ws_sets + nws_sets; };
	if ( _maybe_n && { _yes_s && { _no_e && { _maybe_w } } } ) then { _check_return = ns_sets + ns_sets + ws_sets + nws_sets; }; //removed single
	if ( _maybe_n && { _yes_s && { _no_e && { _no_w } } } ) then { _check_return = ns_sets; }; //removed single
	if ( _maybe_n && { _maybe_s && { _yes_e && { _yes_w } } } ) then { _check_return = ew_sets + nwe_sets + ews_sets; }; //removed nsew
	if ( _maybe_n && { _maybe_s && { _yes_e && { _maybe_w } } } ) then { _check_return = ne_sets + es_sets + ew_sets + nes_sets + nwe_sets + ews_sets; }; //removed single, nsew
	if ( _maybe_n && { _maybe_s && { _yes_e && { _no_w } } } ) then { _check_return = ne_sets + es_sets + nes_sets; }; //removed single
	if ( _maybe_n && { _maybe_s && { _maybe_e && { _yes_w } } } ) then { _check_return = nw_sets + nws_sets + nwe_sets; }; //removed nsew
	if ( _maybe_n && { _maybe_s && { _no_e && { _yes_w } } } ) then { _check_return = nw_sets + ws_sets + nws_sets; }; //removed single
	if ( _maybe_n && { _no_s && { _yes_e && { _yes_w } } } ) then { _check_return = ew_sets + nwe_sets; };
	if ( _maybe_n && { _no_s && { _yes_e && { _maybe_w } } } ) then { _check_return = ne_sets + ew_sets + nwe_sets; }; //removed single
	if ( _maybe_n && { _no_s && { _yes_e && { _no_w } } } ) then { _check_return = ne_sets; }; //removed single
	if ( _maybe_n && { _no_s && { _maybe_e && { _yes_w } } } ) then { _check_return = nw_sets + ew_sets + nwe_sets; }; //removed single
	if ( _maybe_n && { _no_s && { _no_e && { _yes_w } } } ) then { _check_return = nw_sets; }; //removed single
	if ( _no_n && { _yes_s && { _yes_e && { _yes_w } } } ) then { _check_return = ews_sets; };
	if ( _no_n && { _yes_s && { _yes_e && { _maybe_w } } } ) then { _check_return = es_sets + ews_sets; };
	if ( _no_n && { _yes_s && { _yes_e && { _no_w } } } ) then { _check_return = es_sets; };
	if ( _no_n && { _yes_s && { _maybe_e && { _yes_w } } } ) then { _check_return = ws_sets + ews_sets; };
	if ( _no_n && { _yes_s && { _maybe_e && { _maybe_w } } } ) then { _check_return = es_sets + ws_sets + ews_sets; }; //removed single
	if ( _no_n && { _yes_s && { _maybe_e && { _no_w } } } ) then { _check_return = es_sets; }; //removed single
	if ( _no_n && { _yes_s && { _no_e && { _yes_w } } } ) then { _check_return = ws_sets; };
	if ( _no_n && { _yes_s && { _no_e && { _maybe_w } } } ) then { _check_return = ws_sets; }; //removed single
	if ( _no_n && { _yes_s && { _no_e && { _no_w } } } ) then { _check_return = s_sets; };
	if ( _no_n && { _maybe_s && { _yes_e && { _yes_w } } } ) then { _check_return = ew_sets + ew_sets + ews_sets; };
	if ( _no_n && { _maybe_s && { _yes_e && { _maybe_w } } } ) then { _check_return = ew_sets + ew_sets + es_sets + ews_sets; }; //removed single
	if ( _no_n && { _maybe_s && { _yes_e && { _no_w } } } ) then { _check_return = es_sets; }; //removed single
	if ( _no_n && { _maybe_s && { _maybe_e && { _yes_w } } } ) then { _check_return = ew_sets + ew_sets + ws_sets + ews_sets; }; //removed single
	if ( _no_n && { _maybe_s && { _no_e && { _yes_w } } } ) then { _check_return = ws_sets; }; //removed single
	if ( _no_n && { _no_s && { _yes_e && { _yes_w } } } ) then { _check_return = ew_sets; };
	if ( _no_n && { _no_s && { _yes_e && { _maybe_w } } } ) then { _check_return = ew_sets; }; //removed single
	if ( _no_n && { _no_s && { _yes_e && { _no_w } } } ) then { _check_return = e_sets; };
	if ( _no_n && { _no_s && { _maybe_e && { _yes_w } } } ) then { _check_return = ew_sets; }; //removed single
	if ( _no_n && { _no_s && { _no_e && { _yes_w } } } ) then { _check_return = w_sets; };
};

_check_return