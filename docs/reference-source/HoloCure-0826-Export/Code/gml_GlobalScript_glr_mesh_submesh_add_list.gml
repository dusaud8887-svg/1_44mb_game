function glr_mesh_submesh_add_list(arg0, arg1, arg2, arg3)
{
    if (debug_mode)
    {
        if (!glr_debug_is_mesh(arg0))
        {
            show_message(global.GLR_ERROR_ARGUMENT_MESH);
        }
    }
    var mesh = arg0;
    var vlist = arg1;
    var px = arg2;
    var py = arg3;
    var l = ds_list_create();
    var size = ds_list_size(arg1);
    for (var n = 0; n < size; n += 2)
    {
        ds_list_add(l, px + ds_list_find_value(vlist, n));
        ds_list_add(l, py + ds_list_find_value(vlist, n + 1));
    }
    ds_list_add(ds_list_find_value(mesh, UnknownEnum.Value_6), l);
}

enum UnknownEnum
{
    Value_6 = 6
}
