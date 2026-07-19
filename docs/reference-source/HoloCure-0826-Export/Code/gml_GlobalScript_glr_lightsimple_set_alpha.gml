function glr_lightsimple_set_alpha(arg0, arg1)
{
    if (debug_mode)
    {
        if (!glr_debug_is_lightsimple(arg0))
        {
            show_message(global.GLR_ERROR_ARGUMENT_LIGHTSIMPLE);
        }
    }
    ds_list_set(arg0, UnknownEnum.Value_12, arg1);
}

enum UnknownEnum
{
    Value_12 = 12
}
