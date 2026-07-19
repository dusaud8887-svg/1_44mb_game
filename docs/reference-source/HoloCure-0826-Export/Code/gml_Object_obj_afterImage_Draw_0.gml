if (sprite_index)
{
    if (add)
    {
        gpu_set_blendmode(bm_add);
    }
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, afterimage_color, image_alpha * global.attackAlpha);
    gpu_set_blendmode(bm_normal);
}
