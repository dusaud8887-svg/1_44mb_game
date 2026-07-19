function draw_dotted_line(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
{
    arg0 = argument[0];
    arg1 = argument[1];
    arg2 = argument[2];
    arg3 = argument[3];
    start_angle = argument[4];
    arg5 = argument[5];
    arg6 = argument[6];
    dist = point_distance(arg0, arg1, arg2, arg3);
    dist_ang = angle_difference(point_direction(arg0, arg1, arg2, arg3), start_angle);
    inc = 1 / arg5;
    for (i = 0; i < (1 - inc); i += inc)
    {
        draw_x = arg0 + lengthdir_x(i * dist, (i * dist_ang) + start_angle);
        draw_y = arg1 + lengthdir_y(i * dist, (i * dist_ang) + start_angle);
        var draw_x2 = arg0 + lengthdir_x((i + inc) * dist, ((i + inc) * dist_ang) + start_angle);
        var draw_y2 = arg1 + lengthdir_y((i + inc) * dist, ((i + inc) * dist_ang) + start_angle);
        draw_x += ((arg6 / 60) * (draw_x2 - draw_x));
        draw_y += ((arg6 / 60) * (draw_y2 - draw_y));
        draw_sprite(spr_stickerDots, 0, draw_x, draw_y);
    }
    return 0;
}
