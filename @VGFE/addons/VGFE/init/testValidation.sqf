
_expiresAt = "123r4567";
_length = count _expiresAt; 
systemChat format["_expiresAt = %1",_expiresAt];
systemChat format["length _expiresAt = %1",_length];
for "_i" from 0 to (_length -1) do 
{
    _char = _expiresAt select [_i,1];

    if (_char in ['0','1','2','3','4','5','6','7','8','9']) then 
    {
        systemChat format["%1 is valid char",_char];
    } else {
        systemchat format["%1 is invalid",_char];
    };
};