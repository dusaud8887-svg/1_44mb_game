if (currentScene > -1)
{
    if (currentText > -1)
    {
        draw_text_ext_color(320, 100, global.TextContainer.preIntroText.selectedLanguage[currentScene], 20, 640, c_white, c_white, c_white, c_white, 1);
    }
    draw_set_color(c_black);
    draw_set_alpha(screenAlpha);
    draw_rectangle(0, 0, 640, 360, false);
    draw_set_halign(fa_center);
    draw_set_font(Galmuri9);
}
