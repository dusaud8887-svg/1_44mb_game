function __input_gamepad_find_in_sdl2_database()
{
    static _global = __input_global();
    
    if (!(!(false || os_type == os_gxgames) && ((os_type == os_macosx || os_type == os_linux || os_type == os_windows) || os_type == os_android)) || 0 || blacklisted || xinput)
    {
        exit;
    }
    var _guid_dict = _global.__sdl2_database.by_guid;
    if (variable_struct_exists(_guid_dict, guid))
    {
        _definition = variable_struct_get(_guid_dict, guid);
        sdl2_definition = _definition;
        description = _definition[1];
        exit;
    }
    var _definition = undefined;
    var _description_array = variable_struct_get(_global.__sdl2_database.by_description, string_copy(guid, 1, 20));
    if (is_array(_description_array))
    {
        if (array_length(_description_array) > 0)
        {
            _definition = _description_array[0];
        }
    }
    else
    {
        var _vp_array = variable_struct_get(_global.__sdl2_database.by_vendor_product, vendor + product);
        if (is_array(_vp_array))
        {
            if (array_length(_vp_array) > 0)
            {
                _definition = _vp_array[0];
            }
        }
    }
    if (is_array(_definition))
    {
        sdl2_definition = _definition;
        description = _definition[1];
    }
    else
    {
        __input_trace("Warning! No SDL definition found for ", guid, " (vendor=", vendor, ", product=", product, ")");
        sdl2_definition = undefined;
    }
}
