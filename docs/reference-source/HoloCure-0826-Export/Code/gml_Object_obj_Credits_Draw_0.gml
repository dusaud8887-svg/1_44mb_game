draw_set_font(Galmuri9);
draw_set_halign(fa_center);
draw_set_alpha(0.4);
draw_set_color(c_black);
draw_rectangle(150, 0, 490, 360, false);
draw_set_alpha(1);
draw_set_color(c_white);
draw_text_scribble_ext(x, y + creditsScroll, global.TextContainer.CreditsList.selectedLanguage, 500);
commandPromps(false, false, true);
