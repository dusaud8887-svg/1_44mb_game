function glr_receiver_set_transform(arg0, arg1, arg2, arg3, arg4, arg5)
{
    var l = arg0;
    ds_list_set(l, UnknownEnum.Value_4, arg1);
    ds_list_set(l, UnknownEnum.Value_5, arg2);
    ds_list_set(l, UnknownEnum.Value_6, arg3);
    ds_list_set(l, UnknownEnum.Value_7, arg4);
    ds_list_set(l, UnknownEnum.Value_8, arg5);
}

enum UnknownEnum
{
    Value_4 = 4,
    Value_5,
    Value_6,
    Value_7,
    Value_8
}
