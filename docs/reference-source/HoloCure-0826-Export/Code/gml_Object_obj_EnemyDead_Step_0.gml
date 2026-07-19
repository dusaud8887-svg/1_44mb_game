image_alpha -= 0.04;
if (moving)
{
    hspeed -= (image_xscale / 5);
}
if (image_alpha < 0)
{
    instance_destroy();
}
