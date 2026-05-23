/*
	VGFE_fnc_storeVehicle 
	Copyright 2020 by Ghostrider-GRG-
*/

params["_accessPoint","_vehicle","_player"];
//diag_log format["VGFE called with _accessPoint %1 | _vehicle %2 | _plaer %3",_accessPoint, _vehicle, _player];
private _vehSlot = _vehicle getVariable ["VEHICLE_SLOT", "ABORT"];
//diag_log format["VGFE: _storeVehicle: _vehSlot = %1", _vehSlot];

if !(_vehSlot isEqualTo "ABORT") then 
{  //  So we do not store temporary vehicles

	private _vehicleData = [
		typeOf _vehicle,
		[getPosATL _vehicle,getDir _vehicle,vectorup _vehicle],
		[_vehicle] call VGFE_fnc_getVehicleCondition,
		[_vehicle] call VGFE_fnc_getVehicleInventory,
		getObjectTextures _vehicle,
		[_vehicle] call VGFE_fnc_getVehicleLoadout,
		getPlateNumber _vehicle,
		locked _vehicle,
		_vehicle getVariable["VEHICLE_BASECLASS",""]
	];
	//diag_log format["VGFE _storeVehicle: _vehicleData %1", _vehicleData]; 
	
	/* we can only process one client request at a time so add a check for a pendiing request to access VG */
	waitUntil{MyVGFEstate == 1};

	/* Tell the server a request is pending */
	MyVGFEstate = 0;

	private _hiveData = [_player] call VGFE_fnc_getVGdata;
	_hiveData pushBack [_accessPoint, _vehicleData];
	//  params["_player","_accessPoint","_data"];
	 [_player, _hiveData] call VGFE_fnc_storeVGdata; 

	private _storageCost = getNumber(missionConfigFile >> "CfgVGFE" >> "storageCost");
	if (_storageCost > 0) then 
	{
		[_player,(_storageCost * -1)] call EPOCH_server_effectCrypto;
	};

	/*
		The code below was adapted from files in epoch_server.
		Credit: EpodhMod Development Team 
		https://github.com/EpochModTeam/Epoch
	*/

	private _vehHiveKey = format ["%1:%2", (call EPOCH_fn_InstanceID), _vehSlot];
	["Vehicle", _vehHiveKey] call EPOCH_fnc_server_hiveDEL;
	EPOCH_VehicleSlots pushBackUnique _vehSlot;
	missionNamespace setVariable ['EPOCH_VehicleSlotCount', count EPOCH_VehicleSlots, true];
	[format["Vehicle Stored"]] remoteExec["systemChat",_player];
	["Vehicle Stored",5] remoteExec["Epoch_Message",_player];
	deleteVehicle _vehicle;	
} else {
	private _error = format["ERROR: %1 is a temporary vehicle and can not be stored",getText(configFile >> "CfgVehicles" >> typeOf _vehicle >> "displayName")];
	[_error] remoteExec["systemChat",_player];
	[_error,5] remoteExec["EPOCH_Message",_player];
	[_error] remoteExec["diag_log",_player];
};

/* tell the server the VG is ready to handle other requests */
MyVGFEstate = 1;

