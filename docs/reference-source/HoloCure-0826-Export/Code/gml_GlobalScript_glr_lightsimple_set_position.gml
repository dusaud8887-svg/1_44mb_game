function glr_lightsimple_set_position(arg0, arg1, arg2)
{
    if (debug_mode)
    {
        if (!glr_debug_is_lightsimple(arg0))
        {
            show_message(global.GLR_ERROR_ARGUMENT_LIGHTSIMPLE);
        }
    }
    ds_list_set(arg0, UnknownEnum.Value_3, arg1);
    ds_list_set(arg0, UnknownEnum.Value_4, arg2);
}

enum UnknownEnum
{
    Value_3 = 3,
    Value_4
}
