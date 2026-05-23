/*
	VGFE_fnc_getVGkey
	Copyright 2020 by Ghostrider-GRG-
*/
params["_id"];
diag_log format["VGFE_fnc_getVGkey: _id = %1",_id];
private ["_status","_key"];
private _querry2 = (["VGFE_KEY",_id] call EPOCH_fnc_server_hiveGETRANGE);
diag_log format["VGFE_fnc_getVGkey: _querry2 = %1",_querry2];
if ((_querry2 select 0) == 1 && (_querry2 select 1) isEqualType []) then 
{
	_key = if ((_querry2 select 1) isEqualTo []) then {0} else {(_querry2 select 1) select 0};
	if !(_key == 0) then 
	{
		["VGVE_KEY",_id, VGFEexpiresAt] call EPOCH_fnc_server_hiveEXPIRE;	
	};
} else {
	_key = 0;
};
_key