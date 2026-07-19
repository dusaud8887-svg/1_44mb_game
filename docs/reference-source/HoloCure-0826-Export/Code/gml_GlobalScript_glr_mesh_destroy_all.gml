function glr_mesh_destroy_all()
{
    var size = ds_list_size(global.GLR_MESH_STC_LIST);
    repeat (size)
    {
        var mesh = ds_list_find_value(global.GLR_MESH_STC_LIST, 0);
        glr_mesh_destroy(mesh);
    }
    ds_list_clear(global.GLR_MESH_STC_LIST);
    size = ds_list_size(global.GLR_MESH_DYN_LIST);
    repeat (size)
    {
        var mesh = ds_list_find_value(global.GLR_MESH_DYN_LIST, 0);
        glr_mesh_destroy(mesh);
    }
    ds_list_clear(global.GLR_MESH_DYN_LIST);
    ds_list_clear(global.GLR_MESH_SORTED_LIST);
    if (surface_exists(global.GLR_DEPTH_SURFACE))
    {
        surface_free(global.GLR_DEPTH_SURFACE);
    }
}
