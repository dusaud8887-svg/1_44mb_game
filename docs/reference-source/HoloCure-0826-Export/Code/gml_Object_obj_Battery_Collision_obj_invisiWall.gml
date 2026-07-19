var thing = instance_place(x, y, obj_invisiWall);
if (instance_exists(thing))
{
    var followTarget = 227;
    var pdir = point_direction(thing.x + (thing.sprite_width / 2), thing.y + (thing.sprite_height / 2), followTarget.x, followTarget.y);
    var leftOf = followTarget.x < thing.x;
    var rightOf = followTarget.x > (thing.x + thing.sprite_width);
    var aboveOf = followTarget.y < thing.y;
    var bottomOf = followTarget.y > (thing.y + thing.sprite_height);
    if (leftOf)
    {
        x = thing.x - 10;
    }
    if (rightOf)
    {
        x = thing.x + thing.sprite_width + 10;
    }
    if (aboveOf)
    {
        y = thing.y - 10;
    }
    if (bottomOf)
    {
        y = thing.y + thing.sprite_height + 10;
    }
}
