function glr_set_ambient_daytime(arg0)
{
    var a = arg0;
    var r, g, b;
    if (a <= 0.2)
    {
        var ratio = a / 0.2;
        r = lerp(global.GLR_M_R, global.GLR_S_R, ratio);
        g = lerp(global.GLR_M_G, global.GLR_S_G, ratio);
        b = lerp(global.GLR_M_B, global.GLR_S_B, ratio);
        global.GLR_DIRECTIONAL_STRENGTH = 0;
    }
    else if (a <= 0.4)
    {
        var ratio = (a - 0.2) / 0.2;
        r = lerp(global.GLR_S_R, global.GLR_N_R, ratio);
        g = lerp(global.GLR_S_G, global.GLR_N_G, ratio);
        b = lerp(global.GLR_S_B, global.GLR_N_B, ratio);
        global.GLR_DIRECTIONAL_STRENGTH = lerp(0, 0.3, ratio);
        global.GLR_DIRECTIONAL_LENGTH = lerp(1, 0.6, ratio) * 0.2;
    }
    else if (a <= 0.6)
    {
        var ratio = (a - 0.4) / 0.2;
        r = lerp(global.GLR_N_R, global.GLR_A_R, ratio);
        g = lerp(global.GLR_N_G, global.GLR_A_G, ratio);
        b = lerp(global.GLR_N_B, global.GLR_A_B, ratio);
        global.GLR_DIRECTIONAL_STRENGTH = lerp(0.3, 0.6, ratio);
        global.GLR_DIRECTIONAL_LENGTH = lerp(0.6, 0.25, ratio) * 0.2;
    }
    else if (a <= 0.8)
    {
        var ratio = (a - 0.6) / 0.2;
        r = lerp(global.GLR_A_R, global.GLR_E_R, ratio);
        g = lerp(global.GLR_A_G, global.GLR_E_G, ratio);
        b = lerp(global.GLR_A_B, global.GLR_E_B, ratio);
        global.GLR_DIRECTIONAL_STRENGTH = lerp(0.6, 0.75, ratio);
        global.GLR_DIRECTIONAL_LENGTH = lerp(0.25, 0.4, ratio) * 0.2;
    }
    else
    {
        var ratio = (a - 0.8) / 0.2;
        r = lerp(global.GLR_E_R, global.GLR_M_R, ratio);
        g = lerp(global.GLR_E_G, global.GLR_M_G, ratio);
        b = lerp(global.GLR_E_B, global.GLR_M_B, ratio);
        global.GLR_DIRECTIONAL_STRENGTH = lerp(0.75, 0, ratio);
        global.GLR_DIRECTIONAL_LENGTH = lerp(0.4, 1, ratio) * 0.2;
    }
    global.GLR_DIRECTIONAL_ANGLE = 100 + (a * 275);
    global.GLR_AMBIENT_COLOR = make_color_rgb(r, g, b);
    global.GLR_AMBIENT_R = r / 255;
    global.GLR_AMBIENT_G = g / 255;
    global.GLR_AMBIENT_B = b / 255;
}
