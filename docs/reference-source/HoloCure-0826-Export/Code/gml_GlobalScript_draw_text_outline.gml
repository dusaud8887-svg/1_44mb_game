function draw_text_outline(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
{
    var dto_dcol = draw_get_color();
    draw_set_color(argument4);
    var dto_i = 45;
    while (dto_i < 405)
    {
        draw_text_ext_color(argument0 + round(lengthdir_x(argument3, dto_i)), argument1 + round(lengthdir_y(argument3, dto_i)), argument2, argument6, argument7, argument4, argument4, argument4, argument4, argument9);
        dto_i += (360 / argument5);
    }
    draw_set_color(dto_dcol);
    draw_text_ext_color(argument0, argument1, argument2, argument6, argument7, argument8, argument8, argument8, argument8, argument9);
}
