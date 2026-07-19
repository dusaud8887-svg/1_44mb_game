if (!is_string(damageValue))
{
    damageValue = floor(damageValue);
}
draw_set_font(excluded);
draw_set_halign(fa_center);
if (shield && damageValue != "MISS")
{
    hspeed = 0;
    draw_text_outline(x, y, damageValue, 0.75, make_color_rgb(13, 41, 140), 4, 4, 100, make_color_rgb(68, 153, 255), alpha);
}
else if (damageValue == "MISS")
{
    hspeed = 0;
    draw_text_outline(x, y, damageValue, 0.75, 0, 4, 4, 100, make_color_rgb(230, 230, 230), alpha);
}
else if (damageValue == "KO!" || damageValue == "BANNED!" || damageValue == "ARRESTED!")
{
    hspeed = 0;
    draw_text_outline(x, y, damageValue, 0.75, 0, 4, 4, 100, make_color_rgb(190, 30, 30), alpha);
}
else if (cringe)
{
    hspeed = 0;
    draw_text_outline(x, y, damageValue, 0.75, 0, 4, 4, 100, make_color_rgb(212, 78, 250), alpha);
}
else if (critted)
{
    if (damageValue >= 1000)
    {
        draw_set_font(excluded_big);
    }
    if (damageValue >= 10000)
    {
        draw_set_font(excluded_giant);
    }
    var critColor = make_color_rgb(255, 241, 172);
    var critColorOutline = make_color_rgb(201, 146, 33);
    var exclaims = "!";
    if (CritMod >= 1 && CritMod < 2)
    {
        critColor = make_color_rgb(255, 145, 64);
        critColorOutline = make_color_rgb(188, 88, 13);
        exclaims = "!!";
    }
    else if (CritMod >= 2 && CritMod < 3)
    {
        critColor = make_color_rgb(243, 21, 21);
        critColorOutline = make_color_rgb(126, 11, 11);
        exclaims = "!!!";
    }
    else if (CritMod >= 3)
    {
        critColor = make_color_rgb(157, 21, 243);
        critColorOutline = make_color_rgb(83, 11, 126);
        exclaims = "!!!!";
    }
    if (reflected)
    {
        critColor = make_color_rgb(255, 182, 255);
    }
    draw_set_font(excluded_italic);
    if (damageValue >= 1000)
    {
        draw_set_font(excluded_italic_big);
    }
    if (damageValue >= 10000)
    {
        draw_set_font(excluded_italic_giant);
    }
    if (heal)
    {
        draw_text_outline(x, y, string(damageValue) + exclaims, 0.75, 0, 4, 4, 100, make_color_rgb(53, 229, 89), alpha);
    }
    else
    {
        draw_text_outline(x, y, string(damageValue) + exclaims, 0.75, critColorOutline, 4, 4, 100, critColor, alpha);
    }
}
else
{
    if (!is_string(damageValue))
    {
        if (damageValue >= 1000)
        {
            draw_set_font(excluded_big);
        }
        if (damageValue >= 10000)
        {
            draw_set_font(excluded_giant);
        }
    }
    if (heal)
    {
        draw_text_outline(x, y, damageValue, 0.75, 0, 4, 4, 100, make_color_rgb(53, 229, 89), alpha);
    }
    else if (reflected)
    {
        draw_text_outline(x, y, damageValue, 0.75, 0, 4, 4, 100, make_color_rgb(255, 182, 255), alpha);
    }
    else if (isEnemy)
    {
        draw_text_outline(x, y, damageValue, 0.75, 0, 4, 4, 100, 16777215, alpha);
    }
    else
    {
        draw_text_outline(x, y, damageValue, 0.75, 0, 4, 4, 100, make_color_rgb(255, 60, 60), alpha);
    }
}
