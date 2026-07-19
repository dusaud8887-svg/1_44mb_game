function glr_mesh_get_scaling(arg0)
{
    if (debug_mode)
    {
        if (!glr_debug_is_mesh(arg0))
        {
            show_message(global.GLR_ERROR_ARGUMENT_MESH);
        }
    }
    var array;
    array[0] = ds_list_find_value(arg0, UnknownEnum.Value_10);
    array[1] = ds_list_find_value(arg0, UnknownEnum.Value_11);
    return array;
}

enum UnknownEnum
{
    Value_10 = 10,
    Value_11
}
