function glr_shadowsprite_set_static(arg0, arg1)
{
    var l = arg0;
    var is_static = ds_list_find_value(l, UnknownEnum.Value_1);
    if (is_static)
    {
        ds_list_delete(global.GLR_SPR_STC_LIST, ds_list_find_index(global.GLR_SPR_STC_LIST, l));
    }
    else
    {
        ds_list_delete(global.GLR_SPR_DYN_LIST, ds_list_find_index(global.GLR_SPR_DYN_LIST, l));
    }
    if (arg1)
    {
        ds_list_add(global.GLR_SPR_STC_LIST, l);
    }
    else
    {
        ds_list_add(global.GLR_SPR_DYN_LIST, l);
    }
    ds_list_set(l, UnknownEnum.Value_1, arg1);
}

enum UnknownEnum
{
    Value_1 = 1
}
