time++;
if (time == 180)
{
    time = 0;
}
if (global.lightFX)
{
    gpu_set_blendmode(bm_add);
    draw_sprite_ext(bg_camstagelights, 0, 320, 180, 1, 1, 0, c_white, 0.5);
    gpu_set_blendmode(bm_normal);
}
