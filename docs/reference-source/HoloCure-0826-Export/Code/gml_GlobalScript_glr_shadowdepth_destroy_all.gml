function glr_shadowdepth_destroy_all()
{
    var size = ds_list_size(global.GLR_DEP_DYN_LIST);
    for (var i = 0; i < size; i++)
    {
        var ss = ds_list_find_value(global.GLR_DEP_DYN_LIST, i);
        ds_list_destroy(ss);
    }
    ds_list_clear(global.GLR_DEP_DYN_LIST);
}
