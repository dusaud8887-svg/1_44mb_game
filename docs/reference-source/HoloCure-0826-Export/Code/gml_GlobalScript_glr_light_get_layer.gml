function glr_light_get_layer(arg0)
{
    if (debug_mode)
    {
        if (!glr_debug_is_light(arg0))
        {
            show_message(global.GLR_ERROR_ARGUMENT_LIGHT);
        }
    }
    return ds_list_find_value(arg0, UnknownEnum.Value_16);
}

enum UnknownEnum
{
    Value_16 = 16
}
