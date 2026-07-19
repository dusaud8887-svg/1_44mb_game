if (image_alpha < 0)
{
    instance_destroy();
}
alarm[0] = 1;
image_alpha -= fadeRate;
if (grow)
{
    image_xscale += ((abs(image_xscale) / image_xscale) * growthRate);
    image_yscale += ((abs(image_yscale) / image_yscale) * growthRate);
}
