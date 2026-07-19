lifetime++;
if (lifetime > 15)
{
    direction = point_direction(x, y, followCharacterID.x, followCharacterID.y - 16);
    speed += 0.5;
    image_alpha -= 0.05;
}
else
{
    x = followCharacterID.x + offset_x;
    y = followCharacterID.y + offset_y;
}
