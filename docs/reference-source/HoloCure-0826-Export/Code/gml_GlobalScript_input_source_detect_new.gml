function input_source_detect_new()
{
    static _global = __input_global();
    
    var _gamepad_count = array_length(__input_global().__source_gamepad);
    var _sort_order = 1;
    var _g = 0;
    if (!(false || os_type == os_gxgames) && (os_type == os_macosx || (!_global.__using_steamworks && os_type == os_windows) || (_global.__using_steamworks && os_type == os_linux)))
    {
        _sort_order = -1;
        _g = _gamepad_count - 1;
    }
    repeat (_gamepad_count)
    {
        if (input_source_detect_input(__input_global().__source_gamepad[_g]))
        {
            return __input_global().__source_gamepad[_g];
        }
        _g += _sort_order;
    }
    if (input_source_detect_input(__input_global().__source_keyboard))
    {
        return __input_global().__source_keyboard;
    }
    if (input_source_detect_input((1 && ((os_type == os_android || (os_type == os_ios || os_type == os_tvos)) || os_type == os_switch || (false && os_type == os_windows))) ? __input_global().__source_touch : __input_global().__source_mouse))
    {
        return (1 && ((os_type == os_android || (os_type == os_ios || os_type == os_tvos)) || os_type == os_switch || (false && os_type == os_windows))) ? __input_global().__source_touch : __input_global().__source_mouse;
    }
    return undefined;
}
