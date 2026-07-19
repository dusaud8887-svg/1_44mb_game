if (!canTake && speed > 0)
{
    speed -= 0.2;
}
else
{
    speed = 0;
}
if (followPlayerID)
{
    if (canTake && followPlayerID.isAlive && distance_to_object(followPlayerID) < (range + ((range * followPlayerID.pickupRange) / 100)))
    {
        picked = true;
    }
}
if (picked)
{
    if (instance_exists(followPlayerID))
    {
        move_towards_point(followPlayerID.x, followPlayerID.y, SPD);
        if (SPD < 10)
        {
            SPD += 0.1;
        }
    }
}
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
