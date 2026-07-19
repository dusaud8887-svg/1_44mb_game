function glr_mesh_submesh_add_circle(arg0, arg1, arg2, arg3, arg4)
{
    if (debug_mode)
    {
        if (!glr_debug_is_mesh(arg0))
        {
            show_message(global.GLR_ERROR_ARGUMENT_MESH);
        }
    }
    var mesh = arg0;
    var r = arg1;
    var delta_angle = 360 / arg2;
    var px = arg3;
    var py = arg4;
    var l = ds_list_create();
    for (var i = 360; i > 0; i -= delta_angle)
    {
        ds_list_add(l, px + lengthdir_x(r, i), py + lengthdir_y(r, i));
    }
    ds_list_add(ds_list_find_value(mesh, UnknownEnum.Value_6), l);
}

enum UnknownEnum
{
    Value_6 = 6
}
