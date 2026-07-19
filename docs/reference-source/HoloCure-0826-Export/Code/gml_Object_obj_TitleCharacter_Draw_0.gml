if (sprite_index > -1 && !instance_exists(obj_Credits) && !instance_exists(obj_Options))
{
    set_gui_size(640, 360);
    gpu_set_fog(!unlocked, charColor, 0, 1);
    draw_sprite_ext(sprite_index, image_index, x, y, 1, 1, 0, c_white, 1);
    gpu_set_fog(false, c_white, 0, 1);
}
