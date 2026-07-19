if (!isDead && place_meeting(x, y, obj_Enemy))
{
    var pdir = point_direction(other.x, other.y, x, y);
    move_outside_all(pdir, 1);
    isKnockback.speed = 0;
    isKnockback.duration = 0;
    isKnockback.timer = 0;
    other.isKnockback.speed = 0;
    other.isKnockback.duration = 0;
    other.isKnockback.timer = 0;
    speed = 0;
    other.speed = 0;
}
