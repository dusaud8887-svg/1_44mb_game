function glr_occlusion_set_sprite(arg0, arg1, arg2)
{
    var l = arg0;
    ds_list_set(l, UnknownEnum.Value_1, arg1);
    ds_list_set(l, UnknownEnum.Value_2, arg2);
}

enum UnknownEnum
{
    Value_1 = 1,
    Value_2
}
