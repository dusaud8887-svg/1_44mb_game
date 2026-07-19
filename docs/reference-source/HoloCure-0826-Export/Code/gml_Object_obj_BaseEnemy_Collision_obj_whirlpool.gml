if (!isDead)
{
    var directionToPool = point_direction(other.x, other.y, x, y);
    var horVector = lengthdir_x(SPD, directionToPool);
    var verVector = lengthdir_y(SPD, directionToPool);
    if (!place_meeting(x - horVector, y - horVector, obj_Enemy))
    {
        x -= horVector;
        y -= verVector;
    }
    else
    {
    }
}
