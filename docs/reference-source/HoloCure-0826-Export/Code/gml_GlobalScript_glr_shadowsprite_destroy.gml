function glr_shadowsprite_destroy(arg0)
{
    if (ds_list_find_value(arg0, UnknownEnum.Value_1))
    {
        ds_list_delete(global.GLR_SPR_STC_LIST, ds_list_find_index(global.GLR_SPR_DYN_LIST, arg0));
    }
    else
    {
        ds_list_delete(global.GLR_SPR_DYN_LIST, ds_list_find_index(global.GLR_SPR_DYN_LIST, arg0));
    }
    ds_list_destroy(arg0);
}

enum UnknownEnum
{
    Value_1 = 1
}
