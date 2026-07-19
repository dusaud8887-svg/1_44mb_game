if (screenAlpha < 1)
{
    screenAlpha += 0.26;
    if (screenAlpha > 1)
    {
        screenAlpha = 1;
        if (currentScene < 5)
        {
            currentScene++;
        }
        else
        {
            currentScene = -1;
        }
    }
    else
    {
        alarm[1] = 12;
    }
}
