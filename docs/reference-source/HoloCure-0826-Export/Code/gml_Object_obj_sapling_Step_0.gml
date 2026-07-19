if (absorbTimer > 0)
{
    absorbTimer--;
}
if (absorbTimer == 0)
{
    absorbTimer = -1;
    picked = true;
    player = instance_find(obj_Player, 0);
}
if (picked)
{
    if (instance_exists(player))
    {
        move_towards_point(player.x, player.y, SPD);
        if (SPD < 10)
        {
            SPD += 0.1;
        }
    }
}
