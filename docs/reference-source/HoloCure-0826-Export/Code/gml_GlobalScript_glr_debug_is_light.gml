function glr_debug_is_light(arg0)
{
    if (!ds_exists(arg0, ds_type_list))
    {
        return 0;
    }
    else if (ds_list_find_value(arg0, UnknownEnum.Value_0) != UnknownEnum.Value_0)
    {
        return 0;
    }
    return 1;
}

enum UnknownEnum
{
    Value_0
}
