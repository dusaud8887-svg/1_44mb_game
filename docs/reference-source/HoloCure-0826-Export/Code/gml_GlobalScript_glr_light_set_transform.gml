function glr_light_set_transform(arg0, arg1, arg2, arg3, arg4, arg5)
{
    if (debug_mode)
    {
        if (!glr_debug_is_light(arg0))
        {
            show_message(global.GLR_ERROR_ARGUMENT_LIGHT);
        }
    }
    var l = arg0;
    ds_list_set(l, UnknownEnum.Value_3, arg1);
    ds_list_set(l, UnknownEnum.Value_4, arg2);
    ds_list_set(l, UnknownEnum.Value_7, arg3);
    ds_list_set(l, UnknownEnum.Value_8, arg4);
    ds_list_set(l, UnknownEnum.Value_5, arg5);
    ds_list_set(l, UnknownEnum.Value_18, ds_list_find_value(l, UnknownEnum.Value_17) * max(arg3, arg4));
    ds_list_delete(l, UnknownEnum.Value_27);
    ds_list_insert(l, UnknownEnum.Value_27, matrix_multiply(ds_list_find_value(l, UnknownEnum.Value_26), matrix_build(arg1, arg2, 0, 0, 0, arg5, arg3, arg4, 1)));
}

enum UnknownEnum
{
    Value_3 = 3,
    Value_4,
    Value_5,
    Value_7 = 7,
    Value_8,
    Value_17 = 17,
    Value_18,
    Value_26 = 26,
    Value_27
}
