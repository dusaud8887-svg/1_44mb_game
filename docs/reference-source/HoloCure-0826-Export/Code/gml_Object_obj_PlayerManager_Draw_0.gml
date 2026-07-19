if (paused)
{
    if (sprite_exists(paused_screen_sprite))
    {
        var originalView = sprite_get_width(paused_screen_sprite) / 640;
        var pauseScreenView = 1;
        draw_sprite_ext(paused_screen_sprite, 0, camera_get_view_x(view_camera[0]), camera_get_view_y(view_camera[0]), 1 / originalView, 1 / originalView, 0, c_white, 1);
        if (!gameOvered && !gameWon)
        {
            draw_set_alpha(0.7);
            draw_rectangle_colour(0, 0, 10000, 10000, c_black, c_black, c_black, c_black, false);
            draw_set_alpha(1);
        }
    }
}
if (!gameOvered && !gameWon)
{
    draw_set_alpha(whiteFlash);
    depth = 0;
    draw_rectangle_colour(0, 0, 10000, 10000, c_white, c_white, c_white, c_white, false);
    draw_set_alpha(1);
}
if (!gameOvered && !gameWon)
{
    draw_set_alpha(superDank);
    depth = 0;
    draw_rectangle_colour(0, 0, 10000, 10000, c_black, c_black, c_black, c_black, false);
    draw_set_alpha(1);
}
if (room == rm_HoloOffice_SunSet)
{
    draw_set_alpha(0.25);
    draw_rectangle_colour(0, 0, 10000, 10000, c_black, c_black, c_black, c_black, false);
    draw_set_alpha(1);
}
if (!paused && sprite_exists(paused_screen_sprite))
{
    sprite_delete(paused_screen_sprite);
}
