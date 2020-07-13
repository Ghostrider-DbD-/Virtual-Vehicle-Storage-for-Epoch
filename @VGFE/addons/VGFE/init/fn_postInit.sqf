//diag_log "VGFE: post-Initialization for Virtual VehicleStorage for Epoch";

onPlayerConnected {}; // seems this is needed or addMissionEventHandler "PlayerConnected" does not work. as of A3 1.60
addMissionEventHandler ["PlayerConnected", 
{
    _this call VGFE_fnc_onPlayerJoined;
}];
MyVGFEstate = 1;

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






