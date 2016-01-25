// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: relativePos.sqf
//	@file Author: AgentRev
//	@file Created: 28/12/2013 17:44

private ["_unit", "_pos"];

_unit = _this select 0;
_pos = _this select 1;

_unit_pos = position _unit;
_dis_chk_unit = _unit_pos distance [ 7000, 7000, 0 ];
_close_sea_unit = _dis_chk_unit < 600;

if ( _close_sea_unit ) then {
	(getPosATL _unit) vectorAdd ([_pos, -(getDir _unit)] call BIS_fnc_rotateVector2D)
} else {
	(getPosASL _unit) vectorAdd ([_pos, -(getDir _unit)] call BIS_fnc_rotateVector2D)
};