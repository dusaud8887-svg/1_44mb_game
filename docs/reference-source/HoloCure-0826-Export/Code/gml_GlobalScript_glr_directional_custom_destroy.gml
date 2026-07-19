function glr_directional_custom_destroy(arg0)
{
    ds_list_delete(global.GLR_DIR_CUSTOM_LIST, ds_list_find_index(global.GLR_DIR_CUSTOM_LIST, arg0));
    var idx = ds_list_find_index(global.GLR_MESH_SORTED_LIST, arg0);
    if (idx >= 0)
    {
        ds_list_delete(global.GLR_MESH_SORTED_LIST, idx);
    }
    ds_list_destroy(arg0);
}
