//KK_fnc_arrayShufflePlus
//http://killzonekid.com/arma-scripting-tutorials-arrays-part-4-arrayshuffle/ 
private ["_arr","_cnt"];
_arr = _this select 0;
_cnt = count _arr;
for "_i" from 1 to (_this select 1) do {
	_arr pushBack (_arr deleteAt floor random _cnt);
};
_arr