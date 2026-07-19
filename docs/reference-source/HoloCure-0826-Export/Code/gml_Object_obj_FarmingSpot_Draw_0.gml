depth = -y - 3;
shader_set(shdrMob);
shader_set_uniform_f(uni_add, add);
draw_sprite_ext(sprite_index, waterCD > 0, x, y, image_xscale, image_yscale, image_angle, c_white, image_alpha);
shader_reset();
if (currentMenu == UnknownEnum.Value_3)
{
    draw_sprite(displayingInventory2[inventorySelect2 + startingPosition2].config.plantSprite, 0, x, y);
}
if (seedID != -1 && !cropsResults)
{
    draw_sprite_ext(seedID.config.plantSprite, growthState, x, y, image_xscale, image_yscale, image_angle, c_white, image_alpha);
}
if (highlighted)
{
    if (!interacting && mouse_check_button_pressed(mb_left) && (mouse_x > (x - 25) && mouse_x < (x + 25) && mouse_y > (y - 20) && mouse_y < (y + 15)))
    {
        Confirm();
    }
}

enum UnknownEnum
{
    Value_3 = 3
}
