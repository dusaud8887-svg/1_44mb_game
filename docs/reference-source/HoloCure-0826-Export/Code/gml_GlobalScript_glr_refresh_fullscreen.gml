function glr_refresh_fullscreen()
{
    var light_list_size = ds_list_size(global.GLR_LIGHT_LIST);
    for (var i = 0; i < light_list_size; i++)
    {
        var l_id = ds_list_find_value(global.GLR_LIGHT_LIST, i);
        ds_list_set(l_id, UnknownEnum.Value_23, false);
    }
}

enum UnknownEnum
{
    Value_23 = 23
}
