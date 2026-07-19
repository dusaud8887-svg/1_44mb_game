if (!initialSpawn)
{
    var minHeal = max(1, healVal);
    Heal(other, minHeal, 1, true, true, false);
    instance_destroy();
}
