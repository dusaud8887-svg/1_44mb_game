function __input_hotswap_tick()
{
    static _global = __input_global();
    
    with (_global.__players[0])
    {
        if (__ghost)
        {
            __input_trace("Warning! Cannot hotswap because player 0 is a ghost");
            return false;
        }
        if ((__last_input_time < 0 || (_global.__current_time - __last_input_time) > 33) && (__rebind_state <= 0 || !is_array(__rebind_source_filter) || array_length(__rebind_source_filter) <= 0))
        {
            var _new_source = __input_hotswap_tick_input();
            if (_new_source != undefined && !__source_contains(_new_source))
            {
                input_source_set(_new_source, 0, true);
                if (is_method(_global.__hotswap_callback))
                {
                    _global.__hotswap_callback();
                }
                else if (is_numeric(_global.__hotswap_callback) && script_exists(_global.__hotswap_callback))
                {
                    script_execute(_global.__hotswap_callback);
                }
                else if (_global.__hotswap_callback != undefined)
                {
                    __input_error("Hotswap callback set to an illegal value (typeof=", typeof(_global.__hotswap_callback), ")");
                }
            }
        }
    }
}

function __input_hotswap_tick_input()
{
    static _global = __input_global();
    
    if (_global.__any_gamepad_binding_defined)
    {
        var _gamepad_count = array_length(__input_global().__source_gamepad);
        var _g = 0;
        repeat (_gamepad_count)
        {
            if (gamepad_is_connected(_g) && input_source_using(__input_global().__source_gamepad[_g]))
            {
                if (input_gamepad_check(_g, 32769) || input_gamepad_check(_g, 32770) || input_gamepad_check(_g, 32771) || input_gamepad_check(_g, 32772) || input_gamepad_check(_g, 32781) || input_gamepad_check(_g, 32782) || input_gamepad_check(_g, 32783) || input_gamepad_check(_g, 32784) || input_gamepad_check(_g, 32773) || input_gamepad_check(_g, 32774) || input_gamepad_check(_g, 32778) || input_gamepad_check(_g, 32777) || input_gamepad_check(_g, 32779) || input_gamepad_check(_g, 32780) || (!input_gamepad_is_axis(_g, 32775) && input_gamepad_check(_g, 32775)) || (!input_gamepad_is_axis(_g, 32776) && input_gamepad_check(_g, 32776)))
                {
                    break;
                }
                if (abs(input_gamepad_value(_g, 32775)) > input_axis_threshold_get(32775, 0).mini || abs(input_gamepad_value(_g, 32776)) > input_axis_threshold_get(32776, 0).mini || abs(input_gamepad_value(_g, 32786)) > input_axis_threshold_get(32786, 0).mini || abs(input_gamepad_value(_g, 32785)) > input_axis_threshold_get(32785, 0).mini || abs(input_gamepad_value(_g, 32786)) > input_axis_threshold_get(32786, 0).mini || abs(input_gamepad_value(_g, 32787)) > input_axis_threshold_get(32787, 0).mini || abs(input_gamepad_value(_g, 32788)) > input_axis_threshold_get(32788, 0).mini)
                {
                    break;
                }
                if (input_gamepad_check(_g, 32889) || input_gamepad_check(_g, 32890) || input_gamepad_check(_g, 32891) || input_gamepad_check(_g, 32892) || input_gamepad_check(_g, 32893) || input_gamepad_check(_g, 32894) || input_gamepad_check(_g, 32895))
                {
                    break;
                }
            }
            _g++;
        }
        if (_g < _gamepad_count)
        {
            _global.__players[0].__last_input_time = _global.__current_time;
            return __input_global().__source_gamepad[_g];
        }
        else if (!((_global.__frame - _global.__window_focus_frame) < 2))
        {
            var _sort_order = 1;
            _g = 0;
            if (!(false || os_type == os_gxgames) && (os_type == os_macosx || (!_global.__using_steamworks && os_type == os_windows) || (_global.__using_steamworks && os_type == os_linux)))
            {
                _sort_order = -1;
                _g = _gamepad_count - 1;
            }
            repeat (_gamepad_count)
            {
                if (gamepad_is_connected(_g) && input_source_is_available(__input_global().__source_gamepad[_g]))
                {
                    if (input_gamepad_check_pressed(_g, 32769) || input_gamepad_check_pressed(_g, 32770) || input_gamepad_check_pressed(_g, 32771) || input_gamepad_check_pressed(_g, 32772) || input_gamepad_check_pressed(_g, 32773) || input_gamepad_check_pressed(_g, 32774) || input_gamepad_check_pressed(_g, 32778) || input_gamepad_check_pressed(_g, 32777) || input_gamepad_check_pressed(_g, 32779) || input_gamepad_check_pressed(_g, 32780) || (input_gamepad_check_pressed(_g, 32781) && input_gamepad_delta(_g, 32781) != 0) || (input_gamepad_check_pressed(_g, 32782) && input_gamepad_delta(_g, 32782) != 0) || (input_gamepad_check_pressed(_g, 32783) && input_gamepad_delta(_g, 32783) != 0) || (input_gamepad_check_pressed(_g, 32784) && input_gamepad_delta(_g, 32784) != 0) || (!input_gamepad_is_axis(_g, 32775) && input_gamepad_check_pressed(_g, 32775)) || (!input_gamepad_is_axis(_g, 32776) && input_gamepad_check_pressed(_g, 32776)))
                    {
                        return __input_global().__source_gamepad[_g];
                    }
                    if ((abs(input_gamepad_value(_g, 32775)) > input_axis_threshold_get(32775).mini && abs(input_gamepad_delta(_g, 32775)) > 0.1) || (abs(input_gamepad_value(_g, 32776)) > input_axis_threshold_get(32776).mini && abs(input_gamepad_delta(_g, 32776)) > 0.1) || (abs(input_gamepad_value(_g, 32786)) > input_axis_threshold_get(32786).mini && abs(input_gamepad_delta(_g, 32786)) > 0.1) || (abs(input_gamepad_value(_g, 32785)) > input_axis_threshold_get(32785).mini && abs(input_gamepad_delta(_g, 32785)) > 0.1) || (abs(input_gamepad_value(_g, 32786)) > input_axis_threshold_get(32786).mini && abs(input_gamepad_delta(_g, 32786)) > 0.1) || (abs(input_gamepad_value(_g, 32787)) > input_axis_threshold_get(32787).mini && abs(input_gamepad_delta(_g, 32787)) > 0.1) || (abs(input_gamepad_value(_g, 32788)) > input_axis_threshold_get(32788).mini && abs(input_gamepad_delta(_g, 32788)) > 0.1))
                    {
                        return __input_global().__source_gamepad[_g];
                    }
                    if (input_gamepad_check_pressed(_g, 32889) || input_gamepad_check_pressed(_g, 32890) || input_gamepad_check_pressed(_g, 32891) || input_gamepad_check_pressed(_g, 32892) || input_gamepad_check_pressed(_g, 32893) || input_gamepad_check_pressed(_g, 32894) || input_gamepad_check_pressed(_g, 32895))
                    {
                        return __input_global().__source_gamepad[_g];
                    }
                }
                _g += _sort_order;
            }
        }
    }
    if (_global.__any_keyboard_binding_defined && input_source_is_available(__input_global().__source_keyboard) && keyboard_check(vk_anykey) && !__input_key_is_ignored(__input_keyboard_key()))
    {
        return __input_global().__source_keyboard;
    }
    if (1 && (1 && ((os_type == os_android || (os_type == os_ios || os_type == os_tvos)) || os_type == os_switch || (false && os_type == os_windows))))
    {
        if (input_source_is_available(__input_global().__source_touch) && device_mouse_check_button(_global.__pointer_index, mb_left))
        {
            return __input_global().__source_touch;
        }
    }
    else if (input_source_is_available(__input_global().__source_mouse) && ((false && _global.__pointer_moved) || (true && (input_mouse_check(-1) || mouse_wheel_up() || mouse_wheel_down()))))
    {
        return __input_global().__source_mouse;
    }
    return undefined;
}
