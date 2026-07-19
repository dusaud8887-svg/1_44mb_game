inView = x > (camera_get_view_x(view_camera[0]) - 32) && x < (camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]) + 32) && y > (camera_get_view_y(view_camera[0]) - 32) && y < (camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]) + 32 + abs(bbox_top - bbox_bottom));
if (variable_struct_names_count(customDrawScriptBelow) > 0)
{
    var keys = variable_struct_get_names(customDrawScriptBelow);
    for (var i = 0; i < array_length(keys); i++)
    {
        var Script = variable_struct_get(customDrawScriptBelow, keys[i]);
        Script(id);
    }
}
if (inView && isVisible)
{
    shader_set(shdrMob);
    shader_set_uniform_f(uni_add, add);
    if (global.reflection)
    {
        draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, -abs(0.5 * image_yscale), image_angle, make_color_rgb(50, 50, 130), 0.4);
    }
    else
    {
        shadowX = x;
        if (!inAir)
        {
            shadowY = y;
        }
        draw_sprite_ext(spr_Shadow, 0, shadowX, shadowY, image_xscale, image_yscale, 0, c_white, 0.8);
    }
    if (transparent)
    {
        gpu_set_blendmode(bm_add);
    }
    if (variable_instance_exists(id, "upsideDown") && upsideDown)
    {
        draw_sprite_ext(sprite_index, image_index, x, y - abs(bbox_top - bbox_bottom), image_xscale, -image_yscale, image_angle, spriteColor, image_alpha);
    }
    else
    {
        draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, spriteColor, image_alpha);
    }
    gpu_set_blendmode(bm_normal);
    shader_reset();
    if (variable_struct_names_count(customDrawScriptAbove) > 0)
    {
        var keys = variable_struct_get_names(customDrawScriptAbove);
        for (var i = 0; i < array_length(keys); i++)
        {
            var Script = variable_struct_get(customDrawScriptAbove, keys[i]);
            Script(id);
        }
    }
    if (array_length(debuffDisplay) > 0)
    {
        array_delete(debuffDisplay, 0, array_length(debuffDisplay));
    }
    for (var i = 0; i < array_length(debuffIcons); i++)
    {
        if (debuffIcons[i] > 0)
        {
            array_push(debuffDisplay, [i, debuffIcons[i]]);
        }
    }
    for (var i = 0; i < array_length(debuffDisplay); i++)
    {
        draw_sprite_ext(spr_statusEffects, debuffDisplay[i][0], x + 15 + (i * 13), y + 2, 1, 1, 0, c_white, 1);
        if (debuffDisplay[i][1] > 1)
        {
            draw_set_font(jpFont);
            draw_set_color(c_white);
            draw_text_outline(x + 15 + (i * 13), y + 2, debuffDisplay[i][1], 2, 0, 4, 12, 30, 16777215, 1);
        }
    }
}
