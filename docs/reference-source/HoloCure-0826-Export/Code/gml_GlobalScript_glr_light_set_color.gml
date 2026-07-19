function glr_light_set_color(arg0, arg1)
{
    var light = arg0;
    if (debug_mode)
    {
        if (!glr_debug_is_light(arg0))
        {
            show_message(global.GLR_ERROR_ARGUMENT_LIGHT);
        }
    }
    ds_list_set(light, UnknownEnum.Value_11, arg1);
}

enum UnknownEnum
{
    Value_11 = 11
}
