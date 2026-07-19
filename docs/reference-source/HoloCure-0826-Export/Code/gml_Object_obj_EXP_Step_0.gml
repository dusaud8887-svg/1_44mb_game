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
    if (initialSpawn && !place_meeting(x, y, obj_invisiWall))
    {
        if (spawnTimer == 0)
        {
            initialSpawn = 0;
        }
        image_alpha = 1;
    }
}
else
{
    if (followPlayerID)
    {
        if (followPlayerID.isAlive && distance_to_object(followPlayerID) < (range + ((range * followPlayerID.pickupRange) / 100)))
        {
            picked = true;
        }
        if (picked)
        {
            move_towards_point(followPlayerID.x, followPlayerID.y - 16, SPD);
            if (SPD < 20)
            {
                SPD += 0.2;
            }
        }
    }
    if (instance_exists(obj_Summon) && obj_Summon.pickupExp)
    {
        if (followPlayerID.isAlive && distance_to_object(obj_Summon) < (range + ((range * followPlayerID.pickupRange) / 100)))
        {
            picked2 = true;
        }
        if (picked2)
        {
            move_towards_point(obj_Summon.x, obj_Summon.y - 16, SPD);
            if (SPD < 20)
            {
                SPD += 0.2;
            }
        }
        if (!(picked || picked2))
        {
            SPD = 0;
            speed = 0;
        }
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
