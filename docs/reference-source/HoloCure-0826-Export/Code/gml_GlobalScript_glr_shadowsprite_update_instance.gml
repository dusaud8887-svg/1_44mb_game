function glr_shadowsprite_update_instance(arg0)
{
    var l = arg0;
    ds_list_set(l, UnknownEnum.Value_3, sprite_index);
    ds_list_set(l, UnknownEnum.Value_4, image_index);
    ds_list_set(l, UnknownEnum.Value_5, x);
    ds_list_set(l, UnknownEnum.Value_6, y);
    ds_list_set(l, UnknownEnum.Value_7, image_xscale);
    ds_list_set(l, UnknownEnum.Value_8, image_yscale);
    ds_list_set(l, UnknownEnum.Value_9, image_angle);
}

enum UnknownEnum
{
    Value_3 = 3,
    Value_4,
    Value_5,
    Value_6,
    Value_7,
    Value_8,
    Value_9
}
