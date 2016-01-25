// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.1
//	@file Name: spawnInTown.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, [GoT] JoSchaap, AgentRev
//	@file Created: 20/11/2012 05:19
//	@file Args:

private ["_marker", "_preload", "_pos", "_rad", "_townName", "_playerPos"];
_marker = _this select 0;
_preload = param [1, false, [false]];

{
	if (_x select 0 == _marker) exitWith
	{
		_pos = getMarkerPos _marker;
		_rad = _x select 1;
		_townName = _x select 2;

		_playerPos = [_pos,5,_rad,1,0,0,0] call findSafePos;

		_is_sealand_spawn = _townName == "Sealand";
		if ( _is_sealand_spawn ) then { 
			_spawns_town = nearestObjects [ _pos, [ "LocationRespawnPoint_F" ], 50 ];
			[ _spawns_town, 5 ] call KK_fnc_arrayShuffle;
			_pick_town_pos = _spawns_town call BIS_fnc_selectRandom;
			_playerPos = getPosASL _pick_town_pos;
		};
		
		if (_preload) then { waitUntil {sleep 0.1; preloadCamera _playerPos} };

		waitUntil {!isNil "bis_fnc_init" && {bis_fnc_init}};

		if ( _is_sealand_spawn ) then {
			player setPosASL _playerPos;
		} else {
			player setPos _playerPos;
		};
	};
} forEach (call cityList);

player setVariable [_marker + "_lastSpawn", diag_tickTime];

respawnDialogActive = false;
closeDialog 0;

_townName spawn
{
	_townName = _this;
	sleep 1;

	_hour = date select 3;
	_mins = date select 4;
	["Wasteland", _townName, format ["%1:%3%2", _hour, _mins, if (_mins < 10) then {"0"} else {""}]] spawn BIS_fnc_infoText;
};
