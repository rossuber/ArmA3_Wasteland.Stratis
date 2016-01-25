private [ "_x_build", "_y_build", "_picky", "_picked", "_pick_sealand", "_name_dir", "_array", "_array_str", "_logic_center_x", "_logic_center_y", "_logic", "_char_cnt", "_ender", "_markerstr", "_n_found", "_s_found", "_e_found", "_w_found", "_blackmarkerstr" ];

_x_build = _this select 0;
_y_build = _this select 1;
_picky = _this select 2;
_picked = _picky select 0;
[ _picked, 5 ] call KK_fnc_arrayShuffle;

_pick_sealand = _picked select 0 select 2;
_name_dir = _picked select 0 select 3;

_array = [ [ _x_build, _y_build ], _name_dir ];
_array_str = "TERRITORY_" + str _array + ";";

_logic_center_x = ( ( _x_build + 0.5 ) * 100 );
_logic_center_y = ( ( _y_build + 0.5 ) * 100 );

_logic = logics createUnit [ "LocationArea_F", [ _logic_center_x, _logic_center_y, 0 ], [], 0, "NONE" ];
_logic setVariable [ "logic_stuff", _array, false ];

//Construct all the parts to this cell
{ [ _x, _x_build, _y_build ] call opec_fnc_build; } forEach _pick_sealand;

_char_cnt = count _name_dir;
_ender = _char_cnt == 1;

if ( !_ender ) then {
	[ _name_dir, _x_build, _y_build ] call opec_fnc_new_path;
};

_markerstr = createMarker [ _array_str, [ _logic_center_x, _logic_center_y ] ];
_markerstr setMarkerShape "RECTANGLE";
_markerstr setMarkerType "EMPTY";
_markerstr setMarkerBrush "DiagGrid";
_markerstr setMarkerColor "ColorYellow";
_markerstr setMarkerAlpha 0.25;
_markerstr setMarkerSize [ 45, 45 ];

_territory_name = "Sealand: " + str [ _x_build, _y_build ];
config_territory_markers pushBack [ _markerstr, _territory_name, 250, "ISLAND" ];
publicVariable "config_territory_markers";

_n_found = [ "n", _name_dir ] call KK_fnc_inString;
_s_found = [ "s", _name_dir ] call KK_fnc_inString;
_e_found = [ "e", _name_dir ] call KK_fnc_inString;
_w_found = [ "w", _name_dir ] call KK_fnc_inString;
	
if ( _n_found ) then {
	_blackmarkerstr = createMarker [ str [ _x_build, _y_build ] + "_n", [ _logic_center_x, ( _logic_center_y + 25 ) ] ];
	_blackmarkerstr setMarkerShape "RECTANGLE";
	_blackmarkerstr setMarkerType "EMPTY";
	_blackmarkerstr setMarkerColor "ColorBlack";
	_blackmarkerstr setMarkerBrush "SolidFull";
	_blackmarkerstr setMarkerAlpha 0.5;
	_blackmarkerstr setMarkerSize [ 5, 28 ];
};
if ( _e_found ) then {
	_blackmarkerstr = createMarker [ str [ _x_build, _y_build ] + "_e", [ ( _logic_center_x + 25 ), _logic_center_y ] ];
	_blackmarkerstr setMarkerShape "RECTANGLE";
	_blackmarkerstr setMarkerType "EMPTY";
	_blackmarkerstr setMarkerColor "ColorBlack";
	_blackmarkerstr setMarkerBrush "SolidFull";
	_blackmarkerstr setMarkerAlpha 0.5;
	_blackmarkerstr setMarkerSize [ 28, 5 ];
};
if ( _s_found ) then {
	_blackmarkerstr = createMarker [ str [ _x_build, _y_build ] + "_s", [ _logic_center_x, ( _logic_center_y - 25 ) ] ];
	_blackmarkerstr setMarkerShape "RECTANGLE";
	_blackmarkerstr setMarkerType "EMPTY";
	_blackmarkerstr setMarkerColor "ColorBlack";
	_blackmarkerstr setMarkerBrush "SolidFull";
	_blackmarkerstr setMarkerAlpha 0.5;
	_blackmarkerstr setMarkerSize [ 5, 28 ];
};
if ( _w_found ) then {
	_blackmarkerstr = createMarker [ str [ _x_build, _y_build ] + "_w", [ ( _logic_center_x - 25 ), _logic_center_y ] ];
	_blackmarkerstr setMarkerShape "RECTANGLE";
	_blackmarkerstr setMarkerType "EMPTY";
	_blackmarkerstr setMarkerColor "ColorBlack";
	_blackmarkerstr setMarkerBrush "SolidFull";
	_blackmarkerstr setMarkerAlpha 0.5;
	_blackmarkerstr setMarkerSize [ 28, 5 ];
};