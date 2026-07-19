draw_sprite_ext(spr_Shadow, 0, x, y, image_xscale, image_yscale, 0, c_white, 0.8);
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, spriteColor, image_alpha);
if (highlighted)
{
    if (interactIcon > 0)
    {
        draw_sprite(interactIcon, image_index, x, y - interactIconY);
    }
    if (!interacting && mouse_check_button_pressed(mb_left) && (mouse_x > (x - 30) && mouse_x < (x + 30) && mouse_y > (y - 40) && mouse_y < (y + 25)))
    {
        Confirm();
    }
}
