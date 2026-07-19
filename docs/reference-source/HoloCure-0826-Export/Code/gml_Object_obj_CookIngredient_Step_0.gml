if (waitTime == 0)
{
    if (x != pot.x)
    {
        x += ((pot.x - x) * 0.15);
    }
    if (y != (pot.y - 60))
    {
        y += ((pot.y - 60 - y) * 0.15);
    }
    if (point_distance(x, y, pot.x, pot.y - 60) < 1)
    {
        x = pot.x;
        y = pot.y - 60;
    }
}
if (x == pot.x)
{
    if (waitTime < 15)
    {
        waitTime++;
    }
}
if (waitTime >= 15)
{
    y += 3;
    image_alpha -= 0.1;
}
if (image_alpha < 0.1)
{
    audio_play_sound(snd_interactpot, 0, 0);
    instance_destroy();
}
