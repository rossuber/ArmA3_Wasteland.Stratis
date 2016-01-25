private [ "_param_x_hundred", "_param_x_ten", "_param_x_one", "_param_y_hundred", "_param_y_ten", "_param_y_one" ];

sealand_complete = false;
publicVariable "sealand_complete";

//Params
param_number = 30;
_param_x_hundred = 0;
_param_x_ten = 7;
_param_x_one = 0;
_param_y_hundred = 0;
_param_y_ten = 7;
_param_y_one = 0;

param_x = ( _param_x_hundred * 100 ) + ( _param_x_ten * 10 ) + _param_x_one;
param_y = ( _param_y_hundred * 100 ) + ( _param_y_ten * 10 ) + _param_y_one;

//Array definitions
e_sets = [ ( call sealand_fnc_e ) ];
es_sets = [ ( call sealand_fnc_es ) ];
ew_sets = [ ( call sealand_fnc_ew ) ];
ews_sets = [ ( call sealand_fnc_ews ) ];
n_sets = [ ( call sealand_fnc_n ) ];
ne_sets = [ ( call sealand_fnc_ne ) ];
nes_sets = [ ( call sealand_fnc_nes ) ];
ns_sets = [ ( call sealand_fnc_ns ) ];
nsew_sets = [ ( call sealand_fnc_nsew ) ];
nw_sets = [ ( call sealand_fnc_nw ) ];
nwe_sets = [ ( call sealand_fnc_nwe ) ];
nws_sets = [ ( call sealand_fnc_nws ) ];
s_sets = [ ( call sealand_fnc_s ) ];
w_sets = [ ( call sealand_fnc_w ) ];
ws_sets = [ ( call sealand_fnc_ws ) ];

sealand_x_min = 6500;
sealand_y_min = 6500;
sealand_x_max = 7500;
sealand_y_max = 7500;

all_cells = "[" + str [ param_x, param_y, 'nsew' ] + ",";

createCenter sideLogic;
logics = createGroup sideLogic;

[ param_x, param_y, nsew_sets ] call opec_fnc_build_go;
[] spawn {
	were_done_here = false;
	waitUntil {
		sleep 3;
		were_done_here
	};
	[] spawn opec_fnc_finishing;
};