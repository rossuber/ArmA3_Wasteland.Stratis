private [ "_degrees", "_rotate_this", "_ninety", "_oneeighty", "_twoseventy", "_full_return", "_return", "_inner", "_rot_name", "_rot_edges", "_to_build", "_rot_dirs", "_n_found", "_s_found", "_e_found", "_w_found", "_rot_n", "_rot_s", "_rot_e", "_rot_w", "_rot_obj", "_rot_coord", "_rot_dir", "_rot_height", "_rot_simulate", "_rot_vector", "_rot_x", "_rot_y", "_rot_z", "_rot_coord_done", "_rot_dir_done", "_rot_new", "_rot_new_x", "_rot_new_y", "_inner_inner", "_rot_dirs_done" ];

_degrees = _this select 0;
_rotate_this = _this select 1;

_ninety = _degrees == 1;
_oneeighty = _degrees == 2;
_twoseventy = _degrees == 3;

_full_return = [];
_return = [];

{
	_inner = [];
		
	_rot_name = _x select 0;
	_rot_edges = _x select 1;
	_to_build = _x select 2;
	_rot_dirs = _x select 3;
		
	_n_found = [ "n", _rot_dirs ] call KK_fnc_inString;
	_s_found = [ "s", _rot_dirs ] call KK_fnc_inString;
	_e_found = [ "e", _rot_dirs ] call KK_fnc_inString;
	_w_found = [ "w", _rot_dirs ] call KK_fnc_inString;
	_rot_n = "";
	_rot_s = "";
	_rot_e = "";
	_rot_w = "";

	{
		_rot_obj = _x select 0;
		_rot_coord = call compile ( _x select 1 );
		_rot_dir = _x select 2;
		_rot_height = _x select 3;
		_rot_simulate = _x select 4;
		_rot_vector = _x select 5;
			
		_rot_x = _rot_coord select 0;
		_rot_y = _rot_coord select 1;
		_rot_z = _rot_coord select 2;
		
		_rot_coord_done = [];
		_rot_dir_done = 0;
			
		if ( _ninety ) then {
			_rot_dir_done = _rot_dir + 90;
			
			_rot_new = 100 - _rot_x;
			_rot_coord_done = str [ _rot_y, _rot_new, _rot_z ];
			
			if ( _n_found ) then { _rot_e = "e"; };
			if ( _s_found ) then { _rot_w = "w"; };
			if ( _e_found ) then { _rot_s = "s"; };
			if ( _w_found ) then { _rot_n = "n"; };
		};
			
		if ( _oneeighty ) then {
			_rot_dir_done = _rot_dir + 180;
			
			_rot_new_x = 100 - _rot_x;
			_rot_new_y = 100 - _rot_y;
			_rot_coord_done = str [ _rot_new_x, _rot_new_y, _rot_z ];
			
			if ( _n_found ) then { _rot_s = "s"; };
			if ( _s_found ) then { _rot_n = "n"; };
			if ( _e_found ) then { _rot_w = "w"; };
			if ( _w_found ) then { _rot_e = "e"; };
		};

		if ( _twoseventy ) then {
			_rot_dir_done = _rot_dir + 270;
			
			_rot_new = 100 - _rot_y;
			_rot_coord_done = str [ _rot_new, _rot_x, _rot_z ];
			
			if ( _n_found ) then { _rot_w = "w"; };
			if ( _s_found ) then { _rot_e = "e"; };
			if ( _e_found ) then { _rot_n = "n"; };
			if ( _w_found ) then { _rot_s = "s"; };
		};
			
		_inner_inner = [ _rot_obj, _rot_coord_done, _rot_dir_done, _rot_height, _rot_simulate, _rot_vector ];
		_inner pushBack _inner_inner;
	} forEach _to_build;
	
	_rot_dirs_done = _rot_n + _rot_s + _rot_e + _rot_w;
	
	_return = [ _rot_name, _rot_edges, _inner, _rot_dirs_done ];
	_full_return pushBack _return;
} forEach _rotate_this;

_full_return