var followTarget = 227;
var pdir = point_direction(other.x + (other.sprite_width / 2), other.y + (other.sprite_height / 2), followTarget.x, followTarget.y);
var leftOf = followTarget.x < other.x;
var rightOf = followTarget.x > (other.x + other.sprite_width);
var aboveOf = followTarget.y < other.y;
var bottomOf = followTarget.y > (other.y + other.sprite_height);
if (leftOf)
{
    x = other.x - 10;
}
if (rightOf)
{
    x = other.x + other.sprite_width + 10;
}
if (aboveOf)
{
    y = other.y - 10;
}
if (bottomOf)
{
    y = other.y + other.sprite_height + 10;
}
