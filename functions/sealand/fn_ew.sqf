_straights = [ 1, 3 ];
[ _straights, 5 ] call KK_fnc_arrayShuffle;
_this_straight = _straights select 0;

_straight = call sealand_fnc_straight;
[ _this_straight, _straight ] call opec_fnc_rotate;