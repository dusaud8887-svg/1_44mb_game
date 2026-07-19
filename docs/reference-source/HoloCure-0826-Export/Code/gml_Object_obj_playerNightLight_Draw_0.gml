lifetime++;
if (lifetime > 628.3185307179587)
{
    lifetime = 0;
}
x = player.x;
y = player.y;
gpu_set_blendmode(bm_add);
draw_sprite_ext(player.sprite_index, player.image_index, player.x, player.y, player.image_xscale, player.image_yscale, 0, c_white, alpha * 0.35);
draw_sprite_ext(sprite_index, image_index, x, y, 0.9, 0.7, 0, c_white, alpha * (0.1 + (abs(sin(lifetime / 100)) * 0.1)));
gpu_set_blendmode(bm_normal);
