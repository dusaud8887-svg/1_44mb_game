function glr_occlusion_set_transform(arg0, arg1, arg2, arg3, arg4, arg5)
{
    ds_list_set(arg0, UnknownEnum.Value_3, arg1);
    ds_list_set(arg0, UnknownEnum.Value_4, arg2);
    ds_list_set(arg0, UnknownEnum.Value_5, arg3);
    ds_list_set(arg0, UnknownEnum.Value_6, arg4);
    ds_list_set(arg0, UnknownEnum.Value_7, arg5);
    ds_list_set(arg0, UnknownEnum.Value_9, ds_list_find_value(arg0, UnknownEnum.Value_8) * max(arg3, arg4));
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
