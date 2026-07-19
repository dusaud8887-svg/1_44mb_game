inView = x > (camera_get_view_x(view_camera[0]) - 100) && x < (camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]) + 100) && y > (camera_get_view_y(view_camera[0]) - 100) && y < (camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]) + 100 + abs(bbox_top - bbox_bottom));
if (inView)
{
    shader_set(shdrMob);
    shader_set_uniform_f(uni_add, add);
    depth = -y + 500;
    draw_sprite_ext(sprite_index, image_index, x + ((hitShake > 0) * shakeDisplacement), y, image_xscale, image_yscale, image_angle, c_white, image_alpha);
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
