function soundPlay(arg0, arg1, arg2, arg3, arg4 = false)
{
    if (instance_exists(obj_SoundController))
    {
        if (!ds_map_exists(global.soundPlayingList, arg1) && array_length(arg0) > 0)
        {
            var randomSound = floor(random(array_length(arg0)));
            var thesound = audio_play_sound(arg0[randomSound], arg3, false);
            if (arg4)
            {
                audio_sound_pitch(thesound, 0.9 + (irandom(4) * 0.025));
            }
            ds_map_add(global.soundPlayingList, arg1, arg2);
        }
    }
}
