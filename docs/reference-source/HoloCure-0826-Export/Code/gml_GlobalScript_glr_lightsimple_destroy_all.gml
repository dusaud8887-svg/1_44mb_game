function glr_lightsimple_destroy_all()
{
    var light_list_size = ds_list_size(global.GLR_LIGHT_LIST_SIMPLE);
    for (i = 0; i < light_list_size; i++)
    {
        var l_id = ds_list_find_value(global.GLR_LIGHT_LIST_SIMPLE, i);
        ds_list_destroy(l_id);
    }
    ds_list_clear(global.GLR_LIGHT_LIST_SIMPLE);
}
