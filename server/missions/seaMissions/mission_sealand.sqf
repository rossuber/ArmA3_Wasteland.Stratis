// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_TownInvasion.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, JoSchaap, AgentRev, Zenophon
//  @file Information: JoSchaap's Lite version of 'Infantry Occupy House' Original was made by: Zenophon

if (!isServer) exitwith {};

waitUntil { sleep 1; sealand_complete };

#include "seaMissionDefines.sqf"

private ["_nbUnits", "_box1", "_box2", "_townName", "_missionPos", "_buildingRadius", "_putOnRoof", "_fillEvenly", "_tent1", "_chair1", "_chair2", "_cFire1", "_drop_item", "_drugpilerandomizer", "_drugpile"];

_setupVars =
{
	_missionType = "Sealand Invasion";
	_nbUnits = if (missionDifficultyHard) then { AI_GROUP_MEDIUM } else { AI_GROUP_SMALL };
	_missionPos = getPosASL genStore8;

	// settings for this mission
	_b4Pos = [ 7000 + ( 300 - ( random 600 ) ), 7000 + ( 300 - ( random 6 ) ), 0 ];
	_list = _b4Pos nearObjects [ "EmptyDetector", 300 ];

	_trigga = genStore8;
	
	{
		_trigga = _list select _forEachIndex;
		_cooldown = _trigga getVariable [ "cooltime", -600 ];
		
		_now_time = time;
		_diff_time = _now_time - _cooldown;
		_enuff = _diff_time > 600;
		if ( _enuff ) exitWith {
			_missionPos = getPosASL _trigga;
			_nbUnits = _nbUnits + round(random (_nbUnits*0.5));
			_trigga setVariable [ "cooltime", time, true ];
		};
	} forEach _list;
	


	//randomize amount of units
	
	// reduce radius for larger towns. for example to avoid endless hide and seek in kavala ;)
	//_buildingRadius = if (_buildingRadius > 201) then {(_buildingRadius*0.5)} else {_buildingRadius};
	// 25% change on AI not going on rooftops
	//if (random 1 < 0.75) then { _putOnRoof = true } else { _putOnRoof = false };
	// 25% chance on AI trying to fit into a single building instead of spreading out
	//if (random 1 < 0.75) then { _fillEvenly = true } else { _fillEvenly = false };
};

_setupObjects =
{
	// spawn some crates in the middle of town (Town marker position)
	_town_spawns = nearestObjects [ _missionPos, [ "LocationRespawnPoint_F" ], 50 ];
	[ _town_spawns, 5 ] call KK_fnc_arrayShuffle;	

	_box1_pos =  getPosASL (_town_spawns select 0);
	_box1 = createVehicle ["Box_NATO_Wps_F",_box1_pos, [], 5, "None"];
	_box1 setPosASL _box1_pos;
	_box1 setDir random 360;
	[_box1, "mission_USSpecial"] call fn_refillbox;

	_box2_pos = [ ( _box1_pos select 0 ) + 0.25, ( _box1_pos select 1 ) + 0.25, _box1_pos select 2 ];
	//_box2_pos = _box1_pos;
	_box2 = createVehicle ["Box_East_Wps_F", _box2_pos, [], 5, "None"];
	_box1 setPosASL _box2_pos;
	_box2 setDir random 360;
	[_box2, "mission_USLaunchers"] call fn_refillbox;

	// create some atmosphere around the crates 8)
/* 	_tent1 = createVehicle ["Land_cargo_addon02_V2_F", _missionPos, [], 3, "None"];
	_tent1 setDir random 360;
	_chair1 = createVehicle ["Land_CampingChair_V1_F", _missionPos, [], 2, "None"];
	_chair1 setDir random 90;
	_chair2 = createVehicle ["Land_CampingChair_V2_F", _missionPos, [], 2, "None"];
	_chair2 setDir random 180;
	_cFire1	= createVehicle ["Campfire_burning_F", _missionPos, [], 2, "None"]; */

	{ _x setVariable ["R3F_LOG_disabled", true, true] } forEach [_box1, _box2];
/* 
	// spawn some rebels/enemies :)
	_aiGroup = createGroup CIVILIAN;
	[_aiGroup, _missionPos, _nbUnits] call createCustomGroup2;

	// move them into buildings
	[_aiGroup, _missionPos, _buildingRadius, _fillEvenly, _putOnRoof] call moveIntoBuildings; */

	sea_allUnits = [];
	
	_new_list = _missionPos nearObjects [ "EmptyDetector", 10 ];
	_my_trigga = _new_list select 0;
	
	sea_mission_spawn = [ _my_trigga, CIVILIAN ] spawn sea_Garrison;
	
	waitUntil { sleep 1; scriptDone sea_mission_spawn };
	
	[ sea_allUnits, 5 ] call KK_fnc_arrayShuffle;
	_randy = sea_allUnits select 0;
	_aiGroup = group _randy;
	_leader = leader _aiGroup;
	
	_missionHintText = format ["Hostiles have taken over <br/><t size='1.25' color='%1'>%2</t><br/><br/>Get rid of them all, and take their supplies!", seaMissionColor, "Sealand" ];

	[] spawn {
		waitUntil {
			sleep 1;
			{
				_asl_pos = getPosASL _x;
				_z_pos = _asl_pos select 2;
				_low_z = _z_pos < 0.25;
				if ( _low_z ) then { _x setDamage 1; sea_allUnits - [ _x ]; };
				_dead = !alive _x;
				if ( _dead ) then { sea_allUnits - [ _x ]; };
			} forEach sea_allUnits;
			
			( count sea_allUnits ) < 1
		};
	};
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;

_failedExec =
{
	// Mission failed
	{ deleteVehicle _x } forEach [_box1, _box2];
};

_drop_item = 
{
	private["_item", "_pos"];
	_item = _this select 0;
	_pos = _this select 1;

	if (isNil "_item" || {typeName _item != typeName [] || {count(_item) != 2}}) exitWith {};
	if (isNil "_pos" || {typeName _pos != typeName [] || {count(_pos) != 3}}) exitWith {};

	private["_id", "_class"];
	_id = _item select 0;
	_class = _item select 1;

	private["_obj"];
	_obj = createVehicle [_class, _pos, [], 5, "None"];
	_obj setPos ([_pos, [[2 + random 3,0,0], random 360] call BIS_fnc_rotateVector2D] call BIS_fnc_vectorAdd);
	_obj setVariable ["mf_item_id", _id, true];
};

_successExec =
{
	// Mission completed
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box1, _box2];
	_box1_pos = getPos _box1;

	_drugpilerandomizer = [4,8];
	_drugpile = _drugpilerandomizer call BIS_fnc_SelectRandom;
	
	for "_i" from 1 to _drugpile do 
	{
	  private["_item"];
	  _item = [
	          ["lsd", "Land_WaterPurificationTablets_F"],
	          ["marijuana", "Land_VitaminBottle_F"],
	          ["cocaine","Land_PowderedMilk_F"],
	          ["heroin", "Land_PainKillers_F"]
	        ] call BIS_fnc_selectRandom;
	  [_item,  [ ( _box1_pos select 0 ) + -0.25, ( _box1_pos select 1 ) + -0.25, _box1_pos select 2 ]] call _drop_item;
	};
	
	{
		_x setDamage 0.66;
		_x spawn {
			_rand_time = 30 + ( random 30 );
			sleep _rand_time;
			_this setDamage 1;
		};
	} forEach sea_allUnits;
	
	_successHintMessage = format ["Nice work!<br/><br/><t color='%1'>%2</t><br/>is a safe place again!<br/>Their belongings are now yours to take!", seaMissionColor, "Sealand"];
};

_this call seaMissionProcessor;