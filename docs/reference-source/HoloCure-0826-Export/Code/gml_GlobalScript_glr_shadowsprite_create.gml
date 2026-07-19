function glr_shadowsprite_create(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
{
    var l = ds_list_create();
    ds_list_set(l, UnknownEnum.Value_0, true);
    ds_list_set(l, UnknownEnum.Value_2, 0);
    ds_list_set(l, UnknownEnum.Value_1, arg7);
    ds_list_set(l, UnknownEnum.Value_3, arg0);
    ds_list_set(l, UnknownEnum.Value_4, arg1);
    ds_list_set(l, UnknownEnum.Value_5, arg2);
    ds_list_set(l, UnknownEnum.Value_6, arg3);
    ds_list_set(l, UnknownEnum.Value_7, arg4);
    ds_list_set(l, UnknownEnum.Value_8, arg5);
    ds_list_set(l, UnknownEnum.Value_9, arg6);
    var width = sprite_get_width(arg0);
    var height = sprite_get_height(arg0);
    var xo = sprite_get_xoffset(arg0);
    var yo = sprite_get_yoffset(arg0);
    ds_list_set(l, UnknownEnum.Value_11, max(point_distance(0, 0, xo, yo), point_distance(width, 0, xo, yo), point_distance(width, height, xo, yo), point_distance(0, height, xo, yo)));
    if (arg7)
    {
        ds_list_add(global.GLR_SPR_STC_LIST, l);
    }
    else
    {
        ds_list_add(global.GLR_SPR_DYN_LIST, l);
    }
    return l;
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4,
    Value_5,
    Value_6,
    Value_7,
    Value_8,
    Value_9,
    Value_11 = 11
}
