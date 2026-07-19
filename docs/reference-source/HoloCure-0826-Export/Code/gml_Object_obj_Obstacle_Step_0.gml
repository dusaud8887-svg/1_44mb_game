if (hitShake > 0)
{
    hitShake--;
    shakeDisplacement *= -1;
}
if (timeStartedAttacking > -1 && global.debug)
{
    timeStartedAttacking++;
}
