function glr_light_destroy(arg0)
{
    var l_id = arg0;
    if (debug_mode)
    {
        if (!glr_debug_is_light(arg0))
        {
            show_message(global.GLR_ERROR_ARGUMENT_LIGHT);
        }
    }
    var s1 = ds_list_find_value(l_id, UnknownEnum.Value_19);
    if (surface_exists(s1))
    {
        surface_free(s1);
    }
    var s2 = ds_list_find_value(l_id, UnknownEnum.Value_20);
    if (surface_exists(s2))
    {
        surface_free(s2);
    }
    var s3 = ds_list_find_value(l_id, UnknownEnum.Value_21);
    if (surface_exists(s3))
    {
        surface_free(s3);
    }
    var s4 = ds_list_find_value(l_id, UnknownEnum.Value_22);
    if (surface_exists(s4))
    {
        surface_free(s4);
    }
    ds_list_delete(global.GLR_LIGHT_LIST, ds_list_find_index(global.GLR_LIGHT_LIST, arg0));
    ds_list_delete(l_id, UnknownEnum.Value_27);
    ds_list_delete(l_id, UnknownEnum.Value_26);
    ds_list_destroy(l_id);
}

enum UnknownEnum
{
    Value_19 = 19,
    Value_20,
    Value_21,
    Value_22,
    Value_26 = 26,
    Value_27
}
