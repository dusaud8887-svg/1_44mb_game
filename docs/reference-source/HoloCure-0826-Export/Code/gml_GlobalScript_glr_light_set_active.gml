function glr_light_set_active(arg0, arg1)
{
    var l = arg0;
    if (debug_mode)
    {
        if (!glr_debug_is_light(arg0))
        {
            show_message(global.GLR_ERROR_ARGUMENT_LIGHT);
        }
    }
    ds_list_set(l, UnknownEnum.Value_1, arg1);
}

enum UnknownEnum
{
    Value_1 = 1
}
