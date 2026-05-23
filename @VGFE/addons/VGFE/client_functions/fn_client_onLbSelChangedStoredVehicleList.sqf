/*
	VGFE_fnc_client_onLbSelChangedStoredVehiclesList 
	Copyright 2020 by Ghostrider-GRG-
*/
private _display = uiNamespace getVariable["VirtualGarageDialog",""];	
private _ctrl = (_display displayCtrl 1500);
private _index = lbCurSel 1500;
private _veh = _ctrl lbData _index;  //  object
private _vehicleType = _ctrl lbText _index;  //  description based on classname
private _ctrlVehDescription = (_display displayCtrl 1001);
private _ctrlVehicleNickname = (_display displayCtrl 1009);
_ctrlVehDescription ctrlSetStructuredText parseText _vehicleType;
private _vgSlot = MyVGFE select _index;
_vgSlot params["_key","_accessPoint","_vehicleData"];
//_vehicleData params ["_className","_location","_condition","_inventory","_textures","_loadout","_nickname","_vehicleLockState"];
_vehicleData params ["_className","_locationData","_condition","_inventory","_textures","_loadout","_nickname","_vehicleLockState",["_baseclass",""]];

for "_i" from 0 to (count _vehicleData) do {
	diag_log format["VGFE _onLbSelChangedStoredVehicleList: _data %1 | _index %2", _x, _forEachIndex];
};

private _picture = getText(configFile >> "CfgVehicles" >> _className >> "editorPreview");
diag_log format["VGFE_fnc_client_onLbSelChangedStoredVehiclesList:  _className %1 | _picture %2",_classname,_picture];
private _ctrl = (_display displayCtrl 1200);  // Where we display pictures of things
_ctrl ctrlSetText _picture;		

diag_log format["VGFE _onLbSelChangedStoredVehiclesList: _nickname %1", _nickname];
_ctrlVehicleNickname ctrlSetText format["Plate: %1",_nickname];  //  Where we display the license plate name 
if!(VGFE_activeList isEqualTo "retrieve") then
{
	VGFE_activeList = "retrieve";
	private _ctrl = (_display displayCtrl 1600);
	_ctrl ctrlSetText "RETRIEVE";
	_ctrl ctrlSetToolTip "Press to Retrieve the Selected Vehicle";
	_ctrl buttonSetAction "[] call VGFE_fnc_client_RetrieveVehicle;";
	{
		ctrlShow[_x,true];
	} forEach [1009,1600];
};