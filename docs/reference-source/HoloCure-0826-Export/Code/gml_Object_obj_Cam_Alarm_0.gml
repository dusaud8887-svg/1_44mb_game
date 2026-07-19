if (shakeTime > 0)
{
    shakeTime--;
    shakeX = -shakeAmount + (2 * random(shakeAmount));
    shakeY = -shakeAmount + (2 * random(shakeAmount));
    if (shakeTime < (shakeDuration / 2))
    {
        shakeX *= (shakeTime / (shakeDuration / 2));
        shakeY *= (shakeTime / (shakeDuration / 2));
    }
    alarm[0] = 1;
}
else
{
    shakeX = 0;
    shakeY = 0;
}
