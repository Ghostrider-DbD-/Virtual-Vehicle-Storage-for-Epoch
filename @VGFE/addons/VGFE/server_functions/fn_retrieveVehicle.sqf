/*
	VGFE_fnc_retrieveVehicle 
	Copyright 2020 by Ghostrider-GRG-
*/

params["_index","_player"];
//diag_log format["VGFE _retrieveVehicle: _index %1 | _player %2 | typeName _player %3", _index, _player, typeName _player];
if !(EPOCH_VehicleSlots isEqualTo []) then 
{
	private _vgfe = [_player] call VGFE_fnc_getVGdata;
	private _vgfeData = _vgfe deleteAt _index;
	//diag_log format["VGFE _retrieveVehicle: _vgfeData %1", _vgfeData];
	//diag_log format["VGFE _retrieveVehicle: _vgfe %1", _vgfe];
	//diag_log format["VGFE _retrieveVehicle: _player %1 | typeName _player %2", _player, typeName _player];
	[_player, _vgfe] call VGFE_fnc_storeVGdata; 
	private _vehicleData = _vgfeData select 1;
	//diag_log format["VGFE _retrieveVehicle: _vehicleData %1", _vehicleData];
	_vehicleData params ["_className","_locationData","_condition","_inventory","_textures","_loadout","_nickname","_vehicleLockState",["_baseclass",""]];

	/*
		The code below was adapted from files in epoch_server.
		Credit: EpochMod Development Team 
		https://github.com/EpochModTeam/Epoch
	*/	
		/* Spawn and configure the vehicle */



	// [type, position, markers, placement, special]: 
	#define zeroPos [0,0,0]
	private _vehicle = createVehicle[_classname,zeroPos,[],20,"NONE"];
	//diag_log format["VGFE _retrieveVehicle: _vehicle %1 | _className %2", _vehicle, _className];
	if !(isNull _vehicle) then 
	{
		_vehicle allowDamage false;
		_vehicle call EPOCH_server_setVToken;

		_locationData params["_posATL","_dir","_vectorUp"];	
		//diag_log format["VGFE _retrieveVehicle: _posATL %1 | _dir %2 | _vectorUp %3", _posATL, _dir, _vectorUp];
		private _safeSpawn = getNumber(missionConfigFile >> "CfgVGFE" >> "preciseSpawnLocation");
		if (_safeSpawn == 1) then {
			private _size = sizeOf _className;
			private _safePos = _posATL findEmptyPosition [_size, 2 * _size, "classname"];
			if !(_safePos isEqualTo []) then {_posATL = _safePos};
		};
		_vehicle setDir _dir; 
		_vehicle setPosATL _posATL;
		_vehicle setVectorUp _vectorUp;

		// set fuel, damage and hitpoints
		[_vehicle,_condition] call VGFE_fnc_setVehicleCondition;
	

		// Setup vehicle inventory
		[_vehicle,_inventory] call VGFE_fnc_setVehicleInventory;

		// Set vehicle textures and EPOCH texture variable
		[_vehicle,_textures] call VGFE_fnc_setVehicleTextures;
		
		// reload turrets / pylons here so that any epoch cleanup occurs AFTER we do that (just in case)
		[_vehicle,_loadout] call VGFE_fnc_setVehicleLoadout;

		// Restore any nickname information on license plate 
		_vehicle setPlateNumber _nickname;

		//  Handle some special conditions like moving player into drivers seat and vehicle lock state
		private _moveIntoVehicle = getNumber(missionConfigFile >> "CfgVGFE" >> "movePlayerToDriver");
		private _lockOnRetrieval = getNumber(missionConfigFile >> "CfgVGFE" >> "lockOnRetrieval");
		if (_moveIntoVehicle == 1) then 
		{
			_vehicle lock 0;
			_vehicleLockState = 0;			
			//_vehicle setOwner (owner _player);
			[_player,_vehicle] remoteExec["moveInDriver", (owner _player)];
		} else {
			if (_lockOnRetrieval == 1) then 
			{
				_vehicle lock 2;
				_vehicleLockState = 2;
			} else {
				_vehicle lock _vehicleLockState;
			};
		};

		// Lock vehicle for owner
		private _lockOwner = getPlayerUID _player;
		private _playerGroup = _player getVariable["GROUP", ""];
		if !(_playerGroup isEqualTo "") then {
			_lockOwner = _playerGroup;
		};	

		/*
			Deal with turrets and turret ammo according to EPOCH configs.
		*/
		private _serverSettingsConfig = configFile >> "CfgEpochServer";
		// Remove restricted weapons 
		private _removeweapons = [_serverSettingsConfig, "removevehweapons", []] call EPOCH_fnc_returnConfigEntry;
		if !(_removeweapons isequalto []) then {
			{
				_vehicle removeWeaponGlobal _x;
			} foreach _removeweapons;
		};

		//Remove restricted magazines
		private _removemagazinesturret = [_serverSettingsConfig, "removevehmagazinesturret", []] call EPOCH_fnc_returnConfigEntry;
		if !(_removemagazinesturret isequalto []) then {
			{
				_vehicle removeMagazinesTurret _x;
			} foreach _removemagazinesturret;
		};

		// Disable Termal Equipment
		private _disableVehicleTIE = [_serverSettingsConfig, "disableVehicleTIE", true] call EPOCH_fnc_returnConfigEntry;
		if (_disableVehicleTIE) then {
			_vehicle disableTIEquipment true;
		};

		/*
			Take care of some EPOCH bookkeeping for vehicles, save the vehicle to the HIVE, etc.
		*/
		private _slot = EPOCH_VehicleSlots deleteAt 0;
		missionNamespace setVariable ['EPOCH_VehicleSlotCount', count EPOCH_VehicleSlots, true];	

		// Set slot used by vehicle
		_vehicle setVariable["VEHICLE_SLOT", _slot, true];

		// Set BASECLASS if applicable 
		_vehicle setVariable["VEHICLE_BASECLASS",_baseclass];

		// SAVE VEHICLE
		_vehicle call EPOCH_server_save_vehicle;

		// Event Handlers
		_vehicle call EPOCH_server_vehicleInit;

		// save lock state information to the HIVE	
		private _locked = _vehicleLockState in [1,2,3];
		if (_locked && _lockOwner != "") then {
			private _vehLockHiveKey = format["%1:%2", (call EPOCH_fn_InstanceID), _slot];
			["VehicleLock", _vehLockHiveKey, EPOCH_vehicleLockTime, [_lockOwner]] call EPOCH_fnc_server_hiveSETEX;
		} else {
			private _vehLockHiveKey = format["%1:%2", (call EPOCH_fn_InstanceID), _slot];
			["VehicleLock", _vehLockHiveKey] call EPOCH_fnc_server_hiveDEL;
		};

		// Add to A3 remains collector
		addToRemainsCollector[_vehicle];	

		_vehicle allowDamage true;

		// new Dynamicsimulation
		if([configFile >> "CfgEpochServer", "vehicleDynamicSimulationSystem", true] call EPOCH_fnc_returnConfigEntry)then
		{
			_vehicle enableSimulationGlobal false; // turn it off until activated by dynamicSim
			_vehicle enableDynamicSimulation true;
		};

		/* tell the player the vehicle was retrieved successfully */
		private _displayName = getText(configFile >> "CfgVehicles" >> _className >> "displayName");
		private _m = format["%1 has been retrieved from storage",_displayName];
		[_m] remoteExec["systemChat",_player];
		[_m,5] remoteExec["EPOCH_Message",_player];
		[_vehicle] remoteExec["VGFE_fnc_client_vehicleRetrieved",_player];
	} else {
		/* tell the player something went wrong */
		private _displayName = getText(configFile >> "CfgVehicles" >> _className >> "displayName");
		_m = format["Unable to retrieve %1 from storage",_displayName];
		[_m] remoteExec["systemChat",_player];
		[_m] remoteExec["diag_log",_player];
		[_m] remoteExec["EPOCH_Message",_player];		
	};
} else {
	/*
		Tell the player there were nsufficient slots to spawn permenant vehicle
	*/
	["Insufficient Room on Server to Retrieve Vehicle"] remoteExec["systemChat",owner _player];
	["Insufficient Room on Server to Retrieve Vehicle: Contact Server Owner",5] remoteExec["Epoch_Message",owner player];
	["Insufficient Room on Server to Retrieve Vehicle: Contact Server Owner"] remoteExec["diag_log",owner _player];
};