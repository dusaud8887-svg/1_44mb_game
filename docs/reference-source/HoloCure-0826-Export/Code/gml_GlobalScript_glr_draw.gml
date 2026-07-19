function glr_draw()
{
    var v_x0, v_y0, v_x1, v_y1;
    if (view_enabled)
    {
        var cam = view_camera[global.GLR_VIEW];
        v_x0 = camera_get_view_x(cam);
        v_y0 = camera_get_view_y(cam);
        v_x1 = v_x0 + camera_get_view_width(cam);
        v_y1 = v_y0 + camera_get_view_height(cam);
    }
    else
    {
        v_x0 = 0;
        v_y0 = 0;
        v_x1 = room_width;
        v_y1 = room_height;
    }
    var mat_offset = matrix_build(-v_x0, -v_y0, 0, 0, 0, 0, 1, 1, 1);
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
    surface_set_target(global.GLR_MAIN_SURFACE);
    draw_clear(global.GLR_AMBIENT_COLOR);
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
        draw_surface_ext(global.GLR_DIRECTIONAL_SURFACE, 0, 0, 1, 1, 0, -1, global.GLR_DIRECTIONAL_STRENGTH);
    }
    glr_set_projection_ortho(0, 0, global.GLR_WIDTH, global.GLR_HEIGHT, 0);
    if (!global.GLR_BACKGROUND_RECEIVE_SHADOWS && surface_exists(global.GLR_DEPTH_SURFACE))
    {
        shader_set(glr_shader_receiver_normal);
        draw_surface_stretched(global.GLR_DEPTH_SURFACE, 0, 0, global.GLR_WIDTH, global.GLR_HEIGHT);
        shader_reset();
    }
    glr_set_projection_ortho(0, 0, global.GLR_WIDTH / global.GLR_ZOOM, global.GLR_HEIGHT / global.GLR_ZOOM, 0);
    var sz = ds_list_size(global.GLR_SHADOWAREA_LIST);
    var c = 1 - global.GLR_DIRECTIONAL_STRENGTH;
    for (var j = 0; j < sz; j++)
    {
        var l = ds_list_find_value(global.GLR_SHADOWAREA_LIST, j);
        if (ds_list_find_value(l, UnknownEnum.Value_0))
        {
            var ill = ds_list_find_value(l, UnknownEnum.Value_6) * c;
            matrix_set(2, matrix_multiply(ds_list_find_value(l, UnknownEnum.Value_7), mat_offset));
            shader_set(glr_shader_mesh_color);
            shader_set_uniform_f(global.GLR_UNIF_MESH_COLOR, global.GLR_AMBIENT_R * ill, global.GLR_AMBIENT_G * ill, global.GLR_AMBIENT_B * ill, 1);
            vertex_submit(ds_list_find_value(l, UnknownEnum.Value_1), pr_trianglestrip, -1);
            shader_reset();
        }
    }
    matrix_set(2, global.GLR_MATRIX_WORLD_IDENTITY);
    surface_reset_target();
    gpu_set_blendmode_ext_sepalpha(bm_one, bm_one, bm_zero, bm_one);
    surface_set_target(global.GLR_MAIN_SURFACE);
    glr_set_projection_ortho(0, 0, global.GLR_WIDTH / global.GLR_ZOOM, global.GLR_HEIGHT / global.GLR_ZOOM, 0);
    for (var i = 0; i < ds_list_size(global.GLR_LIGHT_LIST); i++)
    {
        var l_id = ds_list_find_value(global.GLR_LIGHT_LIST, i);
        if (!ds_list_find_value(l_id, UnknownEnum.Value_1) || ds_list_find_value(l_id, UnknownEnum.Value_28))
        {
            continue;
        }
        var l_intensity = ds_list_find_value(l_id, UnknownEnum.Value_13);
        if (!surface_exists(ds_list_find_value(l_id, UnknownEnum.Value_19)))
        {
            var l_sprite = ds_list_find_value(l_id, UnknownEnum.Value_14);
            var l_spr_w = sprite_get_width(l_sprite);
            var l_spr_h = sprite_get_height(l_sprite);
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
        matrix_set(2, matrix_multiply(ds_list_find_value(l_id, UnknownEnum.Value_27), mat_offset));
        draw_surface_stretched(l_surf, 0, 0, 1, 1);
    }
    matrix_set(2, global.GLR_MATRIX_WORLD_IDENTITY);
    for (var i = 0; i < ds_list_size(global.GLR_LIGHT_LIST_SIMPLE); i++)
    {
        var l_id = ds_list_find_value(global.GLR_LIGHT_LIST_SIMPLE, i);
        if (!ds_list_find_value(l_id, UnknownEnum.Value_1))
        {
            continue;
        }
        var l_x = ds_list_find_value(l_id, UnknownEnum.Value_3);
        var l_y = ds_list_find_value(l_id, UnknownEnum.Value_4);
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
        var l_bcircle = ds_list_find_value(l_id, UnknownEnum.Value_17) * max(l_xscale, l_yscale);
        var test_x = l_x - clamp(l_x, v_x0, v_x1);
        var test_y = l_y - clamp(l_y, v_y0, v_y1);
        if (((test_x * test_x) + (test_y * test_y)) > (l_bcircle * l_bcircle))
        {
            continue;
        }
        var l_rotation = ds_list_find_value(l_id, UnknownEnum.Value_5);
        var l_color = ds_list_find_value(l_id, UnknownEnum.Value_11);
        var l_alpha = ds_list_find_value(l_id, UnknownEnum.Value_12);
        var l_intensity = ds_list_find_value(l_id, UnknownEnum.Value_13);
        var l_sprite = ds_list_find_value(l_id, UnknownEnum.Value_14);
        var l_spr_index = ds_list_find_value(l_id, UnknownEnum.Value_15);
        draw_sprite_ext(l_sprite, l_spr_index, l_x - v_x0, l_y - v_y0, l_xscale, l_yscale, l_rotation, l_color, l_alpha);
    }
    surface_reset_target();
    gpu_set_blendmode(bm_normal);
    if (global.GLR_OCCLUSION_ENABLED)
    {
        if (!surface_exists(global.GLR_DEPTH_SURFACE))
        {
            global.GLR_DEPTH_SURFACE = surface_create(global.GLR_MAIN_SURFACE_WIDTH, global.GLR_MAIN_SURFACE_HEIGHT);
            if (!surface_exists(global.GLR_DEPTH_SURFACE))
            {
                return 0;
            }
        }
        var size = ds_list_size(global.GLR_OCCLUSION_LIST);
        var size2 = ds_list_size(global.GLR_OCCLUSION_LIST_INST);
        if (size > 0 || size2 > 0)
        {
            surface_set_target(global.GLR_DEPTH_SURFACE);
            glr_set_projection_ortho(0, 0, global.GLR_WIDTH / global.GLR_ZOOM, global.GLR_HEIGHT / global.GLR_ZOOM, 0);
            shader_set(glr_shader_depth);
            for (var i = 0; i < size; i++)
            {
                var l = ds_list_find_value(global.GLR_OCCLUSION_LIST, i);
                if (ds_list_find_value(l, UnknownEnum.Value_0))
                {
                    var px = ds_list_find_value(l, UnknownEnum.Value_3);
                    var py = ds_list_find_value(l, UnknownEnum.Value_4);
                    var bcircle = ds_list_find_value(l, UnknownEnum.Value_9);
                    var test_x = px - clamp(px, v_x0, v_x1);
                    var test_y = py - clamp(py, v_y0, v_y1);
                    if (((test_x * test_x) + (test_y * test_y)) < (bcircle * bcircle))
                    {
                        draw_sprite_ext(ds_list_find_value(l, UnknownEnum.Value_1), ds_list_find_value(l, UnknownEnum.Value_2), px - v_x0, py - v_y0, ds_list_find_value(l, UnknownEnum.Value_5), ds_list_find_value(l, UnknownEnum.Value_6), ds_list_find_value(l, UnknownEnum.Value_7), c_black, 1);
                    }
                }
            }
            for (var i = 0; i < size2; i++)
            {
                var inst = ds_list_find_value(global.GLR_OCCLUSION_LIST_INST, i);
                with (inst)
                {
                    draw_sprite_ext(sprite_index, image_index, x - v_x0, y - v_y0, image_xscale, image_yscale, image_angle, c_black, 1);
                }
            }
            shader_reset();
            surface_reset_target();
        }
    }
    if (global.GLR_BLUR_ENABLED)
    {
        if (!surface_exists(global.GLR_BLUR_SURFACE))
        {
            global.GLR_BLUR_SURFACE = surface_create(global.GLR_MAIN_SURFACE_WIDTH, global.GLR_MAIN_SURFACE_HEIGHT);
            if (!surface_exists(global.GLR_BLUR_SURFACE))
            {
                return 0;
            }
        }
        surface_set_target(global.GLR_BLUR_SURFACE);
        draw_clear_alpha(c_black, 0);
        shader_set(glr_shader_blur_hor);
        draw_surface(global.GLR_MAIN_SURFACE, 0, 0);
        shader_reset();
        surface_reset_target();
        gpu_set_blendmode_ext(bm_zero, bm_src_color);
        shader_set(glr_shader_blur_ver);
        if (surface_exists(global.GLR_MAIN_SURFACE))
        {
            var offsetX;
            if (v_x0 > 0)
            {
                offsetX = floor(v_x0);
            }
            else
            {
                offsetX = ceil(v_x0);
            }
            var offsetY;
            if (v_y0 > 0)
            {
                offsetY = floor(v_y0);
            }
            else
            {
                offsetY = ceil(v_y0);
            }
            draw_surface_stretched(global.GLR_BLUR_SURFACE, offsetX, offsetY, global.GLR_WIDTH / global.GLR_ZOOM, global.GLR_HEIGHT / global.GLR_ZOOM);
        }
        shader_reset();
        gpu_set_blendmode(bm_normal);
    }
    else
    {
        gpu_set_blendmode_ext(bm_zero, bm_src_color);
        if (global.GLR_FXAA_ENABLED)
        {
            shader_set(glr_shader_fxaa);
            shader_set_uniform_f(global.GLR_UNIF_FXAA_SIZE, global.GLR_WIDTH / global.GLR_ZOOM, global.GLR_HEIGHT / global.GLR_ZOOM);
        }
        if (surface_exists(global.GLR_MAIN_SURFACE))
        {
            var offsetX;
            if (v_x0 > 0)
            {
                offsetX = floor(v_x0);
            }
            else
            {
                offsetX = ceil(v_x0);
            }
            var offsetY;
            if (v_y0 > 0)
            {
                offsetY = floor(v_y0);
            }
            else
            {
                offsetY = ceil(v_y0);
            }
            draw_surface_stretched(global.GLR_MAIN_SURFACE, offsetX, offsetY, global.GLR_WIDTH / global.GLR_ZOOM, global.GLR_HEIGHT / global.GLR_ZOOM);
        }
        if (global.GLR_FXAA_ENABLED)
        {
            shader_reset();
        }
        gpu_set_blendmode(bm_normal);
    }
    if (global.GLR_OCCLUSION_ENABLED && surface_exists(global.GLR_DEPTH_SURFACE))
    {
        gpu_set_texrepeat(false);
        shader_set(glr_shader_ambient_occlusion);
        shader_set_uniform_f(global.GLR_UNIF_OCCLUSION, global.GLR_OCCLUSION_INTENSITY);
        draw_surface_stretched(global.GLR_DEPTH_SURFACE, v_x0, v_y0, global.GLR_WIDTH / global.GLR_ZOOM, global.GLR_HEIGHT / global.GLR_ZOOM);
        shader_reset();
        gpu_set_texrepeat(true);
    }
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
    Value_11 = 11,
    Value_12,
    Value_13,
    Value_14,
    Value_15,
    Value_17 = 17,
    Value_19 = 19,
    Value_27 = 27,
    Value_28
}
