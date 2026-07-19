function glr_mesh_submesh_add_path(arg0, arg1, arg2, arg3)
{
    if (debug_mode)
    {
        if (!glr_debug_is_mesh(arg0))
        {
            show_message(global.GLR_ERROR_ARGUMENT_MESH);
        }
    }
    var mesh = arg0;
    var px = arg2;
    var py = arg3;
    var l = ds_list_create();
    var num = path_get_number(arg1);
    for (var i = 0; i < num; i++)
    {
        ds_list_add(l, px + path_get_point_x(arg1, i), py + path_get_point_y(arg1, i));
    }
    ds_list_add(ds_list_find_value(mesh, UnknownEnum.Value_6), l);
}

enum UnknownEnum
{
    Value_6 = 6
}
