if (canControl && shopMode == 2)
{
    if (startingPosition >= 7)
    {
        startingPosition -= 7;
        audio_play_sound(snd_menu_select, 30, 0);
    }
}
else if (canControl && shopMode == 1 && !itemSelected)
{
    if (startingPosition >= 4)
    {
        startingPosition -= 4;
        audio_play_sound(snd_menu_select, 30, 0);
    }
}
