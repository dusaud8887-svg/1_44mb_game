function __input_class_virtual() constructor
{
    static __global = __input_global();
    
    static destroy = function()
    {
        __destroyed = true;
        __global.__virtual_order_dirty = true;
        return undefined;
    };
    
    static debug_draw = function()
    {
        if (__destroyed)
        {
            exit;
        }
        if (__active && is_struct(__global.__touch_player))
        {
            if (__circular == true)
            {
                draw_circle(__x, __y, __radius, true);
                draw_circle(__x, __y, __radius - 4, true);
                draw_circle(__x, __y, __radius - 8, !__held);
            }
            else if (__circular == false)
            {
                draw_rectangle(__left, __top, __right, __bottom, true);
                draw_rectangle(__left + 4, __top + 4, __right - 4, __bottom - 4, true);
                draw_rectangle(__left + 8, __top + 8, __right - 8, __bottom - 8, !__held);
            }
        }
        else
        {
            var _old_alpha = draw_get_alpha();
            draw_set_alpha(0.33 * _old_alpha);
            if (__circular == true)
            {
                draw_circle(__x, __y, __radius, true);
            }
            else if (__circular == false)
            {
                draw_rectangle(__left, __top, __right, __bottom, true);
            }
            draw_set_alpha(_old_alpha);
        }
    };
    
    static rectangle = function(arg0, arg1, arg2, arg3)
    {
        if (__destroyed || __background)
        {
            return self;
        }
        __circular = false;
        __left = arg0;
        __top = arg1;
        __right = arg2;
        __bottom = arg3;
        __width = (1 + arg2) - arg0;
        __height = (1 + arg3) - arg1;
        __x = 0.5 * (arg0 + arg2);
        __y = 0.5 * (arg3 + arg1);
        __radius = undefined;
        __start_x = __x;
        __start_y = __y;
        return self;
    };
    
    static circle = function(arg0, arg1, arg2)
    {
        if (__destroyed || __background)
        {
            return self;
        }
        __circular = true;
        __left = arg0 - arg2;
        __top = arg1 - arg2;
        __right = arg0 + arg2;
        __bottom = arg1 + arg2;
        __width = 2 * arg2;
        __height = 2 * arg2;
        __x = arg0;
        __y = arg1;
        __radius = arg2;
        __start_x = __x;
        __start_y = __y;
        return self;
    };
    
    static get_position = function()
    {
        static _struct = 
        {
            left: undefined,
            top: undefined,
            right: undefined,
            bottom: undefined,
            width: undefined,
            height: undefined,
            x: undefined,
            y: undefined,
            radius: undefined
        };
        
        _struct.left = __left;
        _struct.top = __top;
        _struct.right = __right;
        _struct.bottom = __bottom;
        _struct.width = __width;
        _struct.height = __height;
        _struct.x = __x;
        _struct.y = __y;
        _struct.radius = __radius;
        return _struct;
    };
    
    static button = function(arg0)
    {
        if (__destroyed || __background)
        {
            return self;
        }
        __type = UnknownEnum.Value_0;
        __verb_click = arg0;
        __verb_left = undefined;
        __verb_right = undefined;
        __verb_up = undefined;
        __verb_down = undefined;
        return self;
    };
    
    static dpad = function(arg0, arg1, arg2, arg3, arg4, arg5 = false)
    {
        if (__destroyed || __background)
        {
            return self;
        }
        __type = arg5 ? UnknownEnum.Value_1 : UnknownEnum.Value_2;
        __verb_click = arg0;
        __verb_left = arg1;
        __verb_right = arg2;
        __verb_up = arg3;
        __verb_down = arg4;
        return self;
    };
    
    static thumbstick = function(arg0, arg1, arg2, arg3, arg4)
    {
        if (__destroyed || __background)
        {
            return self;
        }
        __type = UnknownEnum.Value_3;
        __verb_click = arg0;
        __verb_left = arg1;
        __verb_right = arg2;
        __verb_up = arg3;
        __verb_down = arg4;
        return self;
    };
    
    static get_type = function()
    {
        return __type;
    };
    
    static get_verbs = function()
    {
        static _struct = 
        {
            click: undefined,
            left: undefined,
            right: undefined,
            up: undefined,
            down: undefined
        };
        
        _struct.click = __verb_click;
        _struct.left = __verb_left;
        _struct.right = __verb_right;
        _struct.up = __verb_up;
        _struct.down = __verb_down;
        return _struct;
    };
    
    static threshold = function(arg0, arg1)
    {
        if (__destroyed)
        {
            return self;
        }
        __threshold_min = arg0;
        __threshold_max = arg1;
        return self;
    };
    
    static get_threshold = function()
    {
        static _struct = 
        {
            mini: undefined,
            maxi: undefined
        };
        
        _struct.mini = __threshold_min;
        _struct.maxi = __threshold_max;
        return _struct;
    };
    
    static active = function(arg0)
    {
        if (__destroyed)
        {
            return self;
        }
        if (!arg0 && __active)
        {
            __clear_state();
        }
        __active = arg0;
        return self;
    };
    
    static get_active = function()
    {
        return __active;
    };
    
    static priority = function(arg0)
    {
        if (__destroyed)
        {
            return self;
        }
        if (__priority != arg0)
        {
            __priority = arg0;
            __global.__virtual_order_dirty = true;
        }
        return self;
    };
    
    static get_priority = function()
    {
        return __priority;
    };
    
    static follow = function(arg0)
    {
        if (__destroyed)
        {
            return self;
        }
        __follow = arg0;
        return self;
    };
    
    static get_follow = function()
    {
        return __follow;
    };
    
    static release_behavior = function(arg0)
    {
        __release_behavior = arg0;
        return self;
    };
    
    static get_release_behavior = function()
    {
        return __release_behavior;
    };
    
    static first_touch_only = function(arg0)
    {
        if (arg0 && __touch_device > 0)
        {
            __clear_state();
        }
        __first_touch_only = arg0;
        return self;
    };
    
    static get_first_touch_only = function()
    {
        return __first_touch_only;
    };
    
    static pressed = function()
    {
        if (__destroyed)
        {
            return false;
        }
        return __pressed;
    };
    
    static check = function()
    {
        if (__destroyed)
        {
            return false;
        }
        return __held;
    };
    
    static released = function()
    {
        if (__destroyed)
        {
            return false;
        }
        return __released;
    };
    
    static get_x = function()
    {
        if (__destroyed)
        {
            return 0;
        }
        return __normalized_x;
    };
    
    static get_y = function()
    {
        if (__destroyed)
        {
            return 0;
        }
        return __normalized_y;
    };
    
    static get_touch_x = function()
    {
        if (__destroyed)
        {
            return undefined;
        }
        return __touch_x;
    };
    
    static get_touch_y = function()
    {
        if (__destroyed)
        {
            return undefined;
        }
        return __touch_y;
    };
    
    static get_touch_start_x = function()
    {
        if (__destroyed)
        {
            return undefined;
        }
        return __touch_start_x;
    };
    
    static get_touch_start_y = function()
    {
        if (__destroyed)
        {
            return undefined;
        }
        return __touch_start_y;
    };
    
    static record_history = function(arg0)
    {
        if (__destroyed)
        {
            return undefined;
        }
        __record_history = arg0;
        if (__record_history != is_array(__history_array))
        {
            if (__record_history)
            {
                __history_array = array_create(10, undefined);
                var _i = 0;
                repeat (10)
                {
                    __history_array[_i] = 
                    {
                        x: undefined,
                        y: undefined
                    };
                    _i++;
                }
            }
            else
            {
                __history_array = undefined;
            }
        }
        return self;
    };
    
    static get_history = function()
    {
        if (__destroyed)
        {
            return undefined;
        }
        return __history_array;
    };
    
    static get_history_direction = function(arg0 = 10)
    {
        if (__destroyed)
        {
            return undefined;
        }
        if (arg0 <= 0)
        {
            __input_error("Number of sampling frames must be 1 or greater");
            return undefined;
        }
        if (arg0 > 10)
        {
            __input_error("Number of sampling frames (", arg0, ") cannot exceed INPUT_TOUCH_HISTORY_FRAMES (", 10, ")");
            return undefined;
        }
        __input_error("This features has not yet been implement");
        return undefined;
    };
    
    static get_history_distance = function(arg0 = 10)
    {
        if (__destroyed)
        {
            return undefined;
        }
        if (arg0 <= 0)
        {
            __input_error("Number of sampling frames must be 1 or greater");
            return undefined;
        }
        if (arg0 > 10)
        {
            __input_error("Number of sampling frames (", arg0, ") cannot exceed INPUT_TOUCH_HISTORY_FRAMES (", 10, ")");
            return undefined;
        }
        __input_error("This features has not yet been implement");
        return undefined;
    };
    
    static get_history_speed = function(arg0 = 10)
    {
        if (__destroyed)
        {
            return undefined;
        }
        return get_history_distance(arg0) / arg0;
    };
    
    static __set_as_background = function()
    {
        __background = true;
        return self;
    };
    
    static __clear_state = function()
    {
        __touch_device = undefined;
        __pressed = false;
        __held = false;
        __released = false;
        __normalized_x = 0;
        __normalized_y = 0;
        __touch_x = undefined;
        __touch_y = undefined;
        __touch_start_x = undefined;
        __touch_start_y = undefined;
        if (__record_history)
        {
            var _i = 0;
            repeat (10)
            {
                with (__history_array[_i])
                {
                    x = undefined;
                    y = undefined;
                }
                _i++;
            }
        }
        if (__release_behavior == UnknownEnum.Value_2)
        {
            if (__start_x != undefined && __start_y != undefined)
            {
                var _dx = __start_x - __x;
                var _dy = __start_y - __y;
                __left += _dx;
                __top += _dy;
                __right += _dx;
                __bottom += _dy;
                __x = __start_x;
                __y = __start_y;
            }
        }
        else if (__release_behavior == UnknownEnum.Value_1)
        {
            destroy();
        }
    };
    
    static __capture_touchpoint = function(arg0)
    {
        if (__touch_device != undefined)
        {
            return false;
        }
        if (__circular == undefined)
        {
            return false;
        }
        if (!__active)
        {
            return false;
        }
        if (__first_touch_only && arg0 > 0)
        {
            return false;
        }
        var _touch_x = device_mouse_x_to_gui(arg0);
        var _touch_y = device_mouse_y_to_gui(arg0);
        var _over;
        if (__circular)
        {
            _over = point_in_circle(_touch_x, _touch_y, __x, __y, __radius);
        }
        else
        {
            _over = point_in_rectangle(_touch_x, _touch_y, __left, __top, __right, __bottom);
        }
        if (_over)
        {
            __touch_start_x = _touch_x;
            __touch_start_y = _touch_y;
            __touch_device = arg0;
            __captured_this_frame = true;
            __pressed = true;
            __held = true;
            __released = false;
        }
        return _over;
    };
    
    static __tick = function()
    {
        if (__destroyed)
        {
            return undefined;
        }
        if (__touch_device == undefined)
        {
            return undefined;
        }
        if (__released)
        {
            __clear_state();
            if (__destroyed)
            {
                return undefined;
            }
        }
        if (__captured_this_frame)
        {
            __captured_this_frame = false;
        }
        else
        {
            __pressed = false;
            if (__held)
            {
                if (device_mouse_check_button(__touch_device, mb_left))
                {
                    var _player = __global.__touch_player;
                    _player.__verb_set_from_virtual(__verb_click, 1, 1, false);
                    if (__record_history)
                    {
                        var _last_coord = __history_array[9];
                        _last_coord.x = __touch_x;
                        _last_coord.y = __touch_y;
                        array_delete(__history_array, 9, 1);
                        array_insert(__history_array, _last_coord);
                    }
                    __touch_x = device_mouse_x_to_gui(__touch_device);
                    __touch_y = device_mouse_y_to_gui(__touch_device);
                    var _dx = __touch_x - __x;
                    var _dy = __touch_y - __y;
                    var _length = (_dx * _dx) + (_dy * _dy);
                    var _threshold_factor;
                    if (_length <= 0)
                    {
                        _threshold_factor = 0;
                        __normalized_x = 0;
                        __normalized_y = 0;
                    }
                    else
                    {
                        _length = sqrt(_length);
                        _threshold_factor = clamp((_length - __threshold_min) / (__threshold_max - __threshold_min), 0, 1) / _length;
                        __normalized_x = _threshold_factor * _dx;
                        __normalized_y = _threshold_factor * _dy;
                        if (__follow)
                        {
                            var _move_x = 0;
                            var _move_y = 0;
                            if (__circular == true)
                            {
                                var _move_distance = max(0, _length - __radius);
                                _move_x = (_move_distance * _dx) / _length;
                                _move_y = (_move_distance * _dy) / _length;
                            }
                            else if (__circular == false)
                            {
                                var _dLeft = min(0, __touch_x - __left);
                                var _dTop = min(0, __touch_y - __top);
                                var _dRight = max(0, __touch_x - __right);
                                var _dBottom = max(0, __touch_y - __bottom);
                                _move_x += (_dLeft + _dRight);
                                _move_y += (_dTop + _dBottom);
                            }
                            __x += _move_x;
                            __y += _move_y;
                            __left += _move_x;
                            __top += _move_y;
                            __right += _move_x;
                            __bottom += _move_y;
                        }
                    }
                    if (__type == UnknownEnum.Value_1)
                    {
                        if (_threshold_factor > 0)
                        {
                            var _direction = floor((point_direction(0, 0, __normalized_x, __normalized_y) + 45) / 90) % 4;
                            if (_direction == 0)
                            {
                                _player.__verb_set_from_virtual(__verb_right, 1, 1, false);
                            }
                            else if (_direction == 1)
                            {
                                _player.__verb_set_from_virtual(__verb_up, 1, 1, false);
                            }
                            else if (_direction == 2)
                            {
                                _player.__verb_set_from_virtual(__verb_left, 1, 1, false);
                            }
                            else if (_direction == 3)
                            {
                                _player.__verb_set_from_virtual(__verb_down, 1, 1, false);
                            }
                        }
                    }
                    else if (__type == UnknownEnum.Value_2)
                    {
                        if (_threshold_factor > 0)
                        {
                            var _direction = floor((point_direction(0, 0, __normalized_x, __normalized_y) + 22.5) / 45) % 8;
                            if (_direction == 0)
                            {
                                _player.__verb_set_from_virtual(__verb_right, 1, 1, false);
                            }
                            else if (_direction == 1)
                            {
                                _player.__verb_set_from_virtual(__verb_right, 1, 1, false);
                                _player.__verb_set_from_virtual(__verb_up, 1, 1, false);
                            }
                            else if (_direction == 2)
                            {
                                _player.__verb_set_from_virtual(__verb_up, 1, 1, false);
                            }
                            else if (_direction == 3)
                            {
                                _player.__verb_set_from_virtual(__verb_up, 1, 1, false);
                                _player.__verb_set_from_virtual(__verb_left, 1, 1, false);
                            }
                            else if (_direction == 4)
                            {
                                _player.__verb_set_from_virtual(__verb_left, 1, 1, false);
                            }
                            else if (_direction == 5)
                            {
                                _player.__verb_set_from_virtual(__verb_left, 1, 1, false);
                                _player.__verb_set_from_virtual(__verb_down, 1, 1, false);
                            }
                            else if (_direction == 6)
                            {
                                _player.__verb_set_from_virtual(__verb_down, 1, 1, false);
                            }
                            else if (_direction == 7)
                            {
                                _player.__verb_set_from_virtual(__verb_down, 1, 1, false);
                                _player.__verb_set_from_virtual(__verb_right, 1, 1, false);
                            }
                        }
                    }
                    else if (__type == UnknownEnum.Value_3)
                    {
                        _player.__verb_set_from_virtual(__verb_left, max(0, -_dx), max(0, -__normalized_x), true);
                        _player.__verb_set_from_virtual(__verb_right, max(0, _dx), max(0, __normalized_x), true);
                        _player.__verb_set_from_virtual(__verb_up, max(0, -_dy), max(0, -__normalized_y), true);
                        _player.__verb_set_from_virtual(__verb_down, max(0, _dy), max(0, __normalized_y), true);
                    }
                }
                else
                {
                    __pressed = false;
                    __held = false;
                    __released = true;
                }
            }
        }
    };
    
    array_push(__global.__virtual_array, self);
    __global.__virtual_order_dirty = true;
    __destroyed = false;
    __background = false;
    __circular = undefined;
    __left = undefined;
    __top = undefined;
    __right = undefined;
    __bottom = undefined;
    __width = undefined;
    __height = undefined;
    __x = undefined;
    __y = undefined;
    __radius = undefined;
    __start_x = undefined;
    __start_y = undefined;
    __type = UnknownEnum.Value_0;
    __verb_click = undefined;
    __verb_left = undefined;
    __verb_right = undefined;
    __verb_up = undefined;
    __verb_down = undefined;
    __4dir = false;
    __threshold_min = 50;
    __threshold_max = 100;
    __release_behavior = UnknownEnum.Value_0;
    __active = true;
    __priority = 0;
    __follow = false;
    __record_history = false;
    __first_touch_only = false;
    __touch_device = undefined;
    __pressed = false;
    __held = false;
    __released = false;
    __normalized_x = 0;
    __normalized_y = 0;
    __touch_x = undefined;
    __touch_y = undefined;
    __touch_start_x = undefined;
    __touch_start_y = undefined;
    __history_array = undefined;
    __captured_this_frame = false;
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3
}
