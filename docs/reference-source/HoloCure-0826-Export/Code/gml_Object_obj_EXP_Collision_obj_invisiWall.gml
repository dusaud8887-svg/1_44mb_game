if (!picked)
{
    var followTarget = 227;
    var pdir = point_direction(other.x + (other.sprite_width / 2), other.y + (other.sprite_height / 2), followTarget.x, followTarget.y);
    var leftOf = followTarget.x < other.x;
    var rightOf = followTarget.x > (other.x + other.sprite_width);
    var aboveOf = followTarget.y < other.y;
    var bottomOf = followTarget.y > (other.y + other.sprite_height);
    var playerDir = point_direction(x, y, followTarget.x, followTarget.y);
    initialSpawn = true;
    image_alpha = 0;
    x += lengthdir_x(point_distance(x, y, followTarget.x, followTarget.y) * 0.25, playerDir);
    y += lengthdir_y(point_distance(x, y, followTarget.x, followTarget.y) * 0.25, playerDir);
}
