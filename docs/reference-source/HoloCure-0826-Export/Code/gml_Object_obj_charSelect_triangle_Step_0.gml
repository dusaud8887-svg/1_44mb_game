image_alpha -= 0.001;
image_angle += angleChange;
x += hspeedRandom;
y++;
if (y > 500)
{
    instance_destroy();
}
