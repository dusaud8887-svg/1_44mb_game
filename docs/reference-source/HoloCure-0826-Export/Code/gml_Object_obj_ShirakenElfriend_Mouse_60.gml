if (canControl && interacting)
{
    if (startingPosition > 0 && !itemBuyConfirm && pauseMenu == 0)
    {
        startingPosition -= 1;
        audio_play_sound(snd_menu_select, 30, 0);
    }
}
