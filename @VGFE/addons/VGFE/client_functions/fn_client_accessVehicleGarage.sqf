/*
	VGFE_fnc_client_accessVehicleGarage 
	Copyright 2020 by Ghostrider-GRG-
*/

params["_storageType"];
MyVFGFstorageMode = _storageType;
VGFE_activeList = "";
private _display = createDialog  "VGFEDialog";
["test",[player]]  remoteExec["VGFE_fnc_handleClientRequest",2];
["getdata",[player]] remoteExec["VGFE_fnc_handleClientRequest",2];
diag_log format["VGFE_fnc_client_accessVehicleGarage called at %1",diag_tickTime];




