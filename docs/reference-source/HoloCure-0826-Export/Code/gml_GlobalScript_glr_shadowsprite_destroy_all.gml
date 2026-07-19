function glr_shadowsprite_destroy_all()
{
    var size = ds_list_size(global.GLR_SPR_DYN_LIST);
    for (i = 0; i < size; i++)
    {
        var ss = ds_list_find_value(global.GLR_SPR_DYN_LIST, i);
        ds_list_destroy(ss);
    }
    ds_list_clear(global.GLR_SPR_DYN_LIST);
    size = ds_list_size(global.GLR_SPR_STC_LIST);
    for (i = 0; i < size; i++)
    {
        var ss = ds_list_find_value(global.GLR_SPR_STC_LIST, i);
        ds_list_destroy(ss);
    }
    ds_list_clear(global.GLR_SPR_STC_LIST);
}
