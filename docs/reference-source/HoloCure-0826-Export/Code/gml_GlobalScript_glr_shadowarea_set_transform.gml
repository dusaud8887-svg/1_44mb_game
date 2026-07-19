function glr_shadowarea_set_transform(arg0, arg1, arg2, arg3, arg4, arg5)
{
    ds_list_set(arg0, UnknownEnum.Value_7, matrix_build(arg1, arg2, 0, 0, 0, arg3, arg4, arg5, 0));
}

enum UnknownEnum
{
    Value_7 = 7
}
