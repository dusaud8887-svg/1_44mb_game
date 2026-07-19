if (canControl && interacting)
{
    if (currentMenu == UnknownEnum.Value_2 && startingPosition2 < (array_length(displayingInventory2) - 6))
    {
        startingPosition2 += 1;
        audio_play_sound(snd_menu_select, 30, 0);
        global.plantStartingPosition = startingPosition2;
    }
}

enum UnknownEnum
{
    Value_2 = 2
}
