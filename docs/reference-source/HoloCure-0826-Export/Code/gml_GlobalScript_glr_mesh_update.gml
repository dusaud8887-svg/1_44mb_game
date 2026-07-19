function glr_mesh_update(arg0)
{
    if (debug_mode)
    {
        if (!glr_debug_is_mesh(arg0))
        {
            show_message(global.GLR_ERROR_ARGUMENT_MESH);
        }
    }
    var mesh = arg0;
    var mesh_list = ds_list_find_value(mesh, UnknownEnum.Value_6);
    var sz_mesh = ds_list_size(mesh_list);
    var buf = ds_list_find_value(mesh, UnknownEnum.Value_4);
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
    ds_list_set(mesh, UnknownEnum.Value_14, shadow_triangles_count);
    ds_list_set(mesh, UnknownEnum.Value_16, shadow_vertex_count);
    vertex_freeze(buf);
    ds_list_set(mesh, UnknownEnum.Value_4, buf);
    ds_list_set(mesh, UnknownEnum.Value_12, bcr);
    ds_list_set(mesh, UnknownEnum.Value_13, bcr * max(ds_list_find_value(mesh, UnknownEnum.Value_10), ds_list_find_value(mesh, UnknownEnum.Value_11)));
    var triangles = ds_list_create();
    var l = ds_list_create();
    for (var n = 0; n < sz_mesh; n++)
    {
        var submesh = ds_list_find_value(mesh_list, n);
        var vcount = ds_list_size(submesh);
        ds_list_clear(l);
        ds_list_copy(l, submesh);
        sz = ds_list_size(l);
        var cw = 0;
        var ccw = 0;
        for (i = 0; i < sz; i += 2)
        {
            var x1 = ds_list_find_value(l, i % sz);
            var y1 = ds_list_find_value(l, (i + 1) % sz);
            var x2 = ds_list_find_value(l, (i + 2) % sz);
            var y2 = ds_list_find_value(l, (i + 3) % sz);
            var x3 = ds_list_find_value(l, (i + 4) % sz);
            var y3 = ds_list_find_value(l, (i + 5) % sz);
            var dot = ((x2 - x1) * (y3 - y1)) - ((y2 - y1) * (x3 - x1));
            if (dot > 0)
            {
                cw++;
            }
            else if (dot < 0)
            {
                ccw++;
            }
        }
        var mesh_clockwise = 1;
        if (cw < ccw)
        {
            mesh_clockwise = -1;
        }
        else if (cw == ccw)
        {
            var x1 = ds_list_find_value(l, 0);
            var y1 = ds_list_find_value(l, 1);
            var x2 = ds_list_find_value(l, 2);
            var y2 = ds_list_find_value(l, 3);
            var x3 = ds_list_find_value(l, 4);
            var y3 = ds_list_find_value(l, 5);
            if ((((x2 - x1) * (y3 - y1)) - ((y2 - y1) * (x3 - x1))) < 0)
            {
                mesh_clockwise = -1;
            }
        }
        var i = 0;
        sz = ds_list_size(l);
        while (sz >= 6)
        {
            var x1 = ds_list_find_value(l, i % sz);
            var y1 = ds_list_find_value(l, (i + 1) % sz);
            var x2 = ds_list_find_value(l, (i + 2) % sz);
            var y2 = ds_list_find_value(l, (i + 3) % sz);
            var x3 = ds_list_find_value(l, (i + 4) % sz);
            var y3 = ds_list_find_value(l, (i + 5) % sz);
            if (((((x2 - x1) * (y3 - y1)) - ((y2 - y1) * (x3 - x1))) * mesh_clockwise) > 0)
            {
                var in_tris = false;
                var point_count = (sz - 6) / 2;
                var j = i + 6;
                repeat (point_count)
                {
                    if (point_in_triangle(ds_list_find_value(l, j % sz), ds_list_find_value(l, (j + 1) % sz), x1, y1, x2, y2, x3, y3))
                    {
                        in_tris = true;
                        break;
                    }
                    j += 2;
                }
                if (in_tris)
                {
                    i += 2;
                }
                else
                {
                    ds_list_add(triangles, x1, y1, x2, y2, x3, y3);
                    ds_list_delete(l, (i + 2) % sz);
                    ds_list_delete(l, (i + 2) % sz);
                    sz = ds_list_size(l);
                }
            }
            else
            {
                i += 2;
            }
        }
    }
    buf = ds_list_find_value(mesh, UnknownEnum.Value_5);
    if (buf != -1)
    {
        vertex_delete_buffer(buf);
    }
    buf = vertex_create_buffer();
    vertex_begin(buf, global.GLR_MODEL_FORMAT);
    var sz = ds_list_size(triangles);
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
    ds_list_set(mesh, UnknownEnum.Value_5, buf);
    ds_list_set(mesh, UnknownEnum.Value_15, sz / 3);
    ds_list_destroy(triangles);
    ds_list_destroy(l);
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
