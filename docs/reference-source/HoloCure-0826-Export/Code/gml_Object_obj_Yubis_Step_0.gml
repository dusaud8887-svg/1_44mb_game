if (followPlayerID)
{
    if (picked)
    {
        move_towards_point(followPlayerID.x, followPlayerID.y, SPD);
        if (SPD < 20)
        {
            SPD += 0.25;
        }
    }
    else
    {
        SPD = 0;
        speed = 0;
    }
}
isInView = x > (camera_get_view_x(view_camera[0]) - 15) && x < (camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]) + 15) && y > (camera_get_view_y(view_camera[0]) - 15) && y < (camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]) + 15);
depth = -y;
if (global.topBorder != -1)
{
    if (y < global.topBorder)
    {
        y = global.topBorder;
    }
}
if (global.bottomBorder != -1)
{
    if (y > global.bottomBorder)
    {
        y = global.bottomBorder;
    }
}
if (global.leftBorder != -1)
{
    if (x < global.leftBorder)
    {
        x = global.leftBorder;
    }
}
if (global.rightBorder != -1)
{
    if (x > global.rightBorder)
    {
        x = global.rightBorder;
    }
}
