function glr_light_set_static(arg0, arg1)
{
    if (debug_mode)
    {
        if (!glr_debug_is_light(arg0))
        {
            show_message(global.GLR_ERROR_ARGUMENT_LIGHT);
        }
    }
    var l = arg0;
    var t_sur = ds_list_find_value(l, UnknownEnum.Value_20);
    if (t_sur != -1)
    {
        surface_free(t_sur);
        ds_list_set(l, UnknownEnum.Value_20, -1);
    }
    ds_list_set(l, UnknownEnum.Value_2, arg1);
}

enum UnknownEnum
{
    Value_2 = 2,
    Value_20 = 20
}
