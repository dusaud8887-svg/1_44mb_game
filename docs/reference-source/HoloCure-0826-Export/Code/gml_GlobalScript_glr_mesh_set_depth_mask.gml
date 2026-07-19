function glr_mesh_set_depth_mask(arg0, arg1, arg2)
{
    if (debug_mode)
    {
        if (!glr_debug_is_mesh(arg0))
        {
            show_message(global.GLR_ERROR_ARGUMENT_MESH);
        }
    }
    var mesh = arg0;
    ds_list_set(mesh, UnknownEnum.Value_21, arg1);
    ds_list_set(mesh, UnknownEnum.Value_22, arg2);
}

enum UnknownEnum
{
    Value_21 = 21,
    Value_22
}
