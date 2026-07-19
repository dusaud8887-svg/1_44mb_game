function glr_render()
{
    gpu_set_texrepeat(true);
    var v_w, v_h, v_x0, v_y0, v_x1, v_y1;
    if (view_enabled)
    {
        var cam = view_camera[global.GLR_VIEW];
        v_x0 = camera_get_view_x(cam);
        v_y0 = camera_get_view_y(cam);
        v_w = camera_get_view_width(cam);
        v_h = camera_get_view_height(cam);
        v_x1 = v_x0 + v_w;
        v_y1 = v_y0 + v_h;
    }
    else
    {
        v_x0 = 0;
        v_y0 = 0;
        v_w = room_width;
        v_h = room_width;
        v_x1 = room_width;
        v_y1 = room_height;
    }
    var v_max = max(v_w, v_h);
    if (!surface_exists(global.GLR_MAIN_SURFACE))
    {
        var _depth_setting = surface_get_depth_disable();
        surface_depth_disable(false);
        global.GLR_MAIN_SURFACE = surface_create(global.GLR_MAIN_SURFACE_WIDTH, global.GLR_MAIN_SURFACE_HEIGHT);
        surface_depth_disable(_depth_setting);
        if (!surface_exists(global.GLR_MAIN_SURFACE))
        {
            return 0;
        }
    }
    glr_set_projection_ortho(v_x0, v_y0, global.GLR_WIDTH / global.GLR_ZOOM, global.GLR_HEIGHT / global.GLR_ZOOM, 0);
    var main_viewproj_mat = matrix_multiply(matrix_get(0), matrix_get(1));
    var dep_texture = -1;
    var size = ds_list_size(global.GLR_MESH_SORTED_LIST);
    if (size > 0)
    {
        if (!surface_exists(global.GLR_DEPTH_SURFACE))
        {
            var _depth_setting = surface_get_depth_disable();
            surface_depth_disable(false);
            global.GLR_DEPTH_SURFACE = surface_create(global.GLR_MAIN_SURFACE_WIDTH, global.GLR_MAIN_SURFACE_HEIGHT);
            surface_depth_disable(_depth_setting);
            if (!surface_exists(global.GLR_DEPTH_SURFACE))
            {
                return 0;
            }
        }
        surface_set_target(global.GLR_DEPTH_SURFACE);
        glr_set_projection_ortho(v_x0, v_y0, global.GLR_WIDTH / global.GLR_ZOOM, global.GLR_HEIGHT / global.GLR_ZOOM, 0);
        if (global.GLR_BACKGROUND_RECEIVE_SHADOWS)
        {
            draw_clear_alpha(c_black, 0);
        }
        else
        {
            draw_clear_alpha(c_white, 0);
            var sz = ds_list_size(global.GLR_RECEIVER_LIST);
            var v_cx = v_x0 + (v_w / 2);
            var v_cy = v_y0 + (v_h / 2);
            for (var j = 0; j < sz; j++)
            {
                var rc = ds_list_find_value(global.GLR_RECEIVER_LIST, j);
                if (ds_list_find_value(rc, UnknownEnum.Value_1))
                {
                    var px = ds_list_find_value(rc, UnknownEnum.Value_4);
                    var py = ds_list_find_value(rc, UnknownEnum.Value_5);
                    var xscale = ds_list_find_value(rc, UnknownEnum.Value_6);
                    var yscale = ds_list_find_value(rc, UnknownEnum.Value_7);
                    var rot = ds_list_find_value(rc, UnknownEnum.Value_8);
                    if (point_distance(px, py, v_cx, v_cy) > ((ds_list_find_value(rc, UnknownEnum.Value_9) * max(abs(xscale), abs(yscale))) + v_max))
                    {
                    }
                    else
                    {
                        draw_sprite_ext(ds_list_find_value(rc, UnknownEnum.Value_2), ds_list_find_value(rc, UnknownEnum.Value_3), px, py, xscale, yscale, rot, c_black, 1);
                    }
                }
            }
        }
        var i = size - 1;
        while (i >= 0)
        {
            var element = ds_list_find_value(global.GLR_MESH_SORTED_LIST, i);
            if (ds_list_find_value(element, UnknownEnum.Value_1))
            {
                if (ds_list_find_value(element, UnknownEnum.Value_0) == UnknownEnum.Value_2)
                {
                    matrix_set(2, ds_list_find_value(element, UnknownEnum.Value_23));
                    var color = ds_list_find_value(element, UnknownEnum.Value_2);
                    var depth_mask = ds_list_find_value(element, UnknownEnum.Value_21);
                    if (depth_mask != -1)
                    {
                        var index = ds_list_find_value(element, UnknownEnum.Value_22);
                        shader_set(glr_shader_sprite_color);
                        draw_sprite_ext(depth_mask, index, 0, 0, 1, 1, 0, color, 1);
                        shader_reset();
                    }
                    else
                    {
                        shader_set(glr_shader_mesh_color);
                        shader_set_uniform_f(global.GLR_UNIF_MESH_COLOR, color_get_red(color) / 255, color_get_green(color) / 255, color_get_blue(color) / 255, 1);
                        var buf = ds_list_find_value(element, UnknownEnum.Value_5);
                        vertex_submit(buf, pr_trianglelist, -1);
                        shader_reset();
                    }
                }
                else if (ds_list_find_value(element, UnknownEnum.Value_0) == UnknownEnum.Value_4)
                {
                    matrix_set(2, global.GLR_MATRIX_WORLD_IDENTITY);
                    shader_set(glr_shader_sprite_color);
                    draw_sprite_ext(ds_list_find_value(element, UnknownEnum.Value_3), ds_list_find_value(element, UnknownEnum.Value_4), ds_list_find_value(element, UnknownEnum.Value_8), ds_list_find_value(element, UnknownEnum.Value_9), ds_list_find_value(element, UnknownEnum.Value_10), ds_list_find_value(element, UnknownEnum.Value_11), ds_list_find_value(element, UnknownEnum.Value_12), ds_list_find_value(element, UnknownEnum.Value_2), 1);
                    shader_reset();
                }
            }
            i--;
        }
        matrix_set(2, global.GLR_MATRIX_WORLD_IDENTITY);
        surface_reset_target();
        dep_texture = surface_get_texture(global.GLR_DEPTH_SURFACE);
    }
    gpu_set_cullmode(2);
    matrix_set(2, global.GLR_MATRIX_WORLD_IDENTITY);
    var light_list_size = ds_list_size(global.GLR_LIGHT_LIST);
    for (var i = 0; i < light_list_size; i++)
    {
        var l_id = ds_list_find_value(global.GLR_LIGHT_LIST, i);
        if (!ds_list_find_value(l_id, UnknownEnum.Value_1))
        {
            continue;
        }
        var l_x = ds_list_find_value(l_id, UnknownEnum.Value_3);
        var l_y = ds_list_find_value(l_id, UnknownEnum.Value_4);
        var l_rotation = ds_list_find_value(l_id, UnknownEnum.Value_5);
        var l_xscale = ds_list_find_value(l_id, UnknownEnum.Value_7);
        if (l_xscale == 0)
        {
            continue;
        }
        var l_yscale = ds_list_find_value(l_id, UnknownEnum.Value_8);
        if (l_yscale == 0)
        {
            continue;
        }
        var l_bcircle = ds_list_find_value(l_id, UnknownEnum.Value_18);
        var test_x = l_x - clamp(l_x, v_x0, v_x1);
        var test_y = l_y - clamp(l_y, v_y0, v_y1);
        var outofview = ((test_x * test_x) + (test_y * test_y)) > (l_bcircle * l_bcircle);
        ds_list_set(l_id, UnknownEnum.Value_28, outofview);
        if (outofview)
        {
            continue;
        }
        var l_color = ds_list_find_value(l_id, UnknownEnum.Value_11);
        var l_intensity = ds_list_find_value(l_id, UnknownEnum.Value_13);
        var l_sprite = ds_list_find_value(l_id, UnknownEnum.Value_14);
        var l_spr_index = ds_list_find_value(l_id, UnknownEnum.Value_15);
        var l_layer = ds_list_find_value(l_id, UnknownEnum.Value_16);
        var l_static = ds_list_find_value(l_id, UnknownEnum.Value_2);
        var l_spr_xo = sprite_get_xoffset(l_sprite);
        var l_spr_yo = sprite_get_yoffset(l_sprite);
        var l_spr_w = sprite_get_width(l_sprite);
        if (l_spr_w == 0)
        {
            continue;
        }
        var l_spr_h = sprite_get_height(l_sprite);
        if (l_spr_h == 0)
        {
            continue;
        }
        var l_xo = l_spr_xo * l_xscale;
        var l_yo = l_spr_yo * l_yscale;
        var l_w = l_spr_w * l_xscale;
        var l_h = l_spr_h * l_yscale;
        var l_surf_xo = l_spr_xo;
        var l_surf_yo = l_spr_yo;
        var l_depth = ds_list_find_value(l_id, UnknownEnum.Value_6);
        if (l_rotation == 0)
        {
            if ((l_x - l_xo) > v_x1)
            {
                continue;
            }
            if ((l_y - l_yo) > v_y1)
            {
                continue;
            }
            if (((l_x - l_xo) + l_w) < v_x0)
            {
                continue;
            }
            if (((l_y - l_yo) + l_h) < v_y0)
            {
                continue;
            }
        }
        var tra_matrix = matrix_build(((l_xo / l_w) * 2) - 1, 1 - ((l_yo / l_h) * 2), 0, 0, 0, 0, 1 / l_xscale, 1 / l_yscale, 1);
        var light_matrix_complete = matrix_multiply(ds_list_find_value(l_id, UnknownEnum.Value_27), main_viewproj_mat);
        var l_shadowmap, l_shadowsprite_surf2;
        if (l_static)
        {
            l_shadowmap = ds_list_find_value(l_id, UnknownEnum.Value_20);
            if (l_shadowmap == -1 || (l_shadowmap != -1 && !surface_exists(l_shadowmap)))
            {
                ds_list_set(l_id, UnknownEnum.Value_23, false);
                var _depth_setting = surface_get_depth_disable();
                surface_depth_disable(false);
                l_shadowmap = surface_create(l_spr_w, l_spr_h);
                surface_depth_disable(_depth_setting);
                if (!surface_exists(l_shadowmap))
                {
                    return 0;
                }
                l_shadow_strength = ds_list_find_value(l_id, UnknownEnum.Value_24);
                l_tolerance = ds_list_find_value(l_id, UnknownEnum.Value_25);
                ds_list_set(l_id, UnknownEnum.Value_20, l_shadowmap);
                is_clear = true;
                var l_shadowsprite_surf;
                if (global.GLR_SHADOWSPRITE_ENABLED)
                {
                    if (!surface_exists(ds_list_find_value(l_id, UnknownEnum.Value_21)))
                    {
                        _depth_setting = surface_get_depth_disable();
                        surface_depth_disable(false);
                        ds_list_set(l_id, UnknownEnum.Value_21, surface_create(l_spr_w, l_spr_h));
                        surface_depth_disable(_depth_setting);
                        if (!surface_exists(ds_list_find_value(l_id, UnknownEnum.Value_21)))
                        {
                            return 0;
                        }
                    }
                    l_shadowsprite_surf = ds_list_find_value(l_id, UnknownEnum.Value_21);
                    surface_set_target(l_shadowsprite_surf);
                    draw_clear_alpha(c_black, 0);
                    var proj_matrix = matrix_get(1);
                    gpu_set_cullmode(0);
                    glr_set_projection_ortho(l_x - (l_w / 2), l_y - (l_h / 2), l_w, l_h, -l_rotation);
                    matrix_set(1, matrix_multiply(proj_matrix, tra_matrix));
                    sz = ds_list_size(global.GLR_SPR_STC_LIST);
                    for (var j = 0; j < sz; j++)
                    {
                        var spr = ds_list_find_value(global.GLR_SPR_STC_LIST, j);
                        if (ds_list_find_value(spr, UnknownEnum.Value_0) && l_layer >= ds_list_find_value(spr, UnknownEnum.Value_2))
                        {
                            var px = ds_list_find_value(spr, UnknownEnum.Value_5);
                            var py = ds_list_find_value(spr, UnknownEnum.Value_6);
                            var xscale = ds_list_find_value(spr, UnknownEnum.Value_7);
                            var yscale = ds_list_find_value(spr, UnknownEnum.Value_8);
                            if (point_distance(px, py, l_x, l_y) > (((ds_list_find_value(spr, UnknownEnum.Value_11) * max(abs(xscale), abs(yscale))) + l_bcircle) - l_tolerance))
                            {
                            }
                            else
                            {
                                var rot = ds_list_find_value(spr, UnknownEnum.Value_9);
                                var tex = ds_list_find_value(spr, UnknownEnum.Value_3);
                                var sub = ds_list_find_value(spr, UnknownEnum.Value_4);
                                is_clear = false;
                                draw_sprite_ext(tex, sub, px, py, xscale, yscale, rot, c_white, 1);
                            }
                        }
                    }
                    matrix_set(2, global.GLR_MAT_IDENTITY);
                    surface_reset_target();
                    gpu_set_cullmode(2);
                    if (!surface_exists(ds_list_find_value(l_id, UnknownEnum.Value_22)))
                    {
                        _depth_setting = surface_get_depth_disable();
                        surface_depth_disable(false);
                        ds_list_set(l_id, UnknownEnum.Value_22, surface_create(l_spr_w, l_spr_h));
                        surface_depth_disable(_depth_setting);
                        if (!surface_exists(ds_list_find_value(l_id, UnknownEnum.Value_22)))
                        {
                            return 0;
                        }
                    }
                    l_shadowsprite_surf2 = ds_list_find_value(l_id, UnknownEnum.Value_22);
                    if (!is_clear)
                    {
                        var scal = 0.0007;
                        var pow = 0.16;
                        surface_set_target(l_shadowsprite_surf2);
                        draw_clear_alpha(c_black, 0);
                        shader_set(glr_shader_shadow_sprite);
                        shader_set_uniform_f(global.GLR_UNIF_LIGHT_OFFSET_SPR, l_xo / l_w, l_yo / l_h);
                        shader_set_uniform_f(global.GLR_UNIF_LIGHT_SCALE_SPR, scal);
                        draw_surface(l_shadowsprite_surf, 0, 0);
                        shader_reset();
                        surface_reset_target();
                        repeat (2)
                        {
                            pow *= 1.358;
                            scal = power(0.0007, pow);
                            surface_set_target(l_shadowsprite_surf);
                            shader_set(glr_shader_shadow_sprite);
                            shader_set_uniform_f(global.GLR_UNIF_LIGHT_OFFSET_SPR, l_xo / l_w, l_yo / l_h);
                            shader_set_uniform_f(global.GLR_UNIF_LIGHT_SCALE_SPR, scal);
                            draw_surface(l_shadowsprite_surf2, 0, 0);
                            shader_reset();
                            surface_reset_target();
                            pow *= 1.358;
                            scal = power(0.0007, pow);
                            surface_set_target(l_shadowsprite_surf2);
                            shader_set(glr_shader_shadow_sprite);
                            shader_set_uniform_f(global.GLR_UNIF_LIGHT_OFFSET_SPR, l_xo / l_w, l_yo / l_h);
                            shader_set_uniform_f(global.GLR_UNIF_LIGHT_SCALE_SPR, scal);
                            draw_surface(l_shadowsprite_surf, 0, 0);
                            shader_reset();
                            surface_reset_target();
                        }
                    }
                }
                gpu_set_cullmode(0);
                var static_dep_texture = -1;
                size = ds_list_size(global.GLR_MESH_SORTED_LIST);
                if (size > 0)
                {
                    surface_set_target(l_shadowsprite_surf);
                    glr_set_projection_ortho(0, 0, l_w, l_h, 0);
                    var view = matrix_get(0);
                    var tr = matrix_multiply(matrix_build(-l_x, -l_y, 0, 0, 0, 0, 1, 1, 1), matrix_build(l_xo, l_yo, 0, 0, 0, -l_rotation, 1, 1, 1));
                    matrix_set(0, matrix_multiply(tr, view));
                    if (global.GLR_BACKGROUND_RECEIVE_SHADOWS)
                    {
                        draw_clear_alpha(c_black, 0);
                    }
                    else
                    {
                        draw_clear_alpha(c_white, 0);
                        sz = ds_list_size(global.GLR_RECEIVER_LIST);
                        for (var j = 0; j < sz; j++)
                        {
                            var rc = ds_list_find_value(global.GLR_RECEIVER_LIST, j);
                            if (ds_list_find_value(rc, UnknownEnum.Value_1))
                            {
                                var px = ds_list_find_value(rc, UnknownEnum.Value_4);
                                var py = ds_list_find_value(rc, UnknownEnum.Value_5);
                                var xscale = ds_list_find_value(rc, UnknownEnum.Value_6);
                                var yscale = ds_list_find_value(rc, UnknownEnum.Value_7);
                                var rot = ds_list_find_value(rc, UnknownEnum.Value_8);
                                if (point_distance(px, py, l_x, l_y) > (((ds_list_find_value(rc, UnknownEnum.Value_9) * max(abs(xscale), abs(yscale))) + l_bcircle) - l_tolerance))
                                {
                                }
                                else
                                {
                                    draw_sprite_ext(ds_list_find_value(rc, UnknownEnum.Value_2), ds_list_find_value(rc, UnknownEnum.Value_3), px, py, xscale, yscale, rot, c_black, 1);
                                }
                            }
                        }
                    }
                    var n = size - 1;
                    while (n >= 0)
                    {
                        var element = ds_list_find_value(global.GLR_MESH_SORTED_LIST, n);
                        if (ds_list_find_value(element, UnknownEnum.Value_1))
                        {
                            if (ds_list_find_value(element, UnknownEnum.Value_0) == UnknownEnum.Value_2 && ds_list_find_value(element, UnknownEnum.Value_3))
                            {
                                matrix_set(2, ds_list_find_value(element, UnknownEnum.Value_23));
                                var color = ds_list_find_value(element, UnknownEnum.Value_2);
                                var depth_mask = ds_list_find_value(element, UnknownEnum.Value_21);
                                if (depth_mask != -1)
                                {
                                    var index = ds_list_find_value(element, UnknownEnum.Value_22);
                                    shader_set(glr_shader_sprite_color);
                                    draw_sprite_ext(depth_mask, index, 0, 0, 1, 1, 0, color, 1);
                                    shader_reset();
                                }
                                else
                                {
                                    shader_set(glr_shader_mesh_color);
                                    shader_set_uniform_f(global.GLR_UNIF_MESH_COLOR, color_get_red(color) / 255, color_get_green(color) / 255, color_get_blue(color) / 255, 1);
                                    vertex_submit(ds_list_find_value(element, UnknownEnum.Value_5), pr_trianglelist, -1);
                                    shader_reset();
                                }
                            }
                            else if (ds_list_find_value(element, UnknownEnum.Value_0) == UnknownEnum.Value_4)
                            {
                                matrix_set(2, global.GLR_MATRIX_WORLD_IDENTITY);
                                shader_set(glr_shader_sprite_color);
                                draw_sprite_ext(ds_list_find_value(element, UnknownEnum.Value_3), ds_list_find_value(element, UnknownEnum.Value_4), ds_list_find_value(element, UnknownEnum.Value_8), ds_list_find_value(element, UnknownEnum.Value_9), ds_list_find_value(element, UnknownEnum.Value_10), ds_list_find_value(element, UnknownEnum.Value_11), ds_list_find_value(element, UnknownEnum.Value_12), ds_list_find_value(element, UnknownEnum.Value_2), 1);
                                shader_reset();
                            }
                        }
                        n--;
                    }
                    matrix_set(2, global.GLR_MATRIX_WORLD_IDENTITY);
                    shader_reset();
                    surface_reset_target();
                    static_dep_texture = surface_get_texture(l_shadowsprite_surf);
                }
                surface_set_target(l_shadowmap);
                draw_sprite_ext(l_sprite, l_spr_index, l_spr_xo, l_spr_yo, 1, 1, 0, l_color, 1);
                if (!is_clear && global.GLR_SHADOWSPRITE_ENABLED)
                {
                    draw_surface_ext(l_shadowsprite_surf2, 0, 0, 1, 1, 0, -1, l_shadow_strength);
                }
                glr_set_projection_ortho(l_x - (l_w / 2), l_y - (l_h / 2), l_w, l_h, -l_rotation);
                gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
                gpu_set_texrepeat(false);
                sz = ds_list_size(global.GLR_MESH_STC_LIST);
                for (var j = 0; j < sz; j++)
                {
                    var mesh = ds_list_find_value(global.GLR_MESH_STC_LIST, j);
                    if (ds_list_find_value(mesh, UnknownEnum.Value_1) && l_layer >= ds_list_find_value(mesh, UnknownEnum.Value_17))
                    {
                        var px = ds_list_find_value(mesh, UnknownEnum.Value_7);
                        var py = ds_list_find_value(mesh, UnknownEnum.Value_8);
                        if (point_distance(px, py, l_x, l_y) > ((ds_list_find_value(mesh, UnknownEnum.Value_13) + l_bcircle) - l_tolerance))
                        {
                        }
                        else
                        {
                            var buf = ds_list_find_value(mesh, UnknownEnum.Value_4);
                            var zdepth = ds_list_find_value(mesh, UnknownEnum.Value_2);
                            is_clear = false;
                            var shadow_strength = ds_list_find_value(mesh, UnknownEnum.Value_18);
                            matrix_set(2, ds_list_find_value(mesh, UnknownEnum.Value_23));
                            var depth_offset;
                            if (l_depth < zdepth)
                            {
                                depth_offset = 0.1;
                            }
                            else
                            {
                                depth_offset = 0;
                            }
                            shader_set(global.GLR_OS_MESH_SHADER_STATIC);
                            shader_set_uniform_f(global.GLR_UNIF_LIGHT_OFFSET_STATIC, ((l_xo / l_w) * 2) - 1, 1 - ((l_yo / l_h) * 2));
                            shader_set_uniform_f(global.GLR_UNIF_LIGHT_STRENGTH_STATIC, max(l_shadow_strength, shadow_strength));
                            shader_set_uniform_f(global.GLR_UNIF_SHADOW_DEPTH_STATIC, (zdepth / global.GLR_MAX_DEPTH) + depth_offset);
                            vertex_submit(buf, pr_trianglelist, static_dep_texture);
                            shader_reset();
                        }
                    }
                }
                matrix_set(2, global.GLR_MATRIX_WORLD_IDENTITY);
                gpu_set_texrepeat(true);
                gpu_set_blendmode(bm_normal);
                surface_reset_target();
            }
        }
        var is_clear = true;
        var l_shadow_strength = ds_list_find_value(l_id, UnknownEnum.Value_24);
        var l_tolerance = ds_list_find_value(l_id, UnknownEnum.Value_25);
        var sz_static = ds_list_size(global.GLR_SPR_STC_LIST);
        var sz_dynamic = ds_list_size(global.GLR_SPR_DYN_LIST);
        if (global.GLR_SHADOWSPRITE_ENABLED && (sz_static > 0 || sz_dynamic > 0))
        {
            if (!surface_exists(ds_list_find_value(l_id, UnknownEnum.Value_21)))
            {
                var _depth_setting = surface_get_depth_disable();
                surface_depth_disable(false);
                ds_list_set(l_id, UnknownEnum.Value_21, surface_create(l_spr_w, l_spr_h));
                surface_depth_disable(_depth_setting);
                if (!surface_exists(ds_list_find_value(l_id, UnknownEnum.Value_21)))
                {
                    return 0;
                }
            }
            var l_shadowsprite_surf = ds_list_find_value(l_id, UnknownEnum.Value_21);
            surface_set_target(l_shadowsprite_surf);
            draw_clear_alpha(c_black, 0);
            var proj_matrix = matrix_get(1);
            glr_set_projection_ortho(l_x - (l_w / 2), l_y - (l_h / 2), l_w, l_h, -l_rotation);
            matrix_set(1, matrix_multiply(proj_matrix, tra_matrix));
            gpu_set_cullmode(0);
            if (!l_static)
            {
                for (var j = 0; j < sz_static; j++)
                {
                    var spr = ds_list_find_value(global.GLR_SPR_STC_LIST, j);
                    if (ds_list_find_value(spr, UnknownEnum.Value_0) && l_layer >= ds_list_find_value(spr, UnknownEnum.Value_2))
                    {
                        var px = ds_list_find_value(spr, UnknownEnum.Value_5);
                        var py = ds_list_find_value(spr, UnknownEnum.Value_6);
                        var xscale = ds_list_find_value(spr, UnknownEnum.Value_7);
                        var yscale = ds_list_find_value(spr, UnknownEnum.Value_8);
                        if (point_distance(px, py, l_x, l_y) > (((ds_list_find_value(spr, UnknownEnum.Value_11) * max(abs(xscale), abs(yscale))) + l_bcircle) - l_tolerance))
                        {
                        }
                        else
                        {
                            is_clear = false;
                            var tex = ds_list_find_value(spr, UnknownEnum.Value_3);
                            var sub = ds_list_find_value(spr, UnknownEnum.Value_4);
                            var rot = ds_list_find_value(spr, UnknownEnum.Value_9);
                            draw_sprite_ext(tex, sub, px, py, xscale, yscale, rot, c_white, 1);
                        }
                    }
                }
            }
            for (var j = 0; j < sz_dynamic; j++)
            {
                var spr = ds_list_find_value(global.GLR_SPR_DYN_LIST, j);
                if (ds_list_find_value(spr, UnknownEnum.Value_0) && l_layer >= ds_list_find_value(spr, UnknownEnum.Value_2))
                {
                    var px = ds_list_find_value(spr, UnknownEnum.Value_5);
                    var py = ds_list_find_value(spr, UnknownEnum.Value_6);
                    var xscale = ds_list_find_value(spr, UnknownEnum.Value_7);
                    var yscale = ds_list_find_value(spr, UnknownEnum.Value_8);
                    if (point_distance(px, py, l_x, l_y) > (((ds_list_find_value(spr, UnknownEnum.Value_11) * max(abs(xscale), abs(yscale))) + l_bcircle) - l_tolerance))
                    {
                    }
                    else
                    {
                        var tex = ds_list_find_value(spr, UnknownEnum.Value_3);
                        var sub = ds_list_find_value(spr, UnknownEnum.Value_4);
                        var rot = ds_list_find_value(spr, UnknownEnum.Value_9);
                        is_clear = false;
                        draw_sprite_ext(tex, sub, px, py, xscale, yscale, rot, c_white, 1);
                    }
                }
            }
            gpu_set_cullmode(2);
            matrix_set(2, global.GLR_MATRIX_WORLD_IDENTITY);
            surface_reset_target();
            if (!is_clear)
            {
                if (!surface_exists(ds_list_find_value(l_id, UnknownEnum.Value_22)))
                {
                    var _depth_setting = surface_get_depth_disable();
                    surface_depth_disable(false);
                    ds_list_set(l_id, UnknownEnum.Value_22, surface_create(l_spr_w, l_spr_h));
                    surface_depth_disable(_depth_setting);
                    if (!surface_exists(ds_list_find_value(l_id, UnknownEnum.Value_22)))
                    {
                        return 0;
                    }
                }
                l_shadowsprite_surf2 = ds_list_find_value(l_id, UnknownEnum.Value_22);
                var scal = 0.0007;
                var pow = 0.16;
                surface_set_target(l_shadowsprite_surf2);
                draw_clear_alpha(c_black, 0);
                shader_set(glr_shader_shadow_sprite);
                shader_set_uniform_f(global.GLR_UNIF_LIGHT_OFFSET_SPR, l_xo / l_w, l_yo / l_h);
                shader_set_uniform_f(global.GLR_UNIF_LIGHT_SCALE_SPR, scal);
                draw_surface(l_shadowsprite_surf, 0, 0);
                shader_reset();
                surface_reset_target();
                repeat (2)
                {
                    pow *= 1.358;
                    scal = power(0.0007, pow);
                    surface_set_target(l_shadowsprite_surf);
                    shader_set(glr_shader_shadow_sprite);
                    shader_set_uniform_f(global.GLR_UNIF_LIGHT_OFFSET_SPR, l_xo / l_w, l_yo / l_h);
                    shader_set_uniform_f(global.GLR_UNIF_LIGHT_SCALE_SPR, scal);
                    draw_surface(l_shadowsprite_surf2, 0, 0);
                    shader_reset();
                    surface_reset_target();
                    pow *= 1.358;
                    scal = power(0.0007, pow);
                    surface_set_target(l_shadowsprite_surf2);
                    shader_set(glr_shader_shadow_sprite);
                    shader_set_uniform_f(global.GLR_UNIF_LIGHT_OFFSET_SPR, l_xo / l_w, l_yo / l_h);
                    shader_set_uniform_f(global.GLR_UNIF_LIGHT_SCALE_SPR, scal);
                    draw_surface(l_shadowsprite_surf, 0, 0);
                    shader_reset();
                    surface_reset_target();
                }
            }
        }
        if (!surface_exists(ds_list_find_value(l_id, UnknownEnum.Value_19)))
        {
            var _depth_setting = surface_get_depth_disable();
            surface_depth_disable(false);
            ds_list_set(l_id, UnknownEnum.Value_19, surface_create(l_spr_w, l_spr_h));
            surface_depth_disable(_depth_setting);
            if (!surface_exists(ds_list_find_value(l_id, UnknownEnum.Value_19)))
            {
                return 0;
            }
        }
        var l_surf = ds_list_find_value(l_id, UnknownEnum.Value_19);
        surface_set_target(l_surf);
        if (!ds_list_find_value(l_id, UnknownEnum.Value_23))
        {
            if (l_static)
            {
                draw_surface_stretched(l_shadowmap, 0, 0, l_spr_w, l_spr_h);
            }
            else
            {
                draw_sprite_ext(l_sprite, l_spr_index, l_surf_xo, l_surf_yo, 1, 1, 0, l_color, 1);
            }
        }
        if (!is_clear && global.GLR_SHADOWSPRITE_ENABLED)
        {
            draw_surface_ext(l_shadowsprite_surf2, 0, 0, 1, 1, 0, -1, l_shadow_strength);
        }
        surface_reset_target();
        surface_set_target(l_surf);
        var mV = matrix_build_lookat(l_x, l_y, -16000, l_x, l_y, 0, dsin(l_rotation), dcos(l_rotation), 0);
        var mP = matrix_build_projection_ortho(l_w, l_h, 1, 32000);
        var cam = camera_get_active();
        camera_set_view_mat(cam, mV);
        camera_set_proj_mat(cam, matrix_multiply(mP, tra_matrix));
        camera_apply(cam);
        var sz = ds_list_size(global.GLR_DEP_DYN_LIST);
        if (sz > 0)
        {
            gpu_set_cullmode(0);
            for (var j = 0; j < sz; j++)
            {
                var dp = ds_list_find_value(global.GLR_DEP_DYN_LIST, j);
                if (ds_list_find_value(dp, UnknownEnum.Value_0) && ds_list_find_value(dp, UnknownEnum.Value_5) > l_depth)
                {
                    var tex = ds_list_find_value(dp, UnknownEnum.Value_1);
                    var sub = ds_list_find_value(dp, UnknownEnum.Value_2);
                    var px = ds_list_find_value(dp, UnknownEnum.Value_3);
                    var py = ds_list_find_value(dp, UnknownEnum.Value_4);
                    var xscale = ds_list_find_value(dp, UnknownEnum.Value_6);
                    var yscale = ds_list_find_value(dp, UnknownEnum.Value_7);
                    var rot = ds_list_find_value(dp, UnknownEnum.Value_8);
                    if (point_distance(px, py, l_x, l_y) > (((ds_list_find_value(dp, UnknownEnum.Value_10) * max(abs(xscale), abs(yscale))) + l_bcircle) - l_tolerance))
                    {
                    }
                    else
                    {
                        is_clear = false;
                        draw_sprite_ext(tex, sub, px, py, xscale, yscale, rot, c_black, 1);
                    }
                }
            }
            matrix_set(2, global.GLR_MATRIX_WORLD_IDENTITY);
        }
        sz = ds_list_size(global.GLR_MESH_DYN_LIST);
        gpu_set_cullmode(2);
        camera_set_proj_mat(cam, mP);
        camera_apply(cam);
        for (var j = 0; j < sz; j++)
        {
            var mesh = ds_list_find_value(global.GLR_MESH_DYN_LIST, j);
            if (ds_list_find_value(mesh, UnknownEnum.Value_1) && l_layer >= ds_list_find_value(mesh, UnknownEnum.Value_17))
            {
                var px = ds_list_find_value(mesh, UnknownEnum.Value_7);
                var py = ds_list_find_value(mesh, UnknownEnum.Value_8);
                if (point_distance(px, py, l_x, l_y) > ((ds_list_find_value(mesh, UnknownEnum.Value_13) + l_bcircle) - l_tolerance))
                {
                }
                else
                {
                    var buf = ds_list_find_value(mesh, UnknownEnum.Value_4);
                    var zdepth = ds_list_find_value(mesh, UnknownEnum.Value_2);
                    is_clear = false;
                    var shadow_strength = ds_list_find_value(mesh, UnknownEnum.Value_18);
                    matrix_set(2, ds_list_find_value(mesh, UnknownEnum.Value_23));
                    var depth_offset;
                    if (l_depth < zdepth)
                    {
                        depth_offset = 0.1;
                    }
                    else
                    {
                        depth_offset = 0;
                    }
                    shader_set(global.GLR_OS_MESH_SHADER);
                    shader_set_uniform_f(global.GLR_UNIF_LIGHT_OFFSET, ((l_xo / l_w) * 2) - 1, 1 - ((l_yo / l_h) * 2));
                    shader_set_uniform_f(global.GLR_UNIF_LIGHT_STRENGTH, max(l_shadow_strength, shadow_strength));
                    shader_set_uniform_f_array(global.GLR_UNIF_MESH_MATDEPTH, light_matrix_complete);
                    shader_set_uniform_f(global.GLR_UNIF_SHADOW_DEPTH, (zdepth / global.GLR_MAX_DEPTH) + depth_offset);
                    vertex_submit(buf, pr_trianglelist, dep_texture);
                    shader_reset();
                }
            }
        }
        if (!l_static)
        {
            sz = ds_list_size(global.GLR_MESH_STC_LIST);
            for (var j = 0; j < sz; j++)
            {
                var mesh = ds_list_find_value(global.GLR_MESH_STC_LIST, j);
                if (ds_list_find_value(mesh, UnknownEnum.Value_1) && l_layer >= ds_list_find_value(mesh, UnknownEnum.Value_17))
                {
                    var px = ds_list_find_value(mesh, UnknownEnum.Value_7);
                    var py = ds_list_find_value(mesh, UnknownEnum.Value_8);
                    if (point_distance(px, py, l_x, l_y) > ((ds_list_find_value(mesh, UnknownEnum.Value_13) + l_bcircle) - l_tolerance))
                    {
                    }
                    else
                    {
                        var buf = ds_list_find_value(mesh, UnknownEnum.Value_4);
                        var zdepth = ds_list_find_value(mesh, UnknownEnum.Value_2);
                        is_clear = false;
                        var shadow_strength = ds_list_find_value(mesh, UnknownEnum.Value_18);
                        matrix_set(2, ds_list_find_value(mesh, UnknownEnum.Value_23));
                        var depth_offset;
                        if (l_depth < zdepth)
                        {
                            depth_offset = 0.1;
                        }
                        else
                        {
                            depth_offset = 0;
                        }
                        shader_set(global.GLR_OS_MESH_SHADER);
                        shader_set_uniform_f(global.GLR_UNIF_LIGHT_OFFSET, ((l_xo / l_w) * 2) - 1, 1 - ((l_yo / l_h) * 2));
                        shader_set_uniform_f(global.GLR_UNIF_LIGHT_STRENGTH, max(l_shadow_strength, shadow_strength));
                        shader_set_uniform_f_array(global.GLR_UNIF_MESH_MATDEPTH, light_matrix_complete);
                        shader_set_uniform_f(global.GLR_UNIF_SHADOW_DEPTH, (zdepth / global.GLR_MAX_DEPTH) + depth_offset);
                        vertex_submit(buf, pr_trianglelist, dep_texture);
                        shader_reset();
                    }
                }
            }
        }
        matrix_set(2, global.GLR_MATRIX_WORLD_IDENTITY);
        ds_list_set(l_id, UnknownEnum.Value_23, is_clear);
        surface_reset_target();
    }
    gpu_set_cullmode(0);
    if (global.GLR_DIRECTIONAL_ENABLED && global.GLR_DIRECTIONAL_STRENGTH > 0)
    {
        if (!surface_exists(global.GLR_DIRECTIONAL_SURFACE))
        {
            var _depth_setting = surface_get_depth_disable();
            surface_depth_disable(false);
            global.GLR_DIRECTIONAL_SURFACE = surface_create(global.GLR_DIRECTIONAL_WIDTH, global.GLR_DIRECTIONAL_HEIGHT);
            surface_depth_disable(_depth_setting);
            if (!surface_exists(global.GLR_DIRECTIONAL_SURFACE))
            {
                return 0;
            }
        }
        surface_set_target(global.GLR_DIRECTIONAL_SURFACE);
        glr_set_projection_ortho(v_x0, v_y0, global.GLR_WIDTH / global.GLR_ZOOM, global.GLR_HEIGHT / global.GLR_ZOOM, 0);
        draw_clear_alpha(c_black, 0);
        global.GLR_DIRECTIONAL_CLEAR = true;
        var sz = ds_list_size(global.GLR_MESH_STC_LIST);
        for (var j = 0; j < sz; j++)
        {
            var mesh = ds_list_find_value(global.GLR_MESH_STC_LIST, j);
            if (ds_list_find_value(mesh, UnknownEnum.Value_1))
            {
                global.GLR_DIRECTIONAL_CLEAR = false;
                var buf = ds_list_find_value(mesh, UnknownEnum.Value_4);
                var zdepth = ds_list_find_value(mesh, UnknownEnum.Value_2);
                matrix_set(2, ds_list_find_value(mesh, UnknownEnum.Value_23));
                shader_set(global.GLR_OS_DIRECTIONAL_SHADER);
                var len = ds_list_find_value(mesh, UnknownEnum.Value_19);
                shader_set_uniform_f(global.GLR_UNIF_DIRECTIONAL_DEPTH, zdepth / global.GLR_MAX_DEPTH);
                shader_set_uniform_f(global.GLR_UNIF_DIRECTIONAL, lengthdir_x(global.GLR_DIRECTIONAL_LENGTH * len, global.GLR_DIRECTIONAL_ANGLE), lengthdir_y(global.GLR_DIRECTIONAL_LENGTH * len, global.GLR_DIRECTIONAL_ANGLE));
                vertex_submit(buf, pr_trianglelist, dep_texture);
                shader_reset();
            }
        }
        sz = ds_list_size(global.GLR_MESH_DYN_LIST);
        for (var j = 0; j < sz; j++)
        {
            var mesh = ds_list_find_value(global.GLR_MESH_DYN_LIST, j);
            if (ds_list_find_value(mesh, UnknownEnum.Value_1))
            {
                global.GLR_DIRECTIONAL_CLEAR = false;
                var buf = ds_list_find_value(mesh, UnknownEnum.Value_4);
                var zdepth = ds_list_find_value(mesh, UnknownEnum.Value_2);
                matrix_set(2, ds_list_find_value(mesh, UnknownEnum.Value_23));
                shader_set(global.GLR_OS_DIRECTIONAL_SHADER);
                var len = ds_list_find_value(mesh, UnknownEnum.Value_19);
                shader_set_uniform_f(global.GLR_UNIF_DIRECTIONAL_DEPTH, zdepth / global.GLR_MAX_DEPTH);
                shader_set_uniform_f(global.GLR_UNIF_DIRECTIONAL, lengthdir_x(global.GLR_DIRECTIONAL_LENGTH * len, global.GLR_DIRECTIONAL_ANGLE), lengthdir_y(global.GLR_DIRECTIONAL_LENGTH * len, global.GLR_DIRECTIONAL_ANGLE));
                vertex_submit(buf, pr_trianglelist, dep_texture);
                shader_reset();
            }
        }
        sz = ds_list_size(global.GLR_DIR_CUSTOM_LIST);
        if (sz > 0)
        {
            matrix_set(2, global.GLR_MATRIX_WORLD_IDENTITY);
            shader_set(global.GLR_OS_DIRECTIONAL_CUSTOM_SHADER);
            texture_set_stage(global.GLR_SAMPLER_DIRECTIONAL_CUSTOM, dep_texture);
            gpu_set_cullmode(0);
            for (var j = 0; j < sz; j++)
            {
                var dc = ds_list_find_value(global.GLR_DIR_CUSTOM_LIST, j);
                if (ds_list_find_value(dc, UnknownEnum.Value_1))
                {
                    shader_set_uniform_f(global.GLR_UNIF_DIRECTIONAL_CUSTOM_DEPTH, ds_list_find_value(dc, UnknownEnum.Value_2) / global.GLR_MAX_DEPTH);
                    draw_sprite_ext(ds_list_find_value(dc, UnknownEnum.Value_5), ds_list_find_value(dc, UnknownEnum.Value_6), ds_list_find_value(dc, UnknownEnum.Value_8), ds_list_find_value(dc, UnknownEnum.Value_9), ds_list_find_value(dc, UnknownEnum.Value_10) * (0.6 + global.GLR_DIRECTIONAL_LENGTH) * ds_list_find_value(dc, UnknownEnum.Value_7), ds_list_find_value(dc, UnknownEnum.Value_11), global.GLR_DIRECTIONAL_ANGLE, c_black, 1);
                }
            }
            shader_reset();
        }
        matrix_set(2, global.GLR_MATRIX_WORLD_IDENTITY);
        surface_reset_target();
    }
    return 1;
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4,
    Value_5,
    Value_6,
    Value_7,
    Value_8,
    Value_9,
    Value_10,
    Value_11,
    Value_12,
    Value_13,
    Value_14,
    Value_15,
    Value_16,
    Value_17,
    Value_18,
    Value_19,
    Value_20,
    Value_21,
    Value_22,
    Value_23,
    Value_24,
    Value_25,
    Value_27 = 27,
    Value_28
}
