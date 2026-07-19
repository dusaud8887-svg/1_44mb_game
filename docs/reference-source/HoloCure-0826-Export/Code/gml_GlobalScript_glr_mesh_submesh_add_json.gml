function glr_mesh_submesh_add_json(arg0, arg1, arg2, arg3)
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
    var resultMap = json_decode(arg1);
    var list = ds_map_find_value(resultMap, "default");
    var size = ds_list_size(list);
    for (var n = 0; n < size; n++)
    {
        var vtx = ds_list_find_value(list, n);
        ds_list_add(l, px + ds_list_find_value(vtx, 0), py + ds_list_find_value(vtx, 1));
    }
    ds_list_destroy(list);
    ds_map_destroy(resultMap);
    ds_list_add(ds_list_find_value(mesh, UnknownEnum.Value_6), l);
}

enum UnknownEnum
{
    Value_6 = 6
}
