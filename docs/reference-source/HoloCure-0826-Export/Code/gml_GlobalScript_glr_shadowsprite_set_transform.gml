function glr_shadowsprite_set_transform(arg0, arg1, arg2, arg3, arg4, arg5)
{
    ds_list_set(arg0, UnknownEnum.Value_5, arg1);
    ds_list_set(arg0, UnknownEnum.Value_6, arg2);
    ds_list_set(arg0, UnknownEnum.Value_7, arg3);
    ds_list_set(arg0, UnknownEnum.Value_8, arg4);
    ds_list_set(arg0, UnknownEnum.Value_9, arg5);
}

enum UnknownEnum
{
    Value_5 = 5,
    Value_6,
    Value_7,
    Value_8,
    Value_9
}
