/*
	VGFE_fnc_handleClientRequest 
	Copyright 2020 by Ghostrider-GRG-	
*/

params["_requestId","_payload"];
//diag_log format["VGFE_fnc_handleClientRequest: _requestId %1 | _payload %2",_requestId, _payload];

switch (toLower _requestID) do 
{
	case "store": {
		//diag_log format["VGFE _handleClientRequest store with payload = %1",_payload];
		//private _define = if (isNil "VGFE_fnc_storeVehicle") then {true} else {false};
		//diag_log format["VGFE _handleClientRequest: _define = %1", _define];
		_payload call VGFE_fnc_storeVehicle;
	};
	case "retrieve": {
		_payload  call VGFE_fnc_retrieveVehicle;
	};
	case "nickname": {
		_payload call VGFE_fnc_setVehicleNickname;
	};
	case "getdata": {
		_payload call VGFE_fnc_sendClientVGdata;
	};
	case "test": {
		diag_log format["running with test payload = %1 | typeName _payload %2",_payload, typeName _payload];
	};
};