function glr_set_ambient_color(arg0)
{
    global.GLR_AMBIENT_COLOR = arg0;
    global.GLR_AMBIENT_R = color_get_red(arg0) / 255;
    global.GLR_AMBIENT_G = color_get_green(arg0) / 255;
    global.GLR_AMBIENT_B = color_get_blue(arg0) / 255;
}
