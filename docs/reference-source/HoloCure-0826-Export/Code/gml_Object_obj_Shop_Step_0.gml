if (animPlayingSpeed < 60)
{
    animPlayingSpeed += 1;
}
else
{
    animPlayingSpeed = 0;
}
if (blinkRestTime > 0)
{
    blinkRestTime--;
}
if (floor(image_index) == 0)
{
    if (blinkRestTime < 1)
    {
        sprite_index = spr_AchanBlink;
        blinkRestTime = 30 + irandom(240);
    }
}
if ((shopMode == 0 && !gachaing) || (shopMode == 3 && !gachaing))
{
    if (gachaGroupOption != (array_length(gachaItems) - showTeaser))
    {
        currentTears = array_get(array_get(ds_map_find_value(global.PlayerSave, "tears"), gachaGroupOption), 1);
    }
}
if (currentArrayLength > 1)
{
    if (pageTimer > 0)
    {
        pageTimer--;
    }
    else if (pageTimer == 0)
    {
        if (currentPage < (currentArrayLength - 1))
        {
            pageTimer = 120;
            currentPage++;
        }
        else
        {
            pageTimer = 120;
            currentPage = 0;
        }
    }
}
