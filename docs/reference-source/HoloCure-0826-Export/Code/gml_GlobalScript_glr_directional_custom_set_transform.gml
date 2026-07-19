function glr_directional_custom_set_transform(arg0, arg1, arg2, arg3, arg4, arg5)
{
    var l = arg0;
    ds_list_set(l, UnknownEnum.Value_8, arg1);
    ds_list_set(l, UnknownEnum.Value_9, arg2);
    ds_list_set(l, UnknownEnum.Value_10, arg3);
    ds_list_set(l, UnknownEnum.Value_11, arg4);
    ds_list_set(l, UnknownEnum.Value_12, arg5);
}

enum UnknownEnum
{
    Value_8 = 8,
    Value_9,
    Value_10,
    Value_11,
    Value_12
}
