if (canControl && shopMode == 2)
{
    if (startingPosition < (totalThings - 35))
    {
        startingPosition += 7;
        audio_play_sound(snd_menu_select, 30, 0);
    }
}
else if (canControl && shopMode == 1 && !itemSelected)
{
    if (startingPosition < (array_length(separatedShop[shopCategory]) - 16))
    {
        startingPosition += 4;
        if ((shopOption + startingPosition) > (array_length(separatedShop[shopCategory]) - 1))
        {
            shopOption -= 4;
        }
        audio_play_sound(snd_menu_select, 30, 0);
    }
}
