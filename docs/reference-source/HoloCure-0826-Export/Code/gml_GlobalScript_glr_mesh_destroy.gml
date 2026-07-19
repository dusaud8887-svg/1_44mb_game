function glr_mesh_destroy(arg0)
{
    if (debug_mode)
    {
        if (!glr_debug_is_mesh(arg0))
        {
            show_message(global.GLR_ERROR_ARGUMENT_MESH);
        }
    }
    var mesh = arg0;
    var submesh_list = ds_list_find_value(mesh, UnknownEnum.Value_6);
    var sz = ds_list_size(submesh_list);
    for (var i = 0; i < sz; i++)
    {
        ds_list_destroy(ds_list_find_value(submesh_list, i));
    }
    ds_list_destroy(submesh_list);
    buf = ds_list_find_value(mesh, UnknownEnum.Value_4);
    if (buf)
    {
        vertex_delete_buffer(buf);
    }
    buf = ds_list_find_value(mesh, UnknownEnum.Value_5);
    if (buf)
    {
        vertex_delete_buffer(buf);
    }
    if (ds_list_find_value(mesh, UnknownEnum.Value_3))
    {
        ds_list_delete(global.GLR_MESH_STC_LIST, ds_list_find_index(global.GLR_MESH_STC_LIST, mesh));
    }
    else
    {
        ds_list_delete(global.GLR_MESH_DYN_LIST, ds_list_find_index(global.GLR_MESH_DYN_LIST, mesh));
    }
    var idx = ds_list_find_index(global.GLR_MESH_SORTED_LIST, mesh);
    if (idx >= 0)
    {
        ds_list_delete(global.GLR_MESH_SORTED_LIST, idx);
    }
    ds_list_destroy(mesh);
}

enum UnknownEnum
{
    Value_3 = 3,
    Value_4,
    Value_5,
    Value_6
}
