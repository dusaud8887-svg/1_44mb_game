image_angle += randRot;
direction += curvDir;
image_alpha -= 0.005;
if (image_alpha < 0 || global.lightFX == false)
{
    instance_destroy();
}
