function __input_load_sdl2_from_string(arg0)
{
    static _global = __input_global();
    
    __input_trace("Loading SDL2 database from string \"", arg0, "\"");
    var _result;
    if (_global.__use_legacy_strings)
    {
        var _buffer = buffer_create(string_byte_length(arg0) + 1, buffer_fixed, 1);
        buffer_write(_buffer, buffer_string, arg0);
        buffer_seek(_buffer, buffer_seek_start, 0);
        _result = __input_load_sdl2_from_buffer_legacy(_buffer);
        buffer_delete(_buffer);
    }
    else
    {
        _result = __input_load_sdl2_from_string_internal(arg0);
    }
    return _result;
}
