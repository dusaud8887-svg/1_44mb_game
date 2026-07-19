function glr_mesh_set_directional_shadow_length(arg0, arg1)
{
    if (debug_mode)
    {
        if (!glr_debug_is_mesh(arg0))
        {
            show_message(global.GLR_ERROR_ARGUMENT_MESH);
        }
    }
    var mesh = arg0;
    ds_list_set(mesh, UnknownEnum.Value_19, arg1);
}

enum UnknownEnum
{
    Value_19 = 19
}
