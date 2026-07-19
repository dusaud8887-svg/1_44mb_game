lifetime++;
if (lifetime < 100)
{
    if (image_alpha < 1)
    {
        image_alpha += 0.02;
    }
}
if (lifetime > 700)
{
    image_alpha -= 0.01;
}
