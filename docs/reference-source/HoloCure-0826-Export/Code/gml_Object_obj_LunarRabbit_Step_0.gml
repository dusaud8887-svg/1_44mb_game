if (direction < 90 || direction > 270)
{
    image_xscale = 2;
}
if (direction > 90 && direction < 270)
{
    image_xscale = -2;
}
if (followCharacter == -1)
{
    targets = ds_list_create();
    numTargets = collision_circle_list(x, y, 300, obj_Enemy, false, true, targets, true);
    targets = obj_AttackController.RemoveFriendly(targets);
    numTargets = ds_list_size(targets);
    if (numTargets == 0)
    {
        followCharacter = -1;
    }
    else
    {
        followCharacter = ds_list_find_value(targets, 0);
    }
    ds_list_destroy(targets);
    targets = -1;
}
else if (instance_exists(followCharacter))
{
    direction = point_direction(x, y, followCharacter.x, followCharacter.y);
    directionMoving = direction;
    obj_MobManager.MoveToPosition(followCharacter, self);
}
else
{
    followCharacter = -1;
    SPD = 0;
}
if (followCharacter != -1 && SPD < 10)
{
    SPD += 0.1;
}
