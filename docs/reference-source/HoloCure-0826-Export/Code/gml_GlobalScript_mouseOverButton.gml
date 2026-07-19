function MouseOverButton(arg0, arg1, arg2, arg3 = 1, arg4 = 38)
{
    arg3 = 1;
    if (variable_global_exists("new_camera_scale") && global.new_camera_scale != 1)
    {
        arg3 = 1 / global.camera_scale;
    }
    switch (arg0)
    {
        case "long":
            return (mouse_x - camera_get_view_x(view_camera[0])) >= ((arg1 * arg3) - (90 * arg3)) && (mouse_x - camera_get_view_x(view_camera[0])) < ((arg1 * arg3) + (90 * arg3)) && (mouse_y - camera_get_view_y(view_camera[0])) >= (arg2 * arg3) && (mouse_y - camera_get_view_y(view_camera[0])) < ((arg2 * arg3) + (29 * arg3));
            break;
        case "short":
            return (mouse_x - camera_get_view_x(view_camera[0])) >= ((arg1 * arg3) - (45 * arg3)) && (mouse_x - camera_get_view_x(view_camera[0])) < ((arg1 * arg3) + (45 * arg3)) && (mouse_y - camera_get_view_y(view_camera[0])) >= ((arg2 * arg3) - (15 * arg3)) && (mouse_y - camera_get_view_y(view_camera[0])) < ((arg2 * arg3) + (15 * arg3));
            break;
        case "levelButton":
            return (mouse_x - camera_get_view_x(view_camera[0])) >= ((arg1 * arg3) - (55 * arg3)) && (mouse_x - camera_get_view_x(view_camera[0])) < ((arg1 * arg3) + (55 * arg3)) && (mouse_y - camera_get_view_y(view_camera[0])) >= (arg2 * arg3) && (mouse_y - camera_get_view_y(view_camera[0])) < ((arg2 * arg3) + (27 * arg3));
            break;
        case "hiscore":
            return (mouse_x - camera_get_view_x(view_camera[0])) >= ((arg1 * arg3) - (74 * arg3)) && (mouse_x - camera_get_view_x(view_camera[0])) < ((arg1 * arg3) + (74 * arg3)) && (mouse_y - camera_get_view_y(view_camera[0])) >= ((arg2 * arg3) - (14 * arg3)) && (mouse_y - camera_get_view_y(view_camera[0])) < ((arg2 * arg3) + (14 * arg3));
            break;
        case "hiscoreSettings":
            arg1 += 56;
            return (mouse_x - camera_get_view_x(view_camera[0])) >= ((arg1 * arg3) - (18 * arg3)) && (mouse_x - camera_get_view_x(view_camera[0])) < ((arg1 * arg3) + (18 * arg3)) && (mouse_y - camera_get_view_y(view_camera[0])) >= ((arg2 * arg3) - (14 * arg3)) && (mouse_y - camera_get_view_y(view_camera[0])) < ((arg2 * arg3) + (14 * arg3));
            break;
        case "characterSelect":
            return (mouse_x - camera_get_view_x(view_camera[0])) >= ((arg1 * arg3) + (3 * arg3)) && (mouse_x - camera_get_view_x(view_camera[0])) < ((arg1 * arg3) + (48 * arg3)) && (mouse_y - camera_get_view_y(view_camera[0])) >= (arg2 * arg3) && (mouse_y - camera_get_view_y(view_camera[0])) < ((arg2 * arg3) + (arg4 * arg3));
            break;
        case "shopIcon":
            return (mouse_x - camera_get_view_x(view_camera[0])) >= ((arg1 * arg3) - (21 * arg3)) && (mouse_x - camera_get_view_x(view_camera[0])) < ((arg1 * arg3) + (65 * arg3)) && (mouse_y - camera_get_view_y(view_camera[0])) >= ((arg2 * arg3) - (21 * arg3)) && (mouse_y - camera_get_view_y(view_camera[0])) < ((arg2 * arg3) + (22 * arg3));
            break;
        case "itemCase":
            return (mouse_x - camera_get_view_x(view_camera[0])) >= ((arg1 * arg3) - (16 * arg3)) && (mouse_x - camera_get_view_x(view_camera[0])) < ((arg1 * arg3) + (16 * arg3)) && (mouse_y - camera_get_view_y(view_camera[0])) >= ((arg2 * arg3) - (16 * arg3)) && (mouse_y - camera_get_view_y(view_camera[0])) < ((arg2 * arg3) + (16 * arg3));
            break;
        case "fullOption":
            return (mouse_x - camera_get_view_x(view_camera[0])) >= (arg1 * arg3) && (mouse_x - camera_get_view_x(view_camera[0])) < ((arg1 * arg3) + (386 * arg3)) && (mouse_y - camera_get_view_y(view_camera[0])) >= (arg2 * arg3) && (mouse_y - camera_get_view_y(view_camera[0])) < ((arg2 * arg3) + (68 * arg3));
            break;
        case "halfOption":
            return (mouse_x - camera_get_view_x(view_camera[0])) >= ((arg1 - (96 * arg3)) + (4 * arg3)) && (mouse_x - camera_get_view_x(view_camera[0])) < ((arg1 * arg3) + (96 * arg3)) && (mouse_y - camera_get_view_y(view_camera[0])) >= (arg2 * arg3) && (mouse_y - camera_get_view_y(view_camera[0])) < ((arg2 * arg3) + (68 * arg3));
            break;
        case "stampCase":
            return (mouse_x - camera_get_view_x(view_camera[0])) >= ((arg1 * arg3) - (20 * arg3)) && (mouse_x - camera_get_view_x(view_camera[0])) < ((arg1 * arg3) + (20 * arg3)) && (mouse_y - camera_get_view_y(view_camera[0])) >= ((arg2 * arg3) - (20 * arg3)) && (mouse_y - camera_get_view_y(view_camera[0])) < ((arg2 * arg3) + (20 * arg3));
            break;
        case "fandomBox":
            return (mouse_x - camera_get_view_x(view_camera[0])) >= (arg1 * arg3) && (mouse_x - camera_get_view_x(view_camera[0])) < ((arg1 * arg3) + (173 * arg3)) && (mouse_y - camera_get_view_y(view_camera[0])) >= (arg2 * arg3) && (mouse_y - camera_get_view_y(view_camera[0])) < ((arg2 * arg3) + (56 * arg3));
            break;
        case "tile":
            return (mouse_x - camera_get_view_x(view_camera[0])) >= (arg1 * arg3) && (mouse_x - camera_get_view_x(view_camera[0])) < ((arg1 * arg3) + (16 * arg3)) && (mouse_y - camera_get_view_y(view_camera[0])) >= (arg2 * arg3) && (mouse_y - camera_get_view_y(view_camera[0])) < ((arg2 * arg3) + (16 * arg3));
            break;
        case "checkBox":
            return (mouse_x - camera_get_view_x(view_camera[0])) >= (arg1 - (9 * arg3)) && (mouse_x - camera_get_view_x(view_camera[0])) < ((arg1 * arg3) + (9 * arg3)) && (mouse_y - camera_get_view_y(view_camera[0])) >= (arg2 - (9 * arg3)) && (mouse_y - camera_get_view_y(view_camera[0])) < ((arg2 * arg3) + (9 * arg3));
            break;
        case "shopCategory":
            return (mouse_x - camera_get_view_x(view_camera[0])) >= (arg1 - (50 * arg3)) && (mouse_x - camera_get_view_x(view_camera[0])) < ((arg1 * arg3) + (50 * arg3)) && (mouse_y - camera_get_view_y(view_camera[0])) >= (arg2 - (10 * arg3)) && (mouse_y - camera_get_view_y(view_camera[0])) < ((arg2 * arg3) + (10 * arg3));
            break;
        case "goButton":
            return (mouse_x - camera_get_view_x(view_camera[0])) >= ((arg1 * arg3) - (40 * arg3)) && (mouse_x - camera_get_view_x(view_camera[0])) < ((arg1 * arg3) + (40 * arg3)) && (mouse_y - camera_get_view_y(view_camera[0])) >= ((arg2 * arg3) - (40 * arg3)) && (mouse_y - camera_get_view_y(view_camera[0])) < ((arg2 * arg3) + (40 * arg3));
            break;
        case "npc":
            return (mouse_x - camera_get_view_x(view_camera[0])) >= ((arg1 * arg3) - (20 * arg3)) && (mouse_x - camera_get_view_x(view_camera[0])) < ((arg1 * arg3) + (20 * arg3)) && (mouse_y - camera_get_view_y(view_camera[0])) >= ((arg2 * arg3) - (40 * arg3)) && (mouse_y - camera_get_view_y(view_camera[0])) < ((arg2 * arg3) + (5 * arg3));
            break;
        case "smallShopMenu":
            return (mouse_x - camera_get_view_x(view_camera[0])) >= (arg1 * arg3) && (mouse_x - camera_get_view_x(view_camera[0])) < ((arg1 * arg3) + (350 * arg3)) && (mouse_y - camera_get_view_y(view_camera[0])) >= (arg2 * arg3) && (mouse_y - camera_get_view_y(view_camera[0])) < ((arg2 * arg3) + (26 * arg3));
            break;
        case "shortShopMenu":
            return (mouse_x - camera_get_view_x(view_camera[0])) >= (arg1 * arg3) && (mouse_x - camera_get_view_x(view_camera[0])) < ((arg1 * arg3) + (195 * arg3)) && (mouse_y - camera_get_view_y(view_camera[0])) >= (arg2 * arg3) && (mouse_y - camera_get_view_y(view_camera[0])) < ((arg2 * arg3) + (26 * arg3));
            break;
        case "largeShopMenu":
            return (mouse_x - camera_get_view_x(view_camera[0])) >= (arg1 * arg3) && (mouse_x - camera_get_view_x(view_camera[0])) < ((arg1 * arg3) + (350 * arg3)) && (mouse_y - camera_get_view_y(view_camera[0])) >= (arg2 * arg3) && (mouse_y - camera_get_view_y(view_camera[0])) < ((arg2 * arg3) + (70 * arg3));
            break;
        case "seedMenu":
            return (mouse_x - camera_get_view_x(view_camera[0])) >= (arg1 * arg3) && (mouse_x - camera_get_view_x(view_camera[0])) < ((arg1 * arg3) + (165 * arg3)) && (mouse_y - camera_get_view_y(view_camera[0])) >= (arg2 * arg3) && (mouse_y - camera_get_view_y(view_camera[0])) < ((arg2 * arg3) + (26 * arg3));
            break;
        case "arrow":
            return (mouse_x - camera_get_view_x(view_camera[0])) >= ((arg1 * arg3) - (10 * arg3)) && (mouse_x - camera_get_view_x(view_camera[0])) < ((arg1 * arg3) + (10 * arg3)) && (mouse_y - camera_get_view_y(view_camera[0])) >= ((arg2 * arg3) - (10 * arg3)) && (mouse_y - camera_get_view_y(view_camera[0])) < ((arg2 * arg3) + (10 * arg3));
            break;
        case "longArrow":
            return (mouse_x - camera_get_view_x(view_camera[0])) >= ((arg1 * arg3) - (30 * arg3)) && (mouse_x - camera_get_view_x(view_camera[0])) < ((arg1 * arg3) + (30 * arg3)) && (mouse_y - camera_get_view_y(view_camera[0])) >= ((arg2 * arg3) - (10 * arg3)) && (mouse_y - camera_get_view_y(view_camera[0])) < ((arg2 * arg3) + (10 * arg3));
            break;
        case "collabList":
            return (mouse_x - camera_get_view_x(view_camera[0])) >= (arg1 * arg3) && (mouse_x - camera_get_view_x(view_camera[0])) < ((arg1 * arg3) + (10 * arg3)) && (mouse_y - camera_get_view_y(view_camera[0])) >= (arg2 * arg3) && (mouse_y - camera_get_view_y(view_camera[0])) < ((arg2 * arg3) + (260 * arg3));
            break;
        default:
            return false;
            break;
    }
}
