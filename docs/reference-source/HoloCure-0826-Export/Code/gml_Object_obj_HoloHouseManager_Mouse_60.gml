if (canControl && paused && pauseMenu == UnknownEnum.Value_1)
{
    if (startingPosition > 0)
    {
        startingPosition -= 1;
        audio_play_sound(snd_menu_select, 30, 0);
    }
}

enum UnknownEnum
{
    Value_1 = 1
}
