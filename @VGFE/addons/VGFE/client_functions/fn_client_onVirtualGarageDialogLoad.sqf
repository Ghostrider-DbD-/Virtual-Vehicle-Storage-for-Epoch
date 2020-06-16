/*
	VGFE_fnc_client_onVirtualGarageDialogLoad 
	Copyright 2020 by Ghostrider-GRG-
*/


private "_vehTypes";
switch (MyVFGFstorageMode) do 
{
	case "player": {_vehTypes = ["Car","Tank","Air","Ship"]};
	case "garage": {_vehTypes = ["Car","Tank","Air","Ship"]};
	case "hanger": {_vehTypes = ["Air"]};
	case "dock": {_vehTypes = ["Ship"]};
};
private _localVehicles = [_vehTypes,MyVFGFstorageMode] call VGFE_fnc_client_getLocalVehicles;

 
{
	ctrlShow[_x,false];
} forEach [2,1009,1600,1009,1010,1011];

private _display = uiNamespace getVariable["VirtualGarageDialog",""];
private _ctrl = (_display displayCtrl 1001);
_ctrl ctrlSetText "LOADING";
for "_i" from 1 to 20 do 
{
	(_display displayCtrl 1008) progressSetPosition (_i/20);
	uiSleep 0.05;
	switch (_i) do 
	{
		case 4: {_ctrl ctrlSetText "LOADING .";};
		case 8: {_ctrl ctrlSetText "LOADING . .";};
		case 12: {_ctrl ctrlSetText "LOADING . . . ";};
		case 16: {_ctrl ctrlSetText "LOADING . . . .";};
		case 20: {_ctrl ctrlSetText "LOADED";};
	};
};

uiSleep 0.25;

ctrlShow[1008,false];

if ( !(MyVGFE isEqualTo []) || !(_localVehicles isEqualTo []) ) then 
{
	_ctrl ctrlSetText "Select a Vehicle";
	{
		ctrlShow[_x,true];
	} forEach [1000,1005,1006,1007,1010,1011,1500,1501,2];
} else {
	_ctrl ctrlSetText "No Vehicles Found";
	_ctrl ctrlSetTooltip "Please Enter Vehicles Before Storing Them";
	{
		ctrlShow[_x,true];
	} forEach [1000,1005,1006,1007,1010,1011,1500,1501,2];	
};


private _ctrl = (_display displayCtrl 1500);
{
	_x params ["_key","_vehicleData"];
	private _className = _vehicleData select 0;
	private _index = _ctrl lbAdd getText(configFile >> "CfgVehicles" >> _className >> "displayName");
	_ctrl lbSetValue [_index,_key];
	_ctrl lbSetTooltip [_index,"Select Vehicle To Retrive"];
} forEach MyVGFE;

private _ctrl2 = (_display displayCtrl 1501);
{
	private _index = _ctrl2 lbAdd getText(configFile >> "CfgVehicles" >> typeOf _x >> "displayName");
	_ctrl2 lbSetData[_index,netID _x];
	_ctrl2 lbSetTooltip[_index,"Select Vehicle to Store"];
} forEach _localVehicles;

MyVGFELocalVehicles = _localVehicles;
switch (MyVFGFstorageMode) do 
{
	case 'garage': {};
	case 'hanger': {
		private _ctrl = (_display displayCtrl 1010);
		_ctrl ctrlSetText "Hanger";
		_ctrl = (_display displayCtrl 1200);
		_ctrl ctrlSetText "\A3\Air_F_EPC\Plane_CAS_01\Data\UI\Map_Plane_CAS_01_CA.paa";
	};
	case 'dock': {
		private _ctrl = (_display displayCtrl 1010);
		_ctrl ctrlSetText "Dry Dock";
		_ctrl = (_display displayCtrl 1200);
		_ctrl ctrlSetText "\A3\boat_f\Boat_Armed_01\data\ui\map_boat_armed_01_minigun.paa";
	};
};

VGFE_activeList = "";
