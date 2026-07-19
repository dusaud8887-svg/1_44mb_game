if (changingTo == "night")
{
    if (currentTint[0] != nightTint[0])
    {
        currentTint[0] -= rPerTick;
        currentTint[1] -= gPerTick;
        currentTint[2] -= bPerTick;
        fx_set_parameter(effectsLayer, "g_TintCol", currentTint);
        alarm[0] = 1;
    }
}
else if (currentTint[0] != dayTint[0])
{
    currentTint[0] += rPerTick;
    currentTint[1] += gPerTick;
    currentTint[2] += bPerTick;
    fx_set_parameter(effectsLayer, "g_TintCol", currentTint);
    alarm[0] = 1;
}
