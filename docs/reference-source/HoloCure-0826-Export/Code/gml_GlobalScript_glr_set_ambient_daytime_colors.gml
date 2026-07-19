function glr_set_ambient_daytime_colors(arg0, arg1, arg2, arg3, arg4)
{
    global.GLR_M_R = colour_get_red(arg0);
    global.GLR_M_G = colour_get_green(arg0);
    global.GLR_M_B = colour_get_blue(arg0);
    global.GLR_S_R = colour_get_red(arg1);
    global.GLR_S_G = colour_get_green(arg1);
    global.GLR_S_B = colour_get_blue(arg1);
    global.GLR_N_R = colour_get_red(arg2);
    global.GLR_N_G = colour_get_green(arg2);
    global.GLR_N_B = colour_get_blue(arg2);
    global.GLR_A_R = colour_get_red(arg3);
    global.GLR_A_G = colour_get_green(arg3);
    global.GLR_A_B = colour_get_blue(arg3);
    global.GLR_E_R = colour_get_red(arg4);
    global.GLR_E_G = colour_get_green(arg4);
    global.GLR_E_B = colour_get_blue(arg4);
}
