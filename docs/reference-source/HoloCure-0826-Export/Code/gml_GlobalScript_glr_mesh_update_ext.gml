function glr_mesh_update_ext(arg0, arg1)
{
    if (debug_mode)
    {
        if (!glr_debug_is_mesh(arg0))
        {
            show_message(global.GLR_ERROR_ARGUMENT_MESH);
        }
    }
    var mesh_list = ds_list_find_value(arg0, UnknownEnum.Value_6);
    var sz_mesh = ds_list_size(mesh_list);
    var buf = ds_list_find_value(arg0, UnknownEnum.Value_4);
    if (buf != -1)
    {
        vertex_delete_buffer(buf);
    }
    buf = vertex_create_buffer();
    vertex_begin(buf, global.GLR_VERTEX_FORMAT);
    var bcr = 0;
    var shadow_triangles_count = 0;
    var shadow_vertex_count = 0;
    for (var n = 0; n < sz_mesh; n++)
    {
        var submesh = ds_list_find_value(mesh_list, n);
        var vcount = ds_list_size(submesh);
        for (var i = 0; i < vcount; i += 2)
        {
            var x1 = ds_list_find_value(submesh, i % vcount);
            var y1 = ds_list_find_value(submesh, (i + 1) % vcount);
            var x2 = ds_list_find_value(submesh, (i + 2) % vcount);
            var y2 = ds_list_find_value(submesh, (i + 3) % vcount);
            vertex_position_3d(buf, x1, y1, 1);
            vertex_position_3d(buf, x2, y2, 0);
            vertex_position_3d(buf, x2, y2, 1);
            vertex_position_3d(buf, x1, y1, 0);
            vertex_position_3d(buf, x2, y2, 0);
            vertex_position_3d(buf, x1, y1, 1);
            bcr = max(bcr, point_distance(0, 0, x1, y1));
        }
        shadow_triangles_count += vcount;
        shadow_vertex_count += (vcount / 2);
        if (debug_mode)
        {
        }
    }
    vertex_end(buf);
    ds_list_set(arg0, UnknownEnum.Value_14, shadow_triangles_count);
    ds_list_set(arg0, UnknownEnum.Value_16, shadow_vertex_count);
    vertex_freeze(buf);
    ds_list_set(arg0, UnknownEnum.Value_4, buf);
    ds_list_set(arg0, UnknownEnum.Value_12, bcr);
    ds_list_set(arg0, UnknownEnum.Value_13, bcr * max(ds_list_find_value(arg0, UnknownEnum.Value_10), ds_list_find_value(arg0, UnknownEnum.Value_11)));
    var resultMap = json_decode(arg1);
    var triangles = ds_map_find_value(resultMap, "default");
    buf = ds_list_find_value(arg0, UnknownEnum.Value_5);
    if (buf != -1)
    {
        vertex_delete_buffer(buf);
    }
    buf = vertex_create_buffer();
    vertex_begin(buf, global.GLR_MODEL_FORMAT);
    sz = ds_list_size(triangles);
    if (debug_mode)
    {
    }
    for (var i = 0; i < sz; i += 2)
    {
        var x1 = ds_list_find_value(triangles, i);
        var y1 = ds_list_find_value(triangles, i + 1);
        vertex_position(buf, x1, y1);
    }
    vertex_end(buf);
    vertex_freeze(buf);
    ds_list_set(arg0, UnknownEnum.Value_5, buf);
    ds_list_set(arg0, UnknownEnum.Value_15, sz / 3);
    ds_map_destroy(resultMap);
}

enum UnknownEnum
{
    Value_4 = 4,
    Value_5,
    Value_6,
    Value_10 = 10,
    Value_11,
    Value_12,
    Value_13,
    Value_14,
    Value_15,
    Value_16
}
