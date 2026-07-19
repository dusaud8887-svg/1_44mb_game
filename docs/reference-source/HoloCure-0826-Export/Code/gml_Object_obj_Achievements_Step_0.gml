if (array_length(achievementPopUps) > 0)
{
    if (popUpTimer == 0 && popUpMoving == 0)
    {
        popUpMoving = -1;
        audio_play_sound(snd_achievementget, 10, 0);
    }
    if (popUpMoving != 0)
    {
        if (popUpContainer[1] > (310 - (popUpMoving * 2)) && popUpContainer[1] < (360 - (popUpMoving * 2)))
        {
            popUpContainer[1] += popUpMoving * 2;
        }
        else if (popUpMoving == -1)
        {
            popUpTimer = 180;
            popUpMoving = 0;
        }
    }
    if (popUpTimer == 1 && popUpMoving == 0)
    {
        popUpTimer = 0;
        popUpMoving = 1;
    }
    else if (popUpTimer > 0)
    {
        popUpTimer--;
    }
    if (popUpTimer == 0 && popUpMoving == 1 && popUpContainer[1] >= 358)
    {
        popUpTimer = 0;
        popUpMoving = 0;
        array_delete(achievementPopUps, 0, 1);
    }
}
if (global.refreshAchievements)
{
    UpdateAchievements();
    global.refreshAchievements = false;
}
extension_stubfunc_real();
