if (other.isMoving)
{
    if (telePortState == 0)
    {
        telePortState = 1;
    }
}
else if (telePortState == 1)
{
    telePortState = 2;
}
if (telePortState == 2 && canTeleport && otherPortal > 0 && instance_exists(otherPortal) && !other.isMoving && !variable_struct_exists(other.buffs, "ShionSpecial"))
{
    telePortState = 0;
    otherPortal.telePortState = 0;
    other.x = otherPortal.x;
    other.y = otherPortal.y;
    otherPortal.canTeleport = false;
    otherPortal.alarm[0] = 60;
    canTeleport = false;
    other.invincibilityTimer = max(20, other.invincibilityTimer);
    other.invincible = true;
    alarm[0] = 60;
    soundPlay([135], "teleport", 30, 10);
    if (instance_exists(obj_Summon))
    {
        var garlic = instance_find(obj_Summon, 0);
        if (garlic.summonName == "Garlic")
        {
            with (garlic)
            {
                x = (obj_Player.x - 50) + irandom(100);
                y = (obj_Player.y - 50) + irandom(100);
            }
        }
    }
}
