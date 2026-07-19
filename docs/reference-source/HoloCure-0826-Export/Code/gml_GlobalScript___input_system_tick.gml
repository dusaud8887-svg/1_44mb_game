function __input_system_tick()
{
    static _global = __input_global();
    
    _global.__frame++;
    _global.__previous_current_time = _global.__current_time;
    _global.__current_time = current_time;
    _global.__cleared = false;
    if (false && (os_type == os_ps4 || os_type == os_ps5))
    {
        var _gamepad = _global.__players[0].__source_get_gamepad();
        if (_gamepad >= 0 && _gamepad < 4)
        {
            _global.__pointer_index = _gamepad * 2;
            _global.__pointer_pressed = gamepad_button_check_pressed(_gamepad, gp_select);
            _global.__pointer_released = gamepad_button_check_released(_gamepad, gp_select);
        }
    }
    if ((os_type == os_android || (os_type == os_ios || os_type == os_tvos)) || (false && os_type == os_switch) || (true && os_type == os_windows))
    {
        var _touch_index = undefined;
        var _touch_press_index = _global.__pointer_pressed_index;
        var _i = 0;
        repeat (11)
        {
            if (!device_mouse_check_button(_i, mb_left))
            {
                _global.__pointer_durations[_i] = 0;
            }
            else
            {
                _global.__pointer_durations[_i] += delta_time;
                if (_touch_index == undefined || _global.__pointer_durations[_i] < _global.__pointer_durations[_touch_index])
                {
                    _touch_index = _i;
                }
            }
            _i++;
        }
        if (_touch_index == undefined)
        {
            _touch_index = 0;
        }
        _global.__pointer_pressed = device_mouse_check_button_pressed(_touch_index, mb_left);
        _global.__pointer_released = _global.__pointer_index_previous != undefined && device_mouse_check_button_released(_global.__pointer_index_previous, mb_left);
        var _w = display_get_gui_width();
        var _h = display_get_gui_height();
        if (_global.__pointer_released)
        {
            var _tx = device_mouse_x_to_gui(_global.__pointer_index_previous);
            var _ty = device_mouse_y_to_gui(_global.__pointer_index_previous);
            if (_tx < 35 || _tx > (_w - 35) || _ty < 35 || _ty > (_h - 35))
            {
                _global.__pointer_released = false;
            }
        }
        if (_global.__pointer_pressed)
        {
            var _tx = device_mouse_x_to_gui(_touch_index);
            var _ty = device_mouse_y_to_gui(_touch_index);
            if (_tx < 35 || _tx > (_w - 35) || _ty < 35 || _ty > (_h - 35))
            {
                _global.__pointer_pressed = false;
            }
        }
        _global.__pointer_index_previous = _global.__pointer_index;
        _global.__pointer_index = _touch_index;
        if (_global.__pointer_pressed)
        {
            _global.__pointer_pressed_index = _touch_index;
        }
    }
    if ((os_type == os_macosx || os_type == os_linux || os_type == os_windows) && !(false || os_type == os_gxgames))
    {
        if (os_is_paused())
        {
            _global.__window_focus = false;
            io_clear();
            __input_gamepad_stop_trigger_effects(-3);
        }
        else if (_global.__window_focus)
        {
            if (_global.__window_focus_block_mouse)
            {
                _global.__window_focus_block_mouse = false;
                if (__input_mouse_button() != 0)
                {
                    _global.__window_focus_block_mouse = true;
                }
            }
        }
        else if (keyboard_key != vk_nokey || mouse_button != mb_none || (os_type == os_windows && window_has_focus()) || (os_type == os_macosx && _global.__pointer_moved))
        {
            _global.__window_focus = true;
            _global.__window_focus_frame = _global.__frame;
            _global.__window_focus_block_mouse = true;
            if (_global.__mouse_capture)
            {
                _global.__mouse_capture_frame = _global.__frame;
            }
            __input_player_apply_trigger_effects(-3);
        }
    }
    var _moved = false;
    var _m = 0;
    repeat (UnknownEnum.Value_3)
    {
        _global.__pointer_dx[_m] = 0;
        _global.__pointer_dy[_m] = 0;
        _m++;
    }
    if (_global.__mouse_capture && _global.__window_focus)
    {
        if (__input_window_changed())
        {
            _global.__mouse_capture_blocked = true;
            if (os_type == os_windows)
            {
                input_mouse_capture_set(true, _global.__mouse_capture_sensitivity);
            }
        }
        else if (_global.__mouse_capture_blocked && device_mouse_check_button_pressed(0, mb_left))
        {
            input_mouse_capture_set(true, _global.__mouse_capture_sensitivity);
        }
    }
    if (_global.__mouse_capture && !_global.__mouse_capture_blocked)
    {
        if (_global.__window_focus)
        {
            if ((_global.__frame - _global.__mouse_capture_frame) > 10)
            {
                var _pointer_x, _pointer_y;
                if (os_type == os_windows)
                {
                    _pointer_x = display_mouse_get_x() - window_get_x();
                    _pointer_y = display_mouse_get_y() - window_get_y();
                }
                else
                {
                    _pointer_x = device_mouse_raw_x(_global.__pointer_index);
                    _pointer_y = device_mouse_raw_y(_global.__pointer_index);
                }
                if (abs(_pointer_x - (window_get_width() / 2)) >= 1 || abs(_pointer_y - (window_get_height() / 2)) >= 1)
                {
                    _m = 0;
                    repeat (UnknownEnum.Value_3)
                    {
                        var _old_x, _old_y;
                        switch (_m)
                        {
                            case UnknownEnum.Value_0:
                                if (view_enabled && view_visible[0])
                                {
                                    var _camera = view_camera[0];
                                    _old_x = camera_get_view_width(_camera) / 2;
                                    _old_y = camera_get_view_height(_camera) / 2;
                                }
                                else
                                {
                                    _old_x = room_width / 2;
                                    _old_y = room_height / 2;
                                }
                                _pointer_x = device_mouse_x(_global.__pointer_index);
                                _pointer_y = device_mouse_y(_global.__pointer_index);
                                break;
                            case UnknownEnum.Value_1:
                                _old_x = display_get_gui_width() / 2;
                                _old_y = display_get_gui_height() / 2;
                                _pointer_x = device_mouse_x_to_gui(_global.__pointer_index);
                                _pointer_y = device_mouse_y_to_gui(_global.__pointer_index);
                                break;
                            case UnknownEnum.Value_2:
                                _old_x = window_get_width() / 2;
                                _old_y = window_get_height() / 2;
                                if (os_type == os_windows)
                                {
                                    _pointer_x = display_mouse_get_x() - window_get_x();
                                    _pointer_y = display_mouse_get_y() - window_get_y();
                                }
                                else
                                {
                                    _pointer_x = device_mouse_raw_x(_global.__pointer_index);
                                    _pointer_y = device_mouse_raw_y(_global.__pointer_index);
                                }
                                break;
                        }
                        var _dx = (_pointer_x - _old_x) * _global.__mouse_capture_sensitivity;
                        var _dy = (_pointer_y - _old_y) * _global.__mouse_capture_sensitivity;
                        if (_m == UnknownEnum.Value_2 && ((_dx * _dx) + (_dy * _dy)) > 4)
                        {
                            _moved = true;
                        }
                        _global.__pointer_dx[_m] = _dx;
                        _global.__pointer_dy[_m] = _dy;
                        _global.__pointer_x[_m] += _dx;
                        _global.__pointer_y[_m] += _dy;
                        _m++;
                    }
                }
            }
            window_mouse_set(window_get_width() / 2, window_get_height() / 2);
        }
    }
    else if (_global.__window_focus || false || os_type == os_macosx)
    {
        _m = 0;
        repeat (UnknownEnum.Value_3)
        {
            var _old_x = _global.__pointer_x[_m];
            var _old_y = _global.__pointer_y[_m];
            var _pointer_x = _old_x;
            var _pointer_y = _old_y;
            switch (_m)
            {
                case UnknownEnum.Value_0:
                    _pointer_x = device_mouse_x(_global.__pointer_index);
                    _pointer_y = device_mouse_y(_global.__pointer_index);
                    break;
                case UnknownEnum.Value_1:
                    _pointer_x = device_mouse_x_to_gui(_global.__pointer_index);
                    _pointer_y = device_mouse_y_to_gui(_global.__pointer_index);
                    break;
                case UnknownEnum.Value_2:
                    if (os_type == os_windows)
                    {
                        _pointer_x = display_mouse_get_x() - window_get_x();
                        _pointer_y = display_mouse_get_y() - window_get_y();
                    }
                    else
                    {
                        _pointer_x = device_mouse_raw_x(_global.__pointer_index);
                        _pointer_y = device_mouse_raw_y(_global.__pointer_index);
                    }
                    break;
            }
            if (_m == UnknownEnum.Value_2 && point_distance(_old_x, _old_y, _pointer_x, _pointer_y) > 2)
            {
                _moved = true;
            }
            _global.__pointer_dx[_m] = _pointer_x - _old_x;
            _global.__pointer_dy[_m] = _pointer_y - _old_y;
            _global.__pointer_x[_m] = _pointer_x;
            _global.__pointer_y[_m] = _pointer_y;
            _m++;
        }
    }
    _global.__pointer_moved = _moved;
    _global.__tap_click = false;
    if (os_type == os_windows)
    {
        _global.__tap_presses += device_mouse_check_button_pressed(0, mb_left);
        _global.__tap_releases += device_mouse_check_button_released(0, mb_left);
        if (_global.__tap_releases >= _global.__tap_presses)
        {
            _global.__tap_click = _global.__tap_releases > _global.__tap_presses;
            _global.__tap_presses = 0;
            _global.__tap_releases = 0;
        }
    }
    if (_global.__keyboard_allowed && keyboard_check(vk_anykey))
    {
        var _platform = os_type;
        if ((false || os_type == os_gxgames) && (os_type == os_macosx || (os_type == os_ios || os_type == os_tvos)))
        {
            _platform = "apple_web";
        }
        switch (_platform)
        {
            case 0:
                if (keyboard_check(vk_alt) && keyboard_check_pressed(vk_space))
                {
                    keyboard_key_release(vk_alt);
                    keyboard_key_release(vk_space);
                    keyboard_key_release(vk_lalt);
                    keyboard_key_release(vk_ralt);
                }
                break;
            case "apple_web":
                if (keyboard_check_released(92) || keyboard_check_released(93))
                {
                    var _i = 8;
                    var _len = 255 - _i;
                    repeat (_len)
                    {
                        keyboard_key_release(_i);
                        _i++;
                    }
                }
                break;
            case 1:
                if (keyboard_check_released(vk_control))
                {
                    keyboard_key_release(vk_lcontrol);
                    keyboard_key_release(vk_rcontrol);
                }
                if (keyboard_check_released(vk_shift))
                {
                    keyboard_key_release(vk_lshift);
                    keyboard_key_release(vk_rshift);
                }
                if (keyboard_check_released(vk_alt))
                {
                    keyboard_key_release(vk_lalt);
                    keyboard_key_release(vk_ralt);
                }
                if (keyboard_check_released((os_type == os_macosx) ? 92 : 91))
                {
                    keyboard_key_release((os_type == os_macosx) ? (((os_type == os_macosx || (os_type == os_ios || os_type == os_tvos)) && (false || os_type == os_gxgames)) ? 93 : 91) : 92);
                }
                else if (keyboard_check_released((os_type == os_macosx) ? (((os_type == os_macosx || (os_type == os_ios || os_type == os_tvos)) && (false || os_type == os_gxgames)) ? 93 : 91) : 92) && keyboard_check((os_type == os_macosx) ? 92 : 91))
                {
                    keyboard_key_release((os_type == os_macosx) ? 92 : 91);
                }
                break;
        }
    }
    var _steam_handles_changed = false;
    if (_global.__using_steamworks)
    {
        extension_stubfunc_real();
        _steam_handles_changed = __input_steam_handles_changed();
        _global.__steam_handles = extension_stubfunc_real();
    }
    if (_global.__frame > 10)
    {
        var _device_change = max(0, gamepad_get_device_count() - array_length(_global.__gamepads));
        repeat (_device_change)
        {
            array_push(_global.__gamepads, undefined);
        }
        _device_change = max(0, gamepad_get_device_count() - array_length(__input_global().__source_gamepad));
        repeat (_device_change)
        {
            array_push(__input_global().__source_gamepad, new __input_class_source(UnknownEnum.Value_2, array_length(__input_global().__source_gamepad)));
            if (_global.__source_mode == UnknownEnum.Value_3 || _global.__source_mode == UnknownEnum.Value_4)
            {
                _global.__players[0].__source_add(__input_global().__source_gamepad[array_length(__input_global().__source_gamepad) - 1]);
            }
        }
        _g = 0;
        repeat (array_length(_global.__gamepads))
        {
            var _gamepad = _global.__gamepads[_g];
            if (is_struct(_gamepad))
            {
                if (gamepad_is_connected(_g))
                {
                    if (os_type == os_switch && _gamepad.description != gamepad_get_description(_g))
                    {
                        _gamepad.discover();
                    }
                    else
                    {
                        if (_steam_handles_changed)
                        {
                            with (_gamepad)
                            {
                                virtual_set();
                                led_set();
                            }
                        }
                        _gamepad.tick();
                    }
                }
                else
                {
                    __input_trace("Gamepad ", _g, " disconnected");
                    if (instance_exists(obj_PlayerManager))
                    {
                        instance_find(obj_PlayerManager, 0).EscKey();
                        instance_find(obj_PlayerManager, 0).disconnectWarning = true;
                    }
                    gamepad_set_vibration(_global.__gamepads[_g].index, 0, 0);
                    _global.__gamepads[_g] = undefined;
                    if (_global.__source_mode != UnknownEnum.Value_3 && _global.__source_mode != UnknownEnum.Value_4)
                    {
                        _p = 0;
                        repeat (4)
                        {
                            with (_global.__players[_p])
                            {
                                if (__source_contains(__input_global().__source_gamepad[_g]))
                                {
                                    __input_trace("Player ", _p, " gamepad disconnected");
                                    __source_remove(__input_global().__source_gamepad[_g]);
                                }
                            }
                            _p++;
                        }
                    }
                }
            }
            else if (gamepad_is_connected(_g))
            {
                __input_trace("Gamepad ", _g, " connected");
                __input_trace("New gamepad = \"", gamepad_get_description(_g), "\", GUID=\"", gamepad_get_guid(_g), "\", buttons = ", gamepad_button_count(_g), ", axes = ", gamepad_axis_count(_g), ", hats = ", gamepad_hat_count(_g));
                _global.__gamepads[_g] = new __input_class_gamepad(_g);
            }
            _g++;
        }
    }
    var _p = 0;
    repeat (4)
    {
        _global.__players[_p].tick();
        _p++;
    }
    if (_global.__virtual_order_dirty)
    {
        var _i = 0;
        repeat (array_length(_global.__virtual_array))
        {
            if (_global.__virtual_array[_i].__destroyed)
            {
                array_delete(_global.__virtual_array, _i, 1);
            }
            else
            {
                _i++;
            }
        }
        _global.__virtual_order_dirty = false;
        array_sort(_global.__virtual_array, function(arg0, arg1)
        {
            return arg0.__priority - arg1.__priority;
        });
    }
    if (is_struct(_global.__touch_player))
    {
        var _i = 0;
        repeat (11)
        {
            if (device_mouse_check_button_pressed(_i, mb_left))
            {
                var _j = 0;
                repeat (array_length(_global.__virtual_array))
                {
                    if (_global.__virtual_array[_j].__capture_touchpoint(_i))
                    {
                        break;
                    }
                    _j++;
                }
            }
            _i++;
        }
        _i = 0;
        repeat (array_length(_global.__virtual_array))
        {
            _global.__virtual_array[_i].__tick();
            _i++;
        }
    }
    var _any_players_changed = false;
    var _connection_array = _global.__players_status.new_connections;
    var _disconnection_array = _global.__players_status.new_disconnections;
    var _status_array = _global.__players_status.players;
    array_resize(_connection_array, 0);
    array_resize(_disconnection_array, 0);
    _p = 0;
    repeat (4)
    {
        var _old_status = _status_array[_p];
        if (_global.__players[_p].__connected)
        {
            if (_old_status == UnknownEnum.Value_m1 || _old_status == UnknownEnum.Value_0)
            {
                _any_players_changed = true;
                _status_array[_p] = UnknownEnum.Value_1;
                array_push(_global.__players_status.new_connections, _p);
            }
            else
            {
                _status_array[_p] = UnknownEnum.Value_2;
            }
        }
        else if (_old_status == UnknownEnum.Value_1 || _old_status == UnknownEnum.Value_2)
        {
            _any_players_changed = true;
            _status_array[_p] = UnknownEnum.Value_m1;
            array_push(_global.__players_status.new_disconnections, _p);
        }
        else
        {
            _status_array[_p] = UnknownEnum.Value_0;
        }
        _p++;
    }
    _global.__players_status.any_changed = _any_players_changed;
    var _any_gamepads_changed = false;
    _connection_array = _global.__gamepads_status.new_connections;
    _disconnection_array = _global.__gamepads_status.new_disconnections;
    _status_array = _global.__gamepads_status.gamepads;
    array_resize(_connection_array, 0);
    array_resize(_disconnection_array, 0);
    var _device_count = gamepad_get_device_count();
    if (array_length(_status_array) != _device_count)
    {
        array_resize(_status_array, _device_count);
    }
    var _g = 0;
    repeat (_device_count)
    {
        var _old_status = _status_array[_g];
        if (input_gamepad_is_connected(_g))
        {
            if (_old_status == UnknownEnum.Value_m1 || _old_status == UnknownEnum.Value_0)
            {
                _any_gamepads_changed = true;
                _status_array[_g] = UnknownEnum.Value_1;
                array_push(_connection_array, _g);
            }
            else
            {
                _status_array[_g] = UnknownEnum.Value_2;
            }
        }
        else if (_old_status == UnknownEnum.Value_1 || _old_status == UnknownEnum.Value_2)
        {
            _any_gamepads_changed = true;
            _status_array[_g] = UnknownEnum.Value_m1;
            array_push(_disconnection_array, _g);
        }
        else
        {
            _status_array[_g] = UnknownEnum.Value_0;
        }
        _g++;
    }
    _global.__gamepads_status.any_changed = _any_gamepads_changed;
    switch (_global.__source_mode)
    {
        case UnknownEnum.Value_0:
            break;
        case UnknownEnum.Value_1:
            __input_multiplayer_assignment_tick();
            break;
        case UnknownEnum.Value_2:
            __input_hotswap_tick();
            break;
        case UnknownEnum.Value_3:
            break;
        case UnknownEnum.Value_4:
            break;
    }
}

enum UnknownEnum
{
    Value_m1 = -1,
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4
}
