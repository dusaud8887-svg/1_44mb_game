function glr_directional_custom_destroy_all()
{
    var size = ds_list_size(global.GLR_DIR_CUSTOM_LIST);
    for (i = 0; i < size; i++)
    {
        var ss = ds_list_find_value(global.GLR_DIR_CUSTOM_LIST, i);
        var idx = ds_list_find_index(global.GLR_MESH_SORTED_LIST, ss);
        if (idx >= 0)
        {
            ds_list_delete(global.GLR_MESH_SORTED_LIST, idx);
        }
        ds_list_destroy(ss);
    }
    ds_list_clear(global.GLR_DIR_CUSTOM_LIST);
}
