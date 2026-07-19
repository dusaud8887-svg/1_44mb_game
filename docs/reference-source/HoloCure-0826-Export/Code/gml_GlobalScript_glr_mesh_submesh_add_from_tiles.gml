function glr_mesh_submesh_add_from_tiles(arg0, arg1, arg2, arg3)
{
    if (debug_mode)
    {
        if (!glr_debug_is_mesh(arg0))
        {
            show_message(global.GLR_ERROR_ARGUMENT_MESH);
        }
    }
    var lay_id = layer_get_id(arg1);
    var map_id = layer_tilemap_get_id(lay_id);
    var tw = tilemap_get_tile_width(map_id);
    var th = tilemap_get_tile_height(map_id);
    var w = tilemap_get_width(map_id);
    var h = tilemap_get_height(map_id);
    show_message([w, h, tw, th]);
    for (var i = 0; i < w; i++)
    {
        for (var j = 0; j < h; j++)
        {
            if (tilemap_get(map_id, i, j) != 0)
            {
                glr_mesh_submesh_add_box(arg0, tw, th, i * tw, j * th);
            }
        }
    }
}
