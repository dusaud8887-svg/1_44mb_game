dir = 0;
dir2 = 0;
log = false;
dist = 100;

function SetPosition()
{
    dir += 1;
    if (dir2 > 360)
    {
        dir2 -= 360;
    }
    x = obj_Player.x + lengthdir_x(dist, dir);
    y = obj_Player.y + lengthdir_y(dist, dir);
}
