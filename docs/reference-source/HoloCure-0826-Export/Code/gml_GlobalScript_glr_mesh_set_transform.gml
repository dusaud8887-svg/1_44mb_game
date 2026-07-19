function glr_mesh_set_transform(arg0, arg1, arg2, arg3, arg4, arg5)
{
    if (debug_mode)
    {
        if (!glr_debug_is_mesh(arg0))
        {
            show_message(global.GLR_ERROR_ARGUMENT_MESH);
        }
    }
    var mesh = arg0;
    ds_list_set(mesh, UnknownEnum.Value_7, arg1);
    ds_list_set(mesh, UnknownEnum.Value_8, arg2);
    ds_list_set(mesh, UnknownEnum.Value_10, arg3);
    ds_list_set(mesh, UnknownEnum.Value_11, arg4);
    ds_list_set(mesh, UnknownEnum.Value_9, arg5);
    ds_list_delete(mesh, UnknownEnum.Value_23);
    ds_list_insert(mesh, UnknownEnum.Value_23, matrix_build(arg1, arg2, 0, 0, 0, arg5, arg3, arg4, 1));
}

enum UnknownEnum
{
    Value_7 = 7,
    Value_8,
    Value_9,
    Value_10,
    Value_11,
    Value_23 = 23
}
