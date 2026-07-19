function glr_mesh_draw(arg0, arg1, arg2)
{
    if (debug_mode)
    {
        if (!glr_debug_is_mesh(arg0))
        {
            show_message(global.GLR_ERROR_ARGUMENT_MESH);
        }
    }
    var mesh = arg0;
    var color = arg1;
    var alpha = arg2;
    matrix_set(2, ds_list_find_value(mesh, UnknownEnum.Value_23));
    shader_set(glr_shader_mesh_color);
    shader_set_uniform_f(global.GLR_UNIF_MESH_COLOR, color_get_red(color), color_get_green(color), color_get_blue(color), alpha);
    vertex_submit(ds_list_find_value(mesh, UnknownEnum.Value_5), pr_trianglelist, -1);
    shader_reset();
    matrix_set(2, global.GLR_MATRIX_WORLD_IDENTITY);
}

enum UnknownEnum
{
    Value_5 = 5,
    Value_23 = 23
}
