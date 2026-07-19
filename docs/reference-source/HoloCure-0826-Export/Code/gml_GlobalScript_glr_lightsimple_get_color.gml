function glr_lightsimple_get_color(arg0)
{
    if (debug_mode)
    {
        if (!glr_debug_is_lightsimple(arg0))
        {
            show_message(global.GLR_ERROR_ARGUMENT_LIGHTSIMPLE);
        }
    }
    return ds_list_find_value(arg0, UnknownEnum.Value_11);
}

enum UnknownEnum
{
    Value_11 = 11
}
