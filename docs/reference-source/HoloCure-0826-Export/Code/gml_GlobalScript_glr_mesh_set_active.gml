function glr_mesh_set_active(arg0, arg1)
{
    if (debug_mode)
    {
        if (!glr_debug_is_mesh(arg0))
        {
            show_message(global.GLR_ERROR_ARGUMENT_MESH);
        }
    }
    ds_list_set(arg0, UnknownEnum.Value_1, arg1);
}

enum UnknownEnum
{
    Value_1 = 1
}
