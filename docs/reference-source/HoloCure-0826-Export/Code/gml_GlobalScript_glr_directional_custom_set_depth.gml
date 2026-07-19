function glr_directional_custom_set_depth(arg0, arg1)
{
    var l = arg0;
    var dep = max(0, arg1);
    ds_list_set(l, UnknownEnum.Value_2, dep);
    var sz = ds_list_size(global.GLR_MESH_SORTED_LIST);
    if (sz > 0)
    {
        var found = false;
        for (var i = 0; i < sz; i++)
        {
            var list = ds_list_find_value(global.GLR_MESH_SORTED_LIST, i);
            if (ds_list_find_value(list, UnknownEnum.Value_2) <= dep)
            {
                ds_list_insert(global.GLR_MESH_SORTED_LIST, i, l);
                found = true;
                break;
            }
        }
        if (!found)
        {
            ds_list_add(global.GLR_MESH_SORTED_LIST, l);
        }
    }
    else
    {
        ds_list_add(global.GLR_MESH_SORTED_LIST, l);
    }
}

enum UnknownEnum
{
    Value_2 = 2
}
