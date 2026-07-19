function glr_light_set_sprite(arg0, arg1, arg2)
{
    if (debug_mode)
    {
        if (!glr_debug_is_light(arg0))
        {
            show_message(global.GLR_ERROR_ARGUMENT_LIGHT);
        }
    }
    var l = arg0;
    if (arg1 != ds_list_find_value(l, UnknownEnum.Value_14))
    {
        var xscale = ds_list_find_value(l, UnknownEnum.Value_7);
        var yscale = ds_list_find_value(l, UnknownEnum.Value_8);
        var width = sprite_get_width(arg1);
        var height = sprite_get_height(arg1);
        var xo = sprite_get_xoffset(arg1);
        var yo = sprite_get_yoffset(arg1);
        ds_list_set(l, UnknownEnum.Value_9, xo);
        ds_list_set(l, UnknownEnum.Value_10, yo);
        var bcircle = max(point_distance(0, 0, xo, yo), point_distance(width, 0, xo, yo), point_distance(width, height, xo, yo), point_distance(0, height, xo, yo));
        ds_list_set(l, UnknownEnum.Value_17, bcircle);
        ds_list_set(l, UnknownEnum.Value_18, bcircle * max(xscale, yscale));
        var mtx_offset = matrix_build(-xo, -yo, 0, 0, 0, 0, width, height, 1);
        ds_list_delete(l, UnknownEnum.Value_26);
        ds_list_insert(l, UnknownEnum.Value_26, mtx_offset);
        ds_list_delete(l, UnknownEnum.Value_27);
        ds_list_insert(l, UnknownEnum.Value_27, matrix_multiply(mtx_offset, matrix_build(ds_list_find_value(l, UnknownEnum.Value_3), ds_list_find_value(l, UnknownEnum.Value_4), 0, 0, 0, ds_list_find_value(l, UnknownEnum.Value_5), ds_list_find_value(l, UnknownEnum.Value_7), ds_list_find_value(l, UnknownEnum.Value_8), 1)));
        ds_list_set(l, UnknownEnum.Value_14, arg1);
    }
    ds_list_set(l, UnknownEnum.Value_15, arg2);
}

enum UnknownEnum
{
    Value_3 = 3,
    Value_4,
    Value_5,
    Value_7 = 7,
    Value_8,
    Value_9,
    Value_10,
    Value_14 = 14,
    Value_15,
    Value_17 = 17,
    Value_18,
    Value_26 = 26,
    Value_27
}
