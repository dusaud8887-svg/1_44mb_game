function glr_mesh_set_depth(arg0, arg1)
{
    if (debug_mode)
    {
        if (!glr_debug_is_mesh(arg0))
        {
            show_message(global.GLR_ERROR_ARGUMENT_MESH);
        }
    }
    var mesh = arg0;
    var dep = clamp(floor(arg1), 0, global.GLR_MAX_DEPTH);
    ds_list_set(mesh, UnknownEnum.Value_2, dep);
    var index = ds_list_find_index(global.GLR_MESH_SORTED_LIST, mesh);
    if (index >= 0)
    {
        ds_list_delete(global.GLR_MESH_SORTED_LIST, index);
    }
    if (dep > 0)
    {
        var sz = ds_list_size(global.GLR_MESH_SORTED_LIST);
        if (sz > 0)
        {
            var found = false;
            for (var i = 0; i < sz; i++)
            {
                var list = ds_list_find_value(global.GLR_MESH_SORTED_LIST, i);
                if (ds_list_find_value(list, UnknownEnum.Value_2) <= dep)
                {
                    ds_list_insert(global.GLR_MESH_SORTED_LIST, i, mesh);
                    found = true;
                    break;
                }
            }
            if (!found)
            {
                ds_list_add(global.GLR_MESH_SORTED_LIST, mesh);
            }
        }
        else
        {
            ds_list_add(global.GLR_MESH_SORTED_LIST, mesh);
        }
    }
}

enum UnknownEnum
{
    Value_2 = 2
}
