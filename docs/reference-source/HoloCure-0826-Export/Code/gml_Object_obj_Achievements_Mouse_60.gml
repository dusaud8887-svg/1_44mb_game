if (room == rm_Achievements && canControl)
{
    if (achievementMode == 1)
    {
        SelectUp();
    }
    else if (achievementMode == 2)
    {
        if (startingPosition > 0)
        {
            startingPosition--;
            audio_play_sound(snd_menu_select, 30, 0);
        }
    }
}
