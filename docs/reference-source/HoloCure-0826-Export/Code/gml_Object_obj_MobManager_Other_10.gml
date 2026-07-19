function MoveToPosition(arg0, arg1, arg2 = -1)
{
    if (arg2 == -1)
    {
        arg2 = arg1.SPD;
    }
    arg1.normalMovement = true;
    if (arg0.x > arg1.x)
    {
        arg1.image_xscale = abs(arg1.image_xscale);
    }
    else
    {
        arg1.image_xscale = -abs(arg1.image_xscale);
    }
    var dir = arg1.directionMoving;
    if (arg1.directionChangeTime == 0)
    {
        dir = point_direction(arg1.x, arg1.y, arg0.x, arg0.y);
        if (arg1.object_index == obj_Enemy)
        {
            arg1.directionChangeTime = 3;
        }
        arg1.directionMoving = dir;
    }
    var newX = arg1.x + lengthdir_x(arg2, dir);
    var newY = arg1.y + lengthdir_y(arg2, dir);
    arg1.x = newX;
    arg1.y = newY;
}

function FindNewDirection(arg0, arg1)
{
    for (var i = 0; i <= 35; i++)
    {
        var checkUpDown = 1;
        var newDir = arg0 + (i * 10 * checkUpDown);
        var newX = arg1.x + lengthdir_x(arg1.SPD, newDir);
        var newY = arg1.y + lengthdir_y(arg1.SPD, newDir);
        if (!place_meeting(newX, newY, obj_Enemy))
        {
            return newDir;
        }
    }
}

function RunToRandomEnemy(arg0, arg1 = 367, arg2 = 
{
    range: 350,
    resetTimer: 180,
    distanceFromTarget: -50
}, arg3 = false)
{
    if (!variable_struct_exists(arg0.behaviourTimers, "RunToRandomEnemy"))
    {
        arg0.behaviourTimers.RunToRandomEnemy = 0;
    }
    if (arg0.behaviourTimers.RunToRandomEnemy == 0)
    {
        var enemy = FindTargetInRange(227, arg1, arg2.range, arg3);
        var dir = point_direction(arg0.x, arg0.y, enemy.x, enemy.y);
        arg0.directionMoving = dir;
        arg0.waypoint.x = enemy.x + lengthdir_x(arg2.distanceFromTarget, dir);
        arg0.waypoint.y = enemy.y + lengthdir_y(arg2.distanceFromTarget, dir);
        arg0.behaviourTimers.RunToRandomEnemy = arg2.resetTimer;
    }
    else
    {
        arg0.behaviourTimers.RunToRandomEnemy--;
    }
    if (abs(arg0.x - arg0.waypoint.x) <= 10 && abs(arg0.y - arg0.waypoint.y) <= 10)
    {
        arg0.behaviourTimers.RunToRandomEnemy = 0;
    }
    else
    {
        MoveToPosition(arg0.waypoint, arg0);
    }
}

function FindTargetInRange(arg0, arg1 = 367, arg2 = 200, arg3 = 0)
{
    if (!instance_exists(obj_Enemy))
    {
        return arg0;
    }
    var targets = ds_list_create();
    collision_circle_list(arg0.x, arg0.y, arg2, arg1, true, true, targets, true);
    var targets_size = ds_list_size(targets);
    targets = obj_AttackController.RemoveFriendly(targets);
    targets_size = ds_list_size(targets);
    if (targets_size > 0)
    {
        if (arg3)
        {
            return ds_list_find_value(targets, 0);
        }
        else
        {
            var randomIndex = irandom(targets_size - 1);
            return ds_list_find_value(targets, randomIndex);
        }
    }
    else
    {
        return arg0;
    }
}
