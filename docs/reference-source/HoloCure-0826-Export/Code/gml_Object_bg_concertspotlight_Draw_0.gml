currentDir += (randomSign * moveRate);
if (global.lightFX)
{
    gpu_set_blendmode(bm_add);
    draw_sprite_ext(sprite_index, 0, x + (1.2 * lengthdir_x(size, currentDir)), y + lengthdir_y(size, currentDir), 1, 1, 0, currentColor, image_alpha);
    gpu_set_blendmode(bm_normal);
}
