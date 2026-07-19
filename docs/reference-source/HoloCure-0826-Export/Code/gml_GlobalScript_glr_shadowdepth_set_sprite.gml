function glr_shadowdepth_set_sprite(arg0, arg1, arg2)
{
    var l = arg0;
    ds_list_set(l, UnknownEnum.Value_1, arg1);
    ds_list_set(l, UnknownEnum.Value_2, arg2);
    var width = sprite_get_width(arg1);
    var height = sprite_get_height(arg1);
    var xo = sprite_get_xoffset(arg1);
    var yo = sprite_get_yoffset(arg1);
    ds_list_set(l, UnknownEnum.Value_10, max(point_distance(0, 0, xo, yo), point_distance(width, 0, xo, yo), point_distance(width, height, xo, yo), point_distance(0, height, xo, yo)));
}

enum UnknownEnum
{
    Value_1 = 1,
    Value_2,
    Value_10 = 10
}
