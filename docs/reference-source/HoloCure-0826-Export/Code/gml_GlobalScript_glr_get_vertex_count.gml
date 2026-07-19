function glr_get_vertex_count()
{
    var vertices = 0;
    var size = ds_list_size(global.GLR_MESH_STC_LIST);
    for (var i = 0; i < size; i++)
    {
        var mesh = ds_list_find_value(global.GLR_MESH_STC_LIST, i);
        vertices += glr_mesh_get_vertex_count(mesh);
    }
    size = ds_list_size(global.GLR_MESH_DYN_LIST);
    for (var i = 0; i < size; i++)
    {
        var mesh = ds_list_find_value(global.GLR_MESH_DYN_LIST, i);
        vertices += glr_mesh_get_vertex_count(mesh);
    }
    return vertices;
}
