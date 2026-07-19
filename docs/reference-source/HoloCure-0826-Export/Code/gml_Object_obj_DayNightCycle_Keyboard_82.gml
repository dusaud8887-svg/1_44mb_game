if (global.debug)
{
    rain = true;
    rainTime = 5400 + irandom(5400);
    if (!audio_is_playing(snd_rain))
    {
        audio_play_sound(snd_rain, 0, true);
    }
    audio_sound_gain(snd_rain, 1, 300);
}
