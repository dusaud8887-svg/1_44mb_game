if (canControl)
{
    if (!keybindMenu && !controllerMenu)
    {
        if (showOptionRange < (maxOptions[optionPage] - 7))
        {
            showOptionRange++;
            audio_play_sound(snd_menu_select, 30, 0);
        }
    }
}
