if (currentBeat < 8)
{
    for (var i = 0; i < array_length(beatTimes); i++)
    {
        if (beatTimes[i] != -1 && lifetime >= beatTimes[i] && lifetime < (beatTimes[i] + circleTime))
        {
            if (lifetime >= (beatTimes[i] + 55))
            {
                draw_circle_outline(creator.x, creator.y - 16, (rhythmTimes[i] / circleTime) * 150, 3, 36, 4235519);
            }
            else
            {
                draw_circle_outline(creator.x, creator.y - 16, (rhythmTimes[i] / circleTime) * 150, 3, 36, 16777215);
            }
        }
    }
}
if (orangeLight > 0)
{
    gpu_set_blendmode(bm_add);
    draw_set_alpha(orangeLight);
    draw_rectangle_colour(0, 0, 10000, 10000, c_orange, c_orange, c_orange, c_orange, false);
    draw_set_alpha(1);
    gpu_set_blendmode(bm_normal);
}
