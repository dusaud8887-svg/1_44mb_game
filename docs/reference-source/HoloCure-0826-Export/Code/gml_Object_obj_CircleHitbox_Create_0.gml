event_inherited();
collides = false;
var targets = ds_list_create();
var numberOfTargets = collision_ellipse_list(x - radius, y - (radius / 3), x + radius, y + (radius / 3), hitsObject, true, true, targets, false);
if (numberOfTargets > 0)
{
    for (var i = 0; i < ds_list_size(targets); i++)
    {
        HitTarget(ds_list_find_value(targets, i));
    }
}
