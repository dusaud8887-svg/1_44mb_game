if (lifetime == 1)
{
    image_alpha = vis;
}
if (lifetime == 10)
{
    image_alpha = 0;
}
if (lifetime == 15)
{
    image_alpha = vis;
}
if (lifetime == 25)
{
    image_alpha = 0;
}
if (lifetime == 30)
{
    image_alpha = vis;
}
if (lifetime == 40)
{
    image_alpha = 0;
}
if (lifetime == 45)
{
    image_alpha = vis;
}
if (lifetime == 55)
{
    instance_destroy();
}
lifetime++;
isInView = x > (camera_get_view_x(view_camera[0]) - 15) && x < (camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]) + 15) && y > (camera_get_view_y(view_camera[0]) - 15) && y < (camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]) + 15);
