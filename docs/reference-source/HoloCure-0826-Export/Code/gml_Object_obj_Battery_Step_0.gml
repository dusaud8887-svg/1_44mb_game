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
if (followPlayerID)
{
    if (followPlayerID.isAlive && distance_to_object(followPlayerID) < (range + ((range * followPlayerID.pickupRange) / 100)))
    {
        picked = true;
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
}
