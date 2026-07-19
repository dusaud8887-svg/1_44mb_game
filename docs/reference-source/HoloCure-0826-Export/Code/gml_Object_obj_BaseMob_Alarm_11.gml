addDuration -= 1;
if (hitEffectDuration > 0)
{
    if (addDuration <= 0)
    {
        add = 0;
        addDuration = 0;
    }
    alarm[11] = 1;
}
else
{
    add = 0;
    invincible = false;
}
