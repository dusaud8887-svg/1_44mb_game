if (instance_exists(playerFollow))
{
    if (playerFollow.x > (x - spriteWidth) && playerFollow.x < (x + spriteWidth) && playerFollow.y > (y - spriteHeight) && playerFollow.y < y)
    {
        image_alpha = 0.5;
    }
    else
    {
        image_alpha = 1;
    }
}
draw_sprite_ext(sprite_index, image_index, x, y - 4, 1, -0.7, 0, c_black, 0.4);
draw_self();
