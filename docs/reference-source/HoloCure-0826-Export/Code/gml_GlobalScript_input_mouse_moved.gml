function input_mouse_moved()
{
    static _global = __input_global();
    
    return _global.__mouse_allowed_on_platform && _global.__pointer_moved;
}
