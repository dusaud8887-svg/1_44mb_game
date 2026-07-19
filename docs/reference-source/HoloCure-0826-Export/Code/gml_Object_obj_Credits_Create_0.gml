x = 320;
y = 50;
creditsScroll = 0;

function Destroy()
{
    if (room == rm_Title)
    {
        var title = instance_find(obj_TitleScreen, 0);
        title.canControl = true;
        display_set_gui_size(1280, 720);
    }
    instance_destroy();
}

function ReturnMenu()
{
    audio_play_sound(snd_menu_back, 30, 0);
    Destroy();
}
