time++;
if (time == 180)
{
    time = 0;
}
if (global.lightFX)
{
    gpu_set_blendmode(bm_add);
    draw_sprite_ext(bg_light, 0, 0, 0, 1, 1, 0, c_white, 0.5);
    draw_sprite_ext(bg_lightbeams, 0, 0, 0, 1, 1, 0, c_white, alpha * (0.1 + (0.35 * sin(pi * (time / 180)))));
    gpu_set_blendmode(bm_normal);
}
