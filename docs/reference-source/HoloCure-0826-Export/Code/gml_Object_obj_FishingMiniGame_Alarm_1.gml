if (fishGauge > 0 && fishingMode && !barHold)
{
    fishGauge -= 1;
}
if (fishingMode)
{
    alarm[1] = fishDepleteRate;
}
