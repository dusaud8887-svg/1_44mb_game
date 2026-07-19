function commandPromps(arg0, arg1, arg2)
{
    draw_set_font(Galmuri9);
    draw_set_color(make_color_rgb(240, 240, 240));
    draw_set_halign(fa_right);
    var confirm = "";
    if (arg0)
    {
        confirm = global.TextContainer.mainButtons.selectedLanguage[0] + string(key_to_string(global.theButtons[0]));
    }
    var enter = "";
    if (arg1)
    {
        enter = "/ENTER";
    }
    var cancel = "";
    var both = "";
    if (arg0 && arg2)
    {
        both = " | ";
    }
    if (arg2)
    {
        cancel = global.TextContainer.mainButtons.selectedLanguage[1] + string(key_to_string(global.theButtons[1])) + "/ESC";
    }
    draw_text_scribble(630, 345, confirm + enter + both + cancel);
}
