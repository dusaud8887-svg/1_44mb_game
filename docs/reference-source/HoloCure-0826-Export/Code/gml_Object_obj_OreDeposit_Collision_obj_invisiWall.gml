if (!rarest)
{
    var followTarget = 227;
    var playerDir = point_direction(x, y, followTarget.x, followTarget.y);
    initialSpawn = true;
    image_alpha = 0;
    x += lengthdir_x(point_distance(x, y, followTarget.x, followTarget.y) * 0.25, playerDir);
    y += lengthdir_y(point_distance(x, y, followTarget.x, followTarget.y) * 0.25, playerDir);
}
