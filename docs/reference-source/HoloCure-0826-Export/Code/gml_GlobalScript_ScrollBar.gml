function ScrollBar(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7 = true)
{
    var screensize = 1;
    if (variable_global_exists("new_camera_scale") && global.new_camera_scale != 1)
    {
        screensize = 1 / global.camera_scale;
    }
    if (array_length(arg0) > (arg5 * arg4))
    {
        draw_sprite(hud_scrollArrows, 0, arg1, arg2);
        draw_sprite(hud_scrollArrows, 1, arg1, arg3);
        var rectHeight = ((arg3 - arg2) * arg5) / ((array_length(arg0) div arg4) + ((array_length(arg0) % arg4) > 0));
        var scrollDist = (arg3 - arg2) / ((array_length(arg0) div arg4) + ((array_length(arg0) % arg4) > 0));
        draw_set_color(c_white);
        draw_rectangle(arg1 - 2, arg2 + (scrollDist * (arg6 div arg4)), arg1 + 2, arg2 + rectHeight + (scrollDist * (arg6 div arg4)), false);
        var totalYSpace = arg3 - arg2;
        var yPos = arg2;
        var numberOfTicks = ((array_length(arg0) div arg4) + ((array_length(arg0) % arg4) > 0)) - arg5;
        if (mouse_check_button(mb_left) && arg7)
        {
            if ((mouse_x - camera_get_view_x(view_camera[0])) >= ((arg1 - 5) * screensize) && (mouse_x - camera_get_view_x(view_camera[0])) < ((arg1 + 5) * screensize) && (mouse_y - camera_get_view_y(view_camera[0])) >= ((yPos - (totalYSpace / numberOfTicks)) * screensize) && (mouse_y - camera_get_view_y(view_camera[0])) <= (arg3 * screensize))
            {
                for (var j = 0; j < (numberOfTicks + 1); j++)
                {
                    if ((mouse_y - camera_get_view_y(view_camera[0])) > ((yPos + (j * (totalYSpace / (numberOfTicks + 1)))) * screensize) && (mouse_y - camera_get_view_y(view_camera[0])) < ((yPos + ((j + 1) * (totalYSpace / (numberOfTicks + 1)))) * screensize))
                    {
                        if (arg6 != (j * arg4))
                        {
                            arg6 = j * arg4;
                            audio_play_sound(snd_menu_select, 30, 0);
                            return arg6;
                            break;
                        }
                    }
                }
            }
        }
    }
    return arg6;
}
