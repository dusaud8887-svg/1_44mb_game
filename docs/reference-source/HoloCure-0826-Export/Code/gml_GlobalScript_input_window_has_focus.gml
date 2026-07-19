function input_window_has_focus()
{
    static _global = __input_global();
    
    return _global.__window_focus && !os_is_paused();
}
