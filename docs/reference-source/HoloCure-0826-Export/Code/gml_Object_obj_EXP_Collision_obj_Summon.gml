if (!initialSpawn && obj_Summon.pickupExp)
{
    global.experience += (expVal * (obj_Player.expMultiplier + obj_Player.EXP));
    soundPlay([106], "getEXP", 5, 3);
    instance_destroy();
}
