function draw_rectangle_rotated()
{
    var cx = argument0;
    var cy = argument1;
    var xx1 = argument2;
    var yy1 = argument3;
    var xx2 = argument4;
    var yy2 = argument5;
    var rot = argument6;
    var sxx = cos(degtorad(rot));
    var sxy = -sin(degtorad(rot));
    var syx = sin(degtorad(rot));
    var syy = cos(degtorad(rot));
    var x1 = cx + (sxx * xx1) + (syx * yy1);
    var x2 = cx + (sxx * xx2) + (syx * yy1);
    var x3 = cx + (sxx * xx2) + (syx * yy2);
    var x4 = cx + (sxx * xx1) + (syx * yy2);
    var y1 = cy + (sxy * xx1) + (syy * yy1);
    var y2 = cy + (sxy * xx2) + (syy * yy1);
    var y3 = cy + (sxy * xx2) + (syy * yy2);
    var y4 = cy + (sxy * xx1) + (syy * yy2);
    if (argument7)
    {
        draw_line(x1, y1, x4, y4);
        draw_line(x2, y2, x1, y1);
        draw_line(x3, y3, x2, y2);
        draw_line(x4, y4, x3, y3);
    }
    else
    {
        draw_triangle(x1, y1, x2, y2, x3, y3, false);
        draw_triangle(x1, y1, x3, y3, x4, y4, false);
    }
}
