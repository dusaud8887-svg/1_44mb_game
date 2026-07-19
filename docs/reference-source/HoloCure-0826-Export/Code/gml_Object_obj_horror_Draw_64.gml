draw_set_alpha(dank);
draw_set_color(c_black);
draw_rectangle(0, 0, 1000, 1000, false);
draw_set_alpha(1);
draw_sprite_ext(sprite_index, image_index, 0, 0, 1, 1, 0, c_white, image_alpha);
