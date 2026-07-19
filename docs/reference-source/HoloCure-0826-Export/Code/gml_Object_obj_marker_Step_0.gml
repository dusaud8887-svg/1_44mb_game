if (instance_exists(followTargetID) && !stationary)
{
    x += lengthdir_x(0.5, point_direction(x, y, followTargetID.x, followTargetID.y));
    y += lengthdir_y(0.5, point_direction(x, y, followTargetID.x, followTargetID.y));
}
