if (initTime > 1 && markerTime < initTime)
{
    markerTime++;
    draw_set_color(make_color_rgb(255, 170, 170));
    draw_circle(x, y, (image_xscale * srad) + 1, true);
    draw_set_color(c_red);
    draw_circle(x, y, image_xscale * srad * (markerTime / initTime), true);
    draw_set_alpha(0.3 + (0.1 * sin(markerTime / 5)));
    draw_circle(x, y, image_xscale * srad, false);
    draw_set_alpha(1);
}
