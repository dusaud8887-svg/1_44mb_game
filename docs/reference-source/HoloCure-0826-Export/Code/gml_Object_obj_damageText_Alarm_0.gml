if (duration > 0)
{
    alpha = 0.5 + (duration / maxDuration);
}
else
{
    instance_destroy();
}
duration -= 2;
alarm[0] = 2;
