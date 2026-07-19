lifetime++;
if (lifetime > 60)
{
    lifetime = 0;
}
gpu_set_blendmode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, 1, 1, 0, c_white, 0.3);
gpu_set_blendmode(bm_normal);
