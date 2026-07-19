if (canControl && paused && pauseMenu == UnknownEnum.Value_1)
{
    if (startingPosition < (array_length(displayingInventory) - 6))
    {
        startingPosition += 1;
        audio_play_sound(snd_menu_select, 30, 0);
    }
}

enum UnknownEnum
{
    Value_1 = 1
}
