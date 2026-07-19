if (canControl && interacting)
{
    if (startingPosition < (array_length(displayingInventory) - 5) && !sellConfirm && !itemBuyConfirm && pauseMenu == 0)
    {
        startingPosition += 1;
        audio_play_sound(snd_menu_select, 30, 0);
    }
    else if (startingPosition < (array_length(displayingInventory) - 5) && !sellConfirm && !itemBuyConfirm && pauseMenu == 1)
    {
        startingPosition += 1;
        audio_play_sound(snd_menu_select, 30, 0);
    }
}
