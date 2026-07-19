function glr_light_create(arg0, arg1, arg2, arg3, arg4, arg5)
{
    var l = ds_list_create();
    repeat (UnknownEnum.Value_29)
    {
        ds_list_add(l, 0);
    }
    ds_list_set(l, UnknownEnum.Value_0, UnknownEnum.Value_0);
    ds_list_set(l, UnknownEnum.Value_1, true);
    ds_list_set(l, UnknownEnum.Value_2, false);
    ds_list_set(l, UnknownEnum.Value_3, arg2);
    ds_list_set(l, UnknownEnum.Value_4, arg3);
    ds_list_set(l, UnknownEnum.Value_5, 0);
    ds_list_set(l, UnknownEnum.Value_7, 1);
    ds_list_set(l, UnknownEnum.Value_8, 1);
    var intensity = max(0, arg5);
    ds_list_set(l, UnknownEnum.Value_11, arg4);
    ds_list_set(l, UnknownEnum.Value_13, intensity);
    ds_list_set(l, UnknownEnum.Value_14, arg0);
    ds_list_set(l, UnknownEnum.Value_15, arg1);
    ds_list_set(l, UnknownEnum.Value_16, 0);
    ds_list_set(l, UnknownEnum.Value_6, 50000);
    var width = sprite_get_width(arg0);
    var height = sprite_get_height(arg0);
    var xo = sprite_get_xoffset(arg0);
    var yo = sprite_get_yoffset(arg0);
    ds_list_set(l, UnknownEnum.Value_9, xo);
    ds_list_set(l, UnknownEnum.Value_10, yo);
    var bcircle = max(point_distance(0, 0, xo, yo), point_distance(width, 0, xo, yo), point_distance(width, height, xo, yo), point_distance(0, height, xo, yo));
    ds_list_set(l, UnknownEnum.Value_17, bcircle);
    ds_list_set(l, UnknownEnum.Value_18, bcircle);
    var _depth_setting = surface_get_depth_disable();
    surface_depth_disable(false);
    ds_list_set(l, UnknownEnum.Value_19, surface_create(width, height));
    ds_list_set(l, UnknownEnum.Value_20, -1);
    ds_list_set(l, UnknownEnum.Value_21, surface_create(width, height));
    ds_list_set(l, UnknownEnum.Value_22, surface_create(width, height));
    surface_depth_disable(_depth_setting);
    ds_list_set(l, UnknownEnum.Value_23, false);
    ds_list_set(l, UnknownEnum.Value_24, 1);
    ds_list_set(l, UnknownEnum.Value_25, 10);
    var mtx_offset = matrix_build(-xo, -yo, 0, 0, 0, 0, width, height, 1);
    ds_list_set(l, UnknownEnum.Value_26, 0);
    ds_list_set(l, UnknownEnum.Value_27, 0);
    ds_list_delete(l, UnknownEnum.Value_26);
    ds_list_insert(l, UnknownEnum.Value_26, mtx_offset);
    ds_list_delete(l, UnknownEnum.Value_27);
    ds_list_insert(l, UnknownEnum.Value_27, matrix_multiply(mtx_offset, matrix_build(arg2, arg3, 0, 0, 0, 0, 1, 1, 1)));
    ds_list_set(l, UnknownEnum.Value_28, false);
    ds_list_add(global.GLR_LIGHT_LIST, l);
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
    Value_10,
    Value_11,
    Value_13 = 13,
    Value_14,
    Value_15,
    Value_16,
    Value_17,
    Value_18,
    Value_19,
    Value_20,
    Value_21,
    Value_22,
    Value_23,
    Value_24,
    Value_25,
    Value_26,
    Value_27,
    Value_28,
    Value_29
}
