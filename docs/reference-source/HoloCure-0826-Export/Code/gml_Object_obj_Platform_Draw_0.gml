depth = -1200;
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
draw_self();
