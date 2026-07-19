if (canType && renameOption == -1)
{
    canControl = false;
    alarm[1] = 5;
    changingName = false;
    canType = false;
    audio_play_sound(snd_menu_back, 30, 0);
}
else
{
    ReturnMenu();
}
