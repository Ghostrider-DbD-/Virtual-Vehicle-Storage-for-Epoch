/*
	VGFE_fnc_onPlayerJoined
	Copyright 2020 by Ghostrider-GRG-
*/

params["_id","_uid","_name","_jip","_owner"];

diag_log format["<Initialized> VGFE_Server for player named %1 | uid %2 at time %3",_name,_uid,diag_tickTime];

{
	_owner publicVariableClient _x;
} forEach [
	 //"MyVGFE",
	 //"MyVGFEkey",
	 "VGFE_fnc_client_receiveClientVGData",
	"VGFE_fnc_client_getLocalVehicles",
	//"VGFE_fnc_client_getNearbyJammers",
	//"VGFE_fnc_client_isBuildOwner",
	"VGFE_fnc_client_onLbSelChangedLocalVehicleList",
	"VGFE_fnc_client_onLbSelChangedStoredVehicleList",
	"VGFE_fnc_client_setFocusOnLocalVehicleList",
	"VGFE_fnc_client_setFocusOnStoredVehicleList",
	"VGFE_fnc_client_storeVehicle",
    "VGFE_fnc_client_displayVirtualVehicleStorage",
	//"VGFE_fnc_client_init",
	//"VGFE_fnc_client_log",
	"VGFE_fnc_client_retrieveVehicle",
	"VGFE_fnc_client_onVirtualGarageDialogLoad",
	"VGFE_fnc_client_accessVehicleGarage",
	"VGFE_fnc_client_vehicleRetrieved",
	"VGFE_fnc_client_canRetrieve"
];