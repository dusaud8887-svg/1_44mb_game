for (var j = 0; j < 5; j++)
{
    var numLights = 10 * j;
    for (var i = 0; i < numLights; i++)
    {
        draw_sprite(bg_concertlights, 0, x + (1.25 * lengthdir_x(50 + (100 * j), i * (360 / numLights))), y + lengthdir_y(50 + (100 * j), i * (360 / numLights)));
    }
}
