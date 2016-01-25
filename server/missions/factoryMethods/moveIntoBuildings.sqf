// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: customGroup2.sqf
//	@file Author: Zenophon, JoSchaap
//  @file Information: Function called as:  [_aiGroup, _missionPos, _buildingRadius, _fillEvenly, _putOnRoof] call moveIntoBuildings;
//  @file Information: example call: [_CivGrp1, [333.33,3.33,444.44], 300, true, false] call moveIntoBuildings;

if (!isServer) exitWith {};

#define I(X) X = X + 1;
#define EYE_HEIGHT 1.53
#define CHECK_DISTANCE 5
#define FOV_ANGLE 15
#define ROOF_CHECK 4
#define ROOF_EDGE 2

private ["_unitIndex","_aiGroup","_missionPos","_units","_buildingsArray", "_j", "_building", "_randomIndex", "_housePos", "_startAngle", "_i", "_k", "_hitCount", "_fillEvenly", "_putOnRoof", "_isRoof", "_housePos", "_edge", "_checkPos"];

_aiGroup = _this select 0;
_missionPos = _this select 1;
_buildingRadius = _this select 2;
_fillEvenly = _this select 3;
_putOnRoof = _this select 4;
_units = units _aiGroup;
_unitIndex = 0;

//
_ExtendPosition =
{
	private ["_missionPos", "_dist", "_phi"];
	_missionPos = _this select 0;
	_dist = _this select 1;
	_phi = _this select 2;
	([(_missionPos select 0) + (_dist * (cos _phi)),(_missionPos select 1) + (_dist * (sin _phi)), (_this select 3)])
};

// find available buildings
_buildingsArray = nearestObjects [_missionPos, ["house"], _buildingRadius];
_buildingPosArray = [];

_dis_chk_buildings = _missionPos distance [ 7000, 7000, 0 ];
_close_sea_buildings = _dis_chk_buildings < 600;

if ( _close_sea_buildings ) then {
	_buildingsArray = nearestObjects [_missionPos, [
		"Land_FieldToilet_F",
		"Land_Medevac_house_V1_ruins_F",
		"Land_Stadium_p9_F",
		"Land_Kiosk_blueking_F",
		"Land_ToiletBox_F",
		"Land_Medevac_HQ_V1_F",
		"Land_Medevac_house_V1_F",
		"Land_Kiosk_redburger_F",
		"Land_Dome_Big_F",
		"Land_Cargo_Tower_V1_No1_F",
		"Land_Cargo_Tower_V1_No2_F",
		"Land_Cargo_Tower_V1_No3_F",
		"Land_Cargo_Tower_V1_No4_F",
		"Land_Cargo_Tower_V1_No5_F",
		"Land_Cargo_Tower_V1_No6_F",
		"Land_ReservoirTower_F",
		"Land_IndPipe2_big_ground2_F",
		"Land_IndPipe2_big_18_F",
		"Land_IndPipe2_bigL_R_F",
		"Land_Pier_addon",
		"Land_Research_house_V1_F",
		"Land_Research_HQ_F",
		"Land_Slum_House01_F",
		"Land_Slum_House02_F",
		"Land_Slum_House03_F",
		"Land_LightHouse_F",
		"Land_Lighthouse_small_F",
		"Land_Airport_left_F",
		"Land_Airport_right_F",
		"Land_Airport_Tower_dam_F",
		"Land_Airport_Tower_F",
		"Land_cargo_house_slum_F",
		"Land_Cargo_House_V1_F",
		"Land_Cargo_House_V2_F",
		"Land_Cargo_House_V3_F",
		"Land_Cargo_HQ_V1_F",
		"Land_Cargo_HQ_V2_F",
		"Land_Cargo_HQ_V3_F",
		"Land_Cargo_Patrol_V1_F",
		"Land_Cargo_Patrol_V2_F",
		"Land_Cargo_Patrol_V3_F",
		"Land_Cargo_Tower_V1_F",
		"Land_Cargo_Tower_V3_F"
	], _buildingRadius];
};

{
	_buildingPositions = 0;
	for "_i" from 0 to 100 do
	{
		if ((_x buildingPos _buildingPositions) isEqualTo [0,0,0]) exitWith {};
		I(_buildingPositions)
	};
		_posArray = [];
	for "_i" from 0 to (_buildingPositions - 1) do
	{
		_posArray set [_i, _i];
	};
		_buildingPosArray set [_forEachIndex, _posArray];
} forEach _buildingsArray;


// occupy buildings
for [{_j = 0}, {(_unitIndex < count _units) && {(count _buildingPosArray > 0)}}, {I(_j)}] do
	{
		scopeName "for";
		_building = _buildingsArray select (_j % (count _buildingsArray));
		_posArray = _buildingPosArray select (_j % (count _buildingsArray));

		if (count _posArray == 0) then
		{
			_buildingsArray set [(_j % (count _buildingsArray)), 0];
			_buildingPosArray set [(_j % (count _buildingPosArray)), 0];
			_buildingsArray = _buildingsArray - [0];
			_buildingPosArray = _buildingPosArray - [0];
		};

		while {(count _posArray) > 0} do
		{
			scopeName "while";
			if (_unitIndex >= count _units) exitWith {};

			_randomIndex = floor random count _posArray;
			_housePos = _building buildingPos (_posArray select _randomIndex);
			_housePos = [(_housePos select 0), (_housePos select 1), (_housePos select 2) + (getTerrainHeightASL _housePos) + EYE_HEIGHT];

			_posArray set [_randomIndex, _posArray select (count _posArray - 1)];
			_posArray resize (count _posArray - 1);

			_startAngle = (round random 10) * (round random 36);
			for "_i" from _startAngle to (_startAngle + 350) step 10 do
			{
				_checkPos = [_housePos, CHECK_DISTANCE, (90 - _i), (_housePos select 2)] call _ExtendPosition;
				if !(lineIntersects [_checkPos, [_checkPos select 0, _checkPos select 1, (_checkPos select 2) + 25], objNull, objNull]) then
				{
					if !(lineIntersects [_housePos, _checkPos, objNull, objNull]) then
					{
						_checkPos = [_housePos, CHECK_DISTANCE, (90 - _i), (_housePos select 2) + (CHECK_DISTANCE * sin FOV_ANGLE / cos FOV_ANGLE)] call _ExtendPosition;
						if !(lineIntersects [_housePos, _checkPos, objNull, objNull]) then
						{
							_hitCount = 0;
							for "_k" from 30 to 360 step 30 do
							{
								_checkPos = [_housePos, 20, (90 - _k), (_housePos select 2)] call _ExtendPosition;
								if (lineIntersects [_housePos, _checkPos, objNull, objNull]) then
								{
									I(_hitCount)
								};

								if (_hitCount >= ROOF_CHECK) exitWith {};
							};

							_isRoof = (_hitCount < ROOF_CHECK) && {!(lineIntersects [_housePos, [_housePos select 0, _housePos select 1, (_housePos select 2) + 25], objNull, objNull])};
							if (!(_isRoof) || {((_isRoof) && {(_putOnRoof)})}) then
							{
								if (_isRoof) then
								{
									_edge = false;
									for "_k" from 30 to 360 step 30 do
									{
										_checkPos = [_housePos, ROOF_EDGE, (90 - _k), (_housePos select 2)] call _ExtendPosition;
										_edge = !(lineIntersects [_checkPos, [(_checkPos select 0), (_checkPos select 1), (_checkPos select 2) - EYE_HEIGHT - 1], objNull, objNull]);

										if (_edge) exitWith
										{
											_i = _k;
										};
									};
								};

								if (!(_isRoof) || {_edge}) then
								{
									(_units select _unitIndex) setPosASL [(_housePos select 0), (_housePos select 1), (_housePos select 2) - EYE_HEIGHT];
									(_units select _unitIndex) setDir (_i );

									if (_isRoof) then
									{
										(_units select _unitIndex) setUnitPos "MIDDLE";
									} else {
										(_units select _unitIndex) setUnitPos "UP";
									};

									(_units select _unitIndex) lookAt ([_housePos, CHECK_DISTANCE, (90 - _i), (_housePos select 2) - (getTerrainHeightASL _housePos)] call _ExtendPosition);
									doStop (_units select _unitIndex);

									I(_unitIndex)
									if (_fillEvenly) then
									{
										breakTo "for";
									} else {
										breakTo "while";
									};
								};
							};
						};
					};
				};
			};
		};
	};