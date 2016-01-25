// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: sideMissionDefines.sqf
//	@file Author: [404] Deadbeat, AgentRev
//	@file Created: 08/12/2012 15:19

// Side Mission Color = #4BC9B0 - Teal
// Fail Mission Color = #FF1717 - Light red
// Success Mission Color = #17FF41 - Light green

#define seaMissionColor "#3385ff"
#define failMissionColor "#cc66ff"
#define successMissionColor "#00ff99"
#define subTextColor "#FFFFFF"

#define AI_GROUP_SMALL 5
#define AI_GROUP_MEDIUM 10
#define AI_GROUP_LARGE 15

#define missionDifficultyHard (["A3W_missionsDifficulty", 0] call getPublicVar >= 1)

sea_infantry = [ "C_man_hunter_1_F","C_man_p_beggar_F","C_man_p_beggar_F_afro",
	"C_man_p_fugitive_F","C_man_p_shorts_1_F","C_man_polo_1_F",
	"C_man_polo_2_F","C_man_polo_3_F","C_man_polo_4_F",
	"C_man_p_beggar_F","C_man_p_beggar_F_afro",
	"C_man_p_fugitive_F","C_journalist_F","C_Orestes",
	"C_man_polo_5_F","C_man_polo_6_F","C_man_shorts_1_F",
	"C_man_shorts_2_F","C_man_shorts_3_F","C_man_shorts_4_F",
	"C_man_w_worker_F","C_man_p_beggar_F","C_man_p_beggar_F_afro",
	"C_man_p_fugitive_F"
];

sea_wpns = [
		"arifle_Katiba_C_F",
		"arifle_Katiba_F",
		"arifle_Katiba_GL_F",
		"arifle_Mk20C_F",
		"arifle_Mk20_F",
		"arifle_Mk20_GL_F",
		"arifle_MXC_F",
		"arifle_MXM_F",
		"arifle_MX_F",
		"arifle_MX_GL_F",
		"arifle_MX_SW_F",
		"arifle_SDAR_F",
		"arifle_TRG20_F",
		"arifle_TRG21_F",
		"arifle_TRG21_GL_F",
		"hgun_PDW2000_F",
		"LMG_Mk200_F",
		"LMG_Zafir_F",
		"SMG_01_F",
		"SMG_02_F",
		"srifle_EBR_F"
];
	
sea_unis = [
		"U_OrestesBody",
		"U_NikosBody",
		"U_Rangemaster",
		"U_C_Commoner1_3",
		"U_C_Poloshirt_redwhite",
		"U_C_Poloshirt_salmon",
		"U_C_Poloshirt_tricolour",
		"U_C_Poloshirt_blue"
];
	
sea_scopes = [
		"optic_Aco",
		"optic_ACO_grn",
		"optic_aco_smg",
		"optic_Arco",
		"optic_Hamr",
		"optic_Holosight",
		"optic_Holosight_smg"
];
	
sea_packs = [
		"B_FieldPack_blk",
		"B_FieldPack_cbr",
		"B_FieldPack_khk",
		"B_FieldPack_oucamo",
		"B_Kitbag_cbr",
		"B_Kitbag_rgr",
		"B_Kitbag_mcamo",
		"B_Kitbag_sgg",
		"B_Bergen_blk",
		"B_Bergen_rgr",
		"B_Bergen_mcamo",
		"B_Bergen_sgg",
		"B_Carryall_khk",
		"B_Carryall_mcamo",
		"B_Carryall_oli",
		"B_Carryall_oucamo"
];
	
sea_vests = [
		"V_PlateCarrier1_rgr",
		"V_PlateCarrierIA1_dgtl",
		"V_HarnessO_brn",
		"V_RebreatherB"
];

sea_garrison = {
	if (!isServer) exitWith {};

	private ["_rad","_grp","_buildingArray"];

	_trigger = _this select 0;
	_side = _this select 1;
	_infantryClass = [ "C_man_hunter_1_F","C_man_p_beggar_F","C_man_p_beggar_F_afro",
		"C_man_p_fugitive_F","C_man_p_shorts_1_F","C_man_polo_1_F",
		"C_man_polo_2_F","C_man_polo_3_F","C_man_polo_4_F",
		"C_man_p_beggar_F","C_man_p_beggar_F_afro",
		"C_man_p_fugitive_F","C_journalist_F","C_Orestes",
		"C_man_polo_5_F","C_man_polo_6_F","C_man_shorts_1_F",
		"C_man_shorts_2_F","C_man_shorts_3_F","C_man_shorts_4_F",
		"C_man_w_worker_F","C_man_p_beggar_F","C_man_p_beggar_F_afro",
		"C_man_p_fugitive_F"
	];
	
	_trig_pos = getPos _trigger;
	_spawns_tr = nearestObjects [ _trig_pos, [ "LocationRespawnPoint_F" ], 50 ];
	[ _spawns_tr, 5 ] call KK_fnc_arrayShuffle;
	
	_nbUnits = if (missionDifficultyHard) then { AI_GROUP_LARGE } else { AI_GROUP_MEDIUM };
	for "_i" from 1 to _nbUnits do {
		_grp = createGroup _side;
		_pick_tr_pos = _spawns_tr select _i;
		if ( isNil "_pick_tr_pos" ) exitWith{};
		_wp = getPosASL _pick_tr_pos;
		_unit = _grp createUnit [ _infantryClass call BIS_fnc_selectRandom, _wp, [], 0, "NONE" ];
		_unit setPosASL _wp;
		[_unit] spawn sea_Init_Man;
		sea_allUnits pushBack _unit;
	};
	publicVariable "sea_allUnits";
};

//swim_anims = [ "aswmpercmwlksnonwnondf", "aswmpercmsprsnonwnondf", "aswmpercmrunsnonwnondf", "aswmpercmstpsnonwnondnon", "aswmpercmrunsnonwnondf_aswmpercmstpsnonwnondnon", "aswmpercmstpsnonwnondnon_aswmpercmrunsnonwnondf", "aswmpercmstpdnon", "aswmpercmstpdnon_aswmpercmstpdf", "aswmpercmstpdf_aswmpercmstpdnon", "aswmpercmstpsnonwnondf" ];

RUFS_ProbeSurface = {
    private ["_pos", "_bball", "_probe", "_zi", "_zf", "_zdiff", "_vel", "_hasSurface"];
    _pos = _this select 0;
    _zi = _pos select 2;
    _bball = "Land_HumanSkull_F";
    _probe = _bball createVehicle _pos;
    _probe setPosASL _pos;
    _vel = -60;
    _probe setVelocity [0, 0 , -60];
    while {_vel > 0.1 && _vel < -0.1} do {
        _vel = velocity _probe select 2;
    };
    _zf = getPosASL _probe select 2;
    _zdiff = _zi - _zf;
    if (_zdiff > 0.5 || _zdiff < -1) then {
        _hasSurface = false;
    } else {
        _hasSurface = true;
    };
    deleteVehicle _probe;
    [ _zf, _hasSurface ]
};

sea_rand_stretch = 6;
sea_rand_min = 6;
sea_timeout = 30;
sea_path_total = 3;

sea_find_path = {
	private ["_xr","_yr"];
	
	_sea_pos = [ _this ];
	_sea_original = random 360;
	_sea_direction = _sea_original;
	_sea_distance = 0;
	_cnt_pos = 1;
	_cnt_tick = _cnt_pos;
	_old_time = diag_tickTime;
	
	waitUntil {
		_sea_center = _sea_pos select ( ( count _sea_pos ) - 1 );
		
		_cnt_pos = count _sea_pos;
		_much_cnt = _cnt_pos > sea_path_total;
		if ( _much_cnt ) exitWith { diag_log ( "Complete success: " + str _sea_pos ); true };
		
		_same = _cnt_tick == _cnt_pos;
		if ( !_same ) then {
			_sea_direction = _sea_direction + 45;
		};
		_cnt_tick = _cnt_pos;
		
		_full_circle = _sea_direction >=  ( _sea_original + 360 );
		if ( _full_circle ) exitWith { diag_log ( "Full circle fail: " + str _sea_pos ); true };
		
		_zero_dis = _sea_distance <= 0.75;
		if ( _zero_dis ) then {
			_sea_distance = ( random sea_rand_stretch ) + sea_rand_min;
		};
		
		_sea_check = [ _sea_center, _sea_distance, _sea_direction ] call BIS_fnc_relPos;
		
		_steps_PPA = floor ( _sea_distance / 0.5 );
		
		_sea_direction = _sea_direction + 6;
		_sea_distance = _sea_distance - 0.25;
		
		for "_j" from 1 to _steps_PPA step 1 do {
			_pos_wow = _sea_center vectorAdd ( [ [ 0, ( _j * 0.5 ), 0 ], - _sea_direction ] call BIS_fnc_rotateVector2D );
			_wew_check = [ _pos_wow ] call RUFS_ProbeSurface;
			_wew_z = _wew_check select 0;
			_wew = _wew_check select 1;
			if ( !_wew ) exitWith { false };
			_sea_check = [ _sea_check select 0, _sea_check select 1, _wew_z ];
			_done = _steps_PPA == _j;
			if ( _done ) then { 
				_sea_pos pushBack _sea_check;
			};
			if ( _done && _wew ) exitWith { 
				false
			};
		};

		_new_time = diag_tickTime;
		_diff_time = _new_time - _old_time;
		_nuff_time = _diff_time > sea_timeout;
		
		if ( _nuff_time ) exitWith { diag_log ( "Timeout fail: " + str _sea_pos ); true };
	};
	_sea_pos
};

sea_bearing = {
	_pos1 = _this select 0;
	_pos2 = _this select 1;
	
	_deltaX = (getPos _pos1 select 0) - (_pos2 select 0);
	_deltaY = (getPos _pos1 select 1) - (_pos2 select 1);
	_dir = (_deltaX atan2 _deltaY) + 180;
	
	_dir
};

sea_init_Man = {
	_unit = _this select 0;
	_grp = group _unit;
	_unit_pos = getPosASL _unit;

	_unit addHeadgear "G_B_Diving";
	_unit forceAddUniform ( sea_unis call BIS_fnc_selectRandom );
	_unit addVest ( sea_vests call BIS_fnc_selectRandom );
	_unit addBackpack ( sea_packs call BIS_fnc_selectRandom );

	[ _unit, ( sea_wpns call BIS_fnc_selectRandom ), 8 ] call BIS_fnc_addWeapon;
	_unit addMagazines [ "HandGrenade", 3 ];
	_unit addMagazine "SmokeShell";

	_unit addPrimaryWeaponItem "acc_flashlight";
	_unit addPrimaryWeaponItem ( sea_scopes call BIS_fnc_selectRandom );
	_unit enablegunlights "forceOn";

	_unit addRating 1e11;
	_unit call setMissionSkill;
	_unit addEventHandler [ "Killed", server_playerDied ];
	
/* 	_unit addEventHandler [ "AnimChanged", {
		_it = _this select 0;
		_anim = _this select 1;
		_is_swim = _anim in swim_anims;
		if ( _is_swim ) then {
			_it setDamage 1;
		};
	} ]; */
/* 	_pos = _unit_pos call sea_find_path;
	
	_counter = ( count _pos ) - 1;
	
	for "_i" from 0 to _counter do {
		_go_pos = _pos select _i;

		_wp =_grp addWaypoint [ [ _go_pos select 0, _go_pos select 1, ( position player select 2 ) + 0.5 ], 0 ];
		_wp setWaypointBehaviour "AWARE";
		_wp setWaypointCombatMode "RED";
		_wp setWaypointSpeed "LIMITED";
		_wp setWaypointType "MOVE";
	};

	_cyclePos = _pos select _counter;
	_wp =_grp addWaypoint [ [ _cyclePos select 0, _cyclePos select 1, ( position player select 2 ) + 0.5 ], 0 ];
	_wp setWaypointBehaviour "AWARE";
	_wp setWaypointCombatMode "RED";
	_wp setWaypointSpeed "LIMITED";
	_wp setWaypointType "CYCLE"; */

	//_dir = [ _unit, ( _pos select 0 ) ] call sea_bearing;
	_dir = random 360;
	_unit setDir _dir;
	
	_wp =_grp addWaypoint [ position _unit, 0 ];
	_wp setWaypointBehaviour "AWARE";
	_wp setWaypointCombatMode "RED";
	_wp setWaypointSpeed "LIMITED";
	_wp setWaypointType "SAD";
};