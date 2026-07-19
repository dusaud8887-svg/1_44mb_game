for (var i = 0; i < 7; i++)
{
    var screensize = 1;
    if (MouseOverButton("long", container[0] + 12, container[1] + 43 + (i * 34), screensize) && !remapping)
    {
        if (optionPage == 0 && !controllerMenu && !keybindMenu)
        {
            switch (i + showOptionRange)
            {
                case UnknownEnum.Value_2:
                    if ((mouse_x - camera_get_view_x(view_camera[0])) >= ((container[0] + 20) * screensize) && (mouse_x - camera_get_view_x(view_camera[0])) < ((container[0] + 20 + 77) * screensize))
                    {
                        for (var j = 0; j < 11; j++)
                        {
                            if ((mouse_x - camera_get_view_x(view_camera[0])) > ((container[0] + 20 + (j * 7)) * screensize) && (mouse_x - camera_get_view_x(view_camera[0])) < ((container[0] + 20 + ((j + 1) * 7)) * screensize))
                            {
                                global.soundVolume = j * 0.1;
                                audio_group_set_gain(2, global.soundVolume, 0);
                                changedSettings = true;
                                break;
                            }
                        }
                    }
                    break;
                case UnknownEnum.Value_1:
                    if ((mouse_x - camera_get_view_x(view_camera[0])) >= ((container[0] + 20) * screensize) && (mouse_x - camera_get_view_x(view_camera[0])) < ((container[0] + 20 + 77) * screensize))
                    {
                        for (var j = 0; j < 11; j++)
                        {
                            if ((mouse_x - camera_get_view_x(view_camera[0])) > ((container[0] + 20 + (j * 7)) * screensize) && (mouse_x - camera_get_view_x(view_camera[0])) < ((container[0] + 20 + ((j + 1) * 7)) * screensize))
                            {
                                global.musicVolume = j * 0.1;
                                audio_group_set_gain(1, global.musicVolume, 0);
                                changedSettings = true;
                                break;
                            }
                        }
                    }
                    break;
            }
        }
        else if (optionPage == 1)
        {
            switch (i + showOptionRange)
            {
                case UnknownEnum.Value_2:
                    if ((mouse_x - camera_get_view_x(view_camera[0])) >= ((container[0] + 20) * screensize) && (mouse_x - camera_get_view_x(view_camera[0])) < ((container[0] + 20 + 77) * screensize))
                    {
                        for (var j = 0; j < 8; j++)
                        {
                            if ((mouse_x - camera_get_view_x(view_camera[0])) > ((container[0] + 20 + (j * 8.75)) * screensize) && (mouse_x - camera_get_view_x(view_camera[0])) < ((container[0] + 20 + ((j + 1) * 8.75)) * screensize))
                            {
                                global.attackAlpha = 0.3 + (j * 0.1);
                                changedSettings = true;
                                break;
                            }
                        }
                    }
                    break;
            }
        }
    }
}
if (MouseOverButton("short", 270, 215) && deleteConfirm && deleteOption == 0)
{
    HoldConfirm();
}

enum UnknownEnum
{
    Value_1 = 1,
    Value_2
}
