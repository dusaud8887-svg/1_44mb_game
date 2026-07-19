if (instance_exists(obj_Player))
{
    var player = instance_find(obj_Player, 0);
    x = player.x + xPos;
    y = (player.y - 8) + yPos;
}
if (add)
{
    gpu_set_blendmode(bm_add);
}
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale * 2, image_yscale * 2, 0, c_white, image_alpha);
gpu_set_blendmode(bm_normal);
