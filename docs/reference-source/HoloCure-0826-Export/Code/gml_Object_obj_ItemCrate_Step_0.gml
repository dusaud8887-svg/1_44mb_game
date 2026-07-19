event_inherited();
if (!place_meeting(x, y, obj_Obstacle))
{
    image_alpha = 1;
    breakable = true;
}
else
{
    image_alpha = 0;
    breakable = false;
}
if (hitShake > 0)
{
    hitShake--;
    shakeDisplacement *= -1;
}
if (timeStartedAttacking > -1 && global.debug)
{
    timeStartedAttacking++;
}
if (point_distance(x, y, obj_Player.x, obj_Player.y) > max(room_width * 2, room_height * 2))
{
    instance_destroy();
}
