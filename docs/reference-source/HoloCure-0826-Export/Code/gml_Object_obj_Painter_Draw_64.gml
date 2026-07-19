draw_sprite(spr_IofiPaintHUD, 0, 193, 294);
draw_set_halign(fa_left);
draw_set_font(Galmuri9);
draw_text_outline(333, 317, paintTimer div 60, 1, 0, 14, 10, 100, 16777215, 1);
draw_healthbar(194, 295, 445, 308, paintAmount, c_white, make_color_rgb(58, 202, 255), make_color_rgb(58, 202, 255), 0, 0, 0);
draw_sprite_ext(spr_animezoom, paintTimer div 2, 320, 195, 1, 1, 0, c_white, 0.3);
