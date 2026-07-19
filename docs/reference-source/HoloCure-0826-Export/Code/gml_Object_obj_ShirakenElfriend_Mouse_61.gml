if (canControl && interacting)
{
    if (startingPosition < (array_length(obj_HoloHouseManager.allFurnitureArray[furnitureCategory]) - 5) && !itemBuyConfirm && pauseMenu == 0)
    {
        startingPosition += 1;
        audio_play_sound(snd_menu_select, 30, 0);
    }
}
