function glr_debug_draw_mesh(arg0, arg1)
{
    matrix_set(2, ds_list_find_value(arg0, UnknownEnum.Value_23));
    shader_set(glr_shader_mesh_color);
    shader_set_uniform_f(global.GLR_UNIF_MESH_COLOR, color_get_red(arg1) / 255, color_get_green(arg1) / 255, color_get_blue(arg1) / 255, 1);
    var buf = ds_list_find_value(arg0, UnknownEnum.Value_5);
    vertex_submit(buf, pr_trianglelist, -1);
    shader_reset();
    matrix_set(2, global.GLR_MATRIX_WORLD_IDENTITY);
}

enum UnknownEnum
{
    Value_5 = 5,
    Value_23 = 23
}
