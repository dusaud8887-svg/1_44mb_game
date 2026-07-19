draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, spriteColor, image_alpha);
if (highlighted && !interacting)
{
    if (interactIcon > 0)
    {
        draw_sprite(interactIcon, image_index, x, y - interactIconY);
    }
    if (mouse_check_button_pressed(mb_left) && (mouse_x > (x - 30) && mouse_x < (x + 30) && mouse_y > (y - 50) && mouse_y < (y + 5)))
    {
        Confirm();
    }
}
