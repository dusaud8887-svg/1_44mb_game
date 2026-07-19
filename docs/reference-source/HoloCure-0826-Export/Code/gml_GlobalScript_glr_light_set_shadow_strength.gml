function glr_light_set_shadow_strength(arg0, arg1)
{
    if (debug_mode)
    {
        if (!glr_debug_is_light(arg0))
        {
            show_message(global.GLR_ERROR_ARGUMENT_LIGHT);
        }
    }
    var light = arg0;
    ds_list_set(light, UnknownEnum.Value_24, clamp(arg1, 0, 1));
}

enum UnknownEnum
{
    Value_24 = 24
}
