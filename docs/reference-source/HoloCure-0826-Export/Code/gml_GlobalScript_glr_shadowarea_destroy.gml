function glr_shadowarea_destroy(arg0)
{
    var l = arg0;
    vertex_delete_buffer(ds_list_find_value(l, UnknownEnum.Value_1));
    ds_list_delete(global.GLR_SHADOWAREA_LIST, ds_list_find_index(global.GLR_SHADOWAREA_LIST, l));
    ds_list_destroy(l);
}

enum UnknownEnum
{
    Value_1 = 1
}
