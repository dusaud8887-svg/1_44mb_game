function glr_light_destroy_all()
{
    var light_list_size = ds_list_size(global.GLR_LIGHT_LIST);
    for (var i = 0; i < light_list_size; i++)
    {
        var l_id = ds_list_find_value(global.GLR_LIGHT_LIST, i);
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
        ds_list_destroy(l_id);
    }
    ds_list_clear(global.GLR_LIGHT_LIST);
}

enum UnknownEnum
{
    Value_19 = 19,
    Value_20,
    Value_21,
    Value_22
}
