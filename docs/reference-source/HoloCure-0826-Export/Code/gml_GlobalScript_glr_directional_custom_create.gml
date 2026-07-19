function glr_directional_custom_create(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
{
    var l = ds_list_create();
    ds_list_set(l, UnknownEnum.Value_1, true);
    ds_list_set(l, UnknownEnum.Value_0, UnknownEnum.Value_4);
    ds_list_set(l, UnknownEnum.Value_3, arg0);
    ds_list_set(l, UnknownEnum.Value_4, arg1);
    ds_list_set(l, UnknownEnum.Value_5, arg2);
    ds_list_set(l, UnknownEnum.Value_6, arg3);
    ds_list_set(l, UnknownEnum.Value_7, 1);
    ds_list_set(l, UnknownEnum.Value_8, arg4);
    ds_list_set(l, UnknownEnum.Value_9, arg5);
    glr_directional_custom_set_depth(l, arg6);
    ds_list_set(l, UnknownEnum.Value_10, arg7);
    ds_list_set(l, UnknownEnum.Value_11, arg8);
    ds_list_set(l, UnknownEnum.Value_12, arg9);
    var width = sprite_get_width(arg0);
    var height = sprite_get_height(arg0);
    var xo = sprite_get_xoffset(arg0);
    var yo = sprite_get_yoffset(arg0);
    ds_list_set(l, UnknownEnum.Value_13, max(point_distance(0, 0, xo, yo), point_distance(width, 0, xo, yo), point_distance(width, height, xo, yo), point_distance(0, height, xo, yo)));
    ds_list_add(global.GLR_DIR_CUSTOM_LIST, l);
    return l;
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_3 = 3,
    Value_4,
    Value_5,
    Value_6,
    Value_7,
    Value_8,
    Value_9,
    Value_10,
    Value_11,
    Value_12,
    Value_13
}
