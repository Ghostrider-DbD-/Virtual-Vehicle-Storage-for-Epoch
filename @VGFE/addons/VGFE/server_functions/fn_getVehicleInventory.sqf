/*
	VGFE_fnc_getVehicleInventory
	Copyright 2020 by Ghostrider-GRG-
*/

params["_vehicle"];
private "_inventory";
private _saveInventory = getNumber(missionConfigFile >> "CfgVGFE" >> "saveIventory");
if (_saveIventory) then {
	_inventory = [_vehicle] call EPOCH_server_CargoSave;
} else {
	_inventory = [];
};
diag_log format["_fnc_getVehicleInventory: _inventory = %1",_inventory];
_inventory
