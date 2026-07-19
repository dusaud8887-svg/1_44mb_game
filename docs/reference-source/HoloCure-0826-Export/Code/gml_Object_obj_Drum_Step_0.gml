for (var i = 0; i < array_length(rhythmTimes); i++)
{
    if (rhythmTimes[i] > 0)
    {
        rhythmTimes[i]--;
    }
}
for (var i = 0; i < array_length(beatTimes); i++)
{
    if (lifetime == beatTimes[i])
    {
        rhythmTimes[i] = circleTime;
    }
}
if (currentBeat < 8)
{
    if (lifetime > (beatTimes[currentBeat] + circleTime))
    {
        if (currentBeat < (array_length(beatTimes) - 1))
        {
            currentBeat++;
        }
    }
}
lifetime++;
if (orangeLight > 0)
{
    orangeLight -= 0.05;
}
