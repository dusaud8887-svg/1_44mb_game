if (canControl)
{
    switch (pauseMenu)
    {
        case UnknownEnum.Value_0:
            if (!manageConfirm)
            {
                if (startingPosition < (array_length(workers) - 3))
                {
                    startingPosition++;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
            }
            break;
        case UnknownEnum.Value_1:
            if (!hireConfirm)
            {
                if (startingPosition < (array_length(recruits) - 3))
                {
                    startingPosition++;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
            }
            break;
    }
}

enum UnknownEnum
{
    Value_0,
    Value_1
}
