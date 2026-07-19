function glr_mesh_submesh_add_box_from_sprite(arg0, arg1, arg2, arg3)
{
    if (debug_mode)
    {
        if (!glr_debug_is_mesh(arg0))
        {
            show_message(global.GLR_ERROR_ARGUMENT_MESH);
        }
    }
    var mesh = arg0;
    var w = sprite_get_width(arg1);
    var h = sprite_get_height(arg1);
    var xo = sprite_get_xoffset(arg1);
    var yo = sprite_get_yoffset(arg1);
    var px = arg2;
    var py = arg3;
    var l = ds_list_create();
    ds_list_add(l, px - xo, py - yo);
    ds_list_add(l, (px + w) - xo, py - yo);
    ds_list_add(l, (px + w) - xo, (py + h) - yo);
    ds_list_add(l, px - xo, (py + h) - yo);
    ds_list_add(ds_list_find_value(mesh, UnknownEnum.Value_6), l);
}

enum UnknownEnum
{
    Value_6 = 6
}
