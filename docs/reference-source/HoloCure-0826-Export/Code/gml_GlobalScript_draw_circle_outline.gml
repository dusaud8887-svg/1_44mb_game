function draw_circle_outline(arg0, arg1, arg2, arg3, arg4, arg5 = 0)
{
    var xx = argument[0];
    var yy = argument[1];
    var inner_rad = argument[2];
    var thickness = argument[3];
    var drawSegments = argument[4];
    var lineColor = argument[5];
    var jadd = 360 / drawSegments;
    draw_set_color(lineColor);
    draw_primitive_begin(pr_trianglestrip);
    for (var j = 0; j <= 360; j += jadd)
    {
        draw_vertex(xx + lengthdir_x(inner_rad, j), yy + lengthdir_y(inner_rad, j));
        draw_vertex(xx + lengthdir_x(inner_rad + thickness, j), yy + lengthdir_y(inner_rad + thickness, j));
    }
    draw_primitive_end();
}
