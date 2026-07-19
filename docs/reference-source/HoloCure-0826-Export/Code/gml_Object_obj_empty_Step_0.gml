if (!instance_exists(creator))
{
    instance_destroy();
}
deathTime--;
if (deathTime < 1 && !permanent)
{
    instance_destroy();
}
