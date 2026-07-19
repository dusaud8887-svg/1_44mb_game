function glr_mesh_get_transform(arg0)
{
    if (debug_mode)
    {
        if (!glr_debug_is_mesh(arg0))
        {
            show_message(global.GLR_ERROR_ARGUMENT_MESH);
        }
    }
    var array;
    array[0] = ds_list_find_value(arg0, UnknownEnum.Value_7);
    array[1] = ds_list_find_value(arg0, UnknownEnum.Value_8);
    array[2] = ds_list_find_value(arg0, UnknownEnum.Value_10);
    array[3] = ds_list_find_value(arg0, UnknownEnum.Value_11);
    array[4] = ds_list_find_value(arg0, UnknownEnum.Value_9);
    return array;
}

enum UnknownEnum
{
    Value_7 = 7,
    Value_8,
    Value_9,
    Value_10,
    Value_11
}
