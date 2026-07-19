inView = x > (camera_get_view_x(view_camera[0]) - 100) && x < (camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]) + 100) && y > (camera_get_view_y(view_camera[0]) - 100) && y < (camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]) + 100 + abs(bbox_top - bbox_bottom));
if (inView)
{
    shader_set(shdrMob);
    shader_set_uniform_f(uni_add, add);
    if (instance_exists(obj_Player))
    {
        var player = instance_find(obj_Player, 0);
        if (player.x > (x - spriteWidth) && player.x < (x + spriteWidth) && player.y > (y - spriteHeight) && player.y < (y - 6))
        {
            image_alpha = 0.5;
        }
        else
        {
            image_alpha = 1;
        }
    }
    if (transparent)
    {
        gpu_set_blendmode(bm_add);
    }
    depth = -y;
    draw_sprite_ext(sprite_index, image_index, x + ((hitShake > 0) * shakeDisplacement), y + 10, 1, -0.7, 0, c_black, 0.3);
    gpu_set_blendmode(bm_normal);
    shader_reset();
    if (timeStartedAttacking > -1 && global.debug)
    {
        draw_set_color(c_white);
        draw_set_font(Galmuri9);
        draw_set_halign(fa_center);
        draw_text(x, y + 5, totalDamageTaken / max(1, timeStartedAttacking div 60));
    }
}
