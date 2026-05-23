/*
	VGFE_fnc_getVGdata
	Copyright 2020 by Ghostrider-GRG-
*/

params["_player"];
//diag_log format["VGFE _getVGdata: _player = %1 | typeName _player = %2 | getPlayerUID _player %3", _player, typeName _player, getPlayerUID _player];
private _uid = getPlayerUID _player;
private _hiveSearch = ["VGFE_PLAYER", _uid] call EPOCH_fnc_server_hiveGETRANGE;
_hiveSearch params["_status","_result"];
_result