private["_in","_len","_arr","_out"];
_in=_this select 0;
_len=(_this select 1)-1;
_arr=[_in] call KRON_fnc_strToArray;
_out="";
for "_i" from 0 to _len do {
	_out=_out + (_arr select _i);
};
_out