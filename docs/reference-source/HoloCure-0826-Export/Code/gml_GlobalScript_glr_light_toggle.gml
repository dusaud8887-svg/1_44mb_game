function glr_light_toggle(arg0)
{
    var light = arg0;
    if (debug_mode)
    {
        if (!glr_debug_is_light(arg0))
        {
            show_message(global.GLR_ERROR_ARGUMENT_LIGHT);
        }
    }
    ds_list_set(light, UnknownEnum.Value_1, !ds_list_find_value(light, UnknownEnum.Value_1));
}

enum UnknownEnum
{
    Value_1 = 1
}
