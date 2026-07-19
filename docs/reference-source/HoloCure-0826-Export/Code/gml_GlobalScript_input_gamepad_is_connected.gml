function input_gamepad_is_connected(arg0)
{
    static _global = __input_global();
    
    if (arg0 == undefined || arg0 < 0 || arg0 >= array_length(_global.__gamepads))
    {
        return false;
    }
    if (!is_struct(_global.__gamepads[arg0]))
    {
        return false;
    }
    return gamepad_is_connected(arg0);
}
