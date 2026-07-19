if (image_alpha < 0)
{
    instance_destroy();
}
if (duration > 1)
{
    duration--;
}
if (duration == 1)
{
    instance_destroy();
}
