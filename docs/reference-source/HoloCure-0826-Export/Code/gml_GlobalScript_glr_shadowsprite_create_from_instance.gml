function glr_shadowsprite_create_from_instance(arg0)
{
    var l = ds_list_create();
    ds_list_set(l, UnknownEnum.Value_0, true);
    ds_list_set(l, UnknownEnum.Value_2, 0);
    ds_list_set(l, UnknownEnum.Value_1, arg0);
    ds_list_set(l, UnknownEnum.Value_3, sprite_index);
    ds_list_set(l, UnknownEnum.Value_4, image_index);
    ds_list_set(l, UnknownEnum.Value_5, x);
    ds_list_set(l, UnknownEnum.Value_6, y);
    ds_list_set(l, UnknownEnum.Value_7, image_xscale);
    ds_list_set(l, UnknownEnum.Value_8, image_yscale);
    ds_list_set(l, UnknownEnum.Value_9, image_angle);
    var width = sprite_get_width(sprite_index);
    var height = sprite_get_height(sprite_index);
    var xo = sprite_get_xoffset(sprite_index);
    var yo = sprite_get_yoffset(sprite_index);
    ds_list_set(l, UnknownEnum.Value_11, max(point_distance(0, 0, xo, yo), point_distance(width, 0, xo, yo), point_distance(width, height, xo, yo), point_distance(0, height, xo, yo)));
    if (arg0)
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
