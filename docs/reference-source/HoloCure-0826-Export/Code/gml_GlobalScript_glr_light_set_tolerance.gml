function glr_light_set_tolerance(arg0, arg1)
{
    if (debug_mode)
    {
        if (!glr_debug_is_light(arg0))
        {
            show_message(global.GLR_ERROR_ARGUMENT_LIGHT);
        }
    }
    var l = arg0;
    ds_list_set(l, UnknownEnum.Value_25, arg1);
}

enum UnknownEnum
{
    Value_25 = 25
}
