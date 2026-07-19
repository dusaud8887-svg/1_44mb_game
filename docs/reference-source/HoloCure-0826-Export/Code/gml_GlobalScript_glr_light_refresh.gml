function glr_light_refresh(arg0)
{
    if (debug_mode)
    {
        if (!glr_debug_is_light(arg0))
        {
            show_message(global.GLR_ERROR_ARGUMENT_LIGHT);
        }
    }
    var t_sur = ds_list_find_value(arg0, UnknownEnum.Value_20);
    if (t_sur != -1)
    {
        surface_free(t_sur);
        ds_list_set(arg0, UnknownEnum.Value_20, -1);
    }
}

enum UnknownEnum
{
    Value_20 = 20
}
