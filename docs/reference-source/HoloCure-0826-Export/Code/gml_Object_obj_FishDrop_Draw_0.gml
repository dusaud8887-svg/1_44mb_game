hoveringY = sin(lifetime / 30) * 4;
if (!picked)
{
    draw_sprite_ext(spr_ItemLight, image_index, x, y + 12, 0.7, 0.7, 0, c_white, 1);
}
draw_sprite(sprite_index, image_index, x, y + hoveringY);
