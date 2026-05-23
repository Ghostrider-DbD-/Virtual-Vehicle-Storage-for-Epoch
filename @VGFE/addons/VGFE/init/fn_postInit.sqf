//diag_log "VGFE: post-Initialization for Virtual VehicleStorage for Epoch";

onPlayerConnected {}; // seems this is needed or addMissionEventHandler "PlayerConnected" does not work. as of A3 1.60
addMissionEventHandler ["PlayerConnected", 
{
    _this call VGFE_fnc_onPlayerJoined;
}];
MyVGFEstate = 1;
ServerVGid = 1;
VGFEexpiresAt = "999999";	
if (isText(missionConfigFile >> "CfgVGFE" >> "vgfeExpiresAt")) then 
{
	VGFEexpiresAt = getText(missionConfigFile >> "CfgVGFE" >> "vgfeExpiresAt");
};
private _storageMode = getText(missionConfigFile >> "CfgVGFE" >> "storageMode");
//if !(_tolower (storageMode) in ["player","group"]) then {diag_log format["VGFE Debug: Error, %1 not a valide type of storageMode",_storageMode]};
private _ver = getNumber(configFile >> "CfgBuild" >> "VGFE" >> "version");
private _bld = getNumber(configFile >> "CfgBuild" >> "VGFE" >> "build");
private _date = getText(configFile >> "CfgBuild" >> "VGFE" >> "date");
diag_log format["VGFE: Initialized Version %1 Build %2 Date %3",_ver,_bld,_date];
private _expiresAt = getText(missionConfigFile >> "CfgVGFE" >> "vgfeExpiresAt");
private _isNumber = isNumber(missionConfigFile >> "CfgVGFE" >> "vgfeExpiresAt");
private _isText = isText(missionConfigFile >> "CfgVGFE" >> "vgfeExpiresAt");
if !(_isText) then {
    ["CfgVGFE >> vgfeExpiresAt Must be a string!","error"] call VGFE_fnc_log;
};

private _length = count _expiresAt; 
private _valid = true;
for "_i" from 0 to (_length -1) do 
{
    _char = _expiresAt select [_i,1];

    if !(_char in ['0','1','2','3','4','5','6','7','8','9']) then 
    {
        [format["Invalid Character in vgfeExpiresAt = %1 at position %2",_char,_i],'error'] call VGFE_fnc_log;
        _valid = false;
    };
};
if !(_valid) then 
{
    ["Invalid character(s) in CfgVGFE\vgfeExpiresAt: You must correct this error for VGFE to work",'error'] call VGFE_fnc_log;
};

diag_log format["VGFE: InitializationChecks: _isNumber = %1 | _isText = %2 | _expiresAt = %3 count _expiresAt = %4",_isNumber,_isText,_expiresAt,count _expiresAt];

/*
private _define = if (isNil "VGFE_fnc_storeVehicle") then {true} else {false};
diag_log format["VGFE _postInit: _define = %1", _define];

private _handle = 0 spawn {

    private _wait = false;
    while {_wait == false} do {
        _wait = missionNamespace getVariable["EPOCH_SERVER_READY", false];
        diag_log format["VGFE _postInit: EPOCH_SERVER_READY == %2 at %1", diag_tickTime, _wait];
        uiSleep 1;
    };
    diag_log format["VGFE _postInit: EPOCH_SERVER_READY == %1", EPOCH_SERVER_READY];

    diag_log format["_postInit: reading _status from VGFE_STATUS at %1", diag_tickTime];
    private _id = 0;

    private _hiveSearch = ["VGFE_KEY",_id] call EPOCH_fnc_server_hiveGET;
    diag_log format["VGFE _postInit (59) _hiveSearch %1", _hiveSearch];
    uisleep 2;
    _hiveSearch params["_status", "_result"];

     private _doDelete = if !(_result isEqualTo []) then {true} else {false};
    diag_log format["VGFE _postInit (64) _doDelete %1 | _result %2", _doDelete, _result];

    for "_i" from 0 to 5 do {
        private _id = _i;
        private _hiveSearch = ["VGFE_KEY", _id] call EPOCH_fnc_server_hiveGET;
        _hiveSearch params["_status","_result"];
        diag_log format["VGFE _preInit: _status %1 | _result %2 | _prefix %3 | _id %4", _status, _result, "VGFE_KEY", _id];
    };

    if (_doDelete) then {
        for "_i" from 0 to 5 do {
            private _id = _i;
            ["VGFE_KEY",_id] call EPOCH_fnc_server_hiveDEL;
        };
    } else {
        for "_i" from 0 to 5 do {
            private _id = _i;
            private _key = format["is%1", random(20000)];
            ["VGFE_KEY",_id,VGFEexpiresAt,[_key]] call EPOCH_fnc_server_hiveSETEX;
        };
    };
    diag_log format["VGFE _postInit: end of spawned routine at %1", diag_tickTime];
};

diag_log format["VGFE _postInit: end of script at %1", diag_tickTime];










