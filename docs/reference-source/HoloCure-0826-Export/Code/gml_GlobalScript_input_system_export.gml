function input_system_export(arg0 = true, arg1 = false)
{
    static _global = __input_global();
    
    var _players_array = array_create(4, undefined);
    var _root_json = 
    {
        accessibility: 
        {
            momentary_state: _global.__toggle_momentary_state,
            momentary_verbs: variable_struct_get_names(_global.__toggle_momentary_dict),
            cooldown_state: _global.__cooldown_state,
            cooldown_verbs: variable_struct_get_names(_global.__cooldown_dict)
        },
        mouse: 
        {
            capture: _global.__mouse_capture,
            sensitivity: _global.__mouse_capture_sensitivity
        },
        players: _players_array
    };
    var _p = 0;
    repeat (4)
    {
        with (_global.__players[_p])
        {
            _players_array[_p] = __export();
        }
        _p++;
    }
    if (arg0)
    {
        if (arg1)
        {
            return __input_snap_to_json(_root_json, true, true);
        }
        else
        {
            return json_stringify(_root_json);
        }
    }
    else
    {
        return _root_json;
    }
}
