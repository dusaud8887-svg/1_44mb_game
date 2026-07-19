if (screenAlpha < 1)
{
    screenAlpha += 0.02;
    if (screenAlpha >= 1)
    {
        screenAlpha = 1;
        if (currentScene < 1)
        {
            currentScene++;
        }
        else
        {
            currentScene = -1;
            room_goto_next();
        }
    }
    else
    {
        alarm[1] = 1;
    }
}
