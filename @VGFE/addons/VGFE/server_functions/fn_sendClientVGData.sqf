/*
	VGFE_fnc_sendClientVGdata
	Copyright 2020 by Ghostrider-GRG-
*/

params["_player"];

//waitUntil{MyVGFEstate == 1};

/* Tell the server a request is pending */
MyVGFEstate = 0;

private _vg = [_player] call VGFE_fnc_getVGdata;
//diag_log format["vgfe: sendClientVGData: (23)  _vg = %1",_vg];

[_vg] remoteExec["VGFE_fnc_client_receiveClientVGData",_player];

MyVGFEstate = 1;