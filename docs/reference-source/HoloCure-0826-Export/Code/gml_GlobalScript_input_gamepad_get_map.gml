function input_gamepad_get_map(arg0)
{
    static _global = __input_global();
    
    if (arg0 == undefined || arg0 < 0 || arg0 >= array_length(_global.__gamepads))
    {
        return [];
    }
    var _gamepad = _global.__gamepads[arg0];
    if (!is_struct(_gamepad))
    {
        return [];
    }
    with (_gamepad)
    {
        if (!custom_mapping)
        {
            var _mappings = [32769, 32770, 32771, 32772, 32782, 32781, 32783, 32784, 32773, 32774, 32775, 32776, 32785, 32786, 32787, 32788, 32778, 32779, 32780];
            if (!(os_type == os_ps4 || os_type == os_ps5) || 1)
            {
                array_push(_mappings, 32777);
            }
            return _mappings;
        }
        var _output = array_create(array_length(mapping_array), undefined);
        var _i = 0;
        repeat (array_length(mapping_array))
        {
            _output[_i] = mapping_array[_i].gm;
            _i++;
        }
        return _output;
    }
}
