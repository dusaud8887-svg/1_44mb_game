if (instance_exists(obj_Player))
{
    x = lengthdir_x(dist, dir) + obj_Player.x;
    y = lengthdir_y(dist, dir) + obj_Player.y;
}
if (log)
{
    show_debug_message("Directional test x, y: " + string(x) + ", " + string(y));
}
