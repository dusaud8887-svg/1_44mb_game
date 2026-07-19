if (canControl && interacting)
{
    if (startingPosition > 0 && !sellConfirm && !itemBuyConfirm && pauseMenu < 2)
    {
        startingPosition -= 1;
        audio_play_sound(snd_menu_select, 30, 0);
    }
}
