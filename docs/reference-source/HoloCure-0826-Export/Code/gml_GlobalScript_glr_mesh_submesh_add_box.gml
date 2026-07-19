function glr_mesh_submesh_add_box(arg0, arg1, arg2, arg3, arg4)
{
    if (debug_mode)
    {
        if (!glr_debug_is_mesh(arg0))
        {
            show_message(global.GLR_ERROR_ARGUMENT_MESH);
        }
    }
    var mesh = arg0;
    var w = arg1;
    var h = arg2;
    var px = arg3;
    var py = arg4;
    var l = ds_list_create();
    ds_list_add(l, px, py);
    ds_list_add(l, px + w, py);
    ds_list_add(l, px + w, py + h);
    ds_list_add(l, px, py + h);
    ds_list_add(ds_list_find_value(mesh, UnknownEnum.Value_6), l);
}

enum UnknownEnum
{
    Value_6 = 6
}
