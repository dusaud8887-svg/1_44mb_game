if (!initialSpawn)
{
    if (!global.noEXP)
    {
        global.experience += (expVal * (other.expMultiplier + other.EXP));
    }
    soundPlay([106], "getEXP", 5, 3);
    instance_destroy();
}
