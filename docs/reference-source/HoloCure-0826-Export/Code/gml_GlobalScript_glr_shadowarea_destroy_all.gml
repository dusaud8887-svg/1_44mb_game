function glr_shadowarea_destroy_all()
{
    var sz = ds_list_size(global.GLR_SHADOWAREA_LIST);
    for (var i = 0; i < sz; i++)
    {
        var l = ds_list_find_value(global.GLR_SHADOWAREA_LIST, i);
        buffer_delete(ds_list_find_value(l, UnknownEnum.Value_1));
        ds_list_destroy(l);
    }
    ds_list_clear(global.GLR_SHADOWAREA_LIST);
}

enum UnknownEnum
{
    Value_1 = 1
}
