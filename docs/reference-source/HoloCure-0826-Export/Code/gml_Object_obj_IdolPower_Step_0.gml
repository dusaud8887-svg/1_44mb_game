event_inherited();
if (gravity != 0)
{
    if ((y + vspeed) >= setY)
    {
        hspeed = 0;
        vspeed = 0;
        gravity = 0;
        y = setY;
    }
}
