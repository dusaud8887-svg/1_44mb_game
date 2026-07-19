function glr_mesh_get_position(arg0)
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
    return array;
}

enum UnknownEnum
{
    Value_7 = 7,
    Value_8
}
