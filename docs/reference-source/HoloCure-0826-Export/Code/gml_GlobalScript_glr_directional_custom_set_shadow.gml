function glr_directional_custom_set_shadow(arg0, arg1, arg2)
{
    var l = arg0;
    ds_list_set(l, UnknownEnum.Value_5, arg1);
    ds_list_set(l, UnknownEnum.Value_6, arg2);
}

enum UnknownEnum
{
    Value_5 = 5,
    Value_6
}
