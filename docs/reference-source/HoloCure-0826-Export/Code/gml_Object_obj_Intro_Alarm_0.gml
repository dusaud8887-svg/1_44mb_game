if (screenAlpha > 0)
{
    screenAlpha -= 0.26;
    if (screenAlpha < 0)
    {
        screenAlpha = 0;
    }
    else
    {
        alarm[0] = 12;
    }
}
