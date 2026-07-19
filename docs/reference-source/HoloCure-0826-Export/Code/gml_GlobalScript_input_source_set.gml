function input_source_set(arg0, arg1 = 0, arg2 = true, arg3 = true)
{
    static _global = __input_global();
    
    if (arg1 < 0)
    {
        __input_error("Invalid player index provided (", arg1, ")");
        return undefined;
    }
    if (arg1 >= 4)
    {
        __input_error("Player index too large (", arg1, " must be less than ", 4, ")\nIncrease INPUT_MAX_PLAYERS to support more players");
        return undefined;
    }
    if (arg0 == -3)
    {
        if (arg3)
        {
            input_source_clear(-3);
        }
        with (_global.__players[arg1])
        {
            __source_add(__input_global().__source_keyboard);
            __source_add((1 && ((os_type == os_android || (os_type == os_ios || os_type == os_tvos)) || os_type == os_switch || (false && os_type == os_windows))) ? __input_global().__source_touch : __input_global().__source_mouse);
            var _i = 0;
            repeat (12)
            {
                __source_add(__input_global().__source_gamepad[_i]);
                _i++;
            }
            if (arg2)
            {
                __profile_set_auto();
            }
        }
        exit;
    }
    if (_global.__use_is_instanceof)
    {
        if (!is_instanceof(arg0, __input_class_source))
        {
            __input_error("Invalid source provided (", arg0, ")");
        }
    }
    else if (instanceof(arg0) != "__input_class_source")
    {
        __input_error("Invalid source provided (", arg0, ")");
    }
    if (arg0 == __input_global().__source_keyboard)
    {
        if (!_global.__any_keyboard_binding_defined && !_global.__any_mouse_binding_defined)
        {
            __input_error("Cannot claim ", arg0, ", no keyboard or mouse bindings have been created in a default profile (see __input_config_verbs_and_bindings())");
        }
    }
    else if (arg0 == __input_global().__source_mouse)
    {
        if (!_global.__any_mouse_binding_defined)
        {
            __input_error("Cannot claim ", arg0, ", no mouse bindings have been created in a default profile (see __input_config_verbs_and_bindings())");
        }
    }
    else if (arg0 == __input_global().__source_touch)
    {
        if (!_global.__any_touch_binding_defined)
        {
            __input_error("Cannot claim ", arg0, ", no virtual button bindings have been created in a default profile (see __input_config_verbs_and_bindings())");
        }
    }
    else if (arg0.__source == UnknownEnum.Value_2)
    {
        if (!_global.__any_gamepad_binding_defined)
        {
            __input_error("Cannot claim ", arg0, ", no gamepad bindings have been created in a default profile (see __input_config_verbs_and_bindings())");
        }
    }
    if (arg3)
    {
        __input_source_relinquish(arg0);
    }
    with (_global.__players[arg1])
    {
        __sources_clear();
        __source_add(arg0);
        if (arg2)
        {
            __profile_set_auto();
        }
    }
}

enum UnknownEnum
{
    Value_2 = 2
}
