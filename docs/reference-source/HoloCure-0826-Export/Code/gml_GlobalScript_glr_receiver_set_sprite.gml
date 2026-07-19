function glr_receiver_set_sprite(arg0, arg1, arg2)
{
    var l = arg0;
    ds_list_set(l, UnknownEnum.Value_2, arg1);
    ds_list_set(l, UnknownEnum.Value_3, arg2);
}

enum UnknownEnum
{
    Value_2 = 2,
    Value_3
}
