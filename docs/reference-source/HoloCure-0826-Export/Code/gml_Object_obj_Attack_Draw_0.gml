if (customDrawScriptBelow)
{
    customDrawScriptBelow(id, creator);
}
if (sprite_index)
{
    if (transparent)
    {
        gpu_set_blendmode(bm_add);
    }
    if (!isEnemy)
    {
        draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, spriteColor, image_alpha * global.attackAlpha);
    }
    else
    {
        draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, spriteColor, image_alpha);
    }
    gpu_set_blendmode(bm_normal);
}
if (customDrawScriptAbove)
{
    customDrawScriptAbove(id, creator);
}
