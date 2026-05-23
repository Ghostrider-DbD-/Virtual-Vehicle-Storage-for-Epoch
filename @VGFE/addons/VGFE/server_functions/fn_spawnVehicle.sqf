/*
	VGFE_fnc_setVehicleLocation
	Copyright 2020 by Ghostrider-GRG-
*/

#define zeroPos [0,0,0]
params["_className","_locationData","_safeSpawn"];
private _vehicle = objNull;
isNil {
	format["VGFE _spawnVehicle: _className = %1 | _locationData = %2",_className, _locationData];
	_vehicle = createVehicle [_className, zeroPos, [], 0, "NONE"];
	format["VGFE _spawnVehicle: _vehcle = %1", _vehcle];
	_locationData params["_posATL","_dir","_vectorUp"];	
	format["VGFE _spawnVehicle: _posATL %1 | _dir %2 | _vectorUp %2",_posATL, _dir, _vectorDirUp];
	private _spawnPos = _posATL;
	//     center findEmptyPosition [areaRadius, maxDistance, vehicleType]
	if (_safeSpawn == 1) then {
		_spawnPos = _posATL findEmptyPosition [15, 30, typeOf _vehicle];
	};
	_vehicle setPosATL _spawnPos;
	_vehicle setDir _dir;
	_vehicle setVectorUp _vectorUp;

	// Set slot used by vehicle
	_vehObj setVariable["VEHICLE_SLOT", _slot, true];

	// Lock vehicle for owner
	if (_locked && _lockOwner != "") then {
	  _vehLockHiveKey = format["%1:%2", (call EPOCH_fn_InstanceID), _slot];
	  ["VehicleLock", _vehLockHiveKey, EPOCH_vehicleLockTime, [_lockOwner]] call EPOCH_fnc_server_hiveSETEX;
	} else {
	  _vehLockHiveKey = format["%1:%2", (call EPOCH_fn_InstanceID), _slot];
	  ["VehicleLock", _vehLockHiveKey] call EPOCH_fnc_server_hiveDEL;
	};
	
	// new Dynamicsimulation
	if([configFile >> "CfgEpochServer", "vehicleDynamicSimulationSystem", true] call EPOCH_fnc_returnConfigEntry)then
	{
		_vehObj enableSimulationGlobal false; // turn it off until activated by dynamicSim
		_vehObj enableDynamicSimulation true;
	};


	// SAVE VEHICLE
	_vehObj call EPOCH_server_save_vehicle;

	// Event Handlers
	_vehObj call EPOCH_server_vehicleInit;

		// Add to A3 remains collector
	addToRemainsCollector[_vehObj];

	// make vehicle mortal again
	_vehObj allowDamage true;
};
_vehicle
