if (!audio_is_playing(snd_fishreel))
{
    audio_play_sound(snd_fishreel, 30, true);
}
if (!barHold)
{
    var randomButton = [];
    for (var i = 0; i < 5; i++)
    {
        if (i != 5)
        {
            array_push(randomButton, i, i, i);
        }
        else
        {
            array_push(randomButton, i);
        }
    }
    array_push(buttonArray, [randomButton[irandom(array_length(randomButton) - 1)], queueTime]);
}
if (fishingMode && !barHold)
{
    alarm[2] = bpm;
}
