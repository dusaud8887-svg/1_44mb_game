if (spawnTimer > 0)
{
    spawnTimer--;
}
else
{
    initialSpawn = false;
    speed = 0;
}
if (initialSpawn)
{
    if (speed > 0)
    {
        speed -= 0.2;
    }
    else
    {
        speed = 0;
    }
}
else if (followPlayerID)
{
    if (followPlayerID.isAlive && distance_to_object(followPlayerID) < 20)
    {
        picked = true;
    }
    if (picked)
    {
        move_towards_point(followPlayerID.x, followPlayerID.y, SPD);
        if (SPD < 20)
        {
            SPD += 0.2;
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
lifetime++;
