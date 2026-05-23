params["_id","_key"];
diag_log format["VGFE_fnc_getVGkey: _id = %1 | _key = %2",_id,_key];
["VGFE_KEY",_id,VGFEexpiresAt,[_key]] call EPOCH_fnc_server_hiveSETEX;