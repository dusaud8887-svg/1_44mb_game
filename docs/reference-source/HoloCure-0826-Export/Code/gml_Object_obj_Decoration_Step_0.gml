if (lastViewCheck > 0)
{
    lastViewCheck--;
}
if (makeParticle)
{
    alarm[0] = floor(random(60));
    makeParticle = false;
}
if (lastViewCheck == 0)
{
    amIinView = x > (camera_get_view_x(view_camera[0]) - 75) && x < (camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]) + 75) && y > (camera_get_view_y(view_camera[0]) - 75) && y < (camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]) + 75);
    lastViewCheck = 30;
}
