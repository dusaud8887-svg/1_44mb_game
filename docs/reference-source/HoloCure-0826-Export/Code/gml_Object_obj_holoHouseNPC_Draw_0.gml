if (!spawnCheck)
{
    depth = -y - 2;
    draw_sprite_ext(spr_Shadow, 0, x, y, image_xscale, image_yscale, 0, c_white, 0.8 * image_alpha);
    if (instance_exists(obj_DayNightCycle) && obj_DayNightCycle.rain)
    {
        draw_sprite_ext(spr_umbrella2, 0, x, y, image_xscale, 1, 0, c_white, image_alpha);
    }
    shader_set(shdrMob);
    shader_set_uniform_f(uni_add, add);
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_white, image_alpha);
    if (isFishing)
    {
        draw_sprite_ext(spr_FishingRod, 0, x, y, image_xscale, image_yscale, image_angle, c_white, image_alpha);
    }
    shader_reset();
    if (instance_exists(obj_DayNightCycle) && obj_DayNightCycle.rain)
    {
        draw_sprite_ext(spr_umbrella, 0, x, y, image_xscale, 1, 0, c_white, image_alpha);
    }
}
if (highlighted)
{
    if (mouse_check_button_pressed(mb_left) && (mouse_x > (x - 20) && mouse_x < (x + 20) && mouse_y > (y - 30) && mouse_y < (y + 5)))
    {
        Interact();
    }
}
