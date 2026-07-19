if (screenAlpha > 0)
{
    screenAlpha -= 0.02;
    if (screenAlpha < 0)
    {
        screenAlpha = 0;
    }
    else
    {
        alarm[0] = 1;
    }
}
