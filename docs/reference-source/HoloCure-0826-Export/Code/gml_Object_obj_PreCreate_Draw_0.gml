if (waitSpawn > 1)
{
    circleTime = waitSpawn;
    draw_set_alpha(0.4 + (0.2 * sin(waitSpawn / 5)));
    draw_set_color(make_color_rgb(255, 170, 170));
    draw_circle(x, y, (image_xscale * srad) + 1, true);
    draw_set_alpha(1);
    draw_set_color(c_red);
    draw_circle(x, y, image_xscale * srad * (1 - (waitSpawn / initTime)), true);
    draw_set_alpha(0.3 + (0.1 * sin(waitSpawn / 5)));
    draw_circle(x, y, image_xscale * srad, false);
    draw_set_alpha(1);
}
