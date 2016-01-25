//Silola build script from x-cam, opec edit
_obj = objNull;
_logic = objNull;

_dat = _this select 0;
_dat_x = _this select 1;
_dat_y = _this select 2;
	
_x_off = ( _dat_x * 100 );
_y_off = ( _dat_y * 100 );
	
_pre_coord = call compile ( _dat select 1 );
_pre_coord_x = _pre_coord select 0;
_pre_coord_y = _pre_coord select 1;
_new_coord_z = _pre_coord select 2;
_new_coord_x = _pre_coord_x + _x_off;
_new_coord_y = _pre_coord_y + _y_off;

_class_obj = _dat select 0;

_is_spawn = _class_obj == "LocationRespawnPoint_F";

if ( _is_spawn ) then {
	_logic = logics createUnit [ "LocationRespawnPoint_F", [ _new_coord_x, _new_coord_y, _new_coord_z ], [], 0, "CAN_COLLIDE" ];
} else {
	_obj = createVehicle [ _class_obj, [ _new_coord_x, _new_coord_y, _new_coord_z ], [], 0, "CAN_COLLIDE" ];
};

if ( ( _dat select 4 ) == 1 ) then {
	_obj allowDamage false;
	_wow = { [ _obj, false ] call fn_enableSimulationGlobal };
	call _wow;
	_obj setVariable [ "R3F_LOG_disabled", true, true ];
	_obj addEventHandler [ "EpeContactStart", _wow ];
/* 	_obj setVariable [ "fpsFix_skip", true, true ];
	_obj setVariable [ "fpsFix_simulationCooloff", ( diag_tickTime + 999999 ), true ]; */
};

_obj setDir ( _dat select 2 );
		
if ( ( _dat select 3 ) == -100 ) then {
	_obj setPosASL [ _new_coord_x, _new_coord_y, _new_coord_z ];
} else {
	_obj setPosASL [ _new_coord_x, _new_coord_y, _dat select 3 ];
};
		
if ( ( _dat select 5 ) == 0 ) then {
	_obj setVectorUp [ 0, 0, 1 ];
} else {
	_obj setVectorUp ( surfaceNormal ( getPosATL _obj ) );
};
	
if (count (_dat select 6) > 0) then {
	{ _obj call _x } forEach ( _dat select 6 );
};