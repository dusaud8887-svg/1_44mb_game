if (room == rm_Achievements && canControl)
{
    if (achievementMode == 1)
    {
        SelectDown();
    }
    else if (achievementMode == 2)
    {
        if ((4 + startingPosition + 1) < (array_length(global.characterList) - 1))
        {
            startingPosition++;
            audio_play_sound(snd_menu_select, 30, 0);
        }
    }
}
