if (destroyTimer > 0)
{
    destroyTimer--;
}
if (destroyTimer == 0)
{
    instance_destroy();
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
y = originY + (sin(destroyTimer / 25) * 5);
