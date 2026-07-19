function glr_lightsimple_destroy(arg0)
{
    if (debug_mode)
    {
        if (!glr_debug_is_lightsimple(arg0))
        {
            show_message(global.GLR_ERROR_ARGUMENT_LIGHTSIMPLE);
        }
    }
    ds_list_delete(global.GLR_LIGHT_LIST_SIMPLE, ds_list_find_index(global.GLR_LIGHT_LIST_SIMPLE, arg0));
    ds_list_destroy(arg0);
}
