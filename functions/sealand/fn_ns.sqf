_straights = [ 0, 2 ];
[ _straights, 5 ] call KK_fnc_arrayShuffle;
_this_straight = _straights select 0;
_is_ns = _this_straight == 0;
_is_sn = _this_straight == 2;

if ( _is_ns ) then { call sealand_fnc_straight; };
if ( _is_sn ) then {
	_straight = call sealand_fnc_straight;
	[ 2, _straight ] call opec_fnc_rotate;
};