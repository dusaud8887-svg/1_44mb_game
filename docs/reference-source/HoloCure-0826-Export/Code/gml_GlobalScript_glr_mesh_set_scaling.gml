function glr_mesh_set_scaling(arg0, arg1, arg2)
{
    if (debug_mode)
    {
        if (!glr_debug_is_mesh(arg0))
        {
            show_message(global.GLR_ERROR_ARGUMENT_MESH);
        }
    }
    var mesh = arg0;
    ds_list_set(mesh, UnknownEnum.Value_10, arg1);
    ds_list_set(mesh, UnknownEnum.Value_11, arg2);
    ds_list_delete(mesh, UnknownEnum.Value_23);
    ds_list_insert(mesh, UnknownEnum.Value_23, matrix_build(ds_list_find_value(mesh, UnknownEnum.Value_7), ds_list_find_value(mesh, UnknownEnum.Value_8), 0, 0, 0, ds_list_find_value(mesh, UnknownEnum.Value_9), arg1, arg2, 1));
    ds_list_set(mesh, UnknownEnum.Value_13, ds_list_find_value(mesh, UnknownEnum.Value_12) * max(arg1, arg2));
}

enum UnknownEnum
{
    Value_7 = 7,
    Value_8,
    Value_9,
    Value_10,
    Value_11,
    Value_12,
    Value_13,
    Value_23 = 23
}
