function glr_mesh_get_vertex_count(arg0)
{
    if (debug_mode)
    {
        if (!glr_debug_is_mesh(arg0))
        {
            show_message(global.GLR_ERROR_ARGUMENT_MESH);
        }
    }
    return ds_list_find_value(arg0, UnknownEnum.Value_16);
}

enum UnknownEnum
{
    Value_16 = 16
}
